Shader "G-Bits/2Pass_KajiyaKay_Hair"
{
    Properties
    {
        [Header(Base Settings)]
        _BaseMap ("Base Map", 2D) = "white" {}
        _BaseColor ("Base Color (Pass 1)", Color) = (1,1,1,1)
        
        [Header(Kajiya Kay Lighting)]
        _SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
        _SpecularShift ("Specular Shift", Range(-1.0, 1.0)) = 0.1
        _SpecularPower ("Specular Power", Range(1.0, 100.0)) = 20.0
        
        [Header(Pass 1 Settings)]
        [Toggle(_ALPHATEST_ON)]_AlphaClip ("Alpha Clip", Float) = 0
        _Cutoff ("Alpha Cutoff", Range(0.0, 1.0)) = 0.5
        
        [Header(Pass 2 Settings)]
        _BlendColor ("Blend Color (Pass 2)", Color) = (1,1,1,0.5)
        _ZOffset ("Pass 2 Z-Offset", Range(0, 0.05)) = 0.002
    }

    SubShader
    {

        // =================================================================
        // Pass 1: 核心层
        // =================================================================
        Pass
        {
            Name "KajiyaKayBase 1"
            Tags 
            { 
                "LightMode" = "SRPDefaultUnlit" 
            }

            ZWrite On
            ZTest LEqual
            Cull Off

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            // 修复关键字
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT


            #include "./HairCommon.hlsl"

            half4 frag(Varyings input) : SV_Target
            {
                half4 texColor = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);
                half4 albedo = texColor * _BaseColor;
                clip(albedo.a - _Cutoff);

                return albedo;

                // half3 mainLightRes = ComputeMainLight(input, albedo);
                // half3 addLightRes = ComputeAddLight(input, albedo);

                // // half spotShadow = ComputeAddLightAtten(input, albedo);
                
                // // float mainLightAtten = GetMainLightAtten(input, albedo);
                // // half3 screenColor = GetMainLightScreenColor(input, albedo);

                // half3 finalColor = mainLightRes + addLightRes;
                // return half4(finalColor, albedo.a);
            }
            ENDHLSL
        }

        // =================================================================
        // Pass 2: 透明外层
        // =================================================================
        Pass
        {
            Name "KajiyaKayBlend 2"
            Tags 
            {
                // "LightMode" = "UniversalForward"
                "LightMode" = "HairTransparent"
            } 

            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            ZWrite Off
            ZTest LEqual 
            Cull Off

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            // 修复关键字
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            // #pragma shader_feature_local _RECEIVE_SHADOWS_OFF

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "./HairCommon.hlsl"

            half4 frag(Varyings input) : SV_Target 
            {
                half4 texColor = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);
                half4 albedo = texColor * _BlendColor; 
                
                // return albedo;

                half3 mainLightRes = ComputeMainLight(input, albedo);
                half3 addLightRes = ComputeAddLight(input, albedo);

                // half spotShadow = ComputeAddLightAtten(input, albedo);
                
                // float mainLightAtten = GetMainLightAtten(input, albedo);
                // half3 screenColor = GetMainLightScreenColor(input, albedo);

                half3 finalColor = mainLightRes + addLightRes;
                return half4(finalColor, albedo.a);
            }
            ENDHLSL
        }

        // ShadowCaster
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
        
        // DepthOnly
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

        // DepthNormal
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

            #pragma shader_feature_local _ALPHATEST_ON

            // -------------------------------------
            // Universal Pipeline keywords
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"

            // -------------------------------------
            // Includes
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitDepthNormalsPass.hlsl"
            ENDHLSL
        }
    
    }
}