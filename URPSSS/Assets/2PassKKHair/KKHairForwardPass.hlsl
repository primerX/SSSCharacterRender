#ifndef UNIVERSAL_FORWARD_LIT_PASS_INCLUDED
#define UNIVERSAL_FORWARD_LIT_PASS_INCLUDED

#include "./KKHairLighting.hlsl"

struct Attributes
{
    float4 positionOS : POSITION;
    float3 normalOS : NORMAL;
    float4 tangentOS : TANGENT;
    float2 texcoord : TEXCOORD0;

    float2 staticLightmapUV : TEXCOORD1;
    float2 dynamicLightmapUV : TEXCOORD2;

    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float2 uv : TEXCOORD0;
    float3 positionWS : TEXCOORD1;
    float3 normalWS : TEXCOORD2;
    half4 tangentWS : TEXCOORD3; // xyz: tangent, w: sign
    float3 viewDirWS : TEXCOORD4;

    DECLARE_LIGHTMAP_OR_SH(staticLightmapUV, vertexSH, 8);
    #ifdef DYNAMICLIGHTMAP_ON
    float2  dynamicLightmapUV : TEXCOORD9; // Dynamic lightmap UVs
    #endif

    float4 positionCS : SV_POSITION;

    UNITY_VERTEX_INPUT_INSTANCE_ID
};

void InitializeInputData(Varyings input, half3 normalTS, out VectorsData vData, out InputData inputData)
{
    inputData = (InputData)0;

    inputData.positionWS = input.positionWS;

    half3 viewDirWS = GetWorldSpaceNormalizeViewDir(input.positionWS);
    float sgn = input.tangentWS.w; // should be either +1 or -1
    float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);

    #if defined(_NORMALMAP)
        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
        inputData.tangentToWorld = tangentToWorld;
        inputData.normalWS = TransformTangentToWorld(normalTS, tangentToWorld);
    #else
        inputData.normalWS = input.normalWS;
    #endif

    inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
    inputData.viewDirectionWS = viewDirWS;

    inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);

    #if defined(DYNAMICLIGHTMAP_ON)
        inputData.bakedGI = SAMPLE_GI(input.staticLightmapUV, input.dynamicLightmapUV, input.vertexSH, inputData.normalWS);
    #else
        inputData.bakedGI = SAMPLE_GI(input.staticLightmapUV, input.vertexSH, inputData.normalWS);
    #endif

    inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);
    inputData.shadowMask = SAMPLE_SHADOWMASK(input.staticLightmapUV);

    vData = CreateEmptyVectorsData();
    vData.geomNormalWS = input.normalWS.xyz;
    vData.normalWS = inputData.normalWS;
    vData.viewDirectionWS = viewDirWS;
    vData.tangentWS = input.tangentWS;
    vData.bitangentWS = bitangent;

}

///////////////////////////////////////////////////////////////////////////////
//                  Vertex and Fragment functions                            //
///////////////////////////////////////////////////////////////////////////////

Varyings LitPassVertex(Attributes input)
{
    Varyings output = (Varyings)0;

    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input, output);

    VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
    VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);

    output.positionWS = vertexInput.positionWS;
    output.positionCS = vertexInput.positionCS;

    output.normalWS = normalInput.normalWS;

    float sign = input.tangentOS.w * GetOddNegativeScale();
    half4 tangentWS = half4(normalInput.tangentWS.xyz, sign);
    output.tangentWS = tangentWS;

    OUTPUT_LIGHTMAP_UV(input.staticLightmapUV, unity_LightmapST, output.staticLightmapUV);
    #ifdef DYNAMICLIGHTMAP_ON
        output.dynamicLightmapUV = input.dynamicLightmapUV.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    #endif
    OUTPUT_SH(output.normalWS.xyz, output.vertexSH);

    output.uv = input.texcoord;
    return output;
}

half4 LitPassFragment(Varyings input, half faceSign : VFACE) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(input);

    SurfaceData surfaceData;
    HairData hairData;
    InitializeSurfaceData(input.uv, surfaceData, hairData);

    InputData inputData;
    VectorsData vData;
    InitializeInputData(input, surfaceData.normalTS, vData, inputData);

    half4 color = KKHairFragment(inputData, surfaceData, vData, hairData);

    return color;
}

#endif
