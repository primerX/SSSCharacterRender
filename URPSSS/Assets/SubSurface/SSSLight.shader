Shader "Shenkong/SSSLighting"
{
    Properties
    {
        _BaseMap("BaseMap", 2D) = "white" {}
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)

        _SubsurfaceMap("Surface Map", 2D) = "white" {}
        _Subsurface("SurfaceMap Visibility", Range(0, 1)) = 1

        _DiffuseRoughness("Diffuse Roughness", Range(0, 1)) = 1
        _LightClamp("Light Clamp", Float) = 10
        _Diffuseboost("Diffuse boost", Range(1, 2)) = 1

        _BumpMap ("Normal Map", 2D) = "bump" {}
        _NormalIntensity("Normal Scale", Range(0, 10)) = 1

        [Space]
        [Head(MaskSetting)]
        _MaskMap("Mask Map", 2D) = "white" {}
        
        // OcclusionMap
		[NoScaleOffset]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionColor("Occlusion Color", Color) = (0,0,0,0)
		[Toggle]_Cavity("_Cavity", Range( 0 , 1)) = 1
		_CavityStrength("Cavity", Range( 0 , 1)) = 0
		_Occlusionfinalpass("Occlusion final pass", Range( 0 , 1)) = 0.5
		_Occlusionlightpass("Occlusion light pass", Range( 0 , 1)) = 0.5
		_SpecularOcclusion("Specular Occlusion", Range( 0 , 1)) = 1

        // Transmission
		_Travel_Distance("Travel Distance", Range( 0 , 0.02)) = 0.01
		_TravelDistancePointLights("Travel Distance PointLights", Range( 0 , 0.02)) = 0.01

		_TransmissionGradient("TransmissionGradient", 2D) = "white" {}
		_GradientMin("GradientMin", Range( -1 , 1)) = 0
		_GradientMax("GradientMax", Range( 0 , 4)) = 1

        _TransmissionMap("TransmissionMap", 2D) = "white" {}
        _Transmission_intensity("Transmission Intensity", Range( 0 , 5)) = 0.5

		[Enum(x1,1,x2,2,x4,4,x8,8,x16,16)] _TravelDistanceMult("Multiplier", Range( 1 , 6)) = 1
		_Transmission_Bias("Transmission Bias", Range( 0 , 0.5)) = 0


		[Toggle]_MaskWithNormals("Mask with normals", Range( 0 , 1)) = 0
        _CancelMin("CancelMin", Range( -1 , 0)) = -0.5
		_CancelMax("CancelMax", Range( 0 , 1)) = 0
    }

    SubShader
    {
        Tags 
        { 
            "RenderType" = "Opaque" 
            "RenderPipeline" = "UniversalPipeline" 
            "Queue" = "Geometry" 
        }

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM
            // 声明顶点和片元着色器函数名
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            // #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            // #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            // #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
            // #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            // #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
            // #pragma multi_compile_fragment _ _LIGHT_COOKIES
            // #pragma multi_compile _ _LIGHT_LAYERS
            // #pragma multi_compile _ _FORWARD_PLUS

            // -------------------------------------
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			// #pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			// #pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			// #pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

            // 引入 URP 核心库和光照库
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"        
            #include "./Common.hlsl"

            CBUFFER_START(UnityPerMaterial)
                float4 _BaseMap_ST;
                half4 _BaseColor;

                half _Subsurface;

                half _LightClamp;
                half _DiffuseRoughness;
                half _Diffuseboost;

                half4 _RedCheekIntensity;

                half _NormalIntensity;

                // Occusion
                half4 _OcclusionColor;
                float _Cavity;
                float _CavityStrength;
                float _Occlusionlightpass;
                float _Occlusionfinalpass;
                float _SpecularOcclusion;

                // Transmission
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
            CBUFFER_END

            TEXTURE2D(_BaseMap);            SAMPLER(sampler_BaseMap);
            TEXTURE2D(_SubsurfaceMap);      SAMPLER(sampler_SubsurfaceMap);
            TEXTURE2D(_BumpMap);            SAMPLER(sampler_BumpMap);

            TEXTURE2D(_MaskMap);      SAMPLER(sampler_MaskMap);
            TEXTURE2D(_RedCheekMap);      SAMPLER(sampler_RedCheekMap);

            TEXTURE2D(_OcclusionMap);            SAMPLER(sampler_OcclusionMap);

            TEXTURE2D(_TransmissionGradient);       SAMPLER(sampler_TransmissionGradient);
            TEXTURE2D(_TransmissionMap);            SAMPLER(sampler_TransmissionMap);


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
                float3 tangentWS : TEXCOORD3;
                float3 bitangentWS : TEXCOORD4;

                float4 ase_texcoord4 : TEXCOORD5;
				float4 ase_texcoord5 : TEXCOORD6;
				float4 ase_texcoord6 : TEXCOORD7;

                float4 screenPos : TEXCOORD8;
            };

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
				output.tangentWS = normalInput.tangentWS;
				output.bitangentWS = normalInput.bitangentWS;
				output.normalWS = normalInput.normalWS;

                // ASE normalWS
				float3 ase_worldTangent = TransformObjectToWorldDir(input.tangentOS.xyz);
				output.ase_texcoord4.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(input.normalOS);
				output.ase_texcoord5.xyz = ase_worldNormal;
				float ase_vertexTangentSign = input.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				output.ase_texcoord6.xyz = ase_worldBitangent;

                // 3. UV 变换
                // output.uv = TRANSFORM_TEX(input.uv, _BaseMap);
                output.uv = input.uv;

                output.screenPos = ComputeScreenPos(output.positionCS);

                return output;
            }

            // 片元着色器
            half4 frag(Varyings input, bool isFacing : SV_IsFrontFace) : SV_Target
            {
                // --- 准备数据 ---
                // 采样基础纹理并叠加颜色
                half4 baseMap = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);
                half3 albedo = baseMap.rgb * _BaseColor.rgb;

                // 采样法线贴图并解包 (UnpackNormalScale 处理了纹理压缩和强度缩放)
                half4 normal = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, input.uv);
                half3 normalTS = UnpackNormalScale(normal, _NormalIntensity);
                normalTS = normalize(normalTS);
				half3 normalWS = TransformTangentToWorld(normalTS, half3x3(input.tangentWS.xyz, input.bitangentWS.xyz, input.normalWS.xyz));

                // ASE 计算 NormalWS 方法
				float3 ase_worldTangent = input.ase_texcoord4.xyz;
				float3 ase_worldNormal = input.ase_texcoord5.xyz;
				float3 ase_worldBitangent = input.ase_texcoord6.xyz;

				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal610 = normalTS;
				float3 worldNormal610 = normalize( float3(dot(tanToWorld0,tanNormal610), dot(tanToWorld1,tanNormal610), dot(tanToWorld2,tanNormal610)) );
                normalWS = worldNormal610;

                // Sample DepthNormalTexture
                // float2 screenUV = input.screenPos.xy / input.screenPos.w;
                // half3 sceneNormals = half3(SampleSceneNormals(screenUV));
                // sceneNormals = (sceneNormals + 1) / 2;
                // normalWS = normalize(sceneNormals);
                // return half4(sceneNormals, 1);

                // Maskmap
                half4 maskMap = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, input.uv);
                float diffuseRoughness = _DiffuseRoughness;
                // float diffuseRoughness = 1- maskMap.r;

                float3 positionWS = input.positionWS;
                float3 viewWS = normalize(GetWorldSpaceViewDir(input.positionWS));
                float2 lightmapUV = float2(1, 1);
                float3 GI = float3(1, 1, 1);
                
                half3 diffuseRes = DiffuseLightingFull(positionWS, normalWS, 
                                        diffuseRoughness, viewWS, lightmapUV, GI, _LightClamp);

                diffuseRes *= _Diffuseboost;

                // subsurface map
                // half4 subsurface = SAMPLE_TEXTURE2D(_SubsurfaceMap, sampler_SubsurfaceMap, input.uv);
                // subsurface = lerp(half4(1,1,1,1), subsurface, _Subsurface);
                // diffuseRes *= subsurface.rgb;

                // Occlusion
                half4 occlusionMap = SAMPLE_TEXTURE2D(_OcclusionMap, sampler_OcclusionMap, input.uv);
                half4 occlusionColor = lerp(_OcclusionColor, 1, occlusionMap.r);
                // half4 occlusionColor = lerp(_OcclusionColor, 1, maskMap.r);

                half4 occlusionFinalPass = lerp(half4(1, 1, 1, 0), occlusionColor, _Occlusionfinalpass);
                half4 occlusionLightPass = lerp(half4(1, 1, 1, 0), occlusionColor, _Occlusionlightpass); 

                diffuseRes *= occlusionLightPass;

                // return maskMap.r;

                // Shadowmap
                half3 experimental = 0.0;
                
                float Travel_Distance_PointLights = _TravelDistancePointLights * _TravelDistanceMult;
                float2 Cancel = float2(_CancelMin, _CancelMax);
                half2 TSM_Grad = half2(_GradientMin, _GradientMax);
                // half thickness = SAMPLE_TEXTURE2D(_TransmissionMap, sampler_TransmissionMap, input.uv).r + _Transmission_Bias;
                
                half thickness = maskMap.a + _Transmission_Bias;
                half4 redCheekInfo = SAMPLE_TEXTURE2D(_RedCheekMap, sampler_RedCheekMap, input.uv);
                thickness += redCheekInfo.r * _RedCheekIntensity.x;     //
                thickness += redCheekInfo.g * _RedCheekIntensity.y;     // 脸颊部分
                thickness += redCheekInfo.b * _RedCheekIntensity.z;     // 眼下部分
                thickness += redCheekInfo.a * _RedCheekIntensity.w;     // 耳朵部分

                half intensity = _Transmission_intensity;
                
                half3 transmissionArea = TranslucentShadowmap_My(_Travel_Distance, Travel_Distance_PointLights,
                    positionWS, viewWS, normalWS, Cancel, _MaskWithNormals,
                    experimental, _TransmissionGradient, sampler_TransmissionGradient, TSM_Grad,
                    thickness, intensity, _LightClamp
                );

                // return half4(transmissionArea, 1);

                // --- 最终合成 ---
                half3 finalColor = diffuseRes + experimental;

                return half4(finalColor, 1);
            }
            ENDHLSL
        }
    }
}