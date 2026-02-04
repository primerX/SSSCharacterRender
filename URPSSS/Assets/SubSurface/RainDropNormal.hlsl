#ifndef _RAIN_DROP_NORMAL_HLSL_
#define _RAIN_DROP_NORMAL_HLSL_

struct UVMapping
{
    float2 uv;  // Current uv or planar uv

    // Triplanar specific
    float2 uvZY;
    float2 uvXZ;
    float2 uvXY;

    float3 normalWS; // vertex normal
    float3 triplanarWeights;
};

UVMapping InitializeUVData(float3 position, float3 normalWS, float2 uv)
{
    UVMapping uvData = (UVMapping)0;

    uvData.uv = uv;

    uvData.uvXY = position.xy;
    uvData.uvXZ = position.xz;
    uvData.uvZY = position.zy;

    uvData.normalWS = normalWS;
    uvData.triplanarWeights = ComputeTriplanarWeights(normalWS);

    return uvData;
}


TEXTURE2D(_RainNormalMap);      SAMPLER(sampler_RainNormalMap);
TEXTURE2D(_RainMaskMap);      SAMPLER(sampler_RainMaskMap);
TEXTURE2D(_RainDistortionMap);      SAMPLER(sampler_RainDistortionMap);

half _Wetness;
half _RainDistortionSize;
half _RainDistortionScale;
half _RainAnimationSpeed;
half _RainDropSize;
half _RainNormalScale;

half4 _RainTiling;

half2 FlipbookAnimation(half2 uv, uint2 tilesSize, half speed) 
{
    half tileCountX = 1.0 / tilesSize.x;
    half tileCountY = 1.0 / tilesSize.y;

    uint frameIndex = speed % (tilesSize.x * tilesSize.y);

    uint indexX = frameIndex % tilesSize.x;
    uint indexY = tilesSize.y - 1 - (frameIndex / tilesSize.x);

    half2 offset = float2(tileCountX * indexX, tileCountY * indexY);

    return uv * float2(tileCountX, tileCountY) + offset;
}

half2 CalculateRainDistortion(half2 uv)
{
    half2 rainDistortionUV = uv * _RainDistortionSize;
    return SAMPLE_TEXTURE2D(_RainDistortionMap, sampler_LinearRepeat, rainDistortionUV).rg * _RainDistortionScale;
}

half3 SampleRainNormal(float2 uv, TEXTURE2D_PARAM(rainNormalMap, sampler_rainNormalMap), half scale = half(1.0))
{
    half4 normal = SAMPLE_TEXTURE2D(rainNormalMap, sampler_rainNormalMap, uv);
    return UnpackNormalScale(normal, scale);
}

half3 ApplyTriplanarRain(UVMapping uvMapping, half2 rainDistortion)
{
    half2 rainSpeed = half2(0.0, frac(_Time.y * _RainAnimationSpeed));
    half2 rainNormalUV_A = (uvMapping.uvXY + rainDistortion + rainSpeed) * _RainDropSize;
    half2 rainNormalUV_B = (uvMapping.uvZY + rainDistortion + rainSpeed) * _RainDropSize;

    rainNormalUV_A *= _RainTiling.xy;
    rainNormalUV_B *= _RainTiling.xy;

    half rainIntensity_A = _RainNormalScale * uvMapping.triplanarWeights.z;
    half rainIntensity_B = _RainNormalScale * uvMapping.triplanarWeights.x;

    half3 rainNormal_A = SampleRainNormal(rainNormalUV_A, TEXTURE2D_ARGS(_RainNormalMap, sampler_RainNormalMap), rainIntensity_A);
    half3 rainNormal_B = SampleRainNormal(rainNormalUV_B, TEXTURE2D_ARGS(_RainNormalMap, sampler_RainNormalMap), rainIntensity_B);

    return BlendNormal(rainNormal_A, rainNormal_B);
}


half3 ApplyWeather(float3 positionWS, float3 normalWS, float2 uv, float3 normalTS)
{
    // Initialize UV data
    UVMapping uvMapping = InitializeUVData(positionWS, normalWS, uv);
    
    half weatherMask = SAMPLE_TEXTURE2D(_RainMaskMap, sampler_RainMaskMap, uvMapping.uv).r;

    half rainMaskMultiplied = weatherMask * 1;

    half2 rainDistortionUV = uvMapping.uv * _RainDistortionSize;
    half2 rainDistortion = SAMPLE_TEXTURE2D(_RainDistortionMap, sampler_RainDistortionMap, rainDistortionUV).rg * _RainDistortionScale;

    half3 rainNormalTS = ApplyTriplanarRain(uvMapping, rainDistortion);

    normalTS = lerp(normalTS, BlendNormalRNM(rainNormalTS, normalTS), rainMaskMultiplied);

    return normalTS;
}


#endif