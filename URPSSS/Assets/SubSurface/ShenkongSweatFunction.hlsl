#ifndef _SWEAT_FUNCTION_HLSL_
#define _SWEAT_FUNCTION_HLSL_

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

//Sweat
half4 _DropCellAspect;
half4 _DropSize;
half4 _SweatSize;
half4 _DropParams;

float4 _TexRotMatr;
TEXTURE2D(_SweatMap);      SAMPLER(sampler_SweatMap);

//通过UV格子id生成随机数
inline float4 GenerateWaterSeed4(float2 orgSeed)
{
    orgSeed = float2(orgSeed.x * orgSeed.y, orgSeed.x + orgSeed.y);
    float4 seed;
    seed.x = 0.4 * orgSeed.x + 0.6 * orgSeed.y;
    seed.y = 0.2 * orgSeed.x + 0.8 * orgSeed.y;
    seed.z = 1.1 * orgSeed.x + 0.3 * orgSeed.y;
    seed.w = 0.7 * orgSeed.x + 1.4 * orgSeed.y;

    return frac(frac(seed * 0.2187 + 0.381) * 0.8162);
}

// 模拟汗滴下落的轨迹
half move(half t)
{
    t = frac(t);
    half a = min(1, 5 * (1-t));
    t = 6 * a * a - 4 * a * a * a + min(2, 2.5 * t) - 3;
    return t;
}

half SweatFunction(Varyings input)
{
    half2 dropUV = input.uv;
    dropUV = mul(dropUV, rotationMatrix);
    dropUV = mul(dropUV - float2(0.5, 0.5), rotationMatrix) + float2(0.5, 0.5);

    half2 cellUV = dropUV * _DropCellAspect.zw;
    half2 cellIdx = floor(cellUV);
    half4 seed4 = GenerateWaterSeed4(cellIdx);
    cellUV = frac(cellUV);

    half2 randomSize = _DropSize.zw * (seed4.z * 0.8 + 0.2) * _SweatSize;
    half2 dropOffset = (seed4.xy - 0.5) * (1 - 2 * randomSize) + 0.5;
    half2 dropPos = cellUV - dropOffset;
    half2 cellAspect = half2(1, _DropCellAspect.z/_DropCellAspect.w);
    half drop = length(dropPos * cellAspect / randomSize);
    drop = saturate(1 - drop * drop);
    
    half2 waterMaskTex = SAMPLE_TEXTURE2D(_DropMaskTex, sampler_DropMaskTex, input.uv).rg;
    
    half2 waterMask = step(seed4.w, waterMaskTex.x * _DropParams.w);
    drop *= waterMask;
    half dropSmoothness = drop;

    return dropSmoothness;
}


#endif