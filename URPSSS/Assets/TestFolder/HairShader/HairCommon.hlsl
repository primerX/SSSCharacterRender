#ifndef _HAIR_COMMON_HALSL
#define _HAIR_COMMON_HALSL

#define USE_STRUCTURED_BUFFER_FOR_LIGHT_DATA 0
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"

CBUFFER_START(UnityPerMaterial)
    float4 _BaseMap_ST;
    float4 _BaseColor;
    float4 _SpecColor;
    float _Cutoff;
    float _AlphaCutoff;
    float _SpecularShift;
    float _SpecularPower;
    float4 _BlendColor;
    float _ZOffset;

    half _SpecularMultiplier, _PrimaryShift,_Specular,_SecondaryShift,_SpecularMultiplier2;
    half4 _SpecularColor, _MainColor,_SpecularColor2;
CBUFFER_END

TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);


TEXTURE2D(_SpotScreenSpaceShadowmapTexture);
SAMPLER(sampler_SpotScreenSpaceShadowmapTexture);


half3 CalculateKajiyaKay(Light light, half3 albedo, float3 normalWS, float3 tangentWS, float3 viewDirWS)
{
    float3 lightDir = light.direction;
    float3 shiftedTangent = normalize(tangentWS + normalWS * _SpecularShift);

    float dotTL = dot(shiftedTangent, lightDir);
    float diffuseTerm = sqrt(1.0 - dotTL * dotTL);
    diffuseTerm = max(0.0, diffuseTerm);

    float3 halfDir = normalize(lightDir + viewDirWS);
    float dotTH = dot(shiftedTangent, halfDir);
    float sinTH = sqrt(1.0 - dotTH * dotTH);
    float specularTerm = pow(max(0.0, sinTH), _SpecularPower);

    // 关键修复：加入 NdotL 限制，防止点光源从背面照亮
    float NdotL = saturate(dot(normalWS, lightDir));
    // NdotL = pow(NdotL * 0.5 + 0.5, 2);

    half3 diffuseColor = albedo * light.color;
    half3 specularColor = _SpecColor.rgb * specularTerm * light.color;

    return (diffuseColor + specularColor) * light.distanceAttenuation * light.shadowAttenuation * NdotL;
}

struct Attributes
{
    float4 positionOS : POSITION;
    float3 normalOS : NORMAL;
    float4 tangentOS : TANGENT; 
    float2 uv : TEXCOORD0;
};

struct Varyings
{
    float4 positionCS : SV_POSITION;
    float3 positionWS : TEXCOORD1;

    float3 normalWS : TEXCOORD2;
    float3 tangentWS : TEXCOORD3;
    float3 bitangentWS : TEXCOORD4;

    float4 screenPos : TEXCOORD5;
    float2 uv : TEXCOORD0;
};

Varyings vert(Attributes input)
{
    Varyings output;
    VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
    output.positionCS = vertexInput.positionCS;
    output.positionWS = vertexInput.positionWS;

    VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
    output.normalWS = normalInput.normalWS;
    output.tangentWS = normalInput.tangentWS;


    output.tangentWS = TransformObjectToWorldDir(input.tangentOS.xyz);
    output.normalWS = TransformObjectToWorldNormal(input.normalOS);

    float ase_vertexTangentSign = input.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
    output.bitangentWS = cross( output.normalWS, output.tangentWS ) * ase_vertexTangentSign;


    output.uv = TRANSFORM_TEX(input.uv, _BaseMap);

    output.screenPos = ComputeScreenPos(output.positionCS);

    return output;
}

half3 ComputeMainLight(Varyings input, half4 albedo)
{
    half3 finalColor = 0;
    float3 positionWS = input.positionWS;
    float3 normalWS = normalize(input.normalWS);
    // float3 tangentWS = normalize(input.tangentWS);
    // float3 viewDirWS = GetWorldSpaceNormalizeViewDir(positionWS);

    float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
    Light mainLight = GetMainLight(shadowCoord);

    float lambert = max(0,(dot(normalWS, mainLight.direction))); 
    // lambert = pow(lambert * 0.5 + 0.5, 2);

    finalColor = albedo.rgb * lambert * mainLight.color * mainLight.distanceAttenuation * mainLight.shadowAttenuation;
    // finalColor += CalculateKajiyaKay(mainLight, albedo.rgb, normalWS, tangentWS, viewDirWS);

    return finalColor;
}


float GetMainLightAtten(Varyings input, half4 albedo)
{
    half3 finalColor = 0;
    float3 normalWS = normalize(input.normalWS);

    float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
    Light mainLight = GetMainLight(shadowCoord);

    float lambert = max(0,(dot(normalWS, mainLight.direction))); 
    lambert = pow(lambert * 0.5 + 0.5, 2);

    finalColor += albedo.rgb * lambert * mainLight.color * mainLight.distanceAttenuation * mainLight.shadowAttenuation;
    // finalColor += CalculateKajiyaKay(mainLight, albedo.rgb, normalWS, tangentWS, viewDirWS);

    float2 screenUV = input.screenPos.xy / input.screenPos.w;
    half screenShadow = SAMPLE_TEXTURE2D(_ScreenSpaceShadowmapTexture, sampler_ScreenSpaceShadowmapTexture, screenUV).r;

    float finalAtten = screenShadow;
    return finalAtten;
}

half3 GetMainLightScreenColor(Varyings input, half4 albedo)
{
    half3 finalColor = 0;
    float3 normalWS = normalize(input.normalWS);
    float3 tangentWS = normalize(input.tangentWS);
    float3 viewDirWS = GetWorldSpaceNormalizeViewDir(input.positionWS);

    float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
    Light mainLight = GetMainLight(shadowCoord);

    float lambert = max(0,(dot(normalWS, mainLight.direction))); 
    lambert = pow(lambert * 0.5 + 0.5, 2);

    // finalColor += albedo.rgb * lambert * mainLight.color * mainLight.distanceAttenuation * mainLight.shadowAttenuation;
    // finalColor = CalculateKajiyaKay(mainLight, half3(1, 1, 1), normalWS, tangentWS, viewDirWS);

    float2 screenUV = input.screenPos.xy / input.screenPos.w;
    half screenShadow = SAMPLE_TEXTURE2D(_ScreenSpaceShadowmapTexture, sampler_ScreenSpaceShadowmapTexture, screenUV).r;

    finalColor = 1 * lambert * mainLight.color * screenShadow;
    return finalColor;
}


half3 ComputeAddLight(Varyings input, half4 albedo)
{
    half3 finalColor = 0;

    float3 positionWS = input.positionWS;
    float3 normalWS = normalize(input.normalWS);

    // 额外光
    #if _ADDITIONAL_LIGHTS
        uint pixelLightCount = GetAdditionalLightsCount();
        for (uint lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
        {
            Light addLight = GetAdditionalLight(lightIndex, positionWS, 1.0);

            half addLightNoL = max(dot(normalWS, addLight.direction), 0.0);
            // addLightNoL = pow(addLightNoL * 0.5 + 0.5, 2);

            half3 addLightRes = addLight.color * addLight.distanceAttenuation * addLight.shadowAttenuation * addLightNoL * albedo.rgb;

            finalColor += addLightRes;
        }
    #endif
    
    return finalColor;
}


half ComputeScreenAddLight(Varyings input, half4 albedo)
{
    half3 finalColor = 0;

    float2 screenUV = input.screenPos.xy / input.screenPos.w;

    float3 positionWS = input.positionWS;
    float3 normalWS = normalize(input.normalWS);
    
    half spotShadow = SAMPLE_TEXTURE2D(_SpotScreenSpaceShadowmapTexture, sampler_SpotScreenSpaceShadowmapTexture, screenUV).r;


    return spotShadow;
}


float ComputeAddLightAtten(Varyings input, half4 albedo)
{
    half3 finalColor = 0;

    float3 positionWS = input.positionWS;
    float3 normalWS = normalize(input.normalWS);

    float2 screenUV = input.screenPos.xy / input.screenPos.w;
    half spotShadow = SAMPLE_TEXTURE2D(_SpotScreenSpaceShadowmapTexture, sampler_SpotScreenSpaceShadowmapTexture, screenUV).r;


    // 额外光
    float atten = 0;
    #if _ADDITIONAL_LIGHTS
        uint pixelLightCount = GetAdditionalLightsCount();
        for (uint lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
        {
            Light addLight = GetAdditionalLight(lightIndex, positionWS, 1.0);

            half addLightNoL = max(dot(normalWS, addLight.direction), 0.0);

            half3 addLightRes = addLight.color * addLight.distanceAttenuation * addLight.shadowAttenuation * addLightNoL * albedo.rgb;
            // half3 addLightRes = addLight.color * addLight.distanceAttenuation * spotShadow * addLightNoL * albedo.rgb;

            finalColor += addLightRes;

            atten += spotShadow;
        }
    #endif
    
    return atten;
}


#endif