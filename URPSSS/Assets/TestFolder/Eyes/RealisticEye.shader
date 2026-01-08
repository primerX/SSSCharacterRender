Shader "G_Jarvis/URP_RealisticEye"
{
    Properties
    {
        [Header(General Settings)]
        _BaseColor("Global Tint", Color) = (1,1,1,1)
        _Smoothness("Smoothness", Range(0.0, 1.0)) = 0.95
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        
        [Header(Sclera (Eye White))]
        _ScleraMap("Sclera Texture (RGB)", 2D) = "white" {}
        _ScleraNormal("Sclera Normal", 2D) = "bump" {}
        _ScleraTint("Sclera Tint", Color) = (0.9, 0.9, 0.9, 1)

        [Header(Iris (Colored Part))]
        _IrisMap("Iris Texture (RGB)", 2D) = "white" {}
        _IrisColor("Iris Color Tint", Color) = (1,1,1,1)
        _IrisNormal("Iris Normal", 2D) = "bump" {}
        
        [Header(Iris Physics)]
        _ParallaxScale("Iris Depth (Parallax)", Range(0.0, 0.1)) = 0.02
        _PupilSize("Pupil Size (1.0 = Normal)", Range(0.5, 2.0)) = 1.0
        _LimbalRingSize("Limbal Ring Softness", Range(0.01, 0.5)) = 0.1
        _LimbalRingColor("Limbal Ring Color", Color) = (0,0,0,1)

        [Header(Masks)]
        // R: Iris Mask (1=Iris, 0=Sclera)
        // G: Height Map (For Parallax)
        // B: Pupil Mask (Optional)
        _MaskMap("Mask Map (R:IrisMask G:Height)", 2D) = "white" {}
    }

    SubShader
    {
        Tags 
        { 
            "RenderType"="Opaque" 
            "RenderPipeline"="UniversalPipeline" 
            "Queue"="Geometry" 
        }

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag

            // URP Keywords
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/SpaceTransforms.hlsl"

            struct Attributes
            {
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float4 tangentOS    : TANGENT;
                float2 uv           : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionCS   : SV_POSITION;
                float3 positionWS   : TEXCOORD0;
                float3 normalWS     : TEXCOORD1;
                float2 uv           : TEXCOORD2;
                float3 viewDirTS    : TEXCOORD3; // Tangent Space View Direction
            };

            // CBUFFER for batching
            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor;
                float _Smoothness;
                float _Metallic;
                float4 _ScleraTint;
                float4 _IrisColor;
                float _ParallaxScale;
                float _PupilSize;
                float _LimbalRingSize;
                float4 _LimbalRingColor;
                
                float4 _ScleraMap_ST;
                float4 _IrisMap_ST;
            CBUFFER_END

            TEXTURE2D(_ScleraMap);       SAMPLER(sampler_ScleraMap);
            TEXTURE2D(_ScleraNormal);    SAMPLER(sampler_ScleraNormal);
            TEXTURE2D(_IrisMap);         SAMPLER(sampler_IrisMap);
            TEXTURE2D(_IrisNormal);      SAMPLER(sampler_IrisNormal);
            TEXTURE2D(_MaskMap);         SAMPLER(sampler_MaskMap);

            Varyings Vert(Attributes input)
            {
                Varyings output;

                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);

                output.positionCS = vertexInput.positionCS;
                output.positionWS = vertexInput.positionWS;
                output.normalWS = normalInput.normalWS;
                output.uv = input.uv;

                // Calculate Tangent Space View Direction for Parallax
                float3 viewDirWS = GetWorldSpaceNormalizeViewDir(vertexInput.positionWS);
                
                float3 bitangent = cross(normalInput.normalWS, normalInput.tangentWS) * input.tangentOS.w * GetOddNegativeScale();
                float3x3 TBN = float3x3(normalInput.tangentWS, bitangent, normalInput.normalWS);
                
                // Transform ViewDir from World to Tangent space
                output.viewDirTS = mul(TBN, viewDirWS);

                return output;
            }

            // --- Helper Functions ---

            // Simple Parallax Offset
            float2 GetParallaxOffset(float2 uv, float3 viewDirTS, float heightScale)
            {
                // Sample height from Green channel of MaskMap
                float height = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, uv).g;
                
                // Iris is concave (inward), so we invert height logic effectively
                // Or simply: deeper parts shift more.
                // Bias viewDir.z to avoid artifacts at grazing angles
                float3 v = normalize(viewDirTS);
                v.z += 0.42;
                
                return (height * heightScale) * (v.xy / v.z);
            }

            // Pupil Dilation
            float2 GetDilatedUV(float2 uv, float scale)
            {
                float2 center = float2(0.5, 0.5);
                return (uv - center) * (1.0 / scale) + center;
            }

            half4 Frag(Varyings input) : SV_Target
            {
                // 1. Basic Data Setup
                float2 uv = input.uv;
                float3 viewDirWS = GetWorldSpaceNormalizeViewDir(input.positionWS);
                float3 normalWS = normalize(input.normalWS);

                // 2. Sample Mask (R: Iris Mask, G: Height)
                // We sample mask first to know where we are
                float4 maskData = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, uv);
                float irisMask = 1-maskData.a;

                // 3. Calculate Iris UVs (Parallax + Dilation)
                float2 irisUV = uv;
                
                // Only do expensive parallax if we are roughly in the iris area
                // (Optimization: branching is okay here if texture fetch is dependent)
                if (irisMask > 0.01)
                {
                    // A. Parallax
                    // Note: Real refraction is complex, here we approximate with Parallax Mapping
                    // We use the negative viewDirTS because the iris is "inside"
                    float2 parallaxOffset = GetParallaxOffset(uv, -input.viewDirTS, _ParallaxScale);
                    irisUV += parallaxOffset;

                    // B. Pupil Dilation
                    // Apply dilation AFTER parallax for correct depth perception
                    irisUV = GetDilatedUV(irisUV, _PupilSize);
                }

                // 4. Sample Textures
                // Sclera (Eye White)
                float4 scleraCol = SAMPLE_TEXTURE2D(_ScleraMap, sampler_ScleraMap, uv) * _ScleraTint;
                float3 scleraNorm = UnpackNormal(SAMPLE_TEXTURE2D(_ScleraNormal, sampler_ScleraNormal, uv));

                // Iris
                float4 irisCol = SAMPLE_TEXTURE2D(_IrisMap, sampler_IrisMap, irisUV) * _IrisColor;
                // We can blend iris normal, but usually the cornea surface (mesh normal) dominates specular.
                // Let's keep iris normal subtle or just use mesh normal for wetness.
                // For this shader, we will use the mesh normal for the "Cornea" wet look, 
                // but we could blend detail normals if needed.
                
                // 5. Blending Iris and Sclera
                // Soften the mask edge for the Limbal Ring effect
                float blendFactor = smoothstep(0.0, _LimbalRingSize, irisMask);
                
                // Mix Albedo
                float3 finalAlbedo = lerp(scleraCol.rgb, irisCol.rgb, blendFactor);

                // Add Limbal Ring Darkening
                // Darken the edge where the blend happens
                float limbalRing = smoothstep(0.0, 0.2, irisMask) * smoothstep(1.0, 0.8, irisMask);
                // Simple multiply for darkening
                finalAlbedo = lerp(finalAlbedo, finalAlbedo * _LimbalRingColor.rgb, limbalRing * 0.8);

                return half4(finalAlbedo, 1);
                // 6. Surface Data for PBR
                // SurfaceData surfaceData;
                // surfaceData.albedo = finalAlbedo * _BaseColor.rgb;
                // surfaceData.metallic = _Metallic;
                // surfaceData.smoothness = _Smoothness;
                // surfaceData.normalTS = scleraNorm; // Using Sclera normal map for veins bumpiness
                // surfaceData.emission = 0;
                // surfaceData.occlusion = 1;
                // surfaceData.alpha = 1;

                // // 7. Input Data for Lighting
                // InputData inputData;
                // InitializeInputData(input, surfaceData.normalTs, inputData);

                // // 8. Calculate Lighting
                // half4 color = UniversalFragmentPBR(inputData, surfaceData);

                // return color;
            }
            ENDHLSL
        }

    }
}