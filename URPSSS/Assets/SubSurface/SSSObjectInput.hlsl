#ifndef _SSS_OBJECT_INPUT_HLSL_
#define _SSS_OBJECT_INPUT_HLSL_


// 顶点着色器输入结构体
struct Attributes
{
    float4 positionOS : POSITION; // 物体空间坐标
    float3 normalOS   : NORMAL;   // 物体空间法线
    float4 tangentOS : TANGENT;
    float2 uv         : TEXCOORD0;// UV坐标
};

// 顶点 -> 片元 传递结构体
struct Varyings
{
    float4 positionCS : SV_POSITION; // 裁剪空间坐标
    float3 positionWS : TEXCOORD0;   // 世界空间坐标
    float2 uv         : TEXCOORD1;

    float3 normalWS   : TEXCOORD2;   // 世界空间法线
    float4 tangentWS : TEXCOORD3;
    float3 bitangentWS : TEXCOORD4;

    float4 screenPos  : TEXCOORD5; // 传递屏幕坐标

    // float4 ase_texcoord4 : TEXCOORD6;
    // float4 ase_texcoord5 : TEXCOORD7;
    // float4 ase_texcoord6 : TEXCOORD8;
};


// 定义 CBUFFER (常量缓冲区) 以支持 SRP Batcher 优化
CBUFFER_START(UnityPerMaterial)
    float4 _BaseMap_ST;
    half4 _Color;

    half _Subsurface;

    half _LightClamp;
    half _DiffuseRoughness;
    half _Diffuseboost;

    half _NormalIntensity;

    half _RedCheekIntensity;

    float _SmoothnessMult;

    // Occusion
    half4 _OcclusionColor;
    float _Cavity;
    float _Occlusionlightpass;
    float _Occlusionfinalpass;
    float _SpecularOcclusion;

    // Transmission
    half _TransmissionColor;
    float _Travel_Distance;
    float _TravelDistancePointLights;

    half _GradientMin;
    half _GradientMax;

    half _Transmission_intensity;
    half _TravelDistanceMult;
    half _Transmission_Bias;
    half _CancelMin;
    half _CancelMax;

    half _MaskWithNormals;

    half4 _ProfileColor;
    half _Blur;

    half4 _SpecColor;
    half _Smoothness;
    half _CavityStrength;
    half _FresnelIntensity;
    half _EnvironmentReflectionsIntensity;
    half _SpecularHighlightIntensity;
CBUFFER_END

// 纹理采样器声明
TEXTURE2D(_BaseMap);        SAMPLER(sampler_BaseMap);
TEXTURE2D(_SubsurfaceMap);     SAMPLER(sampler_SubsurfaceMap);
TEXTURE2D(_BumpMap);      SAMPLER(sampler_BumpMap);

TEXTURE2D(_MaskMap);      SAMPLER(sampler_MaskMap);

TEXTURE2D(_OcclusionMap);            SAMPLER(sampler_OcclusionMap);
TEXTURE2D(_SpecGlossMap);            SAMPLER(sampler_SpecGlossMap);

TEXTURE2D(_TransmissionGradient);      SAMPLER(sampler_TransmissionGradient);
TEXTURE2D(_TransmissionMap);      SAMPLER(sampler_TransmissionMap);

TEXTURE2D(_SSS_Blur);   SAMPLER(sampler_SSS_Blur);


// 顶点着色器
Varyings vert(Attributes input)
{
    Varyings output;
    
    // 1. 空间变换：物体空间 -> 世界空间 -> 裁剪空间
    VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
    output.positionCS = vertexInput.positionCS;
    output.positionWS = vertexInput.positionWS;

    // 2. 法线变换：物体空间 -> 世界空间
    VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS);
    output.normalWS = normalInput.normalWS;
    float sign = input.tangentOS.w * GetOddNegativeScale();
    half4 tangentWS = half4(normalInput.tangentWS.xyz, sign);
    output.tangentWS = tangentWS;
    output.bitangentWS = normalInput.bitangentWS;

    // // ASE normalWS
    // float3 ase_worldTangent = TransformObjectToWorldDir(input.tangentOS.xyz);
    // output.ase_texcoord4.xyz = ase_worldTangent;
    // float3 ase_worldNormal = TransformObjectToWorldNormal(input.normalOS);
    // output.ase_texcoord5.xyz = ase_worldNormal;
    // float ase_vertexTangentSign = input.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
    // float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
    // output.ase_texcoord6.xyz = ase_worldBitangent;

    // 3. UV 变换
    output.uv = TRANSFORM_TEX(input.uv, _BaseMap);
    
    // ComputeScreenPos 是 URP 提供的核心函数，处理了平台差异（DirectX/OpenGL）
    output.screenPos = ComputeScreenPos(output.positionCS);

    return output;
}

#endif