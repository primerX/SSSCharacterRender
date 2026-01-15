#ifndef UNIVERSAL_DEPTH_ONLY_PASS_INCLUDED
#define UNIVERSAL_DEPTH_ONLY_PASS_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

struct Attributes
{
    float4 positionOS : POSITION;
    float3 normalOS   : NORMAL;
    float2 texcoord : TEXCOORD0;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float2 uv : TEXCOORD0;
    float4 positionCS : SV_POSITION;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

Varyings DepthOnlyVertex(Attributes input)
{
    Varyings output = (Varyings)0;
    UNITY_SETUP_INSTANCE_ID(input);

    output.uv = TRANSFORM_TEX(input.texcoord, _BaseMap);
    output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
    
    return output;
}


half DepthOnlyFragment(Varyings input) : SV_TARGET
{
    half shadowCutoff = _AlphaCutoff;
    #ifdef SHADOW_CUTOFF
        shadowCutoff = _AlphaCutoffShadow;
    #endif

    half2 alphaRemap = half2(_AlphaRemapMin, _AlphaRemapMax);
    half albedoAlpha = SampleAlbedoAlpha(_BaseColor, alphaRemap, input.uv, TEXTURE2D_ARGS(_BaseMap, sampler_BaseMap)).a;
    Alpha(albedoAlpha, shadowCutoff);

    return input.positionCS.z;
}
#endif