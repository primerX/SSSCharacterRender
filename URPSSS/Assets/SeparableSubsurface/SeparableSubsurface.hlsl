#ifndef _SEPARABLE_SURFACE_HLSL_
#define _SEPARABLE_SURFACE_HLSL_

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"

#define DistanceToProjectionWindow 5.671281819617709             //1.0 / tan(0.5 * radians(20));
#define DPTimes300 1701.384545885313                             //DistanceToProjectionWindow * 300
#define SamplerSteps 25
// #define SamplerSteps 9

TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);

TEXTURE2D(_SSS_LightPass);
SAMPLER(sampler_SSS_LightPass);

float4 _MainTex_ST;
float4 _SSS_LightPass_ST;
float4 _CameraDepthTexture_TexelSize;
// float4 _MainTex_TexelSize;

float _SSSScale;
// int _SamplerSteps;

uniform float4 _Kernel[SamplerSteps];

#define CustomKernelSize 9
static float4 customKernel[9] = 
{
    float4( 0.1804, 0.3333, 0.4986 ,  0.0 ),
    float4( 0.1666, 0.2356, 0.2283 , -1.0 ),
    float4( 0.1666, 0.2356, 0.2283 ,  1.0 ),
    float4( 0.1310, 0.0830, 0.0219 , -2.0 ),
    float4( 0.1310, 0.0830, 0.0219 ,  2.0 ),
    float4( 0.0878, 0.0147, 0.00044, -3.0 ),
    float4( 0.0878, 0.0147, 0.00044,  3.0 ),
    float4( 0.0244, 0.000056, 0.0  , -5.0 ),
    float4( 0.0244, 0.000056, 0.0  ,  5.0 ),
};

// static float4 customKernel[CustomKernelSize] = 
// {
//     float4( 0.1611, 0.3333, 0.4986 ,  0.0 ),
//     float4( 0.1524, 0.2356, 0.2283 , -1.0 ),
//     float4( 0.1524, 0.2356, 0.2283 ,  1.0 ),
//     float4( 0.1290, 0.0830, 0.0219 , -2.0 ),
//     float4( 0.1290, 0.0830, 0.0219 ,  2.0 ),
//     float4( 0.0977, 0.0147, 0.00044, -3.0 ),
//     float4( 0.0977, 0.0147, 0.00044,  3.0 ),
//     float4( 0.0402, 0.000056, 0.0  , -5.0 ),
//     float4( 0.0977, 0.000056, 0.0  ,  5.0 ),
// };


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


Varyings Vert(Attributes input)
{
    Varyings output;
    // URP 顶点变换
    output.positionCS = TransformObjectToHClip(input.positionOS.xyz);

    // #if _FIRST_BLUR
    //     output.uv = TRANSFORM_TEX(input.uv, _SSS_LightPass);
    // #else
    //     output.uv = TRANSFORM_TEX(input.uv, _MainTex);
    // #endif

    // output.uv = TRANSFORM_TEX(input.uv, _MainTex);
    output.uv = input.uv;

    return output;
}

half4 SSS(half4 SceneColor, float2 UV, float2 SSSIntencity) 
{
    float rawDepth = SampleSceneDepth(UV);
    float SceneDepth = LinearEyeDepth(rawDepth, _ZBufferParams);

    float BlurLength = DistanceToProjectionWindow / SceneDepth;                                   
    float2 UVOffset = SSSIntencity * BlurLength;                      
    half4 BlurSceneColor = SceneColor;

    BlurSceneColor.rgb *=  _Kernel[0].rgb;  

    [loop]
    for (int i = 1; i < SamplerSteps; i++) 
    {
        float2 SSSUV = UV +  _Kernel[i].a * UVOffset;

        // #if _FIRST_BLUR
        //     half4 SSSSceneColor = SAMPLE_TEXTURE2D(_SSS_LightPass, sampler_SSS_LightPass, SSSUV);
        // #else
        //     half4 SSSSceneColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, SSSUV);
        // #endif

        half4 SSSSceneColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, SSSUV);

        float SSSDepth = LinearEyeDepth(SampleSceneDepth(SSSUV), _ZBufferParams).r;

        float SSSScale = saturate(DPTimes300 * SSSIntencity * abs(SceneDepth - SSSDepth));

        SSSSceneColor.rgb = lerp(SSSSceneColor.rgb, SceneColor.rgb, SSSScale);
        
        BlurSceneColor.rgb +=  _Kernel[i].rgb * SSSSceneColor.rgb;
    }

    return BlurSceneColor;
}


#endif