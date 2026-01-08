// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/LightPass"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		_ttm("ttm", 2D) = "white" {}
		_GI("GI", Range( 0 , 10)) = 1
		[SingleLineTexture]_TransmissionMap("TransmissionMap", 2D) = "white" {}
		_SubsurfaceMap("Subsurface Map", 2D) = "white" {}
		_TransmissionTintMap("_TransmissionTintMap", 2D) = "white" {}
		_ProfileMap("Profile", 2D) = "white" {}
		_Subsurface("Subsurface", Range( 0 , 1)) = 0
		_ProfileColor("Profile Color", Color) = (1,1,1,1)
		_GradientMin("GradientMin", Range( -2 , 1)) = 0
		_LightClamp("LightClamp", Float) = 10
		_GradientMax("GradientMax", Range( 0 , 10)) = 1
		_Blur("Blur", Range( 0 , 1)) = 0.015
		_TransmissionColor("TransmissionColor", Color) = (0.7830189,0.5276353,0.2245639,0)
		_Transmission_intensity("Transmission Intensity", Range( 0 , 5)) = 0.5
		_Travel_Distance("Travel Distance", Range( 0 , 0.02)) = 0.01
		_TravelDistancePointLights("Travel Distance PointLights", Range( 0 , 0.02)) = 0.01
		[Enum(x1,1,x2,2,x4,4,x8,8,x16,16)]_TravelDistanceMult("Multiplier", Range( 1 , 6)) = 1
		_Transmission_Bias("Transmission Bias", Range( 0 , 0.5)) = 0
		_CancelMin("CancelMin", Range( -1 , 0)) = -0.5
		_CancelMax("CancelMax", Range( 0 , 1)) = 0
		[Toggle]_Transmission("Transmission", Range( 0 , 1)) = 0
		[Toggle]_MaskWithNormals("Mask with normals", Range( 0 , 1)) = 0
		[Toggle]_IrisShadow("Enable", Range( 0 , 1)) = 0
		[Toggle]_EnableSubsurface("_EnableSubsurface", Range( 0 , 1)) = 0
		_tsm_min("tsm min", Range( -1 , 1)) = 0
		_tsm_max("tsm max", Range( 0 , 2)) = 1
		_TranslucencyDistanceFade("TranslucencyDistanceFade", Float) = 2000
		_Diffuseboost("Diffuse boost", Range( 1 , 2)) = 1
		_IrisShadowDistance("Iris Shadow Distance", Range( 0 , 0.5)) = 0
		_IrisShadowOpacity("Iris Shadow Opacity", Range( 0 , 1)) = 0
		[Toggle(_ENABLETRANSMISSIONGRADIENT_ON)] _EnableTransmissionGradient("EnableTransmissionGradient", Float) = 0
		[Enum(Light Pass,0,Blur Pass,1,Specular Highlight,2,Environment Reflections,3,Transmission,4)]_SSS_DebugMode("SSS_DebugMode", Range( 1 , 5)) = 1
		[SingleLineTexture]_TransmissionGradient("TransmissionGradient", 2D) = "white" {}
		_GradientMin("GradientMin", Range( -1 , 1)) = 0
		_GradientMax("GradientMax", Range( 0 , 4)) = 1
		[Toggle]_EnableSubsurface("_EnableSubsurface", Float) = 0
		[NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
		[Toggle]_IrisShadow("Iris Shadow", Float) = 0
		[Toggle]_ScleraRing("Sclera Ring", Float) = 0
		_ScleraRingMap("Sclera Ring Map", 2D) = "white" {}
		_AlbedoOpacity("AlbedoInfluence", Range( 0 , 1)) = 1
		[Toggle]_Transmission("_Transmission", Float) = 0
		_DiffuseRoughness("DiffuseRoughness", Range( 0 , 1)) = 0
		_IrisShadowMap("_IrisShadowMap", 2D) = "white" {}
		_Dilation("Dilation", Range( 0 , 10)) = 0
		_DilationMaskRadius("DilationMaskRadius", Range( 0.01 , 0.2)) = 0.189
		_DilationMaskHardness("DilationMaskHardness", Range( 0.01 , 2)) = 0.4020753
		[Toggle]_EyeDilation("_EyeDilation", Float) = 0
		_Depth("Depth", Range( 0 , 1)) = 0
		_Depth_Center("Depth Center", Range( -1 , 1)) = 0
		_IrisSelfShadowCircleRadius("IrisSelfShadowCircleRadius", Range( 0 , 1)) = 0.3586957
		_IrisShadowOpacity("IrisShadowOpacity", Range( 0 , 1)) = 0.3586957
		_IrisSelfShadowCircleHardness("IrisSelfShadowCircleHardness", Range( 0 , 10)) = 10
		[Toggle(_DEBUG_ON)] _Debug("Debug", Float) = 0
		[Toggle(_ENABLE_DETAIL_NORMAL)] _EnableDetailNormal("Enable Detail Normal", Float) = 0
		_Tiling("Tiling", Float) = 1
		_ScaleUV("Scale", Range( 0 , 2)) = 1
		[Toggle]_EnableUVScale("EnableUVScale", Float) = 0
		[Toggle]_EnableParallax("_EnableParallax", Float) = 0
		[NoScaleOffset][Normal]_BumpMap("Normal", 2D) = "bump" {}
		_NormalIntensity("Normal Intensity", Range( 0 , 1)) = 1
		[NoScaleOffset][Normal]_DetailNormalMap("Detail Normal Map", 2D) = "bump" {}
		_DetailNormalIntensity("Detail Normal Intensity", Range( 0 , 1)) = 1
		_DetailNormalMapTile("Tile", Float) = 10
		[NoScaleOffset]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionColor("Occlusion Color", Color) = (0,0,0,0)
		[Toggle]_Cavity("_Cavity", Range( 0 , 1)) = 1
		_CavityStrength("Cavity", Range( 0 , 1)) = 0
		_Occlusionfinalpass("Occlusion final pass", Range( 0 , 1)) = 0.5
		_Occlusionlightpass("Occlusion light pass", Range( 0 , 1)) = 0.5
		_SpecularOcclusion("Specular Occlusion", Range( 0 , 1)) = 1
		_Color("Color", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Lit" }

		Cull Back
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#pragma shader_feature_local_fragment _SPECULAR_SETUP
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			
			
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
		
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _FORWARD_PLUS

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#pragma multi_compile_fragment _ _WRITE_RENDERING_LAYERS

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			#pragma shader_feature_local_fragment _DEBUG_ON
			#include "Common.hlsl"


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);
			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_Linear_Clamp);


			float2 MyCustomExpression17_g843( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g840( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g857( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g854( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 ASEBakedGI( float3 normalWS, float2 uvStaticLightmap, bool applyScaling )
			{
			#ifdef LIGHTMAP_ON
				if( applyScaling )
					uvStaticLightmap = uvStaticLightmap * unity_LightmapST.xy + unity_LightmapST.zw;
				return SampleLightmap( uvStaticLightmap, normalWS );
			#else
				return SampleSH(normalWS);
			#endif
			}
			
			float3 LightingFull2_g792( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			float2 MyCustomExpression17_g824( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g821( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g817( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g814( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 LightingFull2_g808( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			float2 MyCustomExpression17_g47( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g44( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float Transmission3_g880( float TravelDistance, float TravelDistancePointLights, float3 WorldPos, float3 ViewPos, out float3 experimental, float3 WorldNormal, float2 Cancel, float MaskWithNormals, TEXTURE2D(TransmissionGradient), SamplerState ssClamp, float2 TSM_Grad, float Thickness, float Intensity, float LightClamp )
			{
				experimental =1;
				return TranslucentShadowmap(TravelDistance, TravelDistancePointLights, WorldPos, ViewPos, WorldNormal, Cancel, MaskWithNormals, experimental, TransmissionGradient, ssClamp, TSM_Grad, Thickness, Intensity, LightClamp);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord8.xy = v.texcoord.xy;
				o.ase_texcoord8.zw = v.texcoord1.xy;
				o.ase_texcoord9.xy = v.texcoord2.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord9.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif
				v.normalOS = v.normalOS;
				v.tangentOS = v.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( v.normalOS, v.tangentOS );

				o.tSpace0 = float4( normalInput.normalWS, vertexInput.positionWS.x );
				o.tSpace1 = float4( normalInput.tangentWS, vertexInput.positionWS.y );
				o.tSpace2 = float4( normalInput.bitangentWS, vertexInput.positionWS.z );

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord.xy;
					o.lightmapUVOrVertexSH.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );

				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( vertexInput.positionCS.z );
				#else
					half fogFactor = 0;
				#endif

				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.positionCS);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float3 temp_cast_0 = (0.0).xxx;
				
				float2 texCoord15_g839 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g842 = ( texCoord15_g839 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g843 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g842 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g842 ));
				float Depth17_g843 = _Depth;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 ase_tanViewDir =  tanToWorld0 * WorldViewDirection.x + tanToWorld1 * WorldViewDirection.y  + tanToWorld2 * WorldViewDirection.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g843 = ase_tanViewDir;
				float2 uv17_g843 = temp_output_12_0_g843;
				SamplerState ss17_g843 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g843 = MyCustomExpression17_g843( Depth17_g843 , viewDir17_g843 , uv17_g843 , ss17_g843 );
				float2 temp_output_4_0_g840 = (( _EnableParallax )?( localMyCustomExpression17_g843 ):( temp_output_12_0_g843 ));
				float2 inUV8_g840 = temp_output_4_0_g840;
				float2 temp_output_7_0_g841 = ( ( temp_output_4_0_g840 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g841 = dot( temp_output_7_0_g841 , temp_output_7_0_g841 );
				float ScaleMask8_g840 = ( 1.0 - pow( saturate( dotResult2_g841 ) , 0.15 ) );
				float Dilation8_g840 = _Dilation;
				float2 localDilationnotexture8_g840 = Dilationnotexture8_g840( inUV8_g840 , ScaleMask8_g840 , Dilation8_g840 );
				float2 temp_output_26_0_g832 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g840 : temp_output_4_0_g840 );
				float3 unpack1_g832 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g832 ), _NormalIntensity );
				unpack1_g832.z = lerp( 1, unpack1_g832.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g832 = normalize( unpack1_g832 );
				float3 unpack8_g832 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g832 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g832.z = lerp( 1, unpack8_g832.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g832 = BlendNormal( normalizeResult20_g832 , unpack8_g832 );
				#else
				float3 staticSwitch15_g832 = normalizeResult20_g832;
				#endif
				float3 temp_output_6_0_g833 = staticSwitch15_g832;
				float2 texCoord8_g838 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g838 = texCoord8_g838;
				float2 temp_cast_2 = (0.5).xx;
				float4 tex2DNode2_g833 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g838 - temp_cast_2 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g838 )) );
				float3 lerpResult9_g833 = lerp( temp_output_6_0_g833 , float3( 0,0,1 ) , tex2DNode2_g833.a);
				
				float3 WorldPos2_g792 = WorldPosition;
				float2 texCoord15_g853 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g856 = ( texCoord15_g853 * _Tiling );
				float2 temp_cast_3 = (0.5).xx;
				float2 temp_output_12_0_g857 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g856 - temp_cast_3 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g856 ));
				float Depth17_g857 = _Depth;
				float3 viewDir17_g857 = ase_tanViewDir;
				float2 uv17_g857 = temp_output_12_0_g857;
				SamplerState ss17_g857 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g857 = MyCustomExpression17_g857( Depth17_g857 , viewDir17_g857 , uv17_g857 , ss17_g857 );
				float2 temp_output_4_0_g854 = (( _EnableParallax )?( localMyCustomExpression17_g857 ):( temp_output_12_0_g857 ));
				float2 inUV8_g854 = temp_output_4_0_g854;
				float2 temp_output_7_0_g855 = ( ( temp_output_4_0_g854 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g855 = dot( temp_output_7_0_g855 , temp_output_7_0_g855 );
				float ScaleMask8_g854 = ( 1.0 - pow( saturate( dotResult2_g855 ) , 0.15 ) );
				float Dilation8_g854 = _Dilation;
				float2 localDilationnotexture8_g854 = Dilationnotexture8_g854( inUV8_g854 , ScaleMask8_g854 , Dilation8_g854 );
				float2 temp_output_26_0_g846 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g854 : temp_output_4_0_g854 );
				float3 unpack1_g846 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g846 ), _NormalIntensity );
				unpack1_g846.z = lerp( 1, unpack1_g846.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g846 = normalize( unpack1_g846 );
				float3 unpack8_g846 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g846 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g846.z = lerp( 1, unpack8_g846.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g846 = BlendNormal( normalizeResult20_g846 , unpack8_g846 );
				#else
				float3 staticSwitch15_g846 = normalizeResult20_g846;
				#endif
				float3 temp_output_6_0_g847 = staticSwitch15_g846;
				float2 texCoord8_g852 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g852 = texCoord8_g852;
				float2 temp_cast_4 = (0.5).xx;
				float4 tex2DNode2_g847 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g852 - temp_cast_4 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g852 )) );
				float3 lerpResult9_g847 = lerp( temp_output_6_0_g847 , float3( 0,0,1 ) , tex2DNode2_g847.a);
				float3 temp_output_600_0 = (( _ScleraRing )?( lerpResult9_g847 ):( temp_output_6_0_g847 ));
				float3 tanNormal53 = temp_output_600_0;
				float3 worldNormal53 = float3(dot(tanToWorld0,tanNormal53), dot(tanToWorld1,tanNormal53), dot(tanToWorld2,tanNormal53));
				float3 temp_output_6_0_g792 = worldNormal53;
				float3 Normal2_g792 = temp_output_6_0_g792;
				float r2_g792 = _DiffuseRoughness;
				float3 WorldView2_g792 = WorldViewDirection;
				float2 texCoord7_g792 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g792 = texCoord7_g792;
				float2 texCoord9_g792 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g792 = ASEBakedGI( temp_output_6_0_g792, texCoord7_g792, true);
				float3 GI2_g792 = bakedGI8_g792;
				float LightClamp579 = _LightClamp;
				float LightClamp2_g792 = LightClamp579;
				float3 localLightingFull2_g792 = LightingFull2_g792( WorldPos2_g792 , Normal2_g792 , r2_g792 , WorldView2_g792 , lightmapUV2_g792 , GI2_g792 , LightClamp2_g792 );
				float Diffuse_boost168 = _Diffuseboost;
				float4 temp_cast_6 = (1.0).xxxx;
				float2 texCoord15_g820 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g823 = ( texCoord15_g820 * _Tiling );
				float2 temp_cast_7 = (0.5).xx;
				float2 temp_output_12_0_g824 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g823 - temp_cast_7 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g823 ));
				float Depth17_g824 = _Depth;
				float3 viewDir17_g824 = ase_tanViewDir;
				float2 uv17_g824 = temp_output_12_0_g824;
				SamplerState ss17_g824 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g824 = MyCustomExpression17_g824( Depth17_g824 , viewDir17_g824 , uv17_g824 , ss17_g824 );
				float2 temp_output_4_0_g821 = (( _EnableParallax )?( localMyCustomExpression17_g824 ):( temp_output_12_0_g824 ));
				float2 inUV8_g821 = temp_output_4_0_g821;
				float2 temp_output_7_0_g822 = ( ( temp_output_4_0_g821 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g822 = dot( temp_output_7_0_g822 , temp_output_7_0_g822 );
				float ScaleMask8_g821 = ( 1.0 - pow( saturate( dotResult2_g822 ) , 0.15 ) );
				float Dilation8_g821 = _Dilation;
				float2 localDilationnotexture8_g821 = Dilationnotexture8_g821( inUV8_g821 , ScaleMask8_g821 , Dilation8_g821 );
				float4 tex2DNode3_g819 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, ( 1.0 == _EyeDilation ? localDilationnotexture8_g821 : temp_output_4_0_g821 ) );
				float4 lerpResult26_g819 = lerp( _OcclusionColor , temp_cast_6 , tex2DNode3_g819.r);
				float4 lerpResult1_g819 = lerp( float4( 1,1,1,0 ) , lerpResult26_g819 , _Occlusionlightpass);
				float4 temp_output_597_0 = lerpResult1_g819;
				float2 texCoord57 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord58 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI56 = ASEBakedGI( worldNormal53, texCoord57, true);
				float GI128 = _GI;
				float2 texCoord15_g813 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g816 = ( texCoord15_g813 * _Tiling );
				float2 temp_cast_12 = (0.5).xx;
				float2 temp_output_12_0_g817 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g816 - temp_cast_12 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g816 ));
				float Depth17_g817 = _Depth;
				float3 viewDir17_g817 = ase_tanViewDir;
				float2 uv17_g817 = temp_output_12_0_g817;
				SamplerState ss17_g817 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g817 = MyCustomExpression17_g817( Depth17_g817 , viewDir17_g817 , uv17_g817 , ss17_g817 );
				float2 temp_output_4_0_g814 = (( _EnableParallax )?( localMyCustomExpression17_g817 ):( temp_output_12_0_g817 ));
				float2 inUV8_g814 = temp_output_4_0_g814;
				float2 temp_output_7_0_g815 = ( ( temp_output_4_0_g814 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g815 = dot( temp_output_7_0_g815 , temp_output_7_0_g815 );
				float ScaleMask8_g814 = ( 1.0 - pow( saturate( dotResult2_g815 ) , 0.15 ) );
				float Dilation8_g814 = _Dilation;
				float2 localDilationnotexture8_g814 = Dilationnotexture8_g814( inUV8_g814 , ScaleMask8_g814 , Dilation8_g814 );
				float2 temp_output_62_0_g809 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g814 : temp_output_4_0_g814 );
				float3x3 ase_worldToTangent = float3x3(WorldTangent,WorldBiTangent,WorldNormal);
				float3 worldToTangentDir6_g809 = normalize( mul( ase_worldToTangent, SafeNormalize(_MainLightPosition.xyz)) );
				float2 appendResult4_g809 = (float2(worldToTangentDir6_g809.x , worldToTangentDir6_g809.y));
				float Iris_Shadow_Distance196 = _IrisShadowDistance;
				float2 temp_output_2_0_g809 = ( temp_output_62_0_g809 + ( appendResult4_g809 * Iris_Shadow_Distance196 ) );
				float2 temp_output_7_0_g812 = ( ( temp_output_2_0_g809 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g812 = dot( temp_output_7_0_g812 , temp_output_7_0_g812 );
				float3 temp_cast_13 = (( 1.0 - pow( saturate( dotResult2_g812 ) , _IrisSelfShadowCircleHardness ) )).xxx;
				float2 temp_output_7_0_g811 = ( ( temp_output_62_0_g809 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g811 = dot( temp_output_7_0_g811 , temp_output_7_0_g811 );
				float3 Normal_Tangent336 = temp_output_600_0;
				float3 tanNormal26_g809 = Normal_Tangent336;
				float3 worldNormal26_g809 = float3(dot(tanToWorld0,tanNormal26_g809), dot(tanToWorld1,tanNormal26_g809), dot(tanToWorld2,tanNormal26_g809));
				float dotResult27_g809 = dot( SafeNormalize(_MainLightPosition.xyz) , worldNormal26_g809 );
				float smoothstepResult31_g809 = smoothstep( -0.31 , -0.02 , dotResult27_g809);
				float temp_output_2_0_g810 = ( _IrisShadowOpacity * ( 1.0 - pow( saturate( dotResult2_g811 ) , _IrisSelfShadowCircleHardness ) ) * saturate( smoothstepResult31_g809 ) );
				float temp_output_3_0_g810 = ( 1.0 - temp_output_2_0_g810 );
				float3 appendResult7_g810 = (float3(temp_output_3_0_g810 , temp_output_3_0_g810 , temp_output_3_0_g810));
				float IrisShadow190 = (( ( temp_cast_13 * temp_output_2_0_g810 ) + appendResult7_g810 )).x;
				float3 temp_output_492_0 = (( _IrisShadow )?( ( ( ( float4( localLightingFull2_g792 , 0.0 ) * Diffuse_boost168 * temp_output_597_0 ) + ( float4( bakedGI56 , 0.0 ) * GI128 * temp_output_597_0 ) ) * IrisShadow190 ).rgb ):( ( ( float4( localLightingFull2_g792 , 0.0 ) * Diffuse_boost168 * temp_output_597_0 ) + ( float4( bakedGI56 , 0.0 ) * GI128 * temp_output_597_0 ) ).rgb ));
				float3 WorldPos2_g808 = WorldPosition;
				float3 temp_output_6_0_g808 = WorldNormal;
				float3 Normal2_g808 = temp_output_6_0_g808;
				float r2_g808 = _DiffuseRoughness;
				float3 WorldView2_g808 = WorldViewDirection;
				float2 texCoord7_g808 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g808 = texCoord7_g808;
				float2 texCoord9_g808 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g808 = ASEBakedGI( temp_output_6_0_g808, texCoord7_g808, true);
				float3 GI2_g808 = bakedGI8_g808;
				float LightClamp2_g808 = LightClamp579;
				float3 localLightingFull2_g808 = LightingFull2_g808( WorldPos2_g808 , Normal2_g808 , r2_g808 , WorldView2_g808 , lightmapUV2_g808 , GI2_g808 , LightClamp2_g808 );
				float3 bakedGI441 = ASEBakedGI( WorldNormal, texCoord57, true);
				float3 temp_cast_15 = (0.0).xxx;
				float2 texCoord8_g831 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g831 = texCoord8_g831;
				float2 temp_cast_16 = (0.5).xx;
				float4 tex2DNode2_g826 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g831 - temp_cast_16 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g831 )) );
				float3 temp_cast_17 = (tex2DNode2_g826.a).xxx;
				float3 lerpResult439 = lerp( temp_output_492_0 , ( ( localLightingFull2_g808 * Diffuse_boost168 ) + ( bakedGI441 * GI128 ) ) , (( _ScleraRing )?( temp_cast_17 ):( temp_cast_15 )));
				float4 temp_cast_19 = (( _SSS_DebugMode == 4.0 ? 0.0 : 1.0 )).xxxx;
				#ifdef _DEBUG_ON
				float4 staticSwitch586 = temp_cast_19;
				#else
				float4 staticSwitch586 = _Color;
				#endif
				float4 temp_output_34_0 = ( float4( (( _ScleraRing )?( lerpResult439 ):( temp_output_492_0 )) , 0.0 ) * staticSwitch586 );
				float2 texCoord15_g43 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g46 = ( texCoord15_g43 * _Tiling );
				float2 temp_cast_21 = (0.5).xx;
				float2 temp_output_12_0_g47 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g46 - temp_cast_21 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g46 ));
				float Depth17_g47 = _Depth;
				float3 viewDir17_g47 = ase_tanViewDir;
				float2 uv17_g47 = temp_output_12_0_g47;
				SamplerState ss17_g47 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g47 = MyCustomExpression17_g47( Depth17_g47 , viewDir17_g47 , uv17_g47 , ss17_g47 );
				float2 temp_output_4_0_g44 = (( _EnableParallax )?( localMyCustomExpression17_g47 ):( temp_output_12_0_g47 ));
				float2 inUV8_g44 = temp_output_4_0_g44;
				float2 temp_output_7_0_g45 = ( ( temp_output_4_0_g44 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g45 = dot( temp_output_7_0_g45 , temp_output_7_0_g45 );
				float ScaleMask8_g44 = ( 1.0 - pow( saturate( dotResult2_g45 ) , 0.15 ) );
				float Dilation8_g44 = _Dilation;
				float2 localDilationnotexture8_g44 = Dilationnotexture8_g44( inUV8_g44 , ScaleMask8_g44 , Dilation8_g44 );
				float2 temp_output_97_0_g42 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g44 : temp_output_4_0_g44 );
				float4 Subsurface_Map124 = SAMPLE_TEXTURE2D( _SubsurfaceMap, sampler_SubsurfaceMap, temp_output_97_0_g42 );
				float Subsurface126 = _Subsurface;
				float4 lerpResult32 = lerp( float4( 1,1,1,0 ) , Subsurface_Map124 , Subsurface126);
				float Travel_Distance117 = _Travel_Distance;
				float TravelDistance3_g880 = Travel_Distance117;
				float Travel_Distance_PointLights593 = ( _TravelDistancePointLights * _TravelDistanceMult );
				float TravelDistancePointLights3_g880 = Travel_Distance_PointLights593;
				float3 WorldPos3_g880 = WorldPosition;
				float3 ViewPos3_g880 = _WorldSpaceCameraPos;
				float3 experimental3_g880 = float3( 0,0,0 );
				float3 normalizedWorldNormal = normalize( WorldNormal );
				float3 WorldNormal3_g880 = normalizedWorldNormal;
				float Cancel_Min108 = _CancelMin;
				float Cancel_Max109 = _CancelMax;
				float2 appendResult13_g880 = (float2(Cancel_Min108 , Cancel_Max109));
				float2 Cancel3_g880 = appendResult13_g880;
				float MaskWithNormals526 = _MaskWithNormals;
				float MaskWithNormals3_g880 = MaskWithNormals526;
				TEXTURE2D(TransmissionGradient3_g880) = _TransmissionGradient;
				SamplerState ssClamp3_g880 = sampler_Linear_Clamp;
				float2 appendResult27_g880 = (float2(_GradientMin , _GradientMax));
				float2 TSM_Grad3_g880 = appendResult27_g880;
				float Transmission_Bias119 = _Transmission_Bias;
				float2 uv_TransmissionMap = IN.ase_texcoord8.xy * _TransmissionMap_ST.xy + _TransmissionMap_ST.zw;
				float3 temp_cast_24 = (0.0).xxx;
				float2 texCoord8_g54 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g54 = texCoord8_g54;
				float2 temp_cast_25 = (0.5).xx;
				float4 tex2DNode2_g49 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g54 - temp_cast_25 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g54 )) );
				float3 temp_cast_26 = (tex2DNode2_g49.a).xxx;
				float3 temp_output_112_4_g42 = (( _ScleraRing )?( temp_cast_26 ):( temp_cast_24 ));
				float4 lerpResult99_g42 = lerp( SAMPLE_TEXTURE2D( _TransmissionMap, sampler_TransmissionMap, temp_output_97_0_g42 ) , SAMPLE_TEXTURE2D( _TransmissionMap, sampler_TransmissionMap, uv_TransmissionMap ) , float4( saturate( ( temp_output_112_4_g42 * temp_output_112_4_g42 * 2.0 ) ) , 0.0 ));
				float4 Transmission_Map121 = lerpResult99_g42;
				float4 TransmisionBiased81 = ( Transmission_Bias119 + Transmission_Map121 );
				float Thickness3_g880 = TransmisionBiased81.r;
				float Transmission_Intensity106 = _Transmission_intensity;
				float Intensity3_g880 = Transmission_Intensity106;
				float LightClamp3_g880 = LightClamp579;
				float localTransmission3_g880 = Transmission3_g880( TravelDistance3_g880 , TravelDistancePointLights3_g880 , WorldPos3_g880 , ViewPos3_g880 , experimental3_g880 , WorldNormal3_g880 , Cancel3_g880 , MaskWithNormals3_g880 , TransmissionGradient3_g880 , ssClamp3_g880 , TSM_Grad3_g880 , Thickness3_g880 , Intensity3_g880 , LightClamp3_g880 );
				float3 temp_output_603_11 = experimental3_g880;
				float4 Transmission_Color104 = ( _TransmissionColor * SAMPLE_TEXTURE2D( _TransmissionTintMap, sampler_TransmissionTintMap, temp_output_97_0_g42 ) );
				float4 experimental_shadow513 = ( float4( temp_output_603_11 , 0.0 ) * Transmission_Color104 );
				
				float3 temp_cast_31 = (0.0).xxx;
				

				float3 BaseColor = temp_cast_0;
				float3 Normal = (( _ScleraRing )?( lerpResult9_g833 ):( temp_output_6_0_g833 ));
				float3 Emission = (( _Transmission )?( ( (( _EnableSubsurface )?( ( temp_output_34_0 * lerpResult32 ) ):( temp_output_34_0 )) + experimental_shadow513 ) ):( (( _EnableSubsurface )?( ( temp_output_34_0 * lerpResult32 ) ):( temp_output_34_0 )) )).rgb;
				float3 Specular = temp_cast_31;
				float Metallic = 0;
				float Smoothness = 0.0;
				float Occlusion = 0.0;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = 0;
					float CoatSmoothness = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent, WorldBiTangent, WorldNormal));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					inputData.shadowCoord = ShadowCoords;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
				#else
					inputData.shadowCoord = float4(0, 0, 0, 0);
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif
					inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
					inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
					#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = BaseColor;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;

				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#ifdef _DBUFFER
					ApplyDecalToSurfaceData(IN.positionCS, surfaceData, inputData);
				#endif

				half4 color = UniversalFragmentPBR( inputData, surfaceData);

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					#define SUM_LIGHT_TRANSMISSION(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 transmission = max( 0, -dot( inputData.normalWS, Light.direction ) ) * atten * Transmission;\
						color.rgb += BaseColor * transmission;

					SUM_LIGHT_TRANSMISSION( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSMISSION( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSMISSION( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#define SUM_LIGHT_TRANSLUCENCY(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 lightDir = Light.direction + inputData.normalWS * normal;\
						half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );\
						half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;\
						color.rgb += BaseColor * translucency * strength;

					SUM_LIGHT_TRANSLUCENCY( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSLUCENCY( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSLUCENCY( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#include "Common.hlsl"


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif				
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);


			
			float3 _LightDirection;
			float3 _LightPosition;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = positionWS;
				#endif

				float3 normalWS = TransformObjectToWorldDir(v.normalOS);

				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				#if UNITY_REVERSED_Z
					positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#else
					positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				

				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask R
			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#include "Common.hlsl"


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD2;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				

				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#pragma shader_feature_local_fragment _SPECULAR_SETUP
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma shader_feature EDITOR_VISUALIZATION

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			#pragma shader_feature_local_fragment _DEBUG_ON
			#include "Common.hlsl"


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef EDITOR_VISUALIZATION
					float4 VizUV : TEXCOORD2;
					float4 LightCoord : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);
			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_Linear_Clamp);


			float2 MyCustomExpression17_g857( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g854( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 ASEBakedGI( float3 normalWS, float2 uvStaticLightmap, bool applyScaling )
			{
			#ifdef LIGHTMAP_ON
				if( applyScaling )
					uvStaticLightmap = uvStaticLightmap * unity_LightmapST.xy + unity_LightmapST.zw;
				return SampleLightmap( uvStaticLightmap, normalWS );
			#else
				return SampleSH(normalWS);
			#endif
			}
			
			float3 LightingFull2_g792( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			float2 MyCustomExpression17_g824( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g821( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g817( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g814( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 LightingFull2_g808( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			float2 MyCustomExpression17_g47( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g44( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float Transmission3_g880( float TravelDistance, float TravelDistancePointLights, float3 WorldPos, float3 ViewPos, out float3 experimental, float3 WorldNormal, float2 Cancel, float MaskWithNormals, TEXTURE2D(TransmissionGradient), SamplerState ssClamp, float2 TSM_Grad, float Thickness, float Intensity, float LightClamp )
			{
				experimental =1;
				return TranslucentShadowmap(TravelDistance, TravelDistancePointLights, WorldPos, ViewPos, WorldNormal, Cancel, MaskWithNormals, experimental, TransmissionGradient, ssClamp, TSM_Grad, Thickness, Intensity, LightClamp);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord5.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord6.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord7.xyz = ase_worldBitangent;
				
				o.ase_texcoord4.xy = v.texcoord0.xy;
				o.ase_texcoord4.zw = v.texcoord1.xy;
				o.ase_texcoord8.xy = v.texcoord2.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.w = 0;
				o.ase_texcoord8.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = positionWS;
				#endif

				o.positionCS = MetaVertexPosition( v.positionOS, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );

				#ifdef EDITOR_VISUALIZATION
					float2 VizUV = 0;
					float4 LightCoord = 0;
					UnityEditorVizData(v.positionOS.xyz, v.texcoord0.xy, v.texcoord1.xy, v.texcoord2.xy, VizUV, LightCoord);
					o.VizUV = float4(VizUV, 0, 0);
					o.LightCoord = LightCoord;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.texcoord0 = v.texcoord0;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.texcoord0 = patch[0].texcoord0 * bary.x + patch[1].texcoord0 * bary.y + patch[2].texcoord0 * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float3 temp_cast_0 = (0.0).xxx;
				
				float3 WorldPos2_g792 = WorldPosition;
				float2 texCoord15_g853 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g856 = ( texCoord15_g853 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g857 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g856 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g856 ));
				float Depth17_g857 = _Depth;
				float3 ase_worldTangent = IN.ase_texcoord5.xyz;
				float3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord7.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g857 = ase_tanViewDir;
				float2 uv17_g857 = temp_output_12_0_g857;
				SamplerState ss17_g857 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g857 = MyCustomExpression17_g857( Depth17_g857 , viewDir17_g857 , uv17_g857 , ss17_g857 );
				float2 temp_output_4_0_g854 = (( _EnableParallax )?( localMyCustomExpression17_g857 ):( temp_output_12_0_g857 ));
				float2 inUV8_g854 = temp_output_4_0_g854;
				float2 temp_output_7_0_g855 = ( ( temp_output_4_0_g854 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g855 = dot( temp_output_7_0_g855 , temp_output_7_0_g855 );
				float ScaleMask8_g854 = ( 1.0 - pow( saturate( dotResult2_g855 ) , 0.15 ) );
				float Dilation8_g854 = _Dilation;
				float2 localDilationnotexture8_g854 = Dilationnotexture8_g854( inUV8_g854 , ScaleMask8_g854 , Dilation8_g854 );
				float2 temp_output_26_0_g846 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g854 : temp_output_4_0_g854 );
				float3 unpack1_g846 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g846 ), _NormalIntensity );
				unpack1_g846.z = lerp( 1, unpack1_g846.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g846 = normalize( unpack1_g846 );
				float3 unpack8_g846 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g846 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g846.z = lerp( 1, unpack8_g846.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g846 = BlendNormal( normalizeResult20_g846 , unpack8_g846 );
				#else
				float3 staticSwitch15_g846 = normalizeResult20_g846;
				#endif
				float3 temp_output_6_0_g847 = staticSwitch15_g846;
				float2 texCoord8_g852 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g852 = texCoord8_g852;
				float2 temp_cast_2 = (0.5).xx;
				float4 tex2DNode2_g847 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g852 - temp_cast_2 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g852 )) );
				float3 lerpResult9_g847 = lerp( temp_output_6_0_g847 , float3( 0,0,1 ) , tex2DNode2_g847.a);
				float3 temp_output_600_0 = (( _ScleraRing )?( lerpResult9_g847 ):( temp_output_6_0_g847 ));
				float3 tanNormal53 = temp_output_600_0;
				float3 worldNormal53 = float3(dot(tanToWorld0,tanNormal53), dot(tanToWorld1,tanNormal53), dot(tanToWorld2,tanNormal53));
				float3 temp_output_6_0_g792 = worldNormal53;
				float3 Normal2_g792 = temp_output_6_0_g792;
				float r2_g792 = _DiffuseRoughness;
				float3 WorldView2_g792 = ase_worldViewDir;
				float2 texCoord7_g792 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g792 = texCoord7_g792;
				float2 texCoord9_g792 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g792 = ASEBakedGI( temp_output_6_0_g792, texCoord7_g792, true);
				float3 GI2_g792 = bakedGI8_g792;
				float LightClamp579 = _LightClamp;
				float LightClamp2_g792 = LightClamp579;
				float3 localLightingFull2_g792 = LightingFull2_g792( WorldPos2_g792 , Normal2_g792 , r2_g792 , WorldView2_g792 , lightmapUV2_g792 , GI2_g792 , LightClamp2_g792 );
				float Diffuse_boost168 = _Diffuseboost;
				float4 temp_cast_4 = (1.0).xxxx;
				float2 texCoord15_g820 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g823 = ( texCoord15_g820 * _Tiling );
				float2 temp_cast_5 = (0.5).xx;
				float2 temp_output_12_0_g824 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g823 - temp_cast_5 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g823 ));
				float Depth17_g824 = _Depth;
				float3 viewDir17_g824 = ase_tanViewDir;
				float2 uv17_g824 = temp_output_12_0_g824;
				SamplerState ss17_g824 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g824 = MyCustomExpression17_g824( Depth17_g824 , viewDir17_g824 , uv17_g824 , ss17_g824 );
				float2 temp_output_4_0_g821 = (( _EnableParallax )?( localMyCustomExpression17_g824 ):( temp_output_12_0_g824 ));
				float2 inUV8_g821 = temp_output_4_0_g821;
				float2 temp_output_7_0_g822 = ( ( temp_output_4_0_g821 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g822 = dot( temp_output_7_0_g822 , temp_output_7_0_g822 );
				float ScaleMask8_g821 = ( 1.0 - pow( saturate( dotResult2_g822 ) , 0.15 ) );
				float Dilation8_g821 = _Dilation;
				float2 localDilationnotexture8_g821 = Dilationnotexture8_g821( inUV8_g821 , ScaleMask8_g821 , Dilation8_g821 );
				float4 tex2DNode3_g819 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, ( 1.0 == _EyeDilation ? localDilationnotexture8_g821 : temp_output_4_0_g821 ) );
				float4 lerpResult26_g819 = lerp( _OcclusionColor , temp_cast_4 , tex2DNode3_g819.r);
				float4 lerpResult1_g819 = lerp( float4( 1,1,1,0 ) , lerpResult26_g819 , _Occlusionlightpass);
				float4 temp_output_597_0 = lerpResult1_g819;
				float2 texCoord57 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord58 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI56 = ASEBakedGI( worldNormal53, texCoord57, true);
				float GI128 = _GI;
				float2 texCoord15_g813 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g816 = ( texCoord15_g813 * _Tiling );
				float2 temp_cast_10 = (0.5).xx;
				float2 temp_output_12_0_g817 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g816 - temp_cast_10 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g816 ));
				float Depth17_g817 = _Depth;
				float3 viewDir17_g817 = ase_tanViewDir;
				float2 uv17_g817 = temp_output_12_0_g817;
				SamplerState ss17_g817 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g817 = MyCustomExpression17_g817( Depth17_g817 , viewDir17_g817 , uv17_g817 , ss17_g817 );
				float2 temp_output_4_0_g814 = (( _EnableParallax )?( localMyCustomExpression17_g817 ):( temp_output_12_0_g817 ));
				float2 inUV8_g814 = temp_output_4_0_g814;
				float2 temp_output_7_0_g815 = ( ( temp_output_4_0_g814 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g815 = dot( temp_output_7_0_g815 , temp_output_7_0_g815 );
				float ScaleMask8_g814 = ( 1.0 - pow( saturate( dotResult2_g815 ) , 0.15 ) );
				float Dilation8_g814 = _Dilation;
				float2 localDilationnotexture8_g814 = Dilationnotexture8_g814( inUV8_g814 , ScaleMask8_g814 , Dilation8_g814 );
				float2 temp_output_62_0_g809 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g814 : temp_output_4_0_g814 );
				float3x3 ase_worldToTangent = float3x3(ase_worldTangent,ase_worldBitangent,ase_worldNormal);
				float3 worldToTangentDir6_g809 = normalize( mul( ase_worldToTangent, SafeNormalize(_MainLightPosition.xyz)) );
				float2 appendResult4_g809 = (float2(worldToTangentDir6_g809.x , worldToTangentDir6_g809.y));
				float Iris_Shadow_Distance196 = _IrisShadowDistance;
				float2 temp_output_2_0_g809 = ( temp_output_62_0_g809 + ( appendResult4_g809 * Iris_Shadow_Distance196 ) );
				float2 temp_output_7_0_g812 = ( ( temp_output_2_0_g809 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g812 = dot( temp_output_7_0_g812 , temp_output_7_0_g812 );
				float3 temp_cast_11 = (( 1.0 - pow( saturate( dotResult2_g812 ) , _IrisSelfShadowCircleHardness ) )).xxx;
				float2 temp_output_7_0_g811 = ( ( temp_output_62_0_g809 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g811 = dot( temp_output_7_0_g811 , temp_output_7_0_g811 );
				float3 Normal_Tangent336 = temp_output_600_0;
				float3 tanNormal26_g809 = Normal_Tangent336;
				float3 worldNormal26_g809 = float3(dot(tanToWorld0,tanNormal26_g809), dot(tanToWorld1,tanNormal26_g809), dot(tanToWorld2,tanNormal26_g809));
				float dotResult27_g809 = dot( SafeNormalize(_MainLightPosition.xyz) , worldNormal26_g809 );
				float smoothstepResult31_g809 = smoothstep( -0.31 , -0.02 , dotResult27_g809);
				float temp_output_2_0_g810 = ( _IrisShadowOpacity * ( 1.0 - pow( saturate( dotResult2_g811 ) , _IrisSelfShadowCircleHardness ) ) * saturate( smoothstepResult31_g809 ) );
				float temp_output_3_0_g810 = ( 1.0 - temp_output_2_0_g810 );
				float3 appendResult7_g810 = (float3(temp_output_3_0_g810 , temp_output_3_0_g810 , temp_output_3_0_g810));
				float IrisShadow190 = (( ( temp_cast_11 * temp_output_2_0_g810 ) + appendResult7_g810 )).x;
				float3 temp_output_492_0 = (( _IrisShadow )?( ( ( ( float4( localLightingFull2_g792 , 0.0 ) * Diffuse_boost168 * temp_output_597_0 ) + ( float4( bakedGI56 , 0.0 ) * GI128 * temp_output_597_0 ) ) * IrisShadow190 ).rgb ):( ( ( float4( localLightingFull2_g792 , 0.0 ) * Diffuse_boost168 * temp_output_597_0 ) + ( float4( bakedGI56 , 0.0 ) * GI128 * temp_output_597_0 ) ).rgb ));
				float3 WorldPos2_g808 = WorldPosition;
				float3 temp_output_6_0_g808 = ase_worldNormal;
				float3 Normal2_g808 = temp_output_6_0_g808;
				float r2_g808 = _DiffuseRoughness;
				float3 WorldView2_g808 = ase_worldViewDir;
				float2 texCoord7_g808 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g808 = texCoord7_g808;
				float2 texCoord9_g808 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g808 = ASEBakedGI( temp_output_6_0_g808, texCoord7_g808, true);
				float3 GI2_g808 = bakedGI8_g808;
				float LightClamp2_g808 = LightClamp579;
				float3 localLightingFull2_g808 = LightingFull2_g808( WorldPos2_g808 , Normal2_g808 , r2_g808 , WorldView2_g808 , lightmapUV2_g808 , GI2_g808 , LightClamp2_g808 );
				float3 bakedGI441 = ASEBakedGI( ase_worldNormal, texCoord57, true);
				float3 temp_cast_13 = (0.0).xxx;
				float2 texCoord8_g831 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g831 = texCoord8_g831;
				float2 temp_cast_14 = (0.5).xx;
				float4 tex2DNode2_g826 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g831 - temp_cast_14 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g831 )) );
				float3 temp_cast_15 = (tex2DNode2_g826.a).xxx;
				float3 lerpResult439 = lerp( temp_output_492_0 , ( ( localLightingFull2_g808 * Diffuse_boost168 ) + ( bakedGI441 * GI128 ) ) , (( _ScleraRing )?( temp_cast_15 ):( temp_cast_13 )));
				float4 temp_cast_17 = (( _SSS_DebugMode == 4.0 ? 0.0 : 1.0 )).xxxx;
				#ifdef _DEBUG_ON
				float4 staticSwitch586 = temp_cast_17;
				#else
				float4 staticSwitch586 = _Color;
				#endif
				float4 temp_output_34_0 = ( float4( (( _ScleraRing )?( lerpResult439 ):( temp_output_492_0 )) , 0.0 ) * staticSwitch586 );
				float2 texCoord15_g43 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g46 = ( texCoord15_g43 * _Tiling );
				float2 temp_cast_19 = (0.5).xx;
				float2 temp_output_12_0_g47 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g46 - temp_cast_19 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g46 ));
				float Depth17_g47 = _Depth;
				float3 viewDir17_g47 = ase_tanViewDir;
				float2 uv17_g47 = temp_output_12_0_g47;
				SamplerState ss17_g47 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g47 = MyCustomExpression17_g47( Depth17_g47 , viewDir17_g47 , uv17_g47 , ss17_g47 );
				float2 temp_output_4_0_g44 = (( _EnableParallax )?( localMyCustomExpression17_g47 ):( temp_output_12_0_g47 ));
				float2 inUV8_g44 = temp_output_4_0_g44;
				float2 temp_output_7_0_g45 = ( ( temp_output_4_0_g44 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g45 = dot( temp_output_7_0_g45 , temp_output_7_0_g45 );
				float ScaleMask8_g44 = ( 1.0 - pow( saturate( dotResult2_g45 ) , 0.15 ) );
				float Dilation8_g44 = _Dilation;
				float2 localDilationnotexture8_g44 = Dilationnotexture8_g44( inUV8_g44 , ScaleMask8_g44 , Dilation8_g44 );
				float2 temp_output_97_0_g42 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g44 : temp_output_4_0_g44 );
				float4 Subsurface_Map124 = SAMPLE_TEXTURE2D( _SubsurfaceMap, sampler_SubsurfaceMap, temp_output_97_0_g42 );
				float Subsurface126 = _Subsurface;
				float4 lerpResult32 = lerp( float4( 1,1,1,0 ) , Subsurface_Map124 , Subsurface126);
				float Travel_Distance117 = _Travel_Distance;
				float TravelDistance3_g880 = Travel_Distance117;
				float Travel_Distance_PointLights593 = ( _TravelDistancePointLights * _TravelDistanceMult );
				float TravelDistancePointLights3_g880 = Travel_Distance_PointLights593;
				float3 WorldPos3_g880 = WorldPosition;
				float3 ViewPos3_g880 = _WorldSpaceCameraPos;
				float3 experimental3_g880 = float3( 0,0,0 );
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float3 WorldNormal3_g880 = normalizedWorldNormal;
				float Cancel_Min108 = _CancelMin;
				float Cancel_Max109 = _CancelMax;
				float2 appendResult13_g880 = (float2(Cancel_Min108 , Cancel_Max109));
				float2 Cancel3_g880 = appendResult13_g880;
				float MaskWithNormals526 = _MaskWithNormals;
				float MaskWithNormals3_g880 = MaskWithNormals526;
				TEXTURE2D(TransmissionGradient3_g880) = _TransmissionGradient;
				SamplerState ssClamp3_g880 = sampler_Linear_Clamp;
				float2 appendResult27_g880 = (float2(_GradientMin , _GradientMax));
				float2 TSM_Grad3_g880 = appendResult27_g880;
				float Transmission_Bias119 = _Transmission_Bias;
				float2 uv_TransmissionMap = IN.ase_texcoord4.xy * _TransmissionMap_ST.xy + _TransmissionMap_ST.zw;
				float3 temp_cast_22 = (0.0).xxx;
				float2 texCoord8_g54 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g54 = texCoord8_g54;
				float2 temp_cast_23 = (0.5).xx;
				float4 tex2DNode2_g49 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g54 - temp_cast_23 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g54 )) );
				float3 temp_cast_24 = (tex2DNode2_g49.a).xxx;
				float3 temp_output_112_4_g42 = (( _ScleraRing )?( temp_cast_24 ):( temp_cast_22 ));
				float4 lerpResult99_g42 = lerp( SAMPLE_TEXTURE2D( _TransmissionMap, sampler_TransmissionMap, temp_output_97_0_g42 ) , SAMPLE_TEXTURE2D( _TransmissionMap, sampler_TransmissionMap, uv_TransmissionMap ) , float4( saturate( ( temp_output_112_4_g42 * temp_output_112_4_g42 * 2.0 ) ) , 0.0 ));
				float4 Transmission_Map121 = lerpResult99_g42;
				float4 TransmisionBiased81 = ( Transmission_Bias119 + Transmission_Map121 );
				float Thickness3_g880 = TransmisionBiased81.r;
				float Transmission_Intensity106 = _Transmission_intensity;
				float Intensity3_g880 = Transmission_Intensity106;
				float LightClamp3_g880 = LightClamp579;
				float localTransmission3_g880 = Transmission3_g880( TravelDistance3_g880 , TravelDistancePointLights3_g880 , WorldPos3_g880 , ViewPos3_g880 , experimental3_g880 , WorldNormal3_g880 , Cancel3_g880 , MaskWithNormals3_g880 , TransmissionGradient3_g880 , ssClamp3_g880 , TSM_Grad3_g880 , Thickness3_g880 , Intensity3_g880 , LightClamp3_g880 );
				float3 temp_output_603_11 = experimental3_g880;
				float4 Transmission_Color104 = ( _TransmissionColor * SAMPLE_TEXTURE2D( _TransmissionTintMap, sampler_TransmissionTintMap, temp_output_97_0_g42 ) );
				float4 experimental_shadow513 = ( float4( temp_output_603_11 , 0.0 ) * Transmission_Color104 );
				

				float3 BaseColor = temp_cast_0;
				float3 Emission = (( _Transmission )?( ( (( _EnableSubsurface )?( ( temp_output_34_0 * lerpResult32 ) ):( temp_output_34_0 )) + experimental_shadow513 ) ):( (( _EnableSubsurface )?( ( temp_output_34_0 * lerpResult32 ) ):( temp_output_34_0 )) )).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = BaseColor;
				metaInput.Emission = Emission;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = IN.VizUV.xy;
					metaInput.LightCoord = IN.LightCoord;
				#endif

				return UnityMetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#include "Common.hlsl"


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float3 temp_cast_0 = (0.0).xxx;
				

				float3 BaseColor = temp_cast_0;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				half4 color = half4(BaseColor, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormals" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_fragment _ _WRITE_RENDERING_LAYERS

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			#include "Common.hlsl"


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 worldNormal : TEXCOORD1;
				float4 worldTangent : TEXCOORD2;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD3;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD4;
				#endif
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);


			float2 MyCustomExpression17_g843( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g840( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				float3 ase_worldTangent = TransformObjectToWorldDir(v.tangentOS.xyz);
				float ase_vertexTangentSign = v.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord6.xyz = ase_worldBitangent;
				
				o.ase_texcoord5.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;
				o.ase_texcoord6.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;
				v.tangentOS = v.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				float3 normalWS = TransformObjectToWorldNormal( v.normalOS );
				float4 tangentWS = float4( TransformObjectToWorldDir( v.tangentOS.xyz ), v.tangentOS.w );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				o.worldNormal = normalWS;
				o.worldTangent = tangentWS;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag(	VertexOutput IN
						, out half4 outNormalWS : SV_Target0
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float3 WorldNormal = IN.worldNormal;
				float4 WorldTangent = IN.worldTangent;

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 texCoord15_g839 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g842 = ( texCoord15_g839 * _Tiling );
				float2 temp_cast_0 = (0.5).xx;
				float2 temp_output_12_0_g843 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g842 - temp_cast_0 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g842 ));
				float Depth17_g843 = _Depth;
				float3 ase_worldBitangent = IN.ase_texcoord6.xyz;
				float3 tanToWorld0 = float3( WorldTangent.xyz.x, ase_worldBitangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.xyz.y, ase_worldBitangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.xyz.z, ase_worldBitangent.z, WorldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g843 = ase_tanViewDir;
				float2 uv17_g843 = temp_output_12_0_g843;
				SamplerState ss17_g843 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g843 = MyCustomExpression17_g843( Depth17_g843 , viewDir17_g843 , uv17_g843 , ss17_g843 );
				float2 temp_output_4_0_g840 = (( _EnableParallax )?( localMyCustomExpression17_g843 ):( temp_output_12_0_g843 ));
				float2 inUV8_g840 = temp_output_4_0_g840;
				float2 temp_output_7_0_g841 = ( ( temp_output_4_0_g840 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g841 = dot( temp_output_7_0_g841 , temp_output_7_0_g841 );
				float ScaleMask8_g840 = ( 1.0 - pow( saturate( dotResult2_g841 ) , 0.15 ) );
				float Dilation8_g840 = _Dilation;
				float2 localDilationnotexture8_g840 = Dilationnotexture8_g840( inUV8_g840 , ScaleMask8_g840 , Dilation8_g840 );
				float2 temp_output_26_0_g832 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g840 : temp_output_4_0_g840 );
				float3 unpack1_g832 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g832 ), _NormalIntensity );
				unpack1_g832.z = lerp( 1, unpack1_g832.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g832 = normalize( unpack1_g832 );
				float3 unpack8_g832 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g832 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g832.z = lerp( 1, unpack8_g832.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g832 = BlendNormal( normalizeResult20_g832 , unpack8_g832 );
				#else
				float3 staticSwitch15_g832 = normalizeResult20_g832;
				#endif
				float3 temp_output_6_0_g833 = staticSwitch15_g832;
				float2 texCoord8_g838 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g838 = texCoord8_g838;
				float2 temp_cast_1 = (0.5).xx;
				float4 tex2DNode2_g833 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g838 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g838 )) );
				float3 lerpResult9_g833 = lerp( temp_output_6_0_g833 , float3( 0,0,1 ) , tex2DNode2_g833.a);
				

				float3 Normal = (( _ScleraRing )?( lerpResult9_g833 ):( temp_output_6_0_g833 ));
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(WorldNormal);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float crossSign = (WorldTangent.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
							float3 bitangent = crossSign * cross(WorldNormal.xyz, WorldTangent.xyz);
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent.xyz, bitangent, WorldNormal.xyz));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = WorldNormal;
					#endif
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#pragma shader_feature_local_fragment _SPECULAR_SETUP
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			
			
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
		
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _WRITE_RENDERING_LAYERS

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif
			
			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			#pragma shader_feature_local_fragment _DEBUG_ON
			#include "Common.hlsl"


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
				float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);
			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_Linear_Clamp);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float2 MyCustomExpression17_g843( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g840( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g857( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g854( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 ASEBakedGI( float3 normalWS, float2 uvStaticLightmap, bool applyScaling )
			{
			#ifdef LIGHTMAP_ON
				if( applyScaling )
					uvStaticLightmap = uvStaticLightmap * unity_LightmapST.xy + unity_LightmapST.zw;
				return SampleLightmap( uvStaticLightmap, normalWS );
			#else
				return SampleSH(normalWS);
			#endif
			}
			
			float3 LightingFull2_g792( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			float2 MyCustomExpression17_g824( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g821( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g817( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g814( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 LightingFull2_g808( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			float2 MyCustomExpression17_g47( float Depth, float3 viewDir, float2 uv, SamplerState ss )
			{
				float2  finalUV = 0;
				float3 dir = viewDir;
				    float2 maxOffset = dir.xy * (- Depth / (abs(dir.z) + 0.001));
					
				     float minSamples = 16.0;
				    float maxSamples = 128.0;
				    float samples = saturate(3.0 * length(maxOffset));
				    float incr = rcp(lerp(minSamples, maxSamples, samples));
				    half2 tc0 = uv;
				// float h0 = 1 - tex2Dlod(_BaseMap, float4(tc0, 0, 0)).a;
				 float h0 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc0, 0).a;
				for (float i = incr; i <= 1.0; i += incr)
				    {
				        half2 tc = tc0 + maxOffset * i;
				//float h1 = 1 - tex2Dlod(_BaseMap, float4(tc, 0, 0)).a;
				 float h1 = 1 - SAMPLE_TEXTURE2D_LOD( _BaseMap, ss, tc, 0).a;
				if (i >= h1)
				        {
							//hit! now interpolate
				            float r1 = i, r0 = i - incr;
				            float t = (h0 - r0) / ((h0 - r0) + (-h1 + r1));
				            float r = (r0 - t * r0) + t * r1;
				            finalUV = tc0 + r * maxOffset;
				            break;
				        }
				else
				        {
				            finalUV = tc0 + maxOffset;
				        }
				        h0 = h1;
				}
				return finalUV;
			}
			
			float2 Dilationnotexture8_g44( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float Transmission3_g880( float TravelDistance, float TravelDistancePointLights, float3 WorldPos, float3 ViewPos, out float3 experimental, float3 WorldNormal, float2 Cancel, float MaskWithNormals, TEXTURE2D(TransmissionGradient), SamplerState ssClamp, float2 TSM_Grad, float Thickness, float Intensity, float LightClamp )
			{
				experimental =1;
				return TranslucentShadowmap(TravelDistance, TravelDistancePointLights, WorldPos, ViewPos, WorldNormal, Cancel, MaskWithNormals, experimental, TransmissionGradient, ssClamp, TSM_Grad, Thickness, Intensity, LightClamp);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord8.xy = v.texcoord.xy;
				o.ase_texcoord8.zw = v.texcoord1.xy;
				o.ase_texcoord9.xy = v.texcoord2.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord9.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;
				v.tangentOS = v.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( v.normalOS, v.tangentOS );

				o.tSpace0 = float4( normalInput.normalWS, vertexInput.positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, vertexInput.positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, vertexInput.positionWS.z);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH(normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz);
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord.xy;
					o.lightmapUVOrVertexSH.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );

				o.fogFactorAndVertexLight = half4(0, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			FragmentOutput frag ( VertexOutput IN
								#ifdef ASE_DEPTH_WRITE_ON
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.positionCS);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#else
					ShadowCoords = float4(0, 0, 0, 0);
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float3 temp_cast_0 = (0.0).xxx;
				
				float2 texCoord15_g839 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g842 = ( texCoord15_g839 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g843 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g842 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g842 ));
				float Depth17_g843 = _Depth;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 ase_tanViewDir =  tanToWorld0 * WorldViewDirection.x + tanToWorld1 * WorldViewDirection.y  + tanToWorld2 * WorldViewDirection.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g843 = ase_tanViewDir;
				float2 uv17_g843 = temp_output_12_0_g843;
				SamplerState ss17_g843 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g843 = MyCustomExpression17_g843( Depth17_g843 , viewDir17_g843 , uv17_g843 , ss17_g843 );
				float2 temp_output_4_0_g840 = (( _EnableParallax )?( localMyCustomExpression17_g843 ):( temp_output_12_0_g843 ));
				float2 inUV8_g840 = temp_output_4_0_g840;
				float2 temp_output_7_0_g841 = ( ( temp_output_4_0_g840 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g841 = dot( temp_output_7_0_g841 , temp_output_7_0_g841 );
				float ScaleMask8_g840 = ( 1.0 - pow( saturate( dotResult2_g841 ) , 0.15 ) );
				float Dilation8_g840 = _Dilation;
				float2 localDilationnotexture8_g840 = Dilationnotexture8_g840( inUV8_g840 , ScaleMask8_g840 , Dilation8_g840 );
				float2 temp_output_26_0_g832 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g840 : temp_output_4_0_g840 );
				float3 unpack1_g832 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g832 ), _NormalIntensity );
				unpack1_g832.z = lerp( 1, unpack1_g832.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g832 = normalize( unpack1_g832 );
				float3 unpack8_g832 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g832 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g832.z = lerp( 1, unpack8_g832.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g832 = BlendNormal( normalizeResult20_g832 , unpack8_g832 );
				#else
				float3 staticSwitch15_g832 = normalizeResult20_g832;
				#endif
				float3 temp_output_6_0_g833 = staticSwitch15_g832;
				float2 texCoord8_g838 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g838 = texCoord8_g838;
				float2 temp_cast_2 = (0.5).xx;
				float4 tex2DNode2_g833 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g838 - temp_cast_2 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g838 )) );
				float3 lerpResult9_g833 = lerp( temp_output_6_0_g833 , float3( 0,0,1 ) , tex2DNode2_g833.a);
				
				float3 WorldPos2_g792 = WorldPosition;
				float2 texCoord15_g853 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g856 = ( texCoord15_g853 * _Tiling );
				float2 temp_cast_3 = (0.5).xx;
				float2 temp_output_12_0_g857 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g856 - temp_cast_3 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g856 ));
				float Depth17_g857 = _Depth;
				float3 viewDir17_g857 = ase_tanViewDir;
				float2 uv17_g857 = temp_output_12_0_g857;
				SamplerState ss17_g857 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g857 = MyCustomExpression17_g857( Depth17_g857 , viewDir17_g857 , uv17_g857 , ss17_g857 );
				float2 temp_output_4_0_g854 = (( _EnableParallax )?( localMyCustomExpression17_g857 ):( temp_output_12_0_g857 ));
				float2 inUV8_g854 = temp_output_4_0_g854;
				float2 temp_output_7_0_g855 = ( ( temp_output_4_0_g854 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g855 = dot( temp_output_7_0_g855 , temp_output_7_0_g855 );
				float ScaleMask8_g854 = ( 1.0 - pow( saturate( dotResult2_g855 ) , 0.15 ) );
				float Dilation8_g854 = _Dilation;
				float2 localDilationnotexture8_g854 = Dilationnotexture8_g854( inUV8_g854 , ScaleMask8_g854 , Dilation8_g854 );
				float2 temp_output_26_0_g846 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g854 : temp_output_4_0_g854 );
				float3 unpack1_g846 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g846 ), _NormalIntensity );
				unpack1_g846.z = lerp( 1, unpack1_g846.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g846 = normalize( unpack1_g846 );
				float3 unpack8_g846 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g846 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g846.z = lerp( 1, unpack8_g846.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g846 = BlendNormal( normalizeResult20_g846 , unpack8_g846 );
				#else
				float3 staticSwitch15_g846 = normalizeResult20_g846;
				#endif
				float3 temp_output_6_0_g847 = staticSwitch15_g846;
				float2 texCoord8_g852 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g852 = texCoord8_g852;
				float2 temp_cast_4 = (0.5).xx;
				float4 tex2DNode2_g847 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g852 - temp_cast_4 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g852 )) );
				float3 lerpResult9_g847 = lerp( temp_output_6_0_g847 , float3( 0,0,1 ) , tex2DNode2_g847.a);
				float3 temp_output_600_0 = (( _ScleraRing )?( lerpResult9_g847 ):( temp_output_6_0_g847 ));
				float3 tanNormal53 = temp_output_600_0;
				float3 worldNormal53 = float3(dot(tanToWorld0,tanNormal53), dot(tanToWorld1,tanNormal53), dot(tanToWorld2,tanNormal53));
				float3 temp_output_6_0_g792 = worldNormal53;
				float3 Normal2_g792 = temp_output_6_0_g792;
				float r2_g792 = _DiffuseRoughness;
				float3 WorldView2_g792 = WorldViewDirection;
				float2 texCoord7_g792 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g792 = texCoord7_g792;
				float2 texCoord9_g792 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g792 = ASEBakedGI( temp_output_6_0_g792, texCoord7_g792, true);
				float3 GI2_g792 = bakedGI8_g792;
				float LightClamp579 = _LightClamp;
				float LightClamp2_g792 = LightClamp579;
				float3 localLightingFull2_g792 = LightingFull2_g792( WorldPos2_g792 , Normal2_g792 , r2_g792 , WorldView2_g792 , lightmapUV2_g792 , GI2_g792 , LightClamp2_g792 );
				float Diffuse_boost168 = _Diffuseboost;
				float4 temp_cast_6 = (1.0).xxxx;
				float2 texCoord15_g820 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g823 = ( texCoord15_g820 * _Tiling );
				float2 temp_cast_7 = (0.5).xx;
				float2 temp_output_12_0_g824 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g823 - temp_cast_7 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g823 ));
				float Depth17_g824 = _Depth;
				float3 viewDir17_g824 = ase_tanViewDir;
				float2 uv17_g824 = temp_output_12_0_g824;
				SamplerState ss17_g824 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g824 = MyCustomExpression17_g824( Depth17_g824 , viewDir17_g824 , uv17_g824 , ss17_g824 );
				float2 temp_output_4_0_g821 = (( _EnableParallax )?( localMyCustomExpression17_g824 ):( temp_output_12_0_g824 ));
				float2 inUV8_g821 = temp_output_4_0_g821;
				float2 temp_output_7_0_g822 = ( ( temp_output_4_0_g821 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g822 = dot( temp_output_7_0_g822 , temp_output_7_0_g822 );
				float ScaleMask8_g821 = ( 1.0 - pow( saturate( dotResult2_g822 ) , 0.15 ) );
				float Dilation8_g821 = _Dilation;
				float2 localDilationnotexture8_g821 = Dilationnotexture8_g821( inUV8_g821 , ScaleMask8_g821 , Dilation8_g821 );
				float4 tex2DNode3_g819 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, ( 1.0 == _EyeDilation ? localDilationnotexture8_g821 : temp_output_4_0_g821 ) );
				float4 lerpResult26_g819 = lerp( _OcclusionColor , temp_cast_6 , tex2DNode3_g819.r);
				float4 lerpResult1_g819 = lerp( float4( 1,1,1,0 ) , lerpResult26_g819 , _Occlusionlightpass);
				float4 temp_output_597_0 = lerpResult1_g819;
				float2 texCoord57 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord58 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI56 = ASEBakedGI( worldNormal53, texCoord57, true);
				float GI128 = _GI;
				float2 texCoord15_g813 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g816 = ( texCoord15_g813 * _Tiling );
				float2 temp_cast_12 = (0.5).xx;
				float2 temp_output_12_0_g817 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g816 - temp_cast_12 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g816 ));
				float Depth17_g817 = _Depth;
				float3 viewDir17_g817 = ase_tanViewDir;
				float2 uv17_g817 = temp_output_12_0_g817;
				SamplerState ss17_g817 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g817 = MyCustomExpression17_g817( Depth17_g817 , viewDir17_g817 , uv17_g817 , ss17_g817 );
				float2 temp_output_4_0_g814 = (( _EnableParallax )?( localMyCustomExpression17_g817 ):( temp_output_12_0_g817 ));
				float2 inUV8_g814 = temp_output_4_0_g814;
				float2 temp_output_7_0_g815 = ( ( temp_output_4_0_g814 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g815 = dot( temp_output_7_0_g815 , temp_output_7_0_g815 );
				float ScaleMask8_g814 = ( 1.0 - pow( saturate( dotResult2_g815 ) , 0.15 ) );
				float Dilation8_g814 = _Dilation;
				float2 localDilationnotexture8_g814 = Dilationnotexture8_g814( inUV8_g814 , ScaleMask8_g814 , Dilation8_g814 );
				float2 temp_output_62_0_g809 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g814 : temp_output_4_0_g814 );
				float3x3 ase_worldToTangent = float3x3(WorldTangent,WorldBiTangent,WorldNormal);
				float3 worldToTangentDir6_g809 = normalize( mul( ase_worldToTangent, SafeNormalize(_MainLightPosition.xyz)) );
				float2 appendResult4_g809 = (float2(worldToTangentDir6_g809.x , worldToTangentDir6_g809.y));
				float Iris_Shadow_Distance196 = _IrisShadowDistance;
				float2 temp_output_2_0_g809 = ( temp_output_62_0_g809 + ( appendResult4_g809 * Iris_Shadow_Distance196 ) );
				float2 temp_output_7_0_g812 = ( ( temp_output_2_0_g809 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g812 = dot( temp_output_7_0_g812 , temp_output_7_0_g812 );
				float3 temp_cast_13 = (( 1.0 - pow( saturate( dotResult2_g812 ) , _IrisSelfShadowCircleHardness ) )).xxx;
				float2 temp_output_7_0_g811 = ( ( temp_output_62_0_g809 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g811 = dot( temp_output_7_0_g811 , temp_output_7_0_g811 );
				float3 Normal_Tangent336 = temp_output_600_0;
				float3 tanNormal26_g809 = Normal_Tangent336;
				float3 worldNormal26_g809 = float3(dot(tanToWorld0,tanNormal26_g809), dot(tanToWorld1,tanNormal26_g809), dot(tanToWorld2,tanNormal26_g809));
				float dotResult27_g809 = dot( SafeNormalize(_MainLightPosition.xyz) , worldNormal26_g809 );
				float smoothstepResult31_g809 = smoothstep( -0.31 , -0.02 , dotResult27_g809);
				float temp_output_2_0_g810 = ( _IrisShadowOpacity * ( 1.0 - pow( saturate( dotResult2_g811 ) , _IrisSelfShadowCircleHardness ) ) * saturate( smoothstepResult31_g809 ) );
				float temp_output_3_0_g810 = ( 1.0 - temp_output_2_0_g810 );
				float3 appendResult7_g810 = (float3(temp_output_3_0_g810 , temp_output_3_0_g810 , temp_output_3_0_g810));
				float IrisShadow190 = (( ( temp_cast_13 * temp_output_2_0_g810 ) + appendResult7_g810 )).x;
				float3 temp_output_492_0 = (( _IrisShadow )?( ( ( ( float4( localLightingFull2_g792 , 0.0 ) * Diffuse_boost168 * temp_output_597_0 ) + ( float4( bakedGI56 , 0.0 ) * GI128 * temp_output_597_0 ) ) * IrisShadow190 ).rgb ):( ( ( float4( localLightingFull2_g792 , 0.0 ) * Diffuse_boost168 * temp_output_597_0 ) + ( float4( bakedGI56 , 0.0 ) * GI128 * temp_output_597_0 ) ).rgb ));
				float3 WorldPos2_g808 = WorldPosition;
				float3 temp_output_6_0_g808 = WorldNormal;
				float3 Normal2_g808 = temp_output_6_0_g808;
				float r2_g808 = _DiffuseRoughness;
				float3 WorldView2_g808 = WorldViewDirection;
				float2 texCoord7_g808 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g808 = texCoord7_g808;
				float2 texCoord9_g808 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g808 = ASEBakedGI( temp_output_6_0_g808, texCoord7_g808, true);
				float3 GI2_g808 = bakedGI8_g808;
				float LightClamp2_g808 = LightClamp579;
				float3 localLightingFull2_g808 = LightingFull2_g808( WorldPos2_g808 , Normal2_g808 , r2_g808 , WorldView2_g808 , lightmapUV2_g808 , GI2_g808 , LightClamp2_g808 );
				float3 bakedGI441 = ASEBakedGI( WorldNormal, texCoord57, true);
				float3 temp_cast_15 = (0.0).xxx;
				float2 texCoord8_g831 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g831 = texCoord8_g831;
				float2 temp_cast_16 = (0.5).xx;
				float4 tex2DNode2_g826 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g831 - temp_cast_16 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g831 )) );
				float3 temp_cast_17 = (tex2DNode2_g826.a).xxx;
				float3 lerpResult439 = lerp( temp_output_492_0 , ( ( localLightingFull2_g808 * Diffuse_boost168 ) + ( bakedGI441 * GI128 ) ) , (( _ScleraRing )?( temp_cast_17 ):( temp_cast_15 )));
				float4 temp_cast_19 = (( _SSS_DebugMode == 4.0 ? 0.0 : 1.0 )).xxxx;
				#ifdef _DEBUG_ON
				float4 staticSwitch586 = temp_cast_19;
				#else
				float4 staticSwitch586 = _Color;
				#endif
				float4 temp_output_34_0 = ( float4( (( _ScleraRing )?( lerpResult439 ):( temp_output_492_0 )) , 0.0 ) * staticSwitch586 );
				float2 texCoord15_g43 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g46 = ( texCoord15_g43 * _Tiling );
				float2 temp_cast_21 = (0.5).xx;
				float2 temp_output_12_0_g47 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g46 - temp_cast_21 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g46 ));
				float Depth17_g47 = _Depth;
				float3 viewDir17_g47 = ase_tanViewDir;
				float2 uv17_g47 = temp_output_12_0_g47;
				SamplerState ss17_g47 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g47 = MyCustomExpression17_g47( Depth17_g47 , viewDir17_g47 , uv17_g47 , ss17_g47 );
				float2 temp_output_4_0_g44 = (( _EnableParallax )?( localMyCustomExpression17_g47 ):( temp_output_12_0_g47 ));
				float2 inUV8_g44 = temp_output_4_0_g44;
				float2 temp_output_7_0_g45 = ( ( temp_output_4_0_g44 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g45 = dot( temp_output_7_0_g45 , temp_output_7_0_g45 );
				float ScaleMask8_g44 = ( 1.0 - pow( saturate( dotResult2_g45 ) , 0.15 ) );
				float Dilation8_g44 = _Dilation;
				float2 localDilationnotexture8_g44 = Dilationnotexture8_g44( inUV8_g44 , ScaleMask8_g44 , Dilation8_g44 );
				float2 temp_output_97_0_g42 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g44 : temp_output_4_0_g44 );
				float4 Subsurface_Map124 = SAMPLE_TEXTURE2D( _SubsurfaceMap, sampler_SubsurfaceMap, temp_output_97_0_g42 );
				float Subsurface126 = _Subsurface;
				float4 lerpResult32 = lerp( float4( 1,1,1,0 ) , Subsurface_Map124 , Subsurface126);
				float Travel_Distance117 = _Travel_Distance;
				float TravelDistance3_g880 = Travel_Distance117;
				float Travel_Distance_PointLights593 = ( _TravelDistancePointLights * _TravelDistanceMult );
				float TravelDistancePointLights3_g880 = Travel_Distance_PointLights593;
				float3 WorldPos3_g880 = WorldPosition;
				float3 ViewPos3_g880 = _WorldSpaceCameraPos;
				float3 experimental3_g880 = float3( 0,0,0 );
				float3 normalizedWorldNormal = normalize( WorldNormal );
				float3 WorldNormal3_g880 = normalizedWorldNormal;
				float Cancel_Min108 = _CancelMin;
				float Cancel_Max109 = _CancelMax;
				float2 appendResult13_g880 = (float2(Cancel_Min108 , Cancel_Max109));
				float2 Cancel3_g880 = appendResult13_g880;
				float MaskWithNormals526 = _MaskWithNormals;
				float MaskWithNormals3_g880 = MaskWithNormals526;
				TEXTURE2D(TransmissionGradient3_g880) = _TransmissionGradient;
				SamplerState ssClamp3_g880 = sampler_Linear_Clamp;
				float2 appendResult27_g880 = (float2(_GradientMin , _GradientMax));
				float2 TSM_Grad3_g880 = appendResult27_g880;
				float Transmission_Bias119 = _Transmission_Bias;
				float2 uv_TransmissionMap = IN.ase_texcoord8.xy * _TransmissionMap_ST.xy + _TransmissionMap_ST.zw;
				float3 temp_cast_24 = (0.0).xxx;
				float2 texCoord8_g54 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g54 = texCoord8_g54;
				float2 temp_cast_25 = (0.5).xx;
				float4 tex2DNode2_g49 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g54 - temp_cast_25 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g54 )) );
				float3 temp_cast_26 = (tex2DNode2_g49.a).xxx;
				float3 temp_output_112_4_g42 = (( _ScleraRing )?( temp_cast_26 ):( temp_cast_24 ));
				float4 lerpResult99_g42 = lerp( SAMPLE_TEXTURE2D( _TransmissionMap, sampler_TransmissionMap, temp_output_97_0_g42 ) , SAMPLE_TEXTURE2D( _TransmissionMap, sampler_TransmissionMap, uv_TransmissionMap ) , float4( saturate( ( temp_output_112_4_g42 * temp_output_112_4_g42 * 2.0 ) ) , 0.0 ));
				float4 Transmission_Map121 = lerpResult99_g42;
				float4 TransmisionBiased81 = ( Transmission_Bias119 + Transmission_Map121 );
				float Thickness3_g880 = TransmisionBiased81.r;
				float Transmission_Intensity106 = _Transmission_intensity;
				float Intensity3_g880 = Transmission_Intensity106;
				float LightClamp3_g880 = LightClamp579;
				float localTransmission3_g880 = Transmission3_g880( TravelDistance3_g880 , TravelDistancePointLights3_g880 , WorldPos3_g880 , ViewPos3_g880 , experimental3_g880 , WorldNormal3_g880 , Cancel3_g880 , MaskWithNormals3_g880 , TransmissionGradient3_g880 , ssClamp3_g880 , TSM_Grad3_g880 , Thickness3_g880 , Intensity3_g880 , LightClamp3_g880 );
				float3 temp_output_603_11 = experimental3_g880;
				float4 Transmission_Color104 = ( _TransmissionColor * SAMPLE_TEXTURE2D( _TransmissionTintMap, sampler_TransmissionTintMap, temp_output_97_0_g42 ) );
				float4 experimental_shadow513 = ( float4( temp_output_603_11 , 0.0 ) * Transmission_Color104 );
				
				float3 temp_cast_31 = (0.0).xxx;
				

				float3 BaseColor = temp_cast_0;
				float3 Normal = (( _ScleraRing )?( lerpResult9_g833 ):( temp_output_6_0_g833 ));
				float3 Emission = (( _Transmission )?( ( (( _EnableSubsurface )?( ( temp_output_34_0 * lerpResult32 ) ):( temp_output_34_0 )) + experimental_shadow513 ) ):( (( _EnableSubsurface )?( ( temp_output_34_0 * lerpResult32 ) ):( temp_output_34_0 )) )).rgb;
				float3 Specular = temp_cast_31;
				float Metallic = 0;
				float Smoothness = 0.0;
				float Occlusion = 0.0;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.positionCS = IN.positionCS;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
						inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
						inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
						inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = WorldNormal;
				#endif

				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( WorldViewDirection );

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#else
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
					#else
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(IN.positionCS,
						BaseColor,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData
				(BaseColor, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
				color.rgb = GlobalIllumination(brdfData, inputData.bakedGI, Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb, Occlusion);
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SCENESELECTIONPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#include "Common.hlsl"


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				o.positionCS = TransformWorldToHClip(positionWS);

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				

				surfaceDescription.Alpha = 1;
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;

				#ifdef SCENESELECTIONPASS
					outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
					outColor = _SelectionID;
				#endif

				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 140009
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

		    #define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#include "Common.hlsl"


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ProfileColor;
			float4 _Color;
			float4 _OcclusionColor;
			float4 _TransmissionColor;
			float4 _TransmissionMap_ST;
			float _DilationMaskRadius;
			float _CancelMin;
			float _CancelMax;
			float _tsm_min;
			float _tsm_max;
			float _TranslucencyDistanceFade;
			float _Diffuseboost;
			float _IrisShadowDistance;
			float _Transmission_Bias;
			float _Transmission_intensity;
			float _GI;
			float _Travel_Distance;
			float _TravelDistanceMult;
			float _IrisShadowOpacity;
			float _ScleraRing;
			float _EnableParallax;
			float _EnableUVScale;
			float _Tiling;
			float _ScaleUV;
			float _IrisSelfShadowCircleRadius;
			float _IrisSelfShadowCircleHardness;
			float _TravelDistancePointLights;
			float _DilationMaskHardness;
			float _LightClamp;
			float _MaskWithNormals;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _Cavity;
			float _Occlusionfinalpass;
			float _IrisShadow;
			float _AlbedoOpacity;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _GradientMax;
			float _GradientMin;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _SSS_DebugMode;
			float _DetailNormalMapTile;
			float _DiffuseRoughness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_IrisShadowMap);
			SAMPLER(sampler_IrisShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_ProfileMap);
			SAMPLER(sampler_ProfileMap);
			TEXTURE2D(_SubsurfaceMap);
			SAMPLER(sampler_SubsurfaceMap);
			TEXTURE2D(_ttm);
			SAMPLER(sampler_ttm);
			TEXTURE2D(_TransmissionTintMap);
			SAMPLER(sampler_TransmissionTintMap);
			TEXTURE2D(_TransmissionMap);
			SAMPLER(sampler_TransmissionMap);


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );
				o.positionCS = TransformWorldToHClip(positionWS);

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				

				surfaceDescription.Alpha = 1;
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
						clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;

				#ifdef SCENESELECTIONPASS
					outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
					outColor = _SelectionID;
				#endif

				return outColor;
			}

			ENDHLSL
		}
		
	}
	
	CustomEditor "UnityEditor.ShaderGraphLitGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;203;-4163.03,-985.968;Inherit;False;1085.263;1904.925;Comment;22;551;108;526;109;510;168;113;112;196;199;124;121;132;119;117;106;104;128;126;552;579;593;Parameter receiver;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;194;-1635.416,-598.7903;Inherit;False;1286.405;442.2944;Comment;4;200;197;190;208;Iris Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;145;-6044.431,2576.974;Inherit;False;768.3589;238.9481;Comment;4;120;81;122;80;Map and Bias;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;144;194.9281,2318.933;Inherit;False;745.3881;531.8;Comment;4;130;134;133;135;Distance Fade;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;143;-1442.883,2495.364;Inherit;False;1319.483;451.8635;Comment;8;87;88;89;90;91;92;110;111;Normal Masking;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;141;-6453.277,1348.861;Inherit;False;4268.645;1157.403;Comment;16;513;557;556;532;67;118;534;533;517;114;527;516;115;562;565;581;ShadowMap;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;140;-378.3791,1402.406;Inherit;False;495.3759;254.8079;Comment;3;32;125;127;Subsurface;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;139;-2779.765,105.0475;Inherit;False;3987.701;971.2504;Comment;27;239;58;57;253;51;336;238;53;56;169;165;129;59;248;247;193;192;259;442;443;447;439;492;584;582;441;595;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;88;-1375.584,2711.863;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;89;-1072.859,2742.135;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;90;-813.3804,2621.045;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;91;-569.2717,2600.017;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;92;-301.3996,2629.54;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;134;264.9282,2368.933;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;133;254.9281,2737.933;Inherit;False;132;TranslucencyDistanceFade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;135;244.9281,2541.933;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;197;-1258.973,-251.6035;Inherit;False;196;Iris Shadow Distance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;190;-611.2953,-409.6985;Inherit;False;IrisShadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StickyNoteNode;259;-1446.482,302.8876;Inherit;False;150;100;?;;1,1,1,1;Direct light x AO? Maybe not but looks good$;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;-1271.598,-363.0444;Inherit;False;199;Iris Shadow Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;-1228.198,-456.3931;Inherit;False;336;Normal Tangent;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;192;-527.8354,314.4248;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;193;-764.077,369.9315;Inherit;False;190;IrisShadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;247;-1049.319,319.5487;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;248;-832.3186,200.5487;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1283.026,484.5266;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;-1286.892,329.3894;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;-1549.77,422.2404;Inherit;False;168;Diffuse boost;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;238;-1283.606,158.4766;Inherit;False;Constant;_Float0;Float 0;26;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;-2340.382,443.7373;Inherit;False;Normal Tangent;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;253;-2039.826,386.9637;Inherit;False;579;LightClamp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-2036.011,637.7642;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-2041.011,774.7644;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;1628.288,1255.421;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;1854.85,1378.167;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;250;2283.461,1599.365;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;249;2485.035,1473.271;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;228;3194.635,1226.038;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;229;3194.635,1226.038;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;Hidden/LightPass;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;2;Include;;False;;Native;False;0;0;;Include;Common.hlsl;False;;Custom;False;0;0;;;0;0;Standard;40;Workflow;0;638406054578331204;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;DOTS Instancing;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;0;Clear Coat;0;0;0;10;False;True;True;True;True;True;True;True;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;230;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;231;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;232;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;233;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;234;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormals;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;235;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;236;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;237;2298.032,1133.61;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.RangedFloatNode;245;2980.536,1174.911;Inherit;False;Constant;_Float1;Float 1;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;239;781.665,778.5034;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BakedGINode;56;-1742.691,525.0685;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;53;-2004.945,487.7279;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;442;-899.3706,681.003;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;51;-2037.346,237.1285;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;443;-892.4743,531.0075;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;445;-368.855,562.2956;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;446;-155.0447,702.7084;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;447;-378.4287,707.4952;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;439;15.4021,741.2669;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;449;-131.8682,857.1063;Inherit;False;Constant;_Float2;Float 2;33;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;317;2132.572,1313.427;Inherit;False;Property;_EnableSubsurface;_EnableSubsurface;69;0;Create;False;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;270;2696.292,1414.496;Inherit;False;Property;_Transmission;_Transmission;87;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;492;-284.1375,202.8125;Inherit;False;Toggle IrisShadow;71;;557;afa7f85a60ebca04d9d1d2e0e9ea550e;0;2;3;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;208;-1712.817,-548.7149;Inherit;True;Property;_IrisShadowMap;_IrisShadowMap;90;0;Create;True;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;497;318.136,636.4191;Inherit;False;Toggle ScleraRing;73;;571;27e2f89b0c601184794ffae46d74611a;0;2;3;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;110;-829.9456,2751.427;Inherit;False;108;Cancel Min;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;111;-826.9456,2834.427;Inherit;False;109;Cancel Max;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;87;-1392.883,2545.364;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;522;1772.843,1886.012;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;970.6354,1986.787;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;130;602.3162,2454.878;Inherit;False;float fade = 0@$float3 d = WorldPos - ViewPos.xyz@$fade = dot(d, d) / TranslucencyDistanceFade@$return saturate(1 - fade)@;1;Create;3;True;WorldPos;FLOAT3;0,0,0;In;;Inherit;False;True;ViewPos;FLOAT3;0,0,0;In;;Inherit;False;True;TranslucencyDistanceFade;FLOAT;0;In;;Inherit;False;Distance Fade;True;False;0;;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;521;1491.903,1763.42;Inherit;False;513;experimental shadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;30.03363,1848.322;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;32;-61.00368,1452.406;Inherit;False;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-320.406,1790.767;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;-310.2198,1544.414;Inherit;False;126;Subsurface;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;195.6756,1669.904;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;797.4684,1881.83;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-328.3794,1460.095;Inherit;False;124;Subsurface Map;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;318;453.7152,1717.218;Inherit;False;Property;_EnableSubsurface;_EnableSubsurface;61;0;Create;False;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-244.5381,1985.664;Inherit;False;106;Transmission Intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;70;-1240.364,1762.576;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-1071.971,1761.445;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NegateNode;72;-894.4969,1776.878;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ExpOpNode;73;-669.1808,1781.508;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;74;-522.5728,1781.508;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-545.8208,1855.837;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;76;-753.4229,1867.95;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;146;-599.4948,1970.358;Inherit;False;67;tsm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;82;-677.9909,2052.4;Inherit;False;81;TransmisionBiased;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-675.1498,2151.585;Inherit;False;104;Transmission Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;69;-1395.177,1823.838;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;68;-1598.423,1821.994;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-1807.213,1817.17;Inherit;False;67;tsm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-1586.165,1677.682;Inherit;False;104;Transmission Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;-3552,752;Inherit;False;Subsurface;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;128;-3536,608;Inherit;False;GI;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;-3584,-208;Inherit;False;Transmission Bias;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;132;-3568,-128;Inherit;False;TranslucencyDistanceFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;199;-3568,176;Inherit;False;Iris Shadow Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-3552,96;Inherit;False;Cancel Max;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;-3568,16;Inherit;False;Cancel Min;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;556;-5115.003,1554.827;Inherit;False;552;GradientMin;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;557;-5037.116,1641.279;Inherit;False;551;GradientMax;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;-5710.529,2624.779;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;-5975.636,2700.928;Inherit;False;121;Transmission Map;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;-5547.142,2634.901;Inherit;False;TransmisionBiased;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;-5979.414,2622.48;Inherit;False;119;Transmission Bias;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-5487.636,1733.357;Inherit;False;tsm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-6380.285,1648.193;Inherit;False;117;Travel Distance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;513;-4280.641,1790.473;Inherit;False;experimental shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;532;-4736.561,1786.199;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;562;-5458.792,1921.305;Inherit;False;return 1 - exp(-color * color)@;3;Create;1;True;color;FLOAT3;0,0,0;In;;Inherit;False;Transmission Color;True;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;510;-4014.921,614.4999;Inherit;True;Property;_BaseMap;BaseMap;70;1;[NoScaleOffset];Create;False;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-3553,678;Inherit;False;Subsurface Map;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;168;-3564,519;Inherit;False;Diffuse boost;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-3563,434;Inherit;False;tsm max;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;196;-3568,256;Inherit;False;Iris Shadow Distance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3569,347;Inherit;False;tsm min;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;534;-6381.943,1397.716;Inherit;False;106;Transmission Intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;581;-6350.071,1478.061;Inherit;False;579;LightClamp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;584;-817.5099,451.0165;Inherit;False;579;LightClamp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;582;-1681.263,280.7574;Inherit;False;DiffuseLighting;88;;792;12daf9e505d347e46b046875d4f485a5;0;2;10;FLOAT;100;False;6;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;35;455.322,1154.334;Inherit;False;Property;_Color;Color;174;0;Create;True;0;0;0;True;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;586;1012.089,1192.856;Inherit;False;Property;_Debug;Debug;112;0;Create;True;0;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;Fragment;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;588;789.8975,1309.878;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;4;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;589;465.8975,1332.878;Inherit;False;DebugMode;62;;793;3f30ed554b982864b9d7771a34ca3477;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-3569.23,-518.16;Inherit;False;Transmission Intensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;551;-3553.23,-758.16;Inherit;False;GradientMax;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;526;-3553.23,-694.16;Inherit;False;MaskWithNormals;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;552;-3569.23,-854.16;Inherit;False;GradientMin;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;579;-3568.865,-943.2578;Inherit;False;LightClamp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;117;-3569.23,-438.16;Inherit;False;Travel Distance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;593;-3579.321,-313.1682;Inherit;False;Travel Distance PointLights;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-6365.302,2332.686;Inherit;False;113;tsm max;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;516;-6364.191,2048.472;Inherit;False;108;Cancel Min;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;527;-6373.569,2430.389;Inherit;False;526;MaskWithNormals;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;-6365.302,2257.686;Inherit;False;112;tsm min;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;517;-6365.191,2143.472;Inherit;False;109;Cancel Max;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;594;-6413.647,1768.378;Inherit;False;593;Travel Distance PointLights;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;583;-598.7844,529.6966;Inherit;False;DiffuseLighting;88;;808;12daf9e505d347e46b046875d4f485a5;0;2;10;FLOAT;100;False;6;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;-1517.187,595.1274;Inherit;False;128;GI;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BakedGINode;441;-628.6891,637.9008;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StickyNoteNode;595;-700.5703,784.0519;Inherit;False;139;115;Cookies;;1,0.05094332,0.05094332,1;GI is not being attenuatted by cookies. Unity's Lit neither;0;0
Node;AmplifyShaderEditor.FunctionNode;596;-962.7,-421.2604;Inherit;False;FakeShadow;91;;809;3932d1024f7e418439d796f08d8f40e9;0;5;30;FLOAT3;0,0,1;False;23;FLOAT;0;False;20;SAMPLER2D;0;False;19;FLOAT;1;False;18;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;597;-1583.63,685.9344;Inherit;False;Occlusion;149;;819;fda21753bf015b5409b48b776edf6d06;0;0;4;COLOR;0;COLOR;17;FLOAT;5;FLOAT;12
Node;AmplifyShaderEditor.FunctionNode;598;-502.7002,875.577;Inherit;False;ScleraRing;75;;826;645f15d53ddd4014b823049efc7d008e;0;2;11;FLOAT3;1,0,0;False;6;FLOAT3;0,0,0;False;3;FLOAT3;0;FLOAT3;7;FLOAT3;4
Node;AmplifyShaderEditor.FunctionNode;599;2853.668,1313.362;Inherit;False;Normals;113;;832;edf7abb8f1e0054499f2cbbdfb87b80b;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;600;-2659.784,444.9215;Inherit;False;Normals;113;;846;edf7abb8f1e0054499f2cbbdfb87b80b;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;104;-3562.23,-605.16;Inherit;False;Transmission Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-3570,-55;Inherit;False;Transmission Map;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;565;-6395.599,1563.201;Inherit;False;81;TransmisionBiased;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;533;-5098.077,1880.384;Inherit;False;104;Transmission Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;603;-5839.758,1791.286;Inherit;False;TranslucentShadowMap;64;;880;45f4f7ecf74ed814b8fd79e58f762032;0;10;29;FLOAT;1;False;31;FLOAT;100;False;28;FLOAT;1;False;6;FLOAT;0.1;False;32;FLOAT;0.1;False;14;FLOAT;0;False;15;FLOAT;1;False;7;FLOAT;0;False;8;FLOAT;1;False;21;FLOAT;0;False;2;FLOAT;0;FLOAT3;11
Node;AmplifyShaderEditor.FunctionNode;607;-4040.475,-106.7868;Inherit;False;SharedParameters;0;;42;491c93288bd7b9949815d77536da7577;0;0;25;FLOAT;124;FLOAT;119;FLOAT;120;FLOAT;114;COLOR;24;FLOAT;35;FLOAT;127;FLOAT;36;FLOAT;37;FLOAT;44;COLOR;0;FLOAT;38;FLOAT;39;FLOAT;40;FLOAT;76;FLOAT;74;FLOAT;41;FLOAT;42;FLOAT;72;FLOAT;27;COLOR;29;FLOAT;30;COLOR;32;FLOAT;33;COLOR;34
WireConnection;89;0;88;0
WireConnection;90;0;87;0
WireConnection;90;1;89;0
WireConnection;91;0;90;0
WireConnection;91;1;110;0
WireConnection;91;2;111;0
WireConnection;92;0;91;0
WireConnection;190;0;596;0
WireConnection;192;0;248;0
WireConnection;192;1;193;0
WireConnection;247;0;165;0
WireConnection;247;1;59;0
WireConnection;248;0;247;0
WireConnection;59;0;56;0
WireConnection;59;1;129;0
WireConnection;59;2;597;0
WireConnection;165;0;582;0
WireConnection;165;1;169;0
WireConnection;165;2;597;0
WireConnection;336;0;600;0
WireConnection;34;0;239;0
WireConnection;34;1;586;0
WireConnection;224;0;34;0
WireConnection;224;1;32;0
WireConnection;250;0;521;0
WireConnection;249;0;317;0
WireConnection;249;1;250;0
WireConnection;229;0;245;0
WireConnection;229;1;599;0
WireConnection;229;2;270;0
WireConnection;229;9;245;0
WireConnection;229;4;245;0
WireConnection;229;5;245;0
WireConnection;239;0;497;0
WireConnection;56;0;51;0
WireConnection;56;1;53;0
WireConnection;56;2;57;0
WireConnection;56;3;58;0
WireConnection;53;0;600;0
WireConnection;445;0;583;0
WireConnection;445;1;169;0
WireConnection;446;0;445;0
WireConnection;446;1;447;0
WireConnection;447;0;441;0
WireConnection;447;1;129;0
WireConnection;439;0;492;0
WireConnection;439;1;446;0
WireConnection;439;2;598;4
WireConnection;317;0;34;0
WireConnection;317;1;224;0
WireConnection;270;0;317;0
WireConnection;270;1;249;0
WireConnection;492;3;248;0
WireConnection;492;2;192;0
WireConnection;497;3;492;0
WireConnection;497;2;439;0
WireConnection;522;0;521;0
WireConnection;522;1;32;0
WireConnection;95;1;130;0
WireConnection;130;0;134;0
WireConnection;130;1;135;0
WireConnection;130;2;133;0
WireConnection;85;0;75;0
WireConnection;85;1;107;0
WireConnection;32;1;125;0
WireConnection;32;2;127;0
WireConnection;75;0;74;0
WireConnection;75;1;78;0
WireConnection;75;2;146;0
WireConnection;75;3;82;0
WireConnection;75;4;147;0
WireConnection;221;0;32;0
WireConnection;221;1;85;0
WireConnection;86;0;318;0
WireConnection;86;1;92;0
WireConnection;318;0;85;0
WireConnection;318;1;221;0
WireConnection;70;0;105;0
WireConnection;70;1;69;0
WireConnection;71;0;70;0
WireConnection;71;1;70;0
WireConnection;72;0;71;0
WireConnection;73;0;72;0
WireConnection;74;0;73;0
WireConnection;78;0;76;1
WireConnection;78;1;76;2
WireConnection;69;0;68;0
WireConnection;68;0;66;0
WireConnection;126;0;607;30
WireConnection;128;0;607;27
WireConnection;119;0;607;37
WireConnection;132;0;607;44
WireConnection;199;0;607;76
WireConnection;109;0;607;39
WireConnection;108;0;607;38
WireConnection;80;0;120;0
WireConnection;80;1;122;0
WireConnection;81;0;80;0
WireConnection;67;0;603;0
WireConnection;513;0;532;0
WireConnection;532;0;603;11
WireConnection;532;1;533;0
WireConnection;562;0;603;11
WireConnection;124;0;607;29
WireConnection;168;0;607;72
WireConnection;113;0;607;42
WireConnection;196;0;607;74
WireConnection;112;0;607;41
WireConnection;582;10;253;0
WireConnection;582;6;53;0
WireConnection;586;1;35;0
WireConnection;586;0;588;0
WireConnection;588;0;589;0
WireConnection;106;0;607;35
WireConnection;551;0;607;120
WireConnection;526;0;607;114
WireConnection;552;0;607;119
WireConnection;579;0;607;124
WireConnection;117;0;607;36
WireConnection;593;0;607;127
WireConnection;583;10;584;0
WireConnection;583;6;442;0
WireConnection;441;0;443;0
WireConnection;441;1;442;0
WireConnection;441;2;57;0
WireConnection;441;3;58;0
WireConnection;596;30;337;0
WireConnection;596;18;197;0
WireConnection;104;0;607;24
WireConnection;121;0;607;0
WireConnection;603;29;534;0
WireConnection;603;31;581;0
WireConnection;603;28;565;0
WireConnection;603;6;118;0
WireConnection;603;32;594;0
WireConnection;603;14;516;0
WireConnection;603;15;517;0
WireConnection;603;7;114;0
WireConnection;603;8;115;0
WireConnection;603;21;527;0
ASEEND*/
//CHKSM=5BAB00121A1DC0B963E8E40DFAA3B3941E507DC0