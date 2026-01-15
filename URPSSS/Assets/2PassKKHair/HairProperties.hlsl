#ifndef UNIVERSAL_SURFACE_DATA_INCLUDED
#define UNIVERSAL_SURFACE_DATA_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

struct SurfaceData
{
    half3 albedo;
    half3 specular;
    half metallic;
    half smoothness;
    half anisotropy;
    half occlusion;

    half3 normalTS;
    half3 tangentTS;

    half3 emission;
    half alpha;
    
    half3 transmittanceColor;
};

SurfaceData EmptyFill()
{
    SurfaceData data = (SurfaceData)0;

    data.tangentTS = half3(1.0, 1.0, 0.0);

    data.occlusion = 1.0h;

    return data;
}

struct VectorsData
{
    half3 geomNormalWS;
    half3 normalWS;
    half3 bentNormalWS;
    half3 coatNormalWS;
    half3 viewDirectionWS;
    half4 tangentWS;
    half3 bitangentWS;
};

VectorsData CreateEmptyVectorsData()
{
    const VectorsData data = (VectorsData)0;

    return data;
}


CBUFFER_START(UnityPerMaterial)
half _Surface;
half4 _DoubleSidedConstants;
half _AlphaCutoff;
half _AlphaCutoffShadow;
half _SpecularAAScreenSpaceVariance;
half _SpecularAAThreshold;

float4 _BaseMap_ST;
half4 _BaseColor;
half _AlphaRemapMin;
half _AlphaRemapMax;
half _NormalScale;

half _AORemapMin;
half _AORemapMax;

float4 _SmoothnessMaskMap_ST;
half _Smoothness;
half _SmoothnessRemapMin;
half _SmoothnessRemapMax;

half4 _SpecularColor;
half _SpecularMultiplier;
half _SpecularShift;
half _SecondarySpecularMultiplier;
half _SecondarySpecularShift;

half4 _TransmissionColor;
half _TransmissionIntensity;

// half4 _StaticLightColor;
// half4 _StaticLightVector;
CBUFFER_END

struct HairData
{
    half3 specularTint;
    half3 secondarySpecularTint;

    half specularShift;
    half secondarySpecularShift;
    
    half perceptualSmoothness;
    half secondaryPerceptualSmoothness;
    
    half3 transmissionColor;
    half transmissionIntensity;
};

float4 _BaseMap_TexelSize;

TEXTURE2D(_BaseMap);                SAMPLER(sampler_BaseMap);
TEXTURE2D(_NormalMap);              SAMPLER(sampler_NormalMap);
TEXTURE2D(_AmbientOcclusionMap);    SAMPLER(sampler_AmbientOcclusionMap);
TEXTURE2D(_SmoothnessMaskMap);      SAMPLER(sampler_SmoothnessMaskMap);

///////////////////////////////////////////////////////////////////////////////
//                      Material Property Helpers                            //
///////////////////////////////////////////////////////////////////////////////

half RemapValue(half value, half2 range)
{
    return lerp(range.x, range.y, value);
}

half4 SampleAlbedoAlpha(half2 alphaRemap, float2 uv, TEXTURE2D_PARAM(albedoAlphaMap, sampler_albedoAlphaMap))
{
    half4 albedoAlpha = half4(SAMPLE_TEXTURE2D(albedoAlphaMap, sampler_albedoAlphaMap, uv));
    half alpha = RemapValue(albedoAlpha.a, alphaRemap);

    return half4(albedoAlpha.rgb, alpha);
}

half4 SampleAlbedoAlpha(half4 color, half2 alphaRemap, float2 uv, TEXTURE2D_PARAM(albedoAlphaMap, sampler_albedoAlphaMap))
{
    half4 albedoAlpha = SampleAlbedoAlpha(alphaRemap, uv, TEXTURE2D_ARGS(albedoAlphaMap, sampler_albedoAlphaMap));

    return color * albedoAlpha;
}

half Alpha(half alpha, half cutoff)
{
    #if defined(_ALPHATEST_ON)
        clip(alpha - cutoff);
    #endif

    return alpha;
}

half3 ScaleNormal(half4 normal, half scale)
{
    #if BUMP_SCALE_NOT_SUPPORTED
        return UnpackNormal(normal);
    #else
        return UnpackNormalScale(normal, scale);
    #endif
}

half3 SampleNormal(float2 uv, TEXTURE2D_PARAM(normalMap, sampler_normalMap), half scale = half(1.0))
{
    #if defined(_NORMALMAP)
        half4 normal = SAMPLE_TEXTURE2D(normalMap, sampler_normalMap, uv);
        return ScaleNormal(normal, scale);
    #else
        return half3(0.0h, 0.0h, 1.0h);
    #endif
}


#endif