
#ifndef SSS_CUSTOM_INCLUDED
#define SSS_CUSTOM_INCLUDED

half3 GlossyEnvironmentReflectionFix(half3 reflectVector, float3 positionWS, half perceptualRoughness, half3 occlusion, float2 normalizedScreenSpaceUV)
{
#if !defined(_SSS_ENVIRONMENTREFLECTIONS_OFF)
    half3 irradiance;

#if defined(_REFLECTION_PROBE_BLENDING) || USE_FORWARD_PLUS
    irradiance = CalculateIrradianceFromReflectionProbes(reflectVector, positionWS, perceptualRoughness, normalizedScreenSpaceUV);
#else
#ifdef _REFLECTION_PROBE_BOX_PROJECTION
    reflectVector = BoxProjectedCubemapDirection(reflectVector, positionWS, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax);
#endif // _REFLECTION_PROBE_BOX_PROJECTION
    half mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
    half4 encodedIrradiance = half4(SAMPLE_TEXTURECUBE_LOD(unity_SpecCube0, samplerunity_SpecCube0, reflectVector, mip));

    irradiance = DecodeHDREnvironment(encodedIrradiance, unity_SpecCube0_HDR);
#endif // _REFLECTION_PROBE_BLENDING
    return irradiance * occlusion;
#else
    //FIX! 
    //return 0;
    //return _GlossyEnvironmentColor.rgb * occlusion;
#endif // _SSS_ENVIRONMENTREFLECTIONS_OFF
}

#if !USE_FORWARD_PLUS
half3 GlossyEnvironmentReflectionFix(half3 reflectVector, float3 positionWS, half perceptualRoughness, half3 occlusion)
{
    return GlossyEnvironmentReflectionFix(reflectVector, positionWS, perceptualRoughness, occlusion, float2(0.0f, 0.0f));
}
#endif

half3 GlossyEnvironmentReflectionFix(half3 reflectVector, half perceptualRoughness, half3 occlusion)
{
#if !defined(_SSS_ENVIRONMENTREFLECTIONS_OFF)
    half3 irradiance;
    half mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
    half4 encodedIrradiance = half4(SAMPLE_TEXTURECUBE_LOD(unity_SpecCube0, samplerunity_SpecCube0, reflectVector, mip));

    irradiance = DecodeHDREnvironment(encodedIrradiance, unity_SpecCube0_HDR);

    return irradiance * occlusion;
#else
    //FIX! 
    return 0;
    //return _GlossyEnvironmentColor.rgb * occlusion;
#endif // _SSS_ENVIRONMENTREFLECTIONS_OFF
}

inline half Pow5(half x)
{
    return x * x * x * x * x;
}

inline half3 FresnelTerm(half3 F0, half cosA)
{
    half t = Pow5(1 - cosA); // ala Schlick interpoliation
    return F0 + (1 - F0) * t;
}
inline half3 FresnelLerp(half3 F0, half3 F90, half cosA)
{
    half t = Pow5(1 - cosA); // ala Schlick interpoliation
    return lerp(F0, F90, t);
}

void Jimenez_SpecularOcclusion_float(float NdotV, float occlusion, out float o)
{
    float sAO = saturate(-0.3f + NdotV * NdotV);
    o = lerp(pow(occlusion, 8.00f), 1.0f, sAO);
}

float3 LightIntensityClamp(float3 l, float LightClamp)
{
    return clamp(l, 0, LightClamp);
}

float3 WrappedDiffuse(half NdotL, half _Wrap)
{
    
    return saturate((NdotL + _Wrap) / ((1 + _Wrap) * (1 + _Wrap)));
}

//int _CookieLightIndex;



half3 OrenNayar(half3 lightColor, half3 L, half3 N, half diffuseRoughness, float3 V)
{
    half NdotL = saturate(dot(N, L));
    half NdotV = saturate(dot(N, V));
    //return lightColor * NdotL;
    float theta_r = acos(NdotV);
    float theta_i = acos(NdotL);
	
    float cos_phi_diff = saturate(dot(normalize(V - N * NdotV), normalize(L - N * NdotL)));
	
    float alpha = max(theta_i, theta_r);
    float beta = min(theta_i, theta_r);
    
    diffuseRoughness *= diffuseRoughness;
    
    float A = 1.0 - 0.5 * diffuseRoughness / (diffuseRoughness + 0.57);
    float B = 0.45 * diffuseRoughness / (diffuseRoughness + 0.09);
    return lightColor * saturate(NdotL * (A + B * sin(alpha) * tan(beta)));
}

half3 DiffuseLightingFull(float3 WorldPos, half3 Normal, half Wrap, float3 WorldView, 
                        float2 lightmapUV, float3 GI, float LightClamp)
{
#if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
    float4 shadowCoord = ComputeScreenPos(TransformWorldToHClip(WorldPos));
#else
    float4 shadowCoord = TransformWorldToShadowCoord(WorldPos);
#endif

    Light DirectionalLight = GetMainLight();
    float3 Direction = DirectionalLight.direction;
    half3 Color = DirectionalLight.color;
    float DistanceAtten = DirectionalLight.distanceAttenuation;
    
    OUTPUT_LIGHTMAP_UV(lightmapUV, unity_LightmapST, lightmapUV);
    float4 Shadowmask = SAMPLE_SHADOWMASK(lightmapUV);
    float ShadowAtten = MainLightShadow(shadowCoord, WorldPos, Shadowmask, _MainLightOcclusionProbes);
    half3 Lambert = OrenNayar(Color * DistanceAtten, Direction, Normal, Wrap, WorldView);
    

    half3 MainLightDiffuse = ShadowAtten * Lambert;

    //Additional Lights
    half3 AdditionalsDiffuse = 0;
   
    uint pixelLightCount = GetAdditionalLightsCount();
    uint meshRenderingLayers = GetMeshRenderingLayer();

    LIGHT_LOOP_BEGIN(pixelLightCount)

    Light light = GetAdditionalLight(lightIndex, WorldPos, Shadowmask);
	#ifdef _LIGHT_LAYERS
		if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
	#endif
		{
            float3 attenuatedLightColor = light.color * (light.distanceAttenuation * light.shadowAttenuation);
            attenuatedLightColor = LightIntensityClamp(attenuatedLightColor, LightClamp); //Point lights are damn bright inside the range
            AdditionalsDiffuse += OrenNayar(attenuatedLightColor, light.direction, Normal, Wrap, WorldView);
        }
    
    LIGHT_LOOP_END
    
    return MainLightDiffuse + AdditionalsDiffuse;

}

half3 SpecularLightingFull(float3 WorldPos, half3 Normal, half3 SpecColor, half3 Smoothness, half3 WorldView, float2 lightmapUV)
{
#if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
		float4 shadowCoord = ComputeScreenPos(TransformWorldToHClip(WorldPos));
#else
    
    float4 shadowCoord = TransformWorldToShadowCoord(WorldPos);
#endif
    Light DirectionalLight = GetMainLight();
    float3 Direction = DirectionalLight.direction;
    half3 Color = DirectionalLight.color;
    float DistanceAtten = DirectionalLight.distanceAttenuation;
    //float3 Cookie = SampleDirectionalLightCookie(WorldPos);//TODO
    
    OUTPUT_LIGHTMAP_UV(lightmapUV, unity_LightmapST, lightmapUV);
    float4 Shadowmask = SAMPLE_SHADOWMASK(lightmapUV);
    float ShadowAtten = MainLightShadow(shadowCoord, WorldPos, Shadowmask, _MainLightOcclusionProbes);
    half3 Lambert = LightingLambert(Color * DistanceAtten, Direction, Normal);
    half3 GI = 0;
    MixRealtimeAndBakedGI(DirectionalLight, Normal, GI); //TODO
    //float3 MainLightDiffuse = /* Cookie **/ShadowAtten * Lambert /* + GI*/;
    Smoothness = exp2(10 * Smoothness + 1);

    half3 attenuatedLightColor = Color * (DistanceAtten * ShadowAtten);
    half3 specularColor = LightingSpecular(attenuatedLightColor, Direction, Normal, WorldView, float4(SpecColor, 0), Smoothness);
		
#if defined(_LIGHT_COOKIES)
        specularColor *= SampleMainLightCookie(WorldPos);
#endif
    
    //Smoothness = exp2(10 * Smoothness + 1);
    uint pixelLightCount = GetAdditionalLightsCount();
    uint meshRenderingLayers = GetMeshRenderingLayer();

	// For Foward+ the LIGHT_LOOP_BEGIN macro will use inputData.normalizedScreenSpaceUV, inputData.positionWS, so create that:
    InputData inputData = (InputData) 0;
    float4 screenPos = ComputeScreenPos(TransformWorldToHClip(WorldPos));
    inputData.normalizedScreenSpaceUV = screenPos.xy / screenPos.w;
    inputData.positionWS = WorldPos;

    LIGHT_LOOP_BEGIN(pixelLightCount)

    Light light = GetAdditionalLight(lightIndex, WorldPos, Shadowmask);
	#ifdef _LIGHT_LAYERS
		if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
	#endif
		{
			// Blinn-Phong
        half3 attenuatedLightColor = light.color * (light.distanceAttenuation * light.shadowAttenuation);
        //diffuseColor += LightingLambert(attenuatedLightColor, light.direction, Normal);
        specularColor += LightingSpecular(attenuatedLightColor, light.direction, Normal, WorldView, float4(SpecColor, 0), Smoothness);
    }
    LIGHT_LOOP_END


    return specularColor;

}

#if defined(__INTELLISENSE__)
#define ADDITIONAL_LIGHT_CALCULATE_SHADOWS
#define _ENABLETRANSMISSIONGRADIENT_ON
#endif
//Translucency shadowmap

//taken from AdditionalLightRealtimeShadow in Shadows.hlsl
half ComputeAdditionalTSM(int lightIndex, float3 positionWS, half3 lightDirection, half TravelDistance)
{
    //Taken from RealtimeLights.hlsl GetAdditionalLight()
    #if USE_FORWARD_PLUS
       // int lightIndex = i;
    #else
        lightIndex = GetPerObjectLightIndex(lightIndex);
    #endif
    
    #if defined(ADDITIONAL_LIGHT_CALCULATE_SHADOWS)
        ShadowSamplingData shadowSamplingData = GetAdditionalLightShadowSamplingData(lightIndex);
  
        half4 shadowParams = GetAdditionalLightShadowParams(lightIndex);

        int shadowSliceIndex = shadowParams.w;
        if (shadowSliceIndex < 0)
            return 1.0;

        half isPointLight = shadowParams.z;

        UNITY_BRANCH
        if (isPointLight)
        {
            // This is a point light, we have to find out which shadow slice to sample from
            float cubemapFaceId = CubeMapFaceID(-lightDirection);
            shadowSliceIndex += cubemapFaceId;
        }

        #if USE_STRUCTURED_BUFFER_FOR_LIGHT_DATA
                    float4 shadowCoord = mul(_AdditionalLightsWorldToShadow_SSBO[shadowSliceIndex], float4(positionWS, 1.0));
        #else
                    float4 shadowCoord = mul(_AdditionalLightsWorldToShadow[shadowSliceIndex], float4(positionWS, 1.0));
        #endif
        //return SampleShadowmap(TEXTURE2D_ARGS(_AdditionalLightsShadowmapTexture, sampler_LinearClampCompare), shadowCoord, shadowSamplingData, shadowParams, true);
        //
        //isPerspectiveProjection
        shadowCoord.xyz /= shadowCoord.w;
        half depth = SAMPLE_TEXTURE2D_LOD(_AdditionalLightsShadowmapTexture, sampler_LinearClamp, shadowCoord.xy, 0).r;
    
        half ShadowMap = depth - shadowCoord.z;
        TravelDistance = TravelDistance * shadowCoord.z;//correct the distance
        TravelDistance *= 50;//compensate to look similar to the directional
        ShadowMap = ShadowMap / TravelDistance;
        ShadowMap = saturate(ShadowMap);
        return (1.0 - ShadowMap);
        //return 1-shadowCoord.z;
        //return depth;
    #else
        return half(1.0);//el deferred salta aquí
    #endif
}

float3 TransmissionColor(float3 color)
{
    //color = color / (1 - color);
    return 1 - exp(-color * color);
}

float TransmissionMasking(float3 N, float3 L, float2 Cancel)
{
    //return saturate(dot(-N, L));
    return saturate(smoothstep(Cancel.x, Cancel.y, dot(N, -L)));
}

float4 _CascadeWeight;

float TSM_Remap(float tsm, half min, half max)
{
    return smoothstep(min, max, tsm);
}

//Jimenez transmission
float3 T(float s) 
{
 return float3(0.233, 0.455, 0.649) * exp(-s*s/0.0064) +
 float3(0.1, 0.336, 0.344) * exp(-s*s/0.0484) +
 float3(0.118, 0.198, 0.0) * exp(-s*s/0.187) +
 float3(0.113, 0.007, 0.007) * exp(-s*s/0.567) +
 float3(0.358, 0.004, 0.0) * exp(-s*s/1.99) +
 float3(0.078, 0.0, 0.0) * exp(-s*s/7.41);
}

#if defined(__INTELLISENSE__)
#define USE_FORWARD_PLUS
#define TSMRamp half dummyThing
#else
#define TSMRamp TEXTURE2D(_TransmissionGradient)
#endif

float TranslucentShadowmap(float TravelDistance, float TravelDistancePointLights,
                            float3 WorldPos, float3 ViewPos,
                            float3 WorldNormal, float2 Cancel, float MaskWithNormals,
                            out float3 experimental, TSMRamp, 
                            SamplerState ssClamp, half2 TSM_Grad, half Thickness,
                            half Intensity, half LightClamp)
{
    experimental = .5;

	//Sadly, each cascade has a different intensity. 
	//Depends on a thousand variables:
	// - Screen aspect ratio
	// - Scene or GameView window
	// - Max distance in URP Pipeline Asset/Shadows/
	// - Cascade count
	// - Split values
	// - Near Clipping
	// - Field of view
	// - Conservative Enclosing Sphere option
	//  -_-'
	//so... tons of hacks to manually set 4 ad-hoc values (facepalm)
	
    int index = ComputeCascadeIndex(WorldPos);
    float correction = 1;
	
    // if (index == 0)
    // {
    //     correction *= _CascadeWeight.x;
    // }
    // if (index == 1)
    // {
    //     correction *= _CascadeWeight.y;
    // }
    // if (index == 2)
    // {
    //     correction *= _CascadeWeight.z;
    // }
    // if (index == 3)
    // {
    //     correction *= _CascadeWeight.w;
    // }
	
    half cascadeIndex = ComputeCascadeIndex(WorldPos);

    float4 shadowCoord = mul(_MainLightWorldToShadow[cascadeIndex], float4(WorldPos, 1.0));
	//float4 shadowCoord = TransformWorldToShadowCoord(WorldPos);
    
    float depth = SAMPLE_TEXTURE2D(_MainLightShadowmapTexture, sampler_LinearClamp, shadowCoord.xy).x;
    float ShadowMap = depth - shadowCoord.z;
    TravelDistance *= correction;
  
    ShadowMap = saturate(ShadowMap / TravelDistance);
    float DirectionalTSM = 1.0 - ShadowMap;
    Light DirectionalLight = GetMainLight();

    float TransmissionAtten = Thickness;
    float TransmissionAttenAvg = TransmissionAtten;
    TransmissionAttenAvg *= (DirectionalLight.color.r + DirectionalLight.color.g + DirectionalLight.color.b) / 3;
    TransmissionAttenAvg *= Intensity;
    
    //Cancel    
    if (MaskWithNormals == 1)    
        TransmissionAtten *= TransmissionMasking(WorldNormal, DirectionalLight.direction, Cancel);

    float3 MainLight = DirectionalTSM * TransmissionAtten * DirectionalLight.color * Intensity;
    
    #ifdef _ENABLETRANSMISSIONGRADIENT_ON
    MainLight *= SAMPLE_TEXTURE2D_LOD(_TransmissionGradient, ssClamp, TSM_Remap(DirectionalTSM * TransmissionAttenAvg, TSM_Grad.x, TSM_Grad.y), 0).rgb;
    //MainLight *= tex2D(_TransmissionGradient, DirectionalTSM, 0).rgb;
    #endif
    
    //MainLight = TransmissionColor(MainLight);
    #if defined(_LIGHT_COOKIES)
        MainLight *= SampleMainLightCookie(WorldPos);
    #endif
   
    
    //Other lights
    float3 AdditionalLight = 0;
    uint pixelLightCount = GetAdditionalLightsCount();
    uint meshRenderingLayers = GetMeshRenderingLayer();
    float4 Shadowmask = 1;


    
    LIGHT_LOOP_BEGIN(pixelLightCount)

    Light light = GetAdditionalLight(lightIndex, WorldPos, Shadowmask);
	#ifdef _LIGHT_LAYERS
		if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
	#endif
		{
		
        float3 LightColor = light.color;  
        //TODO Cookies
        float3 attenuatedLightColor = LightColor * light.distanceAttenuation;
        attenuatedLightColor = LightIntensityClamp(attenuatedLightColor, LightClamp); //Point lights are damn bright inside the range
        float AdditionalTSM = ComputeAdditionalTSM(lightIndex, WorldPos, light.direction, TravelDistancePointLights);
        float TransmissionAttenAvg = Thickness;
        TransmissionAttenAvg *= (attenuatedLightColor.r + attenuatedLightColor.g + attenuatedLightColor.b) / 3;
        TransmissionAttenAvg *= Intensity;
        //Cancel    
        if (MaskWithNormals == 1)    
            TransmissionAtten *= TransmissionMasking(WorldNormal, light.direction, Cancel);
        
        #ifdef _ENABLETRANSMISSIONGRADIENT_ON
            AdditionalLight += attenuatedLightColor * AdditionalTSM * TransmissionAtten * Intensity * SAMPLE_TEXTURE2D_LOD(_TransmissionGradient, ssClamp, TSM_Remap(AdditionalTSM * TransmissionAttenAvg, TSM_Grad.x, TSM_Grad.y), 0).rgb;
        #else
           AdditionalLight += attenuatedLightColor * AdditionalTSM * TransmissionAtten * Intensity;
        #endif
    }
        
    AdditionalLight *= 1.0 - GetAdditionalLightShadowFade(WorldPos);
    
    LIGHT_LOOP_END

    experimental = AdditionalLight + MainLight * (1.0 - GetMainLightShadowFade(WorldPos));
   
    return DirectionalTSM;
 
}


half ShadowGrad(half ShadowThreshold, half SampleDiff)
{
    return saturate(ShadowThreshold / (ShadowThreshold - SampleDiff));
}

//#define _SelfShadowSteps 20
float Shadow(sampler2D ShadowMap, float2 uv, int SelfShadowSteps, half3 LightVector)
{

    float ShadowThreshold = tex2D(ShadowMap, uv).r;
    float2 LightStep = LightVector.xy / (float) SelfShadowSteps;

    float accum = 0;
    float2 ShadowCoordsStep = uv;
    for (int k = 0; k <= SelfShadowSteps; k++, ShadowCoordsStep += LightStep)
    {
        float NoiseSample = 0;
        float SampleDiff = 0;
        if (ShadowThreshold > 0 && accum < 1)
        {
            NoiseSample = tex2D(ShadowMap, ShadowCoordsStep).r;
            SampleDiff = ShadowThreshold - NoiseSample;


            if (SampleDiff <= 0)
            {
                if (ShadowThreshold > 0)
                {
                    accum += 1 - ShadowGrad(ShadowThreshold, SampleDiff);
                }
                else
                {
                    accum += 1;
                }
            }
            else if (ShadowThreshold <= 0)
            {
                accum += ShadowGrad(ShadowThreshold, SampleDiff);
            }
        }
    }
	//return accum;
    return saturate(1 - accum);

}

#endif