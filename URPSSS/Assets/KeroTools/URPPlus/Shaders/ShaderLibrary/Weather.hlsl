#ifndef WEATHER_INCLUDED
#define WEATHER_INCLUDED

#include "ShaderLibrary/TriplanarMapping.hlsl"

TEXTURE2D(_PuddlesNormal);
TEXTURE2D(_RainNormal); SAMPLER(sampler_RainNormal);
TEXTURE2D(_RainDistortionMap);
TEXTURE2D(_RainMaskMap);

half _RainMultiplier = 1.0;
half _Wetness = 0.0;
half4 _WetnessColor = half4(0.0, 0.0, 1.0, 0.0);

real2 FlipbookAnimation(real2 uv, uint2 tilesSize, half speed) 
{
    real tileCountX = 1.0 / tilesSize.x;
    real tileCountY = 1.0 / tilesSize.y;

    uint frameIndex = speed % (tilesSize.x * tilesSize.y);

    uint indexX = frameIndex % tilesSize.x;
    uint indexY = tilesSize.y - 1 - (frameIndex / tilesSize.x);

    real2 offset = float2(tileCountX * indexX, tileCountY * indexY);

    return uv * float2(tileCountX, tileCountY) + offset;
}

real2 CalculateRainDistortion(real2 uv)
{
    real2 rainDistortionUV = uv * _RainDistortionSize;

    return SAMPLE_TEXTURE2D(_RainDistortionMap, sampler_LinearRepeat, rainDistortionUV).rg * _RainDistortionScale;
}

half3 ApplyTriplanarRain(UVMapping uvMapping, real2 rainDistortion, half3 puddlesNormal)
{
    // Perform rain animation
    real2 rainSpeed = real2(0.0, frac(_Time.y * _RainAnimationSpeed));
    real2 rainNormalUV_A = (uvMapping.uvXY + rainDistortion + rainSpeed) * _RainSize;
    real2 rainNormalUV_B = (uvMapping.uvZY + rainDistortion + rainSpeed) * _RainSize;

    half rainIntensity_A  = _RainNormalScale * uvMapping.triplanarWeights.z;
    // half rainIntensity_A  = _RainNormalScale * uvMapping.triplanarWeights.y;
    half rainIntensity_B = _RainNormalScale * uvMapping.triplanarWeights.x;

    half3 rainNormal_A = SampleRainNormal(rainNormalUV_A, TEXTURE2D_ARGS(_RainNormal, sampler_LinearRepeat), rainIntensity_A);
    half3 rainNormal_B = SampleRainNormal(rainNormalUV_B, TEXTURE2D_ARGS(_RainNormal, sampler_LinearRepeat), rainIntensity_B);

    //反向
    rainNormal_A.xy *= -1;
    rainNormal_B.xy *= -1;
    // return rainNormal_B;
    // Final result
    return BlendNormal(puddlesNormal, BlendNormal(rainNormal_A, rainNormal_B));
    return BlendNormal(rainNormal_A, rainNormal_B);
}

void ApplyWeather(float3 positionWS, float3 normalWS, float2 uv, inout half3 albedo, inout half3 normalTS, inout half smoothness)
{
    // Initialize UV data
    UVMapping uvMapping = InitializeUVData(positionWS, normalWS, uv);
    
    half weatherMask = SAMPLE_TEXTURE2D(_RainMaskMap, sampler_LinearRepeat, uvMapping.uv).r;
    half rainMaskMultiplied = weatherMask * _RainMultiplier;
    half wetnessFactor = _Wetness * _RainWetnessFactor * weatherMask;
    
    if(rainMaskMultiplied > 0 || wetnessFactor > 0)
    {
        real2 rainDistortion = CalculateRainDistortion(uvMapping.uv);
        // Perform puddles animation
        real2 puddlesUV = FlipbookAnimation(frac(uvMapping.uvXZ * _PuddlesSize), _PuddlesFramesSize.xy, _Time.y * _PuddlesAnimationSpeed);
        half3 puddlesNormalTS = SampleRainNormal(puddlesUV, TEXTURE2D_ARGS(_PuddlesNormal, sampler_LinearRepeat), _PuddlesNormalScale * saturate(uvMapping.normalWS.y));
    
        half3 rainNormalTS = puddlesNormalTS;
        #ifdef _RAIN_TRIPLANAR
        rainNormalTS = ApplyTriplanarRain(uvMapping, rainDistortion, puddlesNormalTS);
        // rainNormalTS = SampleRainNormal(uv, TEXTURE2D_ARGS(_RainNormal, sampler_RainNormal), _RainNormalScale);
        #endif

        albedo = lerp(albedo, _WetnessColor.rgb, wetnessFactor * _WetnessColor.a);
        normalTS = lerp(normalTS, BlendNormalRNM(rainNormalTS, normalTS), rainMaskMultiplied);
    }

    smoothness = lerp(smoothness, 1.0h, wetnessFactor);
}

#endif