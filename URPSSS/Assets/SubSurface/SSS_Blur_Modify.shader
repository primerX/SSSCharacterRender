Shader "Hidden/SSS_Blur_Modify_URP"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        // 如果有其他属性可以在这里暴露，但通常Hidden Shader由脚本控制
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" }
        ZTest Always ZWrite Off Cull Off

        Pass
        {
            Name "SSS_Blur_Pass"

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile _ PROFILE_TEST
            #pragma multi_compile _ NORMAL_TEST

            // 引入 URP 核心库
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"

            // 如果你已经将 SSS_Common.hlsl 转换为 URP 格式，请取消下面这行的注释，并删除下方手写的 Helper Functions
            // #include "SSS_Common.hlsl"

            // ------------------------------------------------------------------
            // Helper Functions (用于替代 SSS_Common.hlsl 中的可能内容)
            // ------------------------------------------------------------------
            inline float Pow2(float x)
            {
                return x * x;
            }

            // 简单的深度测试权重计算 (Bilateral Filter weight)
            // 假设逻辑：如果深度差异过大，权重归零，避免边缘溢出
            inline float DepthTest(float centerDepth, float sampleDepth)
            {
                // 这里是一个通用的双边滤波深度权重算法，你可以根据原 SSS_Common 修改参数
                float depthDiff = abs(centerDepth - sampleDepth);
                return 1.0 / (1.0 + depthDiff * 100.0); 
            }
            // ------------------------------------------------------------------

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float2 uv : TEXCOORD0;
                float4 positionCS : SV_POSITION;
            };

            // 纹理声明
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            TEXTURE2D(_SSS_ProfilePass);
            SAMPLER(sampler_SSS_ProfilePass);

            TEXTURE2D(_NoiseTexture);
            SAMPLER(sampler_NoiseTexture);

            // _CameraDepthTexture 已经在 DeclareDepthTexture.hlsl 中声明了
            // 如果需要手动采样特定 LOD，可以使用 _CameraDepthTexture

            // CBuffer 用于 SRP Batcher
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_TexelSize;
                float4 _MainTex_ST;
                
                float _offset;
                float _Dither;
                float DitherScale;
                
                // 原代码中使用了 _FixPixelLeak 但未在变量列表声明，这里补上
                float _FixPixelLeak; 
                
                int _SSS_NUM_SAMPLES;
            CBUFFER_END

            Varyings vert(Attributes input)
            {
                Varyings output;
                // URP 顶点变换
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {
                float2 uv = input.uv;
                
                // 采样 Profile Pass
                half4 profile = max(1e-6, SAMPLE_TEXTURE2D(_SSS_ProfilePass, sampler_SSS_ProfilePass, uv));

                // 获取中心像素深度 (URP 中使用 SampleSceneDepth)
                // 注意：SampleSceneDepth 返回的是非线性深度 (0-1 或 1-0)
                float rawDepth = SampleSceneDepth(uv);
                float d0 = LinearEyeDepth(rawDepth, _ZBufferParams);

                // 计算缩放
                float scale = _offset * (1.0 / d0);
                scale *= profile.a;

                float3 weightSum = 0.0f;

                float d1, d2, d3, d4;
                half4 col = 0;
                
                scale = min(0.2, scale); // Limit radius

                // 默认采样数，防止未初始化
                int numSamples = _SSS_NUM_SAMPLES > 0 ? _SSS_NUM_SAMPLES : 10;

                for (int k = 0; k < numSamples; k++)
                {
                    float step = (float)k / numSamples;
                    float2 offset = (float2)step * (float2)scale;

                    // Dither 代码在原文件中被注释了，这里保持注释状态
                    
                    // Depth test - 使用 LOD 采样避免梯度问题
                    // URP 中 _CameraDepthTexture 通常是 float 类型
                    // 注意：URP 的 _CameraDepthTexture 采样通常不需要 sampler，可以直接用 Load 或 SAMPLE_TEXTURE2D_LOD
                    
                    float rawD1 = SAMPLE_TEXTURE2D_LOD(_CameraDepthTexture, sampler_CameraDepthTexture, uv + float2(offset.x, offset.y), 0).r;
                    float rawD2 = SAMPLE_TEXTURE2D_LOD(_CameraDepthTexture, sampler_CameraDepthTexture, uv + float2(offset.x, -offset.y), 0).r;
                    float rawD3 = SAMPLE_TEXTURE2D_LOD(_CameraDepthTexture, sampler_CameraDepthTexture, uv + float2(-offset.x, offset.y), 0).r;
                    float rawD4 = SAMPLE_TEXTURE2D_LOD(_CameraDepthTexture, sampler_CameraDepthTexture, uv + float2(-offset.x, -offset.y), 0).r;

                    d1 = LinearEyeDepth(rawD1, _ZBufferParams);
                    d2 = LinearEyeDepth(rawD2, _ZBufferParams);
                    d3 = LinearEyeDepth(rawD3, _ZBufferParams);
                    d4 = LinearEyeDepth(rawD4, _ZBufferParams);

                    float DepthTest1 = DepthTest(d0, d1);
                    float DepthTest2 = DepthTest(d0, d2);
                    float DepthTest3 = DepthTest(d0, d3);
                    float DepthTest4 = DepthTest(d0, d4);

                    float EdgeTest1 = DepthTest1;
                    float EdgeTest2 = DepthTest2;
                    float EdgeTest3 = DepthTest3;
                    float EdgeTest4 = DepthTest4;

                    // 计算权重
                    float3 weight = exp(-Pow2(step / profile.rgb)); // 假设 profile 是 float4，此处取 rgb
                    weightSum += weight;

                    // Fix pixel leaks
                    float OffsetConstrain = _FixPixelLeak;
                    float2 Offset1 = float2(offset.x * EdgeTest1, offset.y * EdgeTest1) * OffsetConstrain;
                    float2 Offset2 = float2(offset.x * EdgeTest2, -offset.y * EdgeTest2) * OffsetConstrain;
                    float2 Offset3 = float2(-offset.x * EdgeTest3, offset.y * EdgeTest3) * OffsetConstrain;
                    float2 Offset4 = float2(-offset.x * EdgeTest4, -offset.y * EdgeTest4) * OffsetConstrain;

                    // 累加颜色
                    col.rgb += SAMPLE_TEXTURE2D_LOD(_MainTex, sampler_MainTex, saturate(uv + Offset1), 0).rgb * weight * 0.25;
                    col.rgb += SAMPLE_TEXTURE2D_LOD(_MainTex, sampler_MainTex, saturate(uv + Offset2), 0).rgb * weight * 0.25;
                    col.rgb += SAMPLE_TEXTURE2D_LOD(_MainTex, sampler_MainTex, saturate(uv + Offset3), 0).rgb * weight * 0.25;
                    col.rgb += SAMPLE_TEXTURE2D_LOD(_MainTex, sampler_MainTex, saturate(uv + Offset4), 0).rgb * weight * 0.25;
                }
                
                col.rgb = max(1e-6, col.rgb / weightSum);
                return col;
            }
            ENDHLSL
        }

        // ------------------------------------------------------------------
        // Bilateral Blur
        // ------------------------------------------------------------------

        // 1 - Horizontal
        Pass
        {
            Name "SSAO_Bilateral_HorizontalBlur"

            HLSLPROGRAM
                #pragma vertex Vert
                #pragma fragment HorizontalBlur

                #include "./Blur.hlsl"

            ENDHLSL
        }

        // 2 - Vertical
        Pass
        {
            Name "SSAO_Bilateral_VerticalBlur"

            HLSLPROGRAM
                #pragma vertex Vert
                #pragma fragment VerticalBlur

                #include "./Blur.hlsl"
            ENDHLSL
        }

        // 3 - Final
        Pass
        {
            Name "SSAO_Bilateral_FinalBlur"

            HLSLPROGRAM
                #pragma vertex Vert
                #pragma fragment FinalBlur
                #include "./Blur.hlsl"

            ENDHLSL
        }	

    }
}
