Shader "Shenkong/SSSProfilerPass"
{
    Properties
    {
        _ProfileMap("Profiler Map", 2D) = "white" {}
        _ProfileColor ("Profiler Color", Color) = (1, 1, 1, 1)

        _Blur("Blur", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull Off

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM
            // 声明顶点和片元着色器函数名
            #pragma vertex vert
            #pragma fragment frag

            // 引入 URP 核心库和光照库
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            // 定义 CBUFFER (常量缓冲区) 以支持 SRP Batcher 优化
            CBUFFER_START(UnityPerMaterial)
                half4 _ProfileColor;
                half _Blur;
            CBUFFER_END

            TEXTURE2D(_ProfileMap);        SAMPLER(sampler_ProfileMap);

            // 顶点着色器输入结构体
            struct Attributes
            {
                float4 positionOS : POSITION; // 物体空间坐标
                float3 normalOS   : NORMAL;   // 物体空间法线
                float2 uv         : TEXCOORD0;// UV坐标
            };

            // 顶点 -> 片元 传递结构体
            struct Varyings
            {
                float4 positionCS : SV_POSITION; // 裁剪空间坐标
                float3 positionWS : TEXCOORD0;   // 世界空间坐标
                float2 uv         : TEXCOORD1;

                float3 normalWS   : TEXCOORD2;   // 世界空间法线
                float3 tangentWS : TEXCOORD3;
                float3 bitangentWS : TEXCOORD4;
            };

            // 顶点着色器
            Varyings vert(Attributes input)
            {
                Varyings output;
                
                // 1. 空间变换：物体空间 -> 世界空间 -> 裁剪空间
                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                output.positionCS = vertexInput.positionCS;
                output.positionWS = vertexInput.positionWS;

                // 2. 法线变换：物体空间 -> 世界空间
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS);
                output.normalWS = normalInput.normalWS;
                output.tangentWS = normalInput.tangentWS;
                output.bitangentWS = normalInput.bitangentWS;

                // 3. UV 变换
                output.uv = input.uv;

                return output;
            }

            // 片元着色器
            half4 frag(Varyings input) : SV_Target
            {
                half4 profilerMap = SAMPLE_TEXTURE2D(_ProfileMap, sampler_ProfileMap, input.uv);
                half3 albedo = profilerMap.rgb * _ProfileColor.rgb;
                half alpha = profilerMap.a * _ProfileColor.a * _Blur;

                return half4(albedo, alpha);
            }
            ENDHLSL
        }
    }
}
