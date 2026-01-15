Shader "ShenKong/KKHair-2Pass"
{
    Properties
    {
        _AlphaCutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5
        _AlphaCutoffShadow("AlphaCutoffShadow", Range(0.0, 1.0)) = 0.5
       
        [Header(BaseSetting)]
        [MainTexture] _BaseMap("Albedo", 2D) = "white" {}
        [MainColor] _BaseColor("Color", Color) = (1,1,1,1)
        _AlphaRemapMin("AlphaRemapMin", Range(0.0, 1.0)) = 0.0
        _AlphaRemapMax("AlphaRemapMax", Range(0.0, 1.0)) = 1.0

        [Space]
        [Header(AOSetting)]
        _AmbientOcclusionMap("AmbientOcclusionMap", 2D) = "white" {}
        _AORemapMin("AORemapMin", Range(0.0, 1.0)) = 0.0
        _AORemapMax("AORemapMax", Range(0.0, 1.0)) = 1.0

        [Header(NormalSetting)]
        [Normal] _NormalMap("NormalMap", 2D) = "bump" {}
        _NormalScale("NormalScale", Range(0.0, 8.0)) = 1

        [Header(SmoothnessSetting)]
        _SmoothnessMaskMap("SmoothnessMaskMap", 2D) = "white" {}
        _Smoothness("Smoothness", Range(0.0, 1.0)) = 0.5
        _SmoothnessRemapMin("SmoothnessRemapMin", Range(0.0, 1.0)) = 0.0
        _SmoothnessRemapMax("SmoothnessRemapMax", Range(0.0, 1.0)) = 1.0

        [Header(SpecularSetting)]
        _SpecularColor("SpecularColor", Color) = (0.2, 0.2, 0.2, 1.0)
        _SpecularMultiplier("SpecularMultiplier", Range(0.0, 5.0)) = 1.0
        _SpecularShift("SpecularShift", Range(-5, 5)) = 1.0
        _SecondarySpecularMultiplier("SpecularMultiplier", Range(0.0, 5.0)) = 1.0
        _SecondarySpecularShift("SpecularShift", Range(-5, 5)) = 1.0

        [Header(TransmissionSetting)]
        [HDR] _TransmissionColor("TransmissionColor", Color) = (0.2, 0.2, 0.2)
        _TransmissionIntensity("TransmissionIntensity", Range(0.0, 1.0)) = 1.0

        [Header(OtherSetting)]
        // [ToggleUI] _CastShadows("Cast Shadows", Float) = 0.0
        [ToggleUI] _ReceiveShadows("Receive Shadows", Float) = 1.0
        [ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
        [ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
        _QueueOffset("Queue offset", Float) = 0.0

    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalPipeline"
            "UniversalMaterialType" = "Lit"
            "IgnoreProjector" = "True"
        }

        Pass
        {
            Name "Hair Opaque"
            Tags 
            { 
                "LightMode" = "SRPDefaultUnlit" 
            }

            ZWrite On
            ZTest LEqual
            Cull Off

            HLSLPROGRAM
            #pragma vertex LitPassVertex
            #pragma fragment frag

            #include "./KKHairInput.hlsl"
            #include "./KKHairForwardPass.hlsl"

            half4 frag(Varyings input) : SV_Target
            {
                half4 texColor = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);
                half4 albedo = texColor * _BaseColor;
                clip(albedo.a - _AlphaCutoff);

                return albedo;
            }
            ENDHLSL
        }

        // ------------------------------------------------------------------
        Pass
        {
            Name "Hair Transparent"
            Tags
            {
                "LightMode" = "HairTransparent"
            }

            // -------------------------------------
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            ZWrite Off
            ZTest LEqual 
            Cull Off


            HLSLPROGRAM
            #pragma target 2.0

            // -------------------------------------
            // Shader Stages
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local _DOUBLESIDED_ON

            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local_fragment _AO_MAP
            #pragma shader_feature_local_fragment _SMOOTHNESS_MASK

            #pragma shader_feature_local _RECEIVE_SHADOWS_OFF
            #pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF


            // -------------------------------------
            // Universal Pipeline keywords
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS

            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS

            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION

            #pragma multi_compile_fragment _ _LIGHT_LAYERS

            #include "./KKHairInput.hlsl"
            #include "./KKHairForwardPass.hlsl"
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
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SHADOW_CUTOFF

            // This is used during shadow map generation to differentiate between directional and punctual light shadows, as they use different formulas to apply Normal Bias
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

            // -------------------------------------

            #include "./KKHairInput.hlsl"
            #include "./ShadowCasterPass.hlsl"
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
            ZTest[_ZTest]
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
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SHADOW_CUTOFF

            // -------------------------------------
            // Includes
            #include "./kkHairInput.hlsl"
            #include "./DepthOnlyPass.hlsl"

            ENDHLSL
        }

    }

    FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
