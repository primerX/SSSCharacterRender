Shader "Hidden/SeparableSubsurfaceScatter"
{
    Properties
    {
        [HideInInspector] _MainTex ("Base (RGB)", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }
        
        // 屏幕后处理的标准状态
        // ZTest Always
        // ZWrite Off
        // Cull Off

        ZTest LEqual
        ZWrite On
        Cull Back

        // Stencil{
        //     Ref 5
        //     comp equal
        //     pass keep
        // }


        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "SeparableSubsurface.hlsl"

        ENDHLSL

        // Pass 0: XBlur (水平模糊)
        Pass
        {
            Name "XBlur"
            
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment FragX
            
            #pragma multi_compile_fragment _ _FIRST_BLUR

            half4 FragX(Varyings input) : SV_Target
            {
                // 采样主纹理
                half4 SceneColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
                // half4 SceneColor = SAMPLE_TEXTURE2D(_SSS_LightPass, sampler_SSS_LightPass, input.uv);
                
                // 计算 SSS 强度
                float SSSIntencity = (_SSSScale * _CameraDepthTexture_TexelSize.x);
                
                half3 XBlur = SSS(SceneColor, input.uv, float2(SSSIntencity, 0)).rgb;
                
                return float4(XBlur, SceneColor.a);
            }
            ENDHLSL
        }

        // Pass 1: YBlur (垂直模糊)
        Pass
        {
            Name "YBlur"
            
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment FragY
            
            half4 FragY(Varyings input) : SV_Target
            {
                half4 SceneColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
                
                float SSSIntencity = (_SSSScale * _CameraDepthTexture_TexelSize.y);
                
                half3 YBlur = SSS(SceneColor, input.uv, float2(0, SSSIntencity)).rgb;
                
                return float4(YBlur, SceneColor.a);
            }
            ENDHLSL
        }
    }
}