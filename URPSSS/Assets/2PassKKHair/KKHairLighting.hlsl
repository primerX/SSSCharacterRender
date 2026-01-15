#ifndef UNIVERSAL_LIGHTING_INCLUDED
#define UNIVERSAL_LIGHTING_INCLUDED


// #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RealtimeLights.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/BRDF.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/GlobalIllumination.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/AmbientOcclusion.hlsl"
// #include "./VectorsData.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

#include "./UniversalGlobalIllumination.hlsl"

#if !defined(LIGHTMAP_ON)
// TODO: Controls things like these by exposing SHADER_QUALITY levels (low, medium, high)
#if !defined(_NORMALMAP)
        // Evaluates SH fully in vertex
        #define EVALUATE_SH_VERTEX
#elif !SHADER_HINT_NICE_QUALITY
// Evaluates L2 SH in vertex and L0L1 in pixel
#define EVALUATE_SH_MIXED
#endif
// Otherwise evaluate SH fully per-pixel
#endif

#if defined(LIGHTMAP_ON)
    #define DECLARE_LIGHTMAP_OR_SH(lmName, shName, index) float2 lmName : TEXCOORD##index
    #define OUTPUT_LIGHTMAP_UV(lightmapUV, lightmapScaleOffset, OUT) OUT.xy = lightmapUV.xy * lightmapScaleOffset.xy + lightmapScaleOffset.zw;
    #define OUTPUT_SH(normalWS, OUT)
#else
    #define DECLARE_LIGHTMAP_OR_SH(lmName, shName, index) half3 shName : TEXCOORD##index
    #define OUTPUT_LIGHTMAP_UV(lightmapUV, lightmapScaleOffset, OUT)
    #define OUTPUT_SH(normalWS, OUT) OUT.xyz = SampleSHVertex(normalWS)
#endif

half RoughnessToBlinnPhongSpecularExponent(half roughness)
{
    return clamp(2 * rcp(roughness * roughness) - 2, FLT_EPS, rcp(FLT_EPS));
}

void HairSpecularWithSingleRoughness(BRDFData brdfData, HairData hairData, VectorsData vData, half3 lightDirectionWS,
                                        half NdotL, out half3 specR, out half3 specT)
{
    half NdotV = saturate(dot(vData.geomNormalWS, vData.viewDirectionWS));

    half LdotV, NdotH, LdotH, invLenLV;
    GetBSDFAngle(vData.viewDirectionWS, lightDirectionWS, NdotL, NdotV, LdotV, NdotH, LdotH, invLenLV);

    half perceptualRoughness = PerceptualSmoothnessToPerceptualRoughness(hairData.perceptualSmoothness);
    half roughness = PerceptualRoughnessToRoughness(perceptualRoughness);
    half specularExponent = RoughnessToBlinnPhongSpecularExponent(roughness);
    half3 t1 = ShiftTangent(vData.bitangentWS, vData.normalWS, hairData.specularShift);
    half3 t2 = ShiftTangent(vData.bitangentWS, vData.normalWS, hairData.secondarySpecularShift);

    half3 H = (lightDirectionWS + vData.viewDirectionWS) * invLenLV;

    half3 hairSpec1 = hairData.specularTint * D_KajiyaKay(t1, H, specularExponent);
    half3 hairSpec2 = hairData.secondarySpecularTint * D_KajiyaKay(t2, H, specularExponent);
    half f0 = 0.5 + (perceptualRoughness + perceptualRoughness * LdotV);
    half3 F = F_Schlick(f0, LdotH) * INV_PI;
    
    half scatterFresnel1 = pow(saturate(-LdotV), 9.0) * pow(saturate(1.0 - NdotV * NdotV), 12.0) * hairData.transmissionIntensity;
    half scatterFresnel2 = saturate(PositivePow((1.0 - NdotV), 20.0));
    
    specR = 0.25h * F * (hairSpec1 + hairSpec2) * NdotL * saturate(NdotV * FLT_MAX);
    specT = hairData.transmissionColor * (scatterFresnel1 + hairData.transmissionIntensity * scatterFresnel2);
}

half3 HairLighting(BRDFData brdfData, HairData hairData, VectorsData vData, Light light, bool specularHighlightsOff)
{
    half3 lightAttenuation = light.color * light.distanceAttenuation * light.shadowAttenuation;
    half NdotL = saturate(dot(vData.normalWS, light.direction));
    half3 radiance = NdotL * lightAttenuation;

    half3 brdf = brdfData.diffuse * radiance;
    half3 specularR, specularT;
#ifndef _SPECULARHIGHLIGHTS_OFF
    [branch] if (!specularHighlightsOff)
    {
        HairSpecularWithSingleRoughness(brdfData, hairData, vData, light.direction, NdotL, specularR, specularT);
        brdf += saturate(specularR + specularT) * lightAttenuation;
    }
#endif // _SPECULARHIGHLIGHTS_OFF
    return brdf;
}

///////////////////////////////////////////////////////////////////////////////
//                      Fragment Functions                                   //
///////////////////////////////////////////////////////////////////////////////

inline void InitializeBRDFDataDirect(InputData inputData, inout SurfaceData surfaceData, half3 diffuse, half3 specular,
    half reflectivity, half oneMinusReflectivity, out BRDFData outBRDFData)
{
    outBRDFData = (BRDFData)0;
    outBRDFData.albedo = surfaceData.albedo;
    outBRDFData.diffuse = diffuse;
    outBRDFData.specular = specular;
    outBRDFData.reflectivity = reflectivity;
    #if defined (_MATERIAL_FEATURE_IRIDESCENCE)
    outBRDFData.specular = IridescenceSpecular(inputData.normalWS, inputData.viewDirectionWS, 
                    outBRDFData.specular, surfaceData.iridescenceTMS, 
                    surfaceData.clearCoatMask);
    #endif

    outBRDFData.perceptualRoughness = PerceptualSmoothnessToPerceptualRoughness(surfaceData.smoothness);
    outBRDFData.roughness = max(PerceptualRoughnessToRoughness(outBRDFData.perceptualRoughness), HALF_MIN_SQRT);
    outBRDFData.roughness2 = max(outBRDFData.roughness * outBRDFData.roughness, HALF_MIN);
    outBRDFData.grazingTerm = saturate(surfaceData.smoothness + reflectivity);
    outBRDFData.normalizationTerm = outBRDFData.roughness * 4.0h + 2.0h;
    outBRDFData.roughness2MinusOne = outBRDFData.roughness2 - 1.0h;

    #if defined(_ALPHAPREMULTIPLY_ON)
    outBRDFData.diffuse *= surfaceData.alpha;
    #endif
}

inline void InitializeSpecularBRDFData(InputData inputData, inout SurfaceData surfaceData, out BRDFData outBRDFData)
{
    half reflectivity = ReflectivitySpecular(surfaceData.specular);
    half oneMinusReflectivity = 1.0h - reflectivity;
    half3 brdfDiffuse = surfaceData.albedo * oneMinusReflectivity;
    half3 brdfSpecular = surfaceData.specular;

    InitializeBRDFDataDirect(inputData, surfaceData, brdfDiffuse, brdfSpecular, reflectivity, oneMinusReflectivity, outBRDFData);
}

struct LightingData
{
    half3 giColor;
    half3 mainLightColor;
    half3 additionalLightsColor;
    half3 vertexLightingColor;
    half3 emissionColor;
};

LightingData CreateLightingData(InputData inputData, SurfaceData surfaceData)
{
    LightingData lightingData;

    lightingData.giColor = inputData.bakedGI;
    lightingData.emissionColor = surfaceData.emission;
    lightingData.vertexLightingColor = 0;
    lightingData.mainLightColor = 0;
    lightingData.additionalLightsColor = 0;

    return lightingData;
}

half3 CalculateLightingColor(LightingData lightingData, half3 albedo)
{
    half3 lightingColor = 0;

    if (IsOnlyAOLightingFeatureEnabled())
    {
        return lightingData.giColor; // Contains white + AO
    }

    if (IsLightingFeatureEnabled(DEBUGLIGHTINGFEATUREFLAGS_GLOBAL_ILLUMINATION))
    {
        lightingColor += lightingData.giColor;
    }

    if (IsLightingFeatureEnabled(DEBUGLIGHTINGFEATUREFLAGS_MAIN_LIGHT))
    {
        lightingColor += lightingData.mainLightColor;
    }

    if (IsLightingFeatureEnabled(DEBUGLIGHTINGFEATUREFLAGS_ADDITIONAL_LIGHTS))
    {
        lightingColor += lightingData.additionalLightsColor;
    }

    if (IsLightingFeatureEnabled(DEBUGLIGHTINGFEATUREFLAGS_VERTEX_LIGHTING))
    {
        lightingColor += lightingData.vertexLightingColor;
    }

    lightingColor *= albedo;

    if (IsLightingFeatureEnabled(DEBUGLIGHTINGFEATUREFLAGS_EMISSION))
    {
        lightingColor += lightingData.emissionColor;
    }

    return lightingColor;
}

half4 CalculateFinalColor(LightingData lightingData, half alpha)
{
    half3 finalColor = CalculateLightingColor(lightingData, 1);

    return half4(finalColor, alpha);
}

half4 KKHairFragment(InputData inputData, SurfaceData surfaceData, VectorsData vData, HairData hairData)
{
    bool specularHighlightsOff = false;
    #if defined(_SPECULARHIGHLIGHTS_OFF)
        specularHighlightsOff = true;
    #endif

    BRDFData brdfData;
    InitializeSpecularBRDFData(inputData, surfaceData, brdfData);

    half4 shadowMask = CalculateShadowMask(inputData);
    AmbientOcclusionFactor aoFactor = CreateAmbientOcclusionFactor(inputData, surfaceData);

    uint meshRenderingLayers = GetMeshRenderingLayer();

    Light mainLight = GetMainLight(inputData, shadowMask, aoFactor);

    MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI);
    LightingData lightingData = CreateLightingData(inputData, surfaceData);
    
    half3 indirectSpecular, coatIndirectSpecular;
    ComputeIndirectSpecular(vData, inputData.positionWS, inputData.normalizedScreenSpaceUV, 
                            brdfData.perceptualRoughness, 0.0, surfaceData.anisotropy, 
                            indirectSpecular, coatIndirectSpecular);

    lightingData.giColor = ComplexGlobalIllumination(surfaceData, brdfData, vData, inputData.bakedGI, indirectSpecular,
                                                        coatIndirectSpecular, aoFactor.indirectAmbientOcclusion);

    #ifdef _LIGHT_LAYERS
    if (IsMatchingLightLayer(mainLight.layerMask, meshRenderingLayers))
    #endif
    {
        lightingData.mainLightColor = HairLighting(brdfData, hairData, vData, mainLight, specularHighlightsOff);
    }

    #if defined(_ADDITIONAL_LIGHTS)
    uint pixelLightCount = GetAdditionalLightsCount();

    #if USE_FORWARD_PLUS
    for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
    {
        FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

        Light light = GetAdditionalLight(lightIndex, inputData, shadowMask, aoFactor);

    #ifdef _LIGHT_LAYERS
        if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
    #endif
        {
            lightingData.additionalLightsColor += HairLighting(brdfData, hairData, vData, light, specularHighlightsOff);
        }
    }
    #endif

    LIGHT_LOOP_BEGIN(pixelLightCount)
        Light light = GetAdditionalLight(lightIndex, inputData, shadowMask, aoFactor);

    #ifdef _LIGHT_LAYERS
        if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
    #endif
        {
            lightingData.additionalLightsColor += HairLighting(brdfData, hairData, vData, light, specularHighlightsOff);
        }
    LIGHT_LOOP_END
    #endif

    #if defined(_ADDITIONAL_LIGHTS_VERTEX)
    lightingData.vertexLightingColor += inputData.vertexLighting * brdfData.diffuse;
    #endif


    return CalculateFinalColor(lightingData, surfaceData.alpha);
}

#endif