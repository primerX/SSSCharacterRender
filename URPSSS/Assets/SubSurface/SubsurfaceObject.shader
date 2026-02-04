Shader "Shenkong/SSS MyOjbect"
{
    Properties
    {
        [NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
        _Color ("Base Color", Color) = (1, 1, 1, 1)

        [HideInInspector] [NoScaleOffset]_SubsurfaceMap("Surface Map", 2D) = "white" {}
        [HideInInspector] _Subsurface("SurfaceMap Visibility", Range(0, 1)) = 1

        _DiffuseRoughness("Diffuse Roughness", Range(0, 1)) = 1
        _LightClamp("Light Clamp", Float) = 10
        _Diffuseboost("Diffuse boost", Range(1, 2)) = 1

        [Header(NormalSetting)]
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _NormalIntensity("Normal Scale", Range(0, 3)) = 1

        [Space]
        [Head(MaskSetting)]
        _MaskMap("Mask Map", 2D) = "white" {}
        _RedCheekMap("Red Cheek", 2D) = "white" {}
        _RedCheekIntensity("Red Cheek Intensity", Vector) = (0, 0, 0, 0)

        // [Space]
        // [Header(WeatherSetting)]
        [Toggle] _RainDrop_Normal("RainDrop Normal", Float) = 0
        _Wetness("Weatness", Range(0, 10)) = 1
        _RainMaskMap("Rain MaskMap", 2D) = "white" {}
        _RainTiling("Rain Tiling", Vector) = (1, 1, 1, 1)

        _RainNormalMap ("_Rain NormalMap", 2D) = "bump" {}
        _RainNormalScale("_RainNormalScale", Range(0, 10)) = 1

        _RainDropSize("_RainDrop Size", Range(0, 10)) = 1
        _RainAnimationSpeed("_RainAnimationSpeed", Range(0, 0.2)) = 0.1

        _RainDistortionMap("_Rain DistortionMap", 2D) = "white" {}
        _RainDistortionScale("_RainDistortionScale", Range(0, 2)) = 1
        _RainDistortionSize("_RainDistortionSize", Range(0, 2)) = 1

        [Toggle] _RainDrop_Procedure("RainDrop Procedure", Float) = 0
        _UVGridSize("UV Grid Size", Vector) = (6, 6, 0, 0)
		_RainAmount("_RainAmount", Range(0, 1)) = 1
		_DynamicRainDropSpeed("_DynamicRainDropSpeed", Range(0, 2)) = 0.1
		_DynamiceLayer1Tiling("_DynamiceLayer1Tiling", Range(0, 2)) = 0.1
		_DynamiceLayer2Tiling("_DynamiceLayer2Tiling", Range(0, 2)) = 0.1


        [Header(Occlusion)]
		[NoScaleOffset]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionColor("Occlusion Color", Color) = (0,0,0,0)
		[Toggle]_Cavity("_Cavity", Range( 0 , 1)) = 1
		_CavityStrength("_Cavity Strength", Range( 0 , 1)) = 0
		_Occlusionfinalpass("Occlusion final pass", Range( 0 , 1)) = 0.5
		_Occlusionlightpass("Occlusion light pass", Range( 0 , 1)) = 0.5
		_SpecularOcclusion("Specular Occlusion", Range( 0 , 1)) = 1

        [Header(Transmission)]
        // TransmissionSetting
        _TransmissionMap("TransmissionMap/Thickness", 2D) = "white" {}
		_TransmissionColor("TransmissionColor", Color) = (0.7830189,0.5276353,0.2245639,0)
        _Transmission_intensity("Transmission Intensity", Range( 0 , 5)) = 0.5

        _TransmissionGradient("TransmissionGradient", 2D) = "white" {}
		_GradientMin("GradientMin", Range( -1 , 1)) = 0
		_GradientMax("GradientMax", Range( 0 , 4)) = 1

		_Travel_Distance("Travel Distance MainLight", Range( 0 , 0.02)) = 0.01
		_TravelDistancePointLights("Travel Distance PointLights", Range( 0 , 0.02)) = 0.01

		[Enum(x1,1,x2,2,x4,4,x8,8,x16,16)] _TravelDistanceMult("TravelDistance Multiplier", Range( 1 , 6)) = 1
		_Transmission_Bias("Transmission Bias", Range( 0 , 0.5)) = 0


		[Toggle]_MaskWithNormals("Mask with normals", Range( 0 , 1)) = 0
		_CancelMin("CancelMin", Range( -1 , 0)) = -0.5
		_CancelMax("CancelMax", Range( 0 , 1)) = 0
        
        [Space]
        [Header(SpecSetting)]
        [NoScaleOffset]_SpecGlossMap("Specular Map", 2D) = "white" {}
        _SpecColor("Specular Color", Color) = (0.08490568, 0.08490568, 0.08490568, 1)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.65
		// [Enum(x1,1,x2,2,x4,4,x8,8,x16,16)]_SmoothnessMult("Multiplier", Range( 1 , 6)) = 1

		// _FresnelIntensity("FresnelIntensity", Range( 0 , 1)) = 0.55
        // _EnvironmentReflectionsIntensity("EnvironmentReflectionsIntensity", Range( 0 , 3)) = 1
		_SpecularHighlightIntensity("SpecularHighlightIntensity", Range( 0 , 20)) = 1

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
        [HideInInspector] _ProfileMap("Profiler Map", 2D) = "white" {}
        [HideInInspector] _ProfileColor ("Profiler Color", Color) = (1, 1, 1, 1)
        [HideInInspector] _Blur("Blur", Range(0, 1)) = 0.5
    }

    SubShader
    {
		Tags 
        { 
            "RenderPipeline"="UniversalPipeline" 
            "RenderType"="Opaque" 
        }

        Pass
        {
			Name "SSSObject Forward"
            Tags { "LightMode" = "UniversalForward" }

            Stencil
            {
                Ref 1
                comp Always
                pass Replace
            }

            HLSLPROGRAM
            // 声明顶点和片元着色器函数名
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
  
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            // #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            // #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION


            // -------------------------------------
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			// #pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			// #pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			// #pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma shader_feature_local_fragment _RAINDROP_NROMAL_ON
			#pragma shader_feature_local_fragment _RAINDROP_PROCEDURE_ON

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "./Common.hlsl"
            #include "./SSSObjectInput.hlsl"
            #include "./RainDropNormal.hlsl"
            #include "./RainDropProcedure.hlsl"

            // 片元着色器
            half4 frag(Varyings input, bool isFacing : SV_IsFrontFace) : SV_Target
            {
                // --- 准备数据 ---
                float3 positionWS = input.positionWS;

                // 采样基础纹理并叠加颜色
                half4 baseMap = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);
                half3 albedo = baseMap.rgb * _Color.rgb;

                float2 screenUV = input.screenPos.xy / input.screenPos.w;
                half4 sssBlur = SAMPLE_TEXTURE2D(_SSS_Blur, sampler_SSS_Blur, screenUV);
                
                half4 diffuseColor = baseMap * sssBlur;
                
                half wetness = 1.0f;
                #if _RAINDROP_PROCEDURE_ON
                half4 rainDropColor = RainDropFunction(input);
                diffuseColor = rainDropColor * sssBlur;
                wetness = _Wetness;
                #endif

                half4 maskMap = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, input.uv);

                // Occlusion
                half4 occlusionMap = SAMPLE_TEXTURE2D(_OcclusionMap, sampler_OcclusionMap, input.uv);
                half4 occlusionColor = lerp(_OcclusionColor, 1, occlusionMap.r);
                half4 occlusionFinalPass = lerp(half4(1, 1, 1, 0), occlusionColor, _Occlusionfinalpass);
                half4 occlusionLightPass = lerp(half4(1, 1, 1, 0), occlusionColor, _Occlusionlightpass); 

                diffuseColor *= occlusionFinalPass;

                // 采样法线贴图并解包 (UnpackNormalScale 处理了纹理压缩和强度缩放)
                float4 normal = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, input.uv);
                half3 normalTS = UnpackNormalScale(normal, _NormalIntensity);

                #if _RAINDROP_NROMAL_ON
                normalTS = ApplyWeather(input.positionWS.xyz, input.normalWS.xyz, input.uv, normalTS);
                wetness = _Wetness;
                #endif

				half3 normalWS = TransformTangentToWorld(normalTS, half3x3(input.tangentWS.xyz, input.bitangentWS.xyz, input.normalWS.xyz));

				normalWS = normalize(normalWS);

                // // ASE 计算 NormalWS 方法
				// float3 ase_worldTangent = input.ase_texcoord4.xyz;
				// float3 ase_worldNormal = input.ase_texcoord5.xyz;
				// float3 ase_worldBitangent = input.ase_texcoord6.xyz;

				// float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				// float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				// float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				// float3 tanNormal610 = normalTS;
				// float3 worldNormal610 = normalize( float3(dot(tanToWorld0,tanNormal610), dot(tanToWorld1,tanNormal610), dot(tanToWorld2,tanNormal610)) );
                // normalWS = worldNormal610;


                half3 viewWS = normalize(GetWorldSpaceViewDir(input.positionWS));
                float2 lightmapUV = input.uv;
                float3 GI = float3(1, 1, 1);
                
                // 高光
                // half specularOcclusion = lerp(1, occlusionMap.g, _SpecularOcclusion);
                half specularOcclusion = lerp(1, maskMap.b, _SpecularOcclusion);
                // half specularOcclusion = maskMap.b;
                
                // half cavity = lerp(1, occlusionMap.b, _CavityStrength);
                half cavity = lerp(1, maskMap.b, _CavityStrength);
                cavity = lerp(1, cavity, _Cavity);

                half4 specGlossMap = SAMPLE_TEXTURE2D(_SpecGlossMap, sampler_SpecGlossMap, input.uv);
                half3 specColor = specGlossMap.rgb * _SpecColor * cavity;

                // half smoothness = specGlossMap.a * _SpecColor.a * _Smoothness;
                half smoothness = maskMap.r;

                half3 finalSpec = SpecularLightingFull(positionWS, normalWS, specColor,
                                    smoothness, viewWS, lightmapUV);

                finalSpec *= _SpecularHighlightIntensity * wetness * specularOcclusion;

                half3 finalColor = diffuseColor.rgb + finalSpec;

                return half4(finalColor, 1);
            }

            ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // -------------------------------------
            // Render State Commands
            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull[_Cull]

            HLSLPROGRAM
            #pragma target 2.0

            // -------------------------------------
            // Shader Stages
            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            // -------------------------------------
            // Universal Pipeline keywords

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile_fragment _ LOD_FADE_CROSSFADE

            // This is used during shadow map generation to differentiate between directional and punctual light shadows, as they use different formulas to apply Normal Bias
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

            // -------------------------------------
            // Includes
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // -------------------------------------
            // Render State Commands
            ZWrite On
            ColorMask R
            Cull[_Cull]

            HLSLPROGRAM
            #pragma target 2.0

            // -------------------------------------
            // Shader Stages
            #pragma vertex DepthOnlyVertex
            #pragma fragment DepthOnlyFragment

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile_fragment _ LOD_FADE_CROSSFADE

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            // -------------------------------------
            // Includes
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/DepthOnlyPass.hlsl"
            ENDHLSL
        }

        // This pass is used when drawing to a _CameraNormalsTexture texture
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // -------------------------------------
            // Render State Commands
            ZWrite On
            Cull[_Cull]

            HLSLPROGRAM
            #pragma target 2.0

            // -------------------------------------
            // Shader Stages
            #pragma vertex DepthNormalsVertex
            #pragma fragment DepthNormalsFragment

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local _ _DETAIL_MULX2 _DETAIL_SCALED
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile_fragment _ LOD_FADE_CROSSFADE

            // -------------------------------------
            // Universal Pipeline keywords
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            // -------------------------------------
            // Includes
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitDepthNormalsPass.hlsl"
            ENDHLSL
        }

    }

    CustomEditor "SubsurfaceShaderGUI"
}