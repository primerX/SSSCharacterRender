// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SSS Object"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		_DiffuseRoughness("DiffuseRoughness", Range( 0 , 1)) = 0
		[Enum(Light Pass,0,Blur Pass,1,Specular Highlight,2,Environment Reflections,3,Transmission,4,Lightmap,5,Reflection probe capture,6)]_SSS_DebugMode("SSS_DebugMode", Range( 1 , 7)) = 1
		[SingleLineTexture]_TransmissionGradient("TransmissionGradient", 2D) = "white" {}
		[Toggle]_IrisShadow("Iris Shadow", Float) = 0
		[Toggle]_ScleraRing("Sclera Ring", Float) = 0
		_FresnelIntensity("FresnelIntensity", Range( 0 , 1)) = 0.55
		_ttm("ttm", 2D) = "white" {}
		_Dilation("Dilation", Range( 0 , 10)) = 0
		_DilationMaskRadius("DilationMaskRadius", Range( 0.01 , 0.2)) = 0.189
		_DilationMaskHardness("DilationMaskHardness", Range( 0.01 , 2)) = 0.4020753
		[Toggle]_EyeDilation("_EyeDilation", Float) = 0
		_Depth("Depth", Range( 0 , 1)) = 0
		_Depth_Center("Depth Center", Range( -1 , 1)) = 0
		[NoScaleOffset]_BaseMap("Albedo", 2D) = "white" {}
		_IrisSelfShadowCircleRadius("IrisSelfShadowCircleRadius", Range( 0 , 1)) = 0.3586957
		_IrisShadowOpacity("IrisShadowOpacity", Range( 0 , 1)) = 0.3586957
		_IrisSelfShadowCircleHardness("IrisSelfShadowCircleHardness", Range( 0 , 10)) = 10
		[IntRange]_StencilValue("StencilValue", Range( 0 , 2)) = 1
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
		[Toggle(_DEBUG_ON)] _Debug("Debug", Float) = 0
		_EnvironmentReflectionsIntensity("EnvironmentReflectionsIntensity", Range( 0 , 3)) = 1
		_SpecularHighlightIntensity("SpecularHighlightIntensity", Range( 0 , 20)) = 1
		_SSS_WorkflowMode("WorkflowMode", Float) = 0
		_CorneaDepth("Depth", Range( 0 , 0.5)) = 0
		_Tiling("Tiling", Float) = 1
		_ScaleUV("Scale", Range( 0 , 2)) = 1
		[Toggle]_EnableUVScale("EnableUVScale", Float) = 0
		[Toggle]_EnableParallax("_EnableParallax", Float) = 0
		_CorneaSizeMin("Size min", Range( 0.9 , 1)) = 1
		_CorneaMaskMin("Mask min", Range( 0.9 , 1)) = 0.9592496
		_CorneaSizeMax("Size max", Range( 0 , 1)) = 1
		_CorneaMaskMax("Mask max", Range( 0 , 1)) = 1
		_CorneaOpacity("Opacity", Range( 0 , 1)) = 0.1413043
		[Toggle]_PrepareforGIbake("Prepare for GI bake", Float) = 0
		_Color("Color", Color) = (1,1,1,0)
		[NoScaleOffset][SingleLineTexture]_OverlayAlbedo("Overlay Albedo", 2D) = "white" {}
		_AlbedoInfluence("AlbedoInfluence", Range( 0 , 1)) = 1
		_IrisDetailShadowMap("Detail Shadow Map", 2D) = "white" {}
		[Toggle(_CORNEATURBIDITY_ON)] _CorneaTurbidity("Cornea Turbidity", Float) = 0
		_MicroShadowsOpacity("Micro Shadows Opacity", Range( 0 , 1)) = 1
		[NoScaleOffset]_SpecGlossMap("Specular Map", 2D) = "white" {}
		[SingleLineTexture]_OverlaySpecular("OverlaySpecular", 2D) = "white" {}
		_SpecColor("Specular Color", Color) = (0.08490568,0.08490568,0.08490568,1)
		_OverlaySpecularColor("Overlay Specular Color", Color) = (1,1,1,1)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.65
		_OverlaySmoothness("Overlay Smoothness", Range( 0 , 1)) = 1
		[Toggle(_OVERLAY_ON)] _Overlay("Overlay", Float) = 0
		[Enum(x1,1,x2,2,x4,4,x8,8,x16,16)]_SmoothnessMult("Multiplier", Range( 1 , 6)) = 1
		[NoScaleOffset]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionColor("Occlusion Color", Color) = (0,0,0,0)
		[Toggle]_Cavity("_Cavity", Range( 0 , 1)) = 1
		_CavityStrength("Cavity", Range( 0 , 1)) = 0
		_Occlusionfinalpass("Occlusion final pass", Range( 0 , 1)) = 0.5
		_Occlusionlightpass("Occlusion light pass", Range( 0 , 1)) = 0.5
		_SpecularOcclusion("Specular Occlusion", Range( 0 , 1)) = 1
		[Toggle(_ENABLE_DETAIL_NORMAL)] _EnableDetailNormal("Enable Detail Normal", Float) = 0
		_ScleraRingMap("Sclera Ring Map", 2D) = "white" {}
		_AlbedoOpacity("AlbedoInfluence", Range( 0 , 1)) = 1
		[NoScaleOffset][Normal]_BumpMap("Normal", 2D) = "bump" {}
		_NormalIntensity("Normal Intensity", Range( 0 , 1)) = 1
		[NoScaleOffset][Normal]_DetailNormalMap("Detail Normal Map", 2D) = "bump" {}
		_DetailNormalIntensity("Detail Normal Intensity", Range( 0 , 1)) = 1
		_DetailNormalMapTile("Tile", Float) = 10


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

		Stencil
		{
			Ref 0
		}

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
			Tags {  }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			Stencil
			{
				Ref [_StencilValue]
				Comp Always
				Pass Replace
			}

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
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _OVERLAY_ON
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			#pragma shader_feature_local_fragment _DEBUG_ON
			#pragma shader_feature_local _CORNEATURBIDITY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);
			TEXTURE2D(_SSS_Blur);
			SAMPLER(sampler_Trilinear_Clamp);
			TEXTURE2D(_OverlaySpecular);
			TEXTURE2D(_SSS_LightPass);


			float2 MyCustomExpression17_g1382( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1379( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g1281( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1278( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			inline float4 ASE_ComputeGrabScreenPos( float4 pos )
			{
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				float4 o = pos;
				o.y = pos.w * 0.5f;
				o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
				return o;
			}
			
			float2 MyCustomExpression17_g1375( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1372( float2 inUV, float ScaleMask, float Dilation )
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
			
			float3 LightingFull2_g1361( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			inline float2 ParallaxOffset( half h, half height, half3 viewDir )
			{
				h = h * height - height/2.0;
				float3 v = normalize( viewDir );
				v.z += 0.42;
				return h* (v.xy / v.z);
			}
			
			float2 MyCustomExpression17_g1268( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1265( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g1321( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1318( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 GlossyEnvironmentReflection21_g1251( float3 reflectVector, float3 positionWS, float perceptualRoughness, float3 occlusion, float2 normalizedScreenSpaceUV )
			{
				return GlossyEnvironmentReflectionFix(reflectVector,
				 positionWS, perceptualRoughness, occlusion, normalizedScreenSpaceUV);
			}
			
			float Surfacereduction42_g1251( float roughness )
			{
				float r2 = max(roughness * roughness, HALF_MIN);
				 float surfaceReduction = 1.0 / (r2 + 1.0);
				return surfaceReduction;
			}
			
			float2 MyCustomExpression17_g1261( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1258( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 Fresnel7_g1252( float4 Specular, float NdotV, float _FresnelIntensity, float Cavity )
			{
				half3 oneMinusReflectivity = 1 - Specular.rgb;
				half3 grazingTerm = saturate(Specular.a + (1 - oneMinusReflectivity));
				return FresnelLerp(Specular.rgb * Cavity, grazingTerm, lerp(1.0, NdotV, _FresnelIntensity));
			}
			
			float3 SpecularLightingFull708( float3 WorldPos, float3 Normal, float3 SpecColor, float Smoothness, float3 WorldView, float2 lightmapUV )
			{
				return SpecularLightingFull(WorldPos, Normal, 
				SpecColor, Smoothness, WorldView, lightmapUV);
			}
			
			float3 LightingFull2_g1384( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
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

				float4 temp_cast_0 = (0.0).xxxx;
				float2 texCoord15_g1378 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1381 = ( texCoord15_g1378 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g1382 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1381 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1381 ));
				float Depth17_g1382 = _Depth;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 ase_tanViewDir =  tanToWorld0 * WorldViewDirection.x + tanToWorld1 * WorldViewDirection.y  + tanToWorld2 * WorldViewDirection.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g1382 = ase_tanViewDir;
				float2 uv17_g1382 = temp_output_12_0_g1382;
				SamplerState ss17_g1382 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1382 = MyCustomExpression17_g1382( Depth17_g1382 , viewDir17_g1382 , uv17_g1382 , ss17_g1382 );
				float2 temp_output_4_0_g1379 = (( _EnableParallax )?( localMyCustomExpression17_g1382 ):( temp_output_12_0_g1382 ));
				float2 inUV8_g1379 = temp_output_4_0_g1379;
				float2 temp_output_7_0_g1380 = ( ( temp_output_4_0_g1379 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1380 = dot( temp_output_7_0_g1380 , temp_output_7_0_g1380 );
				float ScaleMask8_g1379 = ( 1.0 - pow( saturate( dotResult2_g1380 ) , 0.15 ) );
				float Dilation8_g1379 = _Dilation;
				float2 localDilationnotexture8_g1379 = Dilationnotexture8_g1379( inUV8_g1379 , ScaleMask8_g1379 , Dilation8_g1379 );
				float4 temp_output_9_0_g1359 = ( _Color * SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1379 : temp_output_4_0_g1379 ) ) );
				float4 Albedo112 = (( _PrepareforGIbake )?( temp_output_9_0_g1359 ):( temp_cast_0 ));
				
				float2 texCoord15_g1277 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1280 = ( texCoord15_g1277 * _Tiling );
				float2 temp_cast_3 = (0.5).xx;
				float2 temp_output_12_0_g1281 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1280 - temp_cast_3 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1280 ));
				float Depth17_g1281 = _Depth;
				float3 viewDir17_g1281 = ase_tanViewDir;
				float2 uv17_g1281 = temp_output_12_0_g1281;
				SamplerState ss17_g1281 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1281 = MyCustomExpression17_g1281( Depth17_g1281 , viewDir17_g1281 , uv17_g1281 , ss17_g1281 );
				float2 temp_output_4_0_g1278 = (( _EnableParallax )?( localMyCustomExpression17_g1281 ):( temp_output_12_0_g1281 ));
				float2 inUV8_g1278 = temp_output_4_0_g1278;
				float2 temp_output_7_0_g1279 = ( ( temp_output_4_0_g1278 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1279 = dot( temp_output_7_0_g1279 , temp_output_7_0_g1279 );
				float ScaleMask8_g1278 = ( 1.0 - pow( saturate( dotResult2_g1279 ) , 0.15 ) );
				float Dilation8_g1278 = _Dilation;
				float2 localDilationnotexture8_g1278 = Dilationnotexture8_g1278( inUV8_g1278 , ScaleMask8_g1278 , Dilation8_g1278 );
				float2 temp_output_26_0_g1270 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1278 : temp_output_4_0_g1278 );
				float3 unpack1_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g1270 ), _NormalIntensity );
				unpack1_g1270.z = lerp( 1, unpack1_g1270.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g1270 = normalize( unpack1_g1270 );
				float3 unpack8_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g1270 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g1270.z = lerp( 1, unpack8_g1270.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g1270 = BlendNormal( normalizeResult20_g1270 , unpack8_g1270 );
				#else
				float3 staticSwitch15_g1270 = normalizeResult20_g1270;
				#endif
				float3 temp_output_6_0_g1271 = staticSwitch15_g1270;
				float2 texCoord8_g1276 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1276 = texCoord8_g1276;
				float2 temp_cast_4 = (0.5).xx;
				float4 tex2DNode2_g1271 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1276 - temp_cast_4 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1276 )) );
				float3 lerpResult9_g1271 = lerp( temp_output_6_0_g1271 , float3( 0,0,1 ) , tex2DNode2_g1271.a);
				float3 Normal83 = (( _ScleraRing )?( lerpResult9_g1271 ):( temp_output_6_0_g1271 ));
				
				float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ScreenPos );
				float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
				float4 tex2DNode1_g1359 = SAMPLE_TEXTURE2D( _SSS_Blur, sampler_Trilinear_Clamp, ase_grabScreenPosNorm.xy );
				float4 temp_cast_6 = (1.0).xxxx;
				float2 texCoord866 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1374 = ( texCoord866 * _Tiling );
				float2 temp_cast_7 = (0.5).xx;
				float2 temp_output_12_0_g1375 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1374 - temp_cast_7 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1374 ));
				float Depth17_g1375 = _Depth;
				float3 viewDir17_g1375 = ase_tanViewDir;
				float2 uv17_g1375 = temp_output_12_0_g1375;
				SamplerState ss17_g1375 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1375 = MyCustomExpression17_g1375( Depth17_g1375 , viewDir17_g1375 , uv17_g1375 , ss17_g1375 );
				float2 temp_output_4_0_g1372 = (( _EnableParallax )?( localMyCustomExpression17_g1375 ):( temp_output_12_0_g1375 ));
				float2 inUV8_g1372 = temp_output_4_0_g1372;
				float2 temp_output_7_0_g1373 = ( ( temp_output_4_0_g1372 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1373 = dot( temp_output_7_0_g1373 , temp_output_7_0_g1373 );
				float ScaleMask8_g1372 = ( 1.0 - pow( saturate( dotResult2_g1373 ) , 0.15 ) );
				float Dilation8_g1372 = _Dilation;
				float2 localDilationnotexture8_g1372 = Dilationnotexture8_g1372( inUV8_g1372 , ScaleMask8_g1372 , Dilation8_g1372 );
				float2 temp_output_161_0_g1359 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1372 : temp_output_4_0_g1372 );
				float4 tex2DNode7_g1359 = SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, temp_output_161_0_g1359 );
				float4 lerpResult127_g1359 = lerp( temp_cast_6 , tex2DNode7_g1359 , _AlbedoInfluence);
				float2 Final_UVs111_g1359 = temp_output_161_0_g1359;
				float4 tex2DNode168_g1359 = SAMPLE_TEXTURE2D( _OverlayAlbedo, sampler_Trilinear_Repeat_Aniso8, Final_UVs111_g1359 );
				float4 lerpResult169_g1359 = lerp( tex2DNode7_g1359 , tex2DNode168_g1359 , tex2DNode168_g1359.a);
				#ifdef _OVERLAY_ON
				float4 staticSwitch167_g1359 = lerpResult169_g1359;
				#else
				float4 staticSwitch167_g1359 = lerpResult127_g1359;
				#endif
				float3 WorldPos2_g1361 = WorldPosition;
				float3 temp_output_6_0_g1361 = WorldNormal;
				float3 Normal2_g1361 = temp_output_6_0_g1361;
				float r2_g1361 = _DiffuseRoughness;
				float3 WorldView2_g1361 = WorldViewDirection;
				float2 texCoord7_g1361 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g1361 = texCoord7_g1361;
				float2 texCoord9_g1361 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g1361 = ASEBakedGI( temp_output_6_0_g1361, texCoord7_g1361, true);
				float3 GI2_g1361 = bakedGI8_g1361;
				float LightClamp2_g1361 = 100.0;
				float3 localLightingFull2_g1361 = LightingFull2_g1361( WorldPos2_g1361 , Normal2_g1361 , r2_g1361 , WorldView2_g1361 , lightmapUV2_g1361 , GI2_g1361 , LightClamp2_g1361 );
				float3 bakedGI70_g1359 = ASEBakedGI( WorldNormal, float2( 0,0 ), true);
				float2 texCoord41_g1359 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_39_0_g1359 = ( texCoord41_g1359 + -0.5 );
				float dotResult40_g1359 = dot( temp_output_39_0_g1359 , temp_output_39_0_g1359 );
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 paralaxOffset35_g1359 = ParallaxOffset( dotResult40_g1359 , _CorneaDepth , ase_tanViewDir );
				float2 texCoord38_g1359 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_44_0_g1359 = ( ( paralaxOffset35_g1359 + texCoord38_g1359 ) + -0.5 );
				float dotResult43_g1359 = dot( temp_output_44_0_g1359 , temp_output_44_0_g1359 );
				float smoothstepResult47_g1359 = smoothstep( _CorneaSizeMin , 1.0 , ( 1.0 - dotResult43_g1359 ));
				float2 temp_output_51_0_g1359 = ( Final_UVs111_g1359 + -0.5 );
				float dotResult52_g1359 = dot( temp_output_51_0_g1359 , temp_output_51_0_g1359 );
				float smoothstepResult48_g1359 = smoothstep( _CorneaMaskMin , 1.0 , ( 1.0 - dotResult52_g1359 ));
				float Cornea_Turbidity63_g1359 = ( smoothstepResult47_g1359 * _CorneaOpacity * smoothstepResult48_g1359 );
				float4 lerpResult65_g1359 = lerp( ( tex2DNode1_g1359 * staticSwitch167_g1359 ) , float4( ( localLightingFull2_g1361 + bakedGI70_g1359 ) , 0.0 ) , Cornea_Turbidity63_g1359);
				#ifdef _CORNEATURBIDITY_ON
				float4 staticSwitch64_g1359 = lerpResult65_g1359;
				#else
				float4 staticSwitch64_g1359 = ( tex2DNode1_g1359 * staticSwitch167_g1359 );
				#endif
				float3 temp_output_6_0_g1362 = staticSwitch64_g1359.rgb;
				float4 temp_cast_10 = (1.0).xxxx;
				float4 Blurred_lighting119_g1359 = tex2DNode1_g1359;
				float2 texCoord8_g1367 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1367 = texCoord8_g1367;
				float2 temp_cast_14 = (0.5).xx;
				float4 tex2DNode2_g1362 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1367 - temp_cast_14 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1367 )) );
				float4 lerpResult1_g1362 = lerp( float4( temp_output_6_0_g1362 , 0.0 ) , ( float4( Blurred_lighting119_g1359.rgb , 0.0 ) * tex2DNode2_g1362 ) , tex2DNode2_g1362.a);
				float4 lerpResult13_g1362 = lerp( temp_cast_10 , lerpResult1_g1362 , _AlbedoOpacity);
				float3 Diffuse110 = (( _ScleraRing )?( lerpResult13_g1362.rgb ):( temp_output_6_0_g1362 ));
				float4 temp_cast_17 = (1.0).xxxx;
				float2 texCoord15_g1264 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1267 = ( texCoord15_g1264 * _Tiling );
				float2 temp_cast_18 = (0.5).xx;
				float2 temp_output_12_0_g1268 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1267 - temp_cast_18 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1267 ));
				float Depth17_g1268 = _Depth;
				float3 viewDir17_g1268 = ase_tanViewDir;
				float2 uv17_g1268 = temp_output_12_0_g1268;
				SamplerState ss17_g1268 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1268 = MyCustomExpression17_g1268( Depth17_g1268 , viewDir17_g1268 , uv17_g1268 , ss17_g1268 );
				float2 temp_output_4_0_g1265 = (( _EnableParallax )?( localMyCustomExpression17_g1268 ):( temp_output_12_0_g1268 ));
				float2 inUV8_g1265 = temp_output_4_0_g1265;
				float2 temp_output_7_0_g1266 = ( ( temp_output_4_0_g1265 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1266 = dot( temp_output_7_0_g1266 , temp_output_7_0_g1266 );
				float ScaleMask8_g1265 = ( 1.0 - pow( saturate( dotResult2_g1266 ) , 0.15 ) );
				float Dilation8_g1265 = _Dilation;
				float2 localDilationnotexture8_g1265 = Dilationnotexture8_g1265( inUV8_g1265 , ScaleMask8_g1265 , Dilation8_g1265 );
				float4 tex2DNode3_g1263 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1265 : temp_output_4_0_g1265 ) );
				float4 lerpResult26_g1263 = lerp( _OcclusionColor , temp_cast_17 , tex2DNode3_g1263.r);
				float4 lerpResult18_g1263 = lerp( float4( 1,1,1,0 ) , lerpResult26_g1263 , _Occlusionfinalpass);
				float4 Occlusion89 = lerpResult18_g1263;
				float3 normalizeResult33_g1251 = normalize( Normal83 );
				float3 worldRefl18_g1251 = reflect( -WorldViewDirection, float3( dot( tanToWorld0, normalizeResult33_g1251 ), dot( tanToWorld1, normalizeResult33_g1251 ), dot( tanToWorld2, normalizeResult33_g1251 ) ) );
				float3 reflectVector21_g1251 = worldRefl18_g1251;
				float3 positionWS21_g1251 = WorldPosition;
				float localUnitythings45_g1251 = ( 0.0 );
				float perceptualRoughness45_g1251 = 0;
				float2 texCoord15_g1317 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1320 = ( texCoord15_g1317 * _Tiling );
				float2 temp_cast_19 = (0.5).xx;
				float2 temp_output_12_0_g1321 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1320 - temp_cast_19 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1320 ));
				float Depth17_g1321 = _Depth;
				float3 viewDir17_g1321 = ase_tanViewDir;
				float2 uv17_g1321 = temp_output_12_0_g1321;
				SamplerState ss17_g1321 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1321 = MyCustomExpression17_g1321( Depth17_g1321 , viewDir17_g1321 , uv17_g1321 , ss17_g1321 );
				float2 temp_output_4_0_g1318 = (( _EnableParallax )?( localMyCustomExpression17_g1321 ):( temp_output_12_0_g1321 ));
				float2 inUV8_g1318 = temp_output_4_0_g1318;
				float2 temp_output_7_0_g1319 = ( ( temp_output_4_0_g1318 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1319 = dot( temp_output_7_0_g1319 , temp_output_7_0_g1319 );
				float ScaleMask8_g1318 = ( 1.0 - pow( saturate( dotResult2_g1319 ) , 0.15 ) );
				float Dilation8_g1318 = _Dilation;
				float2 localDilationnotexture8_g1318 = Dilationnotexture8_g1318( inUV8_g1318 , ScaleMask8_g1318 , Dilation8_g1318 );
				float2 temp_output_13_0_g1316 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1318 : temp_output_4_0_g1318 );
				float4 tex2DNode3_g1316 = SAMPLE_TEXTURE2D( _SpecGlossMap, sampler_Trilinear_Repeat_Aniso4, temp_output_13_0_g1316 );
				float temp_output_7_0_g1316 = ( tex2DNode3_g1316.a * _SpecColor.a * ( _Smoothness * _SmoothnessMult ) );
				float4 tex2DNode16_g1316 = SAMPLE_TEXTURE2D( _OverlaySpecular, sampler_Trilinear_Repeat_Aniso4, temp_output_13_0_g1316 );
				float Overlay_Alpha1136 = tex2DNode168_g1359.a;
				float temp_output_22_0_g1316 = Overlay_Alpha1136;
				float lerpResult20_g1316 = lerp( temp_output_7_0_g1316 , ( tex2DNode16_g1316.a * _OverlaySmoothness ) , temp_output_22_0_g1316);
				#ifdef _OVERLAY_ON
				float staticSwitch19_g1316 = lerpResult20_g1316;
				#else
				float staticSwitch19_g1316 = temp_output_7_0_g1316;
				#endif
				float Smoothness85 = staticSwitch19_g1316;
				float temp_output_22_0_g1251 = Smoothness85;
				float smoothness45_g1251 = temp_output_22_0_g1251;
				float roughness45_g1251 = 0;
				float roughness245_g1251 = 0;
				{
				perceptualRoughness45_g1251 = PerceptualSmoothnessToPerceptualRoughness(smoothness45_g1251);
				roughness45_g1251                      = max(PerceptualRoughnessToRoughness(perceptualRoughness45_g1251), HALF_MIN_SQRT);
				roughness245_g1251                    = max(roughness45_g1251 * roughness45_g1251, HALF_MIN);
				}
				float perceptualRoughness21_g1251 = perceptualRoughness45_g1251;
				float lerpResult6_g1263 = lerp( 1.0 , tex2DNode3_g1263.g , _SpecularOcclusion);
				float Specular_Occlusion130 = lerpResult6_g1263;
				float3 temp_cast_20 = (Specular_Occlusion130).xxx;
				float3 occlusion21_g1251 = temp_cast_20;
				float2 normalizedScreenSpaceUV21_g1251 = ase_grabScreenPosNorm.xy;
				float3 localGlossyEnvironmentReflection21_g1251 = GlossyEnvironmentReflection21_g1251( reflectVector21_g1251 , positionWS21_g1251 , perceptualRoughness21_g1251 , occlusion21_g1251 , normalizedScreenSpaceUV21_g1251 );
				float roughness42_g1251 = roughness45_g1251;
				float localSurfacereduction42_g1251 = Surfacereduction42_g1251( roughness42_g1251 );
				float3 temp_output_6_0_g1316 = (( tex2DNode3_g1316 * _SpecColor )).rgb;
				float4 lerpResult18_g1316 = lerp( float4( temp_output_6_0_g1316 , 0.0 ) , ( tex2DNode16_g1316 * _OverlaySpecularColor ) , temp_output_22_0_g1316);
				#ifdef _OVERLAY_ON
				float4 staticSwitch15_g1316 = lerpResult18_g1316;
				#else
				float4 staticSwitch15_g1316 = float4( temp_output_6_0_g1316 , 0.0 );
				#endif
				float lerpResult13_g1263 = lerp( 1.0 , tex2DNode3_g1263.b , _CavityStrength);
				float Cavity360 = ( 1.0 == _Cavity ? lerpResult13_g1263 : 1.0 );
				float4 temp_output_737_0 = ( staticSwitch15_g1316 * Cavity360 );
				float2 texCoord15_g1257 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1260 = ( texCoord15_g1257 * _Tiling );
				float2 temp_cast_25 = (0.5).xx;
				float2 temp_output_12_0_g1261 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1260 - temp_cast_25 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1260 ));
				float Depth17_g1261 = _Depth;
				float3 viewDir17_g1261 = ase_tanViewDir;
				float2 uv17_g1261 = temp_output_12_0_g1261;
				SamplerState ss17_g1261 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1261 = MyCustomExpression17_g1261( Depth17_g1261 , viewDir17_g1261 , uv17_g1261 , ss17_g1261 );
				float2 temp_output_4_0_g1258 = (( _EnableParallax )?( localMyCustomExpression17_g1261 ):( temp_output_12_0_g1261 ));
				float2 inUV8_g1258 = temp_output_4_0_g1258;
				float2 temp_output_7_0_g1259 = ( ( temp_output_4_0_g1258 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1259 = dot( temp_output_7_0_g1259 , temp_output_7_0_g1259 );
				float ScaleMask8_g1258 = ( 1.0 - pow( saturate( dotResult2_g1259 ) , 0.15 ) );
				float Dilation8_g1258 = _Dilation;
				float2 localDilationnotexture8_g1258 = Dilationnotexture8_g1258( inUV8_g1258 , ScaleMask8_g1258 , Dilation8_g1258 );
				float2 temp_output_62_0_g1253 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1258 : temp_output_4_0_g1258 );
				float3x3 ase_worldToTangent = float3x3(WorldTangent,WorldBiTangent,WorldNormal);
				float3 worldToTangentDir6_g1253 = normalize( mul( ase_worldToTangent, SafeNormalize(_MainLightPosition.xyz)) );
				float2 appendResult4_g1253 = (float2(worldToTangentDir6_g1253.x , worldToTangentDir6_g1253.y));
				float2 temp_output_2_0_g1253 = ( temp_output_62_0_g1253 + ( appendResult4_g1253 * _IrisShadowDistance ) );
				float2 temp_output_7_0_g1256 = ( ( temp_output_2_0_g1253 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g1256 = dot( temp_output_7_0_g1256 , temp_output_7_0_g1256 );
				float3 temp_cast_26 = (( 1.0 - pow( saturate( dotResult2_g1256 ) , _IrisSelfShadowCircleHardness ) )).xxx;
				float2 temp_output_7_0_g1255 = ( ( temp_output_62_0_g1253 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g1255 = dot( temp_output_7_0_g1255 , temp_output_7_0_g1255 );
				float3 tanNormal26_g1253 = Normal83;
				float3 worldNormal26_g1253 = float3(dot(tanToWorld0,tanNormal26_g1253), dot(tanToWorld1,tanNormal26_g1253), dot(tanToWorld2,tanNormal26_g1253));
				float dotResult27_g1253 = dot( SafeNormalize(_MainLightPosition.xyz) , worldNormal26_g1253 );
				float smoothstepResult31_g1253 = smoothstep( -0.31 , -0.02 , dotResult27_g1253);
				float temp_output_2_0_g1254 = ( _IrisShadowOpacity * ( 1.0 - pow( saturate( dotResult2_g1255 ) , _IrisSelfShadowCircleHardness ) ) * saturate( smoothstepResult31_g1253 ) );
				float temp_output_3_0_g1254 = ( 1.0 - temp_output_2_0_g1254 );
				float3 appendResult7_g1254 = (float3(temp_output_3_0_g1254 , temp_output_3_0_g1254 , temp_output_3_0_g1254));
				float temp_output_1187_0 = (( ( temp_cast_26 * temp_output_2_0_g1254 ) + appendResult7_g1254 )).x;
				float3 temp_cast_27 = (temp_output_1187_0).xxx;
				float3 temp_cast_28 = (0.0).xxx;
				float3 temp_cast_29 = (tex2DNode2_g1362.a).xxx;
				float3 temp_output_154_4_g1359 = (( _ScleraRing )?( temp_cast_29 ):( temp_cast_28 ));
				float3 Sclera_Ring_Alpha421 = temp_output_154_4_g1359;
				float lerpResult656 = lerp( temp_output_1187_0 , 1.0 , Sclera_Ring_Alpha421.x);
				float3 temp_cast_31 = (lerpResult656).xxx;
				float3 IrisShadow509 = (( _ScleraRing )?( temp_cast_31 ):( temp_cast_27 ));
				float3 temp_output_1031_0 = (( _IrisShadow )?( ( temp_output_737_0 * float4( IrisShadow509 , 0.0 ) ).rgb ):( temp_output_737_0.rgb ));
				float3 temp_output_425_0 = ( 1.0 - Sclera_Ring_Alpha421 );
				float3 temp_output_1033_0 = (( _ScleraRing )?( ( temp_output_1031_0 * temp_output_425_0 * temp_output_425_0 ) ):( temp_output_1031_0 ));
				float3 Specular87 = temp_output_1033_0;
				float3 temp_output_5_0_g1252 = Specular87;
				float4 appendResult9_g1252 = (float4(temp_output_5_0_g1252 , temp_output_22_0_g1251));
				float4 Specular7_g1252 = appendResult9_g1252;
				float3 tanNormal31_g1251 = normalizeResult33_g1251;
				float3 worldNormal31_g1251 = normalize( float3(dot(tanToWorld0,tanNormal31_g1251), dot(tanToWorld1,tanNormal31_g1251), dot(tanToWorld2,tanNormal31_g1251)) );
				float3 temp_output_3_0_g1252 = worldNormal31_g1251;
				float3 temp_output_4_0_g1252 = WorldViewDirection;
				float dotResult11_g1252 = dot( temp_output_3_0_g1252 , temp_output_4_0_g1252 );
				float NdotV7_g1252 = saturate( dotResult11_g1252 );
				float _FresnelIntensity7_g1252 = _FresnelIntensity;
				float3 temp_cast_34 = (Cavity360).xxx;
				float Cavity7_g1252 = temp_cast_34.x;
				float3 localFresnel7_g1252 = Fresnel7_g1252( Specular7_g1252 , NdotV7_g1252 , _FresnelIntensity7_g1252 , Cavity7_g1252 );
				float3 EnvironmentReflections721 = ( ( ( localGlossyEnvironmentReflection21_g1251 * localSurfacereduction42_g1251 ) * localFresnel7_g1252 ) * _EnvironmentReflectionsIntensity );
				float3 WorldPos708 = WorldPosition;
				float3 tanNormal710 = Normal83;
				float3 worldNormal710 = float3(dot(tanToWorld0,tanNormal710), dot(tanToWorld1,tanNormal710), dot(tanToWorld2,tanNormal710));
				float3 Normal708 = worldNormal710;
				float3 SpecColor708 = ( Specular87 * Cavity360 );
				float Smoothness708 = Smoothness85;
				float3 WorldView708 = WorldViewDirection;
				float2 texCoord1078 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV708 = texCoord1078;
				float3 localSpecularLightingFull708 = SpecularLightingFull708( WorldPos708 , Normal708 , SpecColor708 , Smoothness708 , WorldView708 , lightmapUV708 );
				float3 Specular_Highlight718 = ( localSpecularLightingFull708 * Specular_Occlusion130 * _SpecularHighlightIntensity );
				float temp_output_1204_0 = _SSS_DebugMode;
				float3 WorldPos2_g1384 = WorldPosition;
				float3 tanNormal1198 = Normal83;
				float3 worldNormal1198 = float3(dot(tanToWorld0,tanNormal1198), dot(tanToWorld1,tanNormal1198), dot(tanToWorld2,tanNormal1198));
				float3 temp_output_6_0_g1384 = worldNormal1198;
				float3 Normal2_g1384 = temp_output_6_0_g1384;
				float r2_g1384 = _DiffuseRoughness;
				float3 WorldView2_g1384 = WorldViewDirection;
				float2 texCoord7_g1384 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g1384 = texCoord7_g1384;
				float2 texCoord9_g1384 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g1384 = ASEBakedGI( temp_output_6_0_g1384, texCoord7_g1384, true);
				float3 GI2_g1384 = bakedGI8_g1384;
				float LightClamp2_g1384 = 100.0;
				float3 localLightingFull2_g1384 = LightingFull2_g1384( WorldPos2_g1384 , Normal2_g1384 , r2_g1384 , WorldView2_g1384 , lightmapUV2_g1384 , GI2_g1384 , LightClamp2_g1384 );
				float4 Albedo_for_Reflection_Probe1210 = temp_output_9_0_g1359;
				float GI_boost1219 = _GI;
				float2 texCoord1200 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord1201 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI1202 = ASEBakedGI( worldNormal1198, texCoord1200, true);
				float4 _SSS_Blur259 = tex2DNode1_g1359;
				float4 _SSS_LightPass258 = SAMPLE_TEXTURE2D( _SSS_LightPass, sampler_Trilinear_Clamp, ase_grabScreenPosNorm.xy );
				#ifdef _DEBUG_ON
				float4 staticSwitch1070 = ( 6.0 == temp_output_1204_0 ? ( ( float4( localLightingFull2_g1384 , 0.0 ) * ( Albedo_for_Reflection_Probe1210 * GI_boost1219 ) ) + float4( Specular_Highlight718 , 0.0 ) + ( float4( bakedGI1202 , 0.0 ) * ( Albedo_for_Reflection_Probe1210 * GI_boost1219 ) ) ) : ( 5.0 == temp_output_1204_0 ? float4( bakedGI1202 , 0.0 ) : ( 4.0 == temp_output_1204_0 ? _SSS_Blur259 : ( 3.0 == temp_output_1204_0 ? float4( EnvironmentReflections721 , 0.0 ) : ( 2.0 == temp_output_1204_0 ? float4( Specular_Highlight718 , 0.0 ) : ( 1.0 == temp_output_1204_0 ? _SSS_Blur259 : _SSS_LightPass258 ) ) ) ) ) );
				#else
				float4 staticSwitch1070 = ( ( float4( Diffuse110 , 0.0 ) * Occlusion89 ) + float4( EnvironmentReflections721 , 0.0 ) + float4( Specular_Highlight718 , 0.0 ) );
				#endif
				

				float3 BaseColor = Albedo112.rgb;
				float3 Normal = Normal83;
				float3 Emission = staticSwitch1070.rgb;
				float3 Specular = 0.5;
				float Metallic = 0;
				float Smoothness = 0.5;
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

			#pragma multi_compile_local_fragment __ _OVERLAY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);


			
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

			#pragma multi_compile_local_fragment __ _OVERLAY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);


			
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

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _OVERLAY_ON
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local_fragment _DEBUG_ON
			#pragma shader_feature_local _CORNEATURBIDITY_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
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
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			TEXTURE2D(_SSS_Blur);
			SAMPLER(sampler_Trilinear_Clamp);
			TEXTURE2D(_ScleraRingMap);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_OverlaySpecular);
			TEXTURE2D(_SSS_LightPass);


			float2 MyCustomExpression17_g1382( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1379( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			inline float4 ASE_ComputeGrabScreenPos( float4 pos )
			{
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				float4 o = pos;
				o.y = pos.w * 0.5f;
				o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
				return o;
			}
			
			float2 MyCustomExpression17_g1375( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1372( float2 inUV, float ScaleMask, float Dilation )
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
			
			float3 LightingFull2_g1361( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			inline float2 ParallaxOffset( half h, half height, half3 viewDir )
			{
				h = h * height - height/2.0;
				float3 v = normalize( viewDir );
				v.z += 0.42;
				return h* (v.xy / v.z);
			}
			
			float2 MyCustomExpression17_g1268( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1265( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g1281( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1278( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g1321( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1318( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 GlossyEnvironmentReflection21_g1251( float3 reflectVector, float3 positionWS, float perceptualRoughness, float3 occlusion, float2 normalizedScreenSpaceUV )
			{
				return GlossyEnvironmentReflectionFix(reflectVector,
				 positionWS, perceptualRoughness, occlusion, normalizedScreenSpaceUV);
			}
			
			float Surfacereduction42_g1251( float roughness )
			{
				float r2 = max(roughness * roughness, HALF_MIN);
				 float surfaceReduction = 1.0 / (r2 + 1.0);
				return surfaceReduction;
			}
			
			float2 MyCustomExpression17_g1261( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1258( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 Fresnel7_g1252( float4 Specular, float NdotV, float _FresnelIntensity, float Cavity )
			{
				half3 oneMinusReflectivity = 1 - Specular.rgb;
				half3 grazingTerm = saturate(Specular.a + (1 - oneMinusReflectivity));
				return FresnelLerp(Specular.rgb * Cavity, grazingTerm, lerp(1.0, NdotV, _FresnelIntensity));
			}
			
			float3 SpecularLightingFull708( float3 WorldPos, float3 Normal, float3 SpecColor, float Smoothness, float3 WorldView, float2 lightmapUV )
			{
				return SpecularLightingFull(WorldPos, Normal, 
				SpecColor, Smoothness, WorldView, lightmapUV);
			}
			
			float3 LightingFull2_g1384( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
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
				
				float4 ase_clipPos = TransformObjectToHClip((v.positionOS).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord8 = screenPos;
				
				o.ase_texcoord4.xy = v.texcoord0.xy;
				o.ase_texcoord4.zw = v.texcoord1.xy;
				o.ase_texcoord9.xy = v.texcoord2.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.w = 0;
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

				float4 temp_cast_0 = (0.0).xxxx;
				float2 texCoord15_g1378 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1381 = ( texCoord15_g1378 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g1382 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1381 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1381 ));
				float Depth17_g1382 = _Depth;
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
				float3 viewDir17_g1382 = ase_tanViewDir;
				float2 uv17_g1382 = temp_output_12_0_g1382;
				SamplerState ss17_g1382 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1382 = MyCustomExpression17_g1382( Depth17_g1382 , viewDir17_g1382 , uv17_g1382 , ss17_g1382 );
				float2 temp_output_4_0_g1379 = (( _EnableParallax )?( localMyCustomExpression17_g1382 ):( temp_output_12_0_g1382 ));
				float2 inUV8_g1379 = temp_output_4_0_g1379;
				float2 temp_output_7_0_g1380 = ( ( temp_output_4_0_g1379 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1380 = dot( temp_output_7_0_g1380 , temp_output_7_0_g1380 );
				float ScaleMask8_g1379 = ( 1.0 - pow( saturate( dotResult2_g1380 ) , 0.15 ) );
				float Dilation8_g1379 = _Dilation;
				float2 localDilationnotexture8_g1379 = Dilationnotexture8_g1379( inUV8_g1379 , ScaleMask8_g1379 , Dilation8_g1379 );
				float4 temp_output_9_0_g1359 = ( _Color * SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1379 : temp_output_4_0_g1379 ) ) );
				float4 Albedo112 = (( _PrepareforGIbake )?( temp_output_9_0_g1359 ):( temp_cast_0 ));
				
				float4 screenPos = IN.ase_texcoord8;
				float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( screenPos );
				float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
				float4 tex2DNode1_g1359 = SAMPLE_TEXTURE2D( _SSS_Blur, sampler_Trilinear_Clamp, ase_grabScreenPosNorm.xy );
				float4 temp_cast_4 = (1.0).xxxx;
				float2 texCoord866 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1374 = ( texCoord866 * _Tiling );
				float2 temp_cast_5 = (0.5).xx;
				float2 temp_output_12_0_g1375 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1374 - temp_cast_5 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1374 ));
				float Depth17_g1375 = _Depth;
				float3 viewDir17_g1375 = ase_tanViewDir;
				float2 uv17_g1375 = temp_output_12_0_g1375;
				SamplerState ss17_g1375 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1375 = MyCustomExpression17_g1375( Depth17_g1375 , viewDir17_g1375 , uv17_g1375 , ss17_g1375 );
				float2 temp_output_4_0_g1372 = (( _EnableParallax )?( localMyCustomExpression17_g1375 ):( temp_output_12_0_g1375 ));
				float2 inUV8_g1372 = temp_output_4_0_g1372;
				float2 temp_output_7_0_g1373 = ( ( temp_output_4_0_g1372 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1373 = dot( temp_output_7_0_g1373 , temp_output_7_0_g1373 );
				float ScaleMask8_g1372 = ( 1.0 - pow( saturate( dotResult2_g1373 ) , 0.15 ) );
				float Dilation8_g1372 = _Dilation;
				float2 localDilationnotexture8_g1372 = Dilationnotexture8_g1372( inUV8_g1372 , ScaleMask8_g1372 , Dilation8_g1372 );
				float2 temp_output_161_0_g1359 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1372 : temp_output_4_0_g1372 );
				float4 tex2DNode7_g1359 = SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, temp_output_161_0_g1359 );
				float4 lerpResult127_g1359 = lerp( temp_cast_4 , tex2DNode7_g1359 , _AlbedoInfluence);
				float2 Final_UVs111_g1359 = temp_output_161_0_g1359;
				float4 tex2DNode168_g1359 = SAMPLE_TEXTURE2D( _OverlayAlbedo, sampler_Trilinear_Repeat_Aniso8, Final_UVs111_g1359 );
				float4 lerpResult169_g1359 = lerp( tex2DNode7_g1359 , tex2DNode168_g1359 , tex2DNode168_g1359.a);
				#ifdef _OVERLAY_ON
				float4 staticSwitch167_g1359 = lerpResult169_g1359;
				#else
				float4 staticSwitch167_g1359 = lerpResult127_g1359;
				#endif
				float3 WorldPos2_g1361 = WorldPosition;
				float3 temp_output_6_0_g1361 = ase_worldNormal;
				float3 Normal2_g1361 = temp_output_6_0_g1361;
				float r2_g1361 = _DiffuseRoughness;
				float3 WorldView2_g1361 = ase_worldViewDir;
				float2 texCoord7_g1361 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g1361 = texCoord7_g1361;
				float2 texCoord9_g1361 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g1361 = ASEBakedGI( temp_output_6_0_g1361, texCoord7_g1361, true);
				float3 GI2_g1361 = bakedGI8_g1361;
				float LightClamp2_g1361 = 100.0;
				float3 localLightingFull2_g1361 = LightingFull2_g1361( WorldPos2_g1361 , Normal2_g1361 , r2_g1361 , WorldView2_g1361 , lightmapUV2_g1361 , GI2_g1361 , LightClamp2_g1361 );
				float3 bakedGI70_g1359 = ASEBakedGI( ase_worldNormal, float2( 0,0 ), true);
				float2 texCoord41_g1359 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_39_0_g1359 = ( texCoord41_g1359 + -0.5 );
				float dotResult40_g1359 = dot( temp_output_39_0_g1359 , temp_output_39_0_g1359 );
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 paralaxOffset35_g1359 = ParallaxOffset( dotResult40_g1359 , _CorneaDepth , ase_tanViewDir );
				float2 texCoord38_g1359 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_44_0_g1359 = ( ( paralaxOffset35_g1359 + texCoord38_g1359 ) + -0.5 );
				float dotResult43_g1359 = dot( temp_output_44_0_g1359 , temp_output_44_0_g1359 );
				float smoothstepResult47_g1359 = smoothstep( _CorneaSizeMin , 1.0 , ( 1.0 - dotResult43_g1359 ));
				float2 temp_output_51_0_g1359 = ( Final_UVs111_g1359 + -0.5 );
				float dotResult52_g1359 = dot( temp_output_51_0_g1359 , temp_output_51_0_g1359 );
				float smoothstepResult48_g1359 = smoothstep( _CorneaMaskMin , 1.0 , ( 1.0 - dotResult52_g1359 ));
				float Cornea_Turbidity63_g1359 = ( smoothstepResult47_g1359 * _CorneaOpacity * smoothstepResult48_g1359 );
				float4 lerpResult65_g1359 = lerp( ( tex2DNode1_g1359 * staticSwitch167_g1359 ) , float4( ( localLightingFull2_g1361 + bakedGI70_g1359 ) , 0.0 ) , Cornea_Turbidity63_g1359);
				#ifdef _CORNEATURBIDITY_ON
				float4 staticSwitch64_g1359 = lerpResult65_g1359;
				#else
				float4 staticSwitch64_g1359 = ( tex2DNode1_g1359 * staticSwitch167_g1359 );
				#endif
				float3 temp_output_6_0_g1362 = staticSwitch64_g1359.rgb;
				float4 temp_cast_8 = (1.0).xxxx;
				float4 Blurred_lighting119_g1359 = tex2DNode1_g1359;
				float2 texCoord8_g1367 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1367 = texCoord8_g1367;
				float2 temp_cast_12 = (0.5).xx;
				float4 tex2DNode2_g1362 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1367 - temp_cast_12 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1367 )) );
				float4 lerpResult1_g1362 = lerp( float4( temp_output_6_0_g1362 , 0.0 ) , ( float4( Blurred_lighting119_g1359.rgb , 0.0 ) * tex2DNode2_g1362 ) , tex2DNode2_g1362.a);
				float4 lerpResult13_g1362 = lerp( temp_cast_8 , lerpResult1_g1362 , _AlbedoOpacity);
				float3 Diffuse110 = (( _ScleraRing )?( lerpResult13_g1362.rgb ):( temp_output_6_0_g1362 ));
				float4 temp_cast_15 = (1.0).xxxx;
				float2 texCoord15_g1264 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1267 = ( texCoord15_g1264 * _Tiling );
				float2 temp_cast_16 = (0.5).xx;
				float2 temp_output_12_0_g1268 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1267 - temp_cast_16 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1267 ));
				float Depth17_g1268 = _Depth;
				float3 viewDir17_g1268 = ase_tanViewDir;
				float2 uv17_g1268 = temp_output_12_0_g1268;
				SamplerState ss17_g1268 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1268 = MyCustomExpression17_g1268( Depth17_g1268 , viewDir17_g1268 , uv17_g1268 , ss17_g1268 );
				float2 temp_output_4_0_g1265 = (( _EnableParallax )?( localMyCustomExpression17_g1268 ):( temp_output_12_0_g1268 ));
				float2 inUV8_g1265 = temp_output_4_0_g1265;
				float2 temp_output_7_0_g1266 = ( ( temp_output_4_0_g1265 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1266 = dot( temp_output_7_0_g1266 , temp_output_7_0_g1266 );
				float ScaleMask8_g1265 = ( 1.0 - pow( saturate( dotResult2_g1266 ) , 0.15 ) );
				float Dilation8_g1265 = _Dilation;
				float2 localDilationnotexture8_g1265 = Dilationnotexture8_g1265( inUV8_g1265 , ScaleMask8_g1265 , Dilation8_g1265 );
				float4 tex2DNode3_g1263 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1265 : temp_output_4_0_g1265 ) );
				float4 lerpResult26_g1263 = lerp( _OcclusionColor , temp_cast_15 , tex2DNode3_g1263.r);
				float4 lerpResult18_g1263 = lerp( float4( 1,1,1,0 ) , lerpResult26_g1263 , _Occlusionfinalpass);
				float4 Occlusion89 = lerpResult18_g1263;
				float2 texCoord15_g1277 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1280 = ( texCoord15_g1277 * _Tiling );
				float2 temp_cast_17 = (0.5).xx;
				float2 temp_output_12_0_g1281 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1280 - temp_cast_17 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1280 ));
				float Depth17_g1281 = _Depth;
				float3 viewDir17_g1281 = ase_tanViewDir;
				float2 uv17_g1281 = temp_output_12_0_g1281;
				SamplerState ss17_g1281 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1281 = MyCustomExpression17_g1281( Depth17_g1281 , viewDir17_g1281 , uv17_g1281 , ss17_g1281 );
				float2 temp_output_4_0_g1278 = (( _EnableParallax )?( localMyCustomExpression17_g1281 ):( temp_output_12_0_g1281 ));
				float2 inUV8_g1278 = temp_output_4_0_g1278;
				float2 temp_output_7_0_g1279 = ( ( temp_output_4_0_g1278 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1279 = dot( temp_output_7_0_g1279 , temp_output_7_0_g1279 );
				float ScaleMask8_g1278 = ( 1.0 - pow( saturate( dotResult2_g1279 ) , 0.15 ) );
				float Dilation8_g1278 = _Dilation;
				float2 localDilationnotexture8_g1278 = Dilationnotexture8_g1278( inUV8_g1278 , ScaleMask8_g1278 , Dilation8_g1278 );
				float2 temp_output_26_0_g1270 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1278 : temp_output_4_0_g1278 );
				float3 unpack1_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g1270 ), _NormalIntensity );
				unpack1_g1270.z = lerp( 1, unpack1_g1270.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g1270 = normalize( unpack1_g1270 );
				float3 unpack8_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g1270 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g1270.z = lerp( 1, unpack8_g1270.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g1270 = BlendNormal( normalizeResult20_g1270 , unpack8_g1270 );
				#else
				float3 staticSwitch15_g1270 = normalizeResult20_g1270;
				#endif
				float3 temp_output_6_0_g1271 = staticSwitch15_g1270;
				float2 texCoord8_g1276 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1276 = texCoord8_g1276;
				float2 temp_cast_18 = (0.5).xx;
				float4 tex2DNode2_g1271 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1276 - temp_cast_18 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1276 )) );
				float3 lerpResult9_g1271 = lerp( temp_output_6_0_g1271 , float3( 0,0,1 ) , tex2DNode2_g1271.a);
				float3 Normal83 = (( _ScleraRing )?( lerpResult9_g1271 ):( temp_output_6_0_g1271 ));
				float3 normalizeResult33_g1251 = normalize( Normal83 );
				float3 worldRefl18_g1251 = reflect( -ase_worldViewDir, float3( dot( tanToWorld0, normalizeResult33_g1251 ), dot( tanToWorld1, normalizeResult33_g1251 ), dot( tanToWorld2, normalizeResult33_g1251 ) ) );
				float3 reflectVector21_g1251 = worldRefl18_g1251;
				float3 positionWS21_g1251 = WorldPosition;
				float localUnitythings45_g1251 = ( 0.0 );
				float perceptualRoughness45_g1251 = 0;
				float2 texCoord15_g1317 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1320 = ( texCoord15_g1317 * _Tiling );
				float2 temp_cast_19 = (0.5).xx;
				float2 temp_output_12_0_g1321 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1320 - temp_cast_19 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1320 ));
				float Depth17_g1321 = _Depth;
				float3 viewDir17_g1321 = ase_tanViewDir;
				float2 uv17_g1321 = temp_output_12_0_g1321;
				SamplerState ss17_g1321 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1321 = MyCustomExpression17_g1321( Depth17_g1321 , viewDir17_g1321 , uv17_g1321 , ss17_g1321 );
				float2 temp_output_4_0_g1318 = (( _EnableParallax )?( localMyCustomExpression17_g1321 ):( temp_output_12_0_g1321 ));
				float2 inUV8_g1318 = temp_output_4_0_g1318;
				float2 temp_output_7_0_g1319 = ( ( temp_output_4_0_g1318 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1319 = dot( temp_output_7_0_g1319 , temp_output_7_0_g1319 );
				float ScaleMask8_g1318 = ( 1.0 - pow( saturate( dotResult2_g1319 ) , 0.15 ) );
				float Dilation8_g1318 = _Dilation;
				float2 localDilationnotexture8_g1318 = Dilationnotexture8_g1318( inUV8_g1318 , ScaleMask8_g1318 , Dilation8_g1318 );
				float2 temp_output_13_0_g1316 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1318 : temp_output_4_0_g1318 );
				float4 tex2DNode3_g1316 = SAMPLE_TEXTURE2D( _SpecGlossMap, sampler_Trilinear_Repeat_Aniso4, temp_output_13_0_g1316 );
				float temp_output_7_0_g1316 = ( tex2DNode3_g1316.a * _SpecColor.a * ( _Smoothness * _SmoothnessMult ) );
				float4 tex2DNode16_g1316 = SAMPLE_TEXTURE2D( _OverlaySpecular, sampler_Trilinear_Repeat_Aniso4, temp_output_13_0_g1316 );
				float Overlay_Alpha1136 = tex2DNode168_g1359.a;
				float temp_output_22_0_g1316 = Overlay_Alpha1136;
				float lerpResult20_g1316 = lerp( temp_output_7_0_g1316 , ( tex2DNode16_g1316.a * _OverlaySmoothness ) , temp_output_22_0_g1316);
				#ifdef _OVERLAY_ON
				float staticSwitch19_g1316 = lerpResult20_g1316;
				#else
				float staticSwitch19_g1316 = temp_output_7_0_g1316;
				#endif
				float Smoothness85 = staticSwitch19_g1316;
				float temp_output_22_0_g1251 = Smoothness85;
				float smoothness45_g1251 = temp_output_22_0_g1251;
				float roughness45_g1251 = 0;
				float roughness245_g1251 = 0;
				{
				perceptualRoughness45_g1251 = PerceptualSmoothnessToPerceptualRoughness(smoothness45_g1251);
				roughness45_g1251                      = max(PerceptualRoughnessToRoughness(perceptualRoughness45_g1251), HALF_MIN_SQRT);
				roughness245_g1251                    = max(roughness45_g1251 * roughness45_g1251, HALF_MIN);
				}
				float perceptualRoughness21_g1251 = perceptualRoughness45_g1251;
				float lerpResult6_g1263 = lerp( 1.0 , tex2DNode3_g1263.g , _SpecularOcclusion);
				float Specular_Occlusion130 = lerpResult6_g1263;
				float3 temp_cast_20 = (Specular_Occlusion130).xxx;
				float3 occlusion21_g1251 = temp_cast_20;
				float2 normalizedScreenSpaceUV21_g1251 = ase_grabScreenPosNorm.xy;
				float3 localGlossyEnvironmentReflection21_g1251 = GlossyEnvironmentReflection21_g1251( reflectVector21_g1251 , positionWS21_g1251 , perceptualRoughness21_g1251 , occlusion21_g1251 , normalizedScreenSpaceUV21_g1251 );
				float roughness42_g1251 = roughness45_g1251;
				float localSurfacereduction42_g1251 = Surfacereduction42_g1251( roughness42_g1251 );
				float3 temp_output_6_0_g1316 = (( tex2DNode3_g1316 * _SpecColor )).rgb;
				float4 lerpResult18_g1316 = lerp( float4( temp_output_6_0_g1316 , 0.0 ) , ( tex2DNode16_g1316 * _OverlaySpecularColor ) , temp_output_22_0_g1316);
				#ifdef _OVERLAY_ON
				float4 staticSwitch15_g1316 = lerpResult18_g1316;
				#else
				float4 staticSwitch15_g1316 = float4( temp_output_6_0_g1316 , 0.0 );
				#endif
				float lerpResult13_g1263 = lerp( 1.0 , tex2DNode3_g1263.b , _CavityStrength);
				float Cavity360 = ( 1.0 == _Cavity ? lerpResult13_g1263 : 1.0 );
				float4 temp_output_737_0 = ( staticSwitch15_g1316 * Cavity360 );
				float2 texCoord15_g1257 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1260 = ( texCoord15_g1257 * _Tiling );
				float2 temp_cast_25 = (0.5).xx;
				float2 temp_output_12_0_g1261 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1260 - temp_cast_25 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1260 ));
				float Depth17_g1261 = _Depth;
				float3 viewDir17_g1261 = ase_tanViewDir;
				float2 uv17_g1261 = temp_output_12_0_g1261;
				SamplerState ss17_g1261 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1261 = MyCustomExpression17_g1261( Depth17_g1261 , viewDir17_g1261 , uv17_g1261 , ss17_g1261 );
				float2 temp_output_4_0_g1258 = (( _EnableParallax )?( localMyCustomExpression17_g1261 ):( temp_output_12_0_g1261 ));
				float2 inUV8_g1258 = temp_output_4_0_g1258;
				float2 temp_output_7_0_g1259 = ( ( temp_output_4_0_g1258 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1259 = dot( temp_output_7_0_g1259 , temp_output_7_0_g1259 );
				float ScaleMask8_g1258 = ( 1.0 - pow( saturate( dotResult2_g1259 ) , 0.15 ) );
				float Dilation8_g1258 = _Dilation;
				float2 localDilationnotexture8_g1258 = Dilationnotexture8_g1258( inUV8_g1258 , ScaleMask8_g1258 , Dilation8_g1258 );
				float2 temp_output_62_0_g1253 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1258 : temp_output_4_0_g1258 );
				float3x3 ase_worldToTangent = float3x3(ase_worldTangent,ase_worldBitangent,ase_worldNormal);
				float3 worldToTangentDir6_g1253 = normalize( mul( ase_worldToTangent, SafeNormalize(_MainLightPosition.xyz)) );
				float2 appendResult4_g1253 = (float2(worldToTangentDir6_g1253.x , worldToTangentDir6_g1253.y));
				float2 temp_output_2_0_g1253 = ( temp_output_62_0_g1253 + ( appendResult4_g1253 * _IrisShadowDistance ) );
				float2 temp_output_7_0_g1256 = ( ( temp_output_2_0_g1253 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g1256 = dot( temp_output_7_0_g1256 , temp_output_7_0_g1256 );
				float3 temp_cast_26 = (( 1.0 - pow( saturate( dotResult2_g1256 ) , _IrisSelfShadowCircleHardness ) )).xxx;
				float2 temp_output_7_0_g1255 = ( ( temp_output_62_0_g1253 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g1255 = dot( temp_output_7_0_g1255 , temp_output_7_0_g1255 );
				float3 tanNormal26_g1253 = Normal83;
				float3 worldNormal26_g1253 = float3(dot(tanToWorld0,tanNormal26_g1253), dot(tanToWorld1,tanNormal26_g1253), dot(tanToWorld2,tanNormal26_g1253));
				float dotResult27_g1253 = dot( SafeNormalize(_MainLightPosition.xyz) , worldNormal26_g1253 );
				float smoothstepResult31_g1253 = smoothstep( -0.31 , -0.02 , dotResult27_g1253);
				float temp_output_2_0_g1254 = ( _IrisShadowOpacity * ( 1.0 - pow( saturate( dotResult2_g1255 ) , _IrisSelfShadowCircleHardness ) ) * saturate( smoothstepResult31_g1253 ) );
				float temp_output_3_0_g1254 = ( 1.0 - temp_output_2_0_g1254 );
				float3 appendResult7_g1254 = (float3(temp_output_3_0_g1254 , temp_output_3_0_g1254 , temp_output_3_0_g1254));
				float temp_output_1187_0 = (( ( temp_cast_26 * temp_output_2_0_g1254 ) + appendResult7_g1254 )).x;
				float3 temp_cast_27 = (temp_output_1187_0).xxx;
				float3 temp_cast_28 = (0.0).xxx;
				float3 temp_cast_29 = (tex2DNode2_g1362.a).xxx;
				float3 temp_output_154_4_g1359 = (( _ScleraRing )?( temp_cast_29 ):( temp_cast_28 ));
				float3 Sclera_Ring_Alpha421 = temp_output_154_4_g1359;
				float lerpResult656 = lerp( temp_output_1187_0 , 1.0 , Sclera_Ring_Alpha421.x);
				float3 temp_cast_31 = (lerpResult656).xxx;
				float3 IrisShadow509 = (( _ScleraRing )?( temp_cast_31 ):( temp_cast_27 ));
				float3 temp_output_1031_0 = (( _IrisShadow )?( ( temp_output_737_0 * float4( IrisShadow509 , 0.0 ) ).rgb ):( temp_output_737_0.rgb ));
				float3 temp_output_425_0 = ( 1.0 - Sclera_Ring_Alpha421 );
				float3 temp_output_1033_0 = (( _ScleraRing )?( ( temp_output_1031_0 * temp_output_425_0 * temp_output_425_0 ) ):( temp_output_1031_0 ));
				float3 Specular87 = temp_output_1033_0;
				float3 temp_output_5_0_g1252 = Specular87;
				float4 appendResult9_g1252 = (float4(temp_output_5_0_g1252 , temp_output_22_0_g1251));
				float4 Specular7_g1252 = appendResult9_g1252;
				float3 tanNormal31_g1251 = normalizeResult33_g1251;
				float3 worldNormal31_g1251 = normalize( float3(dot(tanToWorld0,tanNormal31_g1251), dot(tanToWorld1,tanNormal31_g1251), dot(tanToWorld2,tanNormal31_g1251)) );
				float3 temp_output_3_0_g1252 = worldNormal31_g1251;
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 temp_output_4_0_g1252 = ase_worldViewDir;
				float dotResult11_g1252 = dot( temp_output_3_0_g1252 , temp_output_4_0_g1252 );
				float NdotV7_g1252 = saturate( dotResult11_g1252 );
				float _FresnelIntensity7_g1252 = _FresnelIntensity;
				float3 temp_cast_34 = (Cavity360).xxx;
				float Cavity7_g1252 = temp_cast_34.x;
				float3 localFresnel7_g1252 = Fresnel7_g1252( Specular7_g1252 , NdotV7_g1252 , _FresnelIntensity7_g1252 , Cavity7_g1252 );
				float3 EnvironmentReflections721 = ( ( ( localGlossyEnvironmentReflection21_g1251 * localSurfacereduction42_g1251 ) * localFresnel7_g1252 ) * _EnvironmentReflectionsIntensity );
				float3 WorldPos708 = WorldPosition;
				float3 tanNormal710 = Normal83;
				float3 worldNormal710 = float3(dot(tanToWorld0,tanNormal710), dot(tanToWorld1,tanNormal710), dot(tanToWorld2,tanNormal710));
				float3 Normal708 = worldNormal710;
				float3 SpecColor708 = ( Specular87 * Cavity360 );
				float Smoothness708 = Smoothness85;
				float3 WorldView708 = ase_worldViewDir;
				float2 texCoord1078 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV708 = texCoord1078;
				float3 localSpecularLightingFull708 = SpecularLightingFull708( WorldPos708 , Normal708 , SpecColor708 , Smoothness708 , WorldView708 , lightmapUV708 );
				float3 Specular_Highlight718 = ( localSpecularLightingFull708 * Specular_Occlusion130 * _SpecularHighlightIntensity );
				float temp_output_1204_0 = _SSS_DebugMode;
				float3 WorldPos2_g1384 = WorldPosition;
				float3 tanNormal1198 = Normal83;
				float3 worldNormal1198 = float3(dot(tanToWorld0,tanNormal1198), dot(tanToWorld1,tanNormal1198), dot(tanToWorld2,tanNormal1198));
				float3 temp_output_6_0_g1384 = worldNormal1198;
				float3 Normal2_g1384 = temp_output_6_0_g1384;
				float r2_g1384 = _DiffuseRoughness;
				float3 WorldView2_g1384 = ase_worldViewDir;
				float2 texCoord7_g1384 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g1384 = texCoord7_g1384;
				float2 texCoord9_g1384 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g1384 = ASEBakedGI( temp_output_6_0_g1384, texCoord7_g1384, true);
				float3 GI2_g1384 = bakedGI8_g1384;
				float LightClamp2_g1384 = 100.0;
				float3 localLightingFull2_g1384 = LightingFull2_g1384( WorldPos2_g1384 , Normal2_g1384 , r2_g1384 , WorldView2_g1384 , lightmapUV2_g1384 , GI2_g1384 , LightClamp2_g1384 );
				float4 Albedo_for_Reflection_Probe1210 = temp_output_9_0_g1359;
				float GI_boost1219 = _GI;
				float2 texCoord1200 = IN.ase_texcoord4.zw * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord1201 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI1202 = ASEBakedGI( worldNormal1198, texCoord1200, true);
				float4 _SSS_Blur259 = tex2DNode1_g1359;
				float4 _SSS_LightPass258 = SAMPLE_TEXTURE2D( _SSS_LightPass, sampler_Trilinear_Clamp, ase_grabScreenPosNorm.xy );
				#ifdef _DEBUG_ON
				float4 staticSwitch1070 = ( 6.0 == temp_output_1204_0 ? ( ( float4( localLightingFull2_g1384 , 0.0 ) * ( Albedo_for_Reflection_Probe1210 * GI_boost1219 ) ) + float4( Specular_Highlight718 , 0.0 ) + ( float4( bakedGI1202 , 0.0 ) * ( Albedo_for_Reflection_Probe1210 * GI_boost1219 ) ) ) : ( 5.0 == temp_output_1204_0 ? float4( bakedGI1202 , 0.0 ) : ( 4.0 == temp_output_1204_0 ? _SSS_Blur259 : ( 3.0 == temp_output_1204_0 ? float4( EnvironmentReflections721 , 0.0 ) : ( 2.0 == temp_output_1204_0 ? float4( Specular_Highlight718 , 0.0 ) : ( 1.0 == temp_output_1204_0 ? _SSS_Blur259 : _SSS_LightPass258 ) ) ) ) ) );
				#else
				float4 staticSwitch1070 = ( ( float4( Diffuse110 , 0.0 ) * Occlusion89 ) + float4( EnvironmentReflections721 , 0.0 ) + float4( Specular_Highlight718 , 0.0 ) );
				#endif
				

				float3 BaseColor = Albedo112.rgb;
				float3 Emission = staticSwitch1070.rgb;
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

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _OVERLAY_ON
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#include "Common.hlsl"


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
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
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);


			float2 MyCustomExpression17_g1382( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1379( float2 inUV, float ScaleMask, float Dilation )
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
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;

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
				float4 ase_texcoord : TEXCOORD0;
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
				o.ase_texcoord = v.ase_texcoord;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
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

				float4 temp_cast_0 = (0.0).xxxx;
				float2 texCoord15_g1378 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1381 = ( texCoord15_g1378 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g1382 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1381 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1381 ));
				float Depth17_g1382 = _Depth;
				float3 ase_worldTangent = IN.ase_texcoord3.xyz;
				float3 ase_worldNormal = IN.ase_texcoord4.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g1382 = ase_tanViewDir;
				float2 uv17_g1382 = temp_output_12_0_g1382;
				SamplerState ss17_g1382 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1382 = MyCustomExpression17_g1382( Depth17_g1382 , viewDir17_g1382 , uv17_g1382 , ss17_g1382 );
				float2 temp_output_4_0_g1379 = (( _EnableParallax )?( localMyCustomExpression17_g1382 ):( temp_output_12_0_g1382 ));
				float2 inUV8_g1379 = temp_output_4_0_g1379;
				float2 temp_output_7_0_g1380 = ( ( temp_output_4_0_g1379 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1380 = dot( temp_output_7_0_g1380 , temp_output_7_0_g1380 );
				float ScaleMask8_g1379 = ( 1.0 - pow( saturate( dotResult2_g1380 ) , 0.15 ) );
				float Dilation8_g1379 = _Dilation;
				float2 localDilationnotexture8_g1379 = Dilationnotexture8_g1379( inUV8_g1379 , ScaleMask8_g1379 , Dilation8_g1379 );
				float4 temp_output_9_0_g1359 = ( _Color * SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1379 : temp_output_4_0_g1379 ) ) );
				float4 Albedo112 = (( _PrepareforGIbake )?( temp_output_9_0_g1359 ):( temp_cast_0 ));
				

				float3 BaseColor = Albedo112.rgb;
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
			#pragma multi_compile_local_fragment __ _OVERLAY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);


			float2 MyCustomExpression17_g1281( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1278( float2 inUV, float ScaleMask, float Dilation )
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

				float2 texCoord15_g1277 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1280 = ( texCoord15_g1277 * _Tiling );
				float2 temp_cast_0 = (0.5).xx;
				float2 temp_output_12_0_g1281 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1280 - temp_cast_0 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1280 ));
				float Depth17_g1281 = _Depth;
				float3 ase_worldBitangent = IN.ase_texcoord6.xyz;
				float3 tanToWorld0 = float3( WorldTangent.xyz.x, ase_worldBitangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.xyz.y, ase_worldBitangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.xyz.z, ase_worldBitangent.z, WorldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g1281 = ase_tanViewDir;
				float2 uv17_g1281 = temp_output_12_0_g1281;
				SamplerState ss17_g1281 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1281 = MyCustomExpression17_g1281( Depth17_g1281 , viewDir17_g1281 , uv17_g1281 , ss17_g1281 );
				float2 temp_output_4_0_g1278 = (( _EnableParallax )?( localMyCustomExpression17_g1281 ):( temp_output_12_0_g1281 ));
				float2 inUV8_g1278 = temp_output_4_0_g1278;
				float2 temp_output_7_0_g1279 = ( ( temp_output_4_0_g1278 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1279 = dot( temp_output_7_0_g1279 , temp_output_7_0_g1279 );
				float ScaleMask8_g1278 = ( 1.0 - pow( saturate( dotResult2_g1279 ) , 0.15 ) );
				float Dilation8_g1278 = _Dilation;
				float2 localDilationnotexture8_g1278 = Dilationnotexture8_g1278( inUV8_g1278 , ScaleMask8_g1278 , Dilation8_g1278 );
				float2 temp_output_26_0_g1270 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1278 : temp_output_4_0_g1278 );
				float3 unpack1_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g1270 ), _NormalIntensity );
				unpack1_g1270.z = lerp( 1, unpack1_g1270.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g1270 = normalize( unpack1_g1270 );
				float3 unpack8_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g1270 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g1270.z = lerp( 1, unpack8_g1270.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g1270 = BlendNormal( normalizeResult20_g1270 , unpack8_g1270 );
				#else
				float3 staticSwitch15_g1270 = normalizeResult20_g1270;
				#endif
				float3 temp_output_6_0_g1271 = staticSwitch15_g1270;
				float2 texCoord8_g1276 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1276 = texCoord8_g1276;
				float2 temp_cast_1 = (0.5).xx;
				float4 tex2DNode2_g1271 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1276 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1276 )) );
				float3 lerpResult9_g1271 = lerp( temp_output_6_0_g1271 , float3( 0,0,1 ) , tex2DNode2_g1271.a);
				float3 Normal83 = (( _ScleraRing )?( lerpResult9_g1271 ):( temp_output_6_0_g1271 ));
				

				float3 Normal = Normal83;
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
			Stencil
			{
				Ref 0
				Comp Always
				Pass Replace
			}

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
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ _OVERLAY_ON
			#pragma multi_compile_local_fragment __ _ENABLETRANSMISSIONGRADIENT_ON
			#pragma shader_feature_local _ENABLE_DETAIL_NORMAL
			#pragma shader_feature_local_fragment _DEBUG_ON
			#pragma shader_feature_local _CORNEATURBIDITY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);
			SAMPLER(sampler_Trilinear_Repeat_Aniso8);
			SAMPLER(sampler_Trilinear_Repeat_Aniso4);
			TEXTURE2D(_ScleraRingMap);
			TEXTURE2D(_SSS_Blur);
			SAMPLER(sampler_Trilinear_Clamp);
			TEXTURE2D(_OverlaySpecular);
			TEXTURE2D(_SSS_LightPass);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float2 MyCustomExpression17_g1382( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1379( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g1281( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1278( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			inline float4 ASE_ComputeGrabScreenPos( float4 pos )
			{
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				float4 o = pos;
				o.y = pos.w * 0.5f;
				o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
				return o;
			}
			
			float2 MyCustomExpression17_g1375( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1372( float2 inUV, float ScaleMask, float Dilation )
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
			
			float3 LightingFull2_g1361( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
			}
			
			inline float2 ParallaxOffset( half h, half height, half3 viewDir )
			{
				h = h * height - height/2.0;
				float3 v = normalize( viewDir );
				v.z += 0.42;
				return h* (v.xy / v.z);
			}
			
			float2 MyCustomExpression17_g1268( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1265( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float2 MyCustomExpression17_g1321( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1318( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 GlossyEnvironmentReflection21_g1251( float3 reflectVector, float3 positionWS, float perceptualRoughness, float3 occlusion, float2 normalizedScreenSpaceUV )
			{
				return GlossyEnvironmentReflectionFix(reflectVector,
				 positionWS, perceptualRoughness, occlusion, normalizedScreenSpaceUV);
			}
			
			float Surfacereduction42_g1251( float roughness )
			{
				float r2 = max(roughness * roughness, HALF_MIN);
				 float surfaceReduction = 1.0 / (r2 + 1.0);
				return surfaceReduction;
			}
			
			float2 MyCustomExpression17_g1261( float Depth, float3 viewDir, float2 uv, SamplerState ss )
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
			
			float2 Dilationnotexture8_g1258( float2 inUV, float ScaleMask, float Dilation )
			{
				float2 outUV = inUV;
				outUV -= 0.5;
				float pupilRange = 1.0 - ScaleMask;
				outUV.xy *= saturate(lerp(1.0f, pupilRange, Dilation));
				outUV.xy += 0.5f;
				return outUV;
			}
			
			float3 Fresnel7_g1252( float4 Specular, float NdotV, float _FresnelIntensity, float Cavity )
			{
				half3 oneMinusReflectivity = 1 - Specular.rgb;
				half3 grazingTerm = saturate(Specular.a + (1 - oneMinusReflectivity));
				return FresnelLerp(Specular.rgb * Cavity, grazingTerm, lerp(1.0, NdotV, _FresnelIntensity));
			}
			
			float3 SpecularLightingFull708( float3 WorldPos, float3 Normal, float3 SpecColor, float Smoothness, float3 WorldView, float2 lightmapUV )
			{
				return SpecularLightingFull(WorldPos, Normal, 
				SpecColor, Smoothness, WorldView, lightmapUV);
			}
			
			float3 LightingFull2_g1384( float3 WorldPos, float3 Normal, float r, float3 WorldView, float2 lightmapUV, float3 GI, float LightClamp )
			{
				return DiffuseLightingFull(WorldPos, Normal, r, WorldView, lightmapUV, GI, LightClamp);
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

				float4 temp_cast_0 = (0.0).xxxx;
				float2 texCoord15_g1378 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1381 = ( texCoord15_g1378 * _Tiling );
				float2 temp_cast_1 = (0.5).xx;
				float2 temp_output_12_0_g1382 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1381 - temp_cast_1 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1381 ));
				float Depth17_g1382 = _Depth;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 ase_tanViewDir =  tanToWorld0 * WorldViewDirection.x + tanToWorld1 * WorldViewDirection.y  + tanToWorld2 * WorldViewDirection.z;
				ase_tanViewDir = SafeNormalize( ase_tanViewDir );
				float3 viewDir17_g1382 = ase_tanViewDir;
				float2 uv17_g1382 = temp_output_12_0_g1382;
				SamplerState ss17_g1382 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1382 = MyCustomExpression17_g1382( Depth17_g1382 , viewDir17_g1382 , uv17_g1382 , ss17_g1382 );
				float2 temp_output_4_0_g1379 = (( _EnableParallax )?( localMyCustomExpression17_g1382 ):( temp_output_12_0_g1382 ));
				float2 inUV8_g1379 = temp_output_4_0_g1379;
				float2 temp_output_7_0_g1380 = ( ( temp_output_4_0_g1379 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1380 = dot( temp_output_7_0_g1380 , temp_output_7_0_g1380 );
				float ScaleMask8_g1379 = ( 1.0 - pow( saturate( dotResult2_g1380 ) , 0.15 ) );
				float Dilation8_g1379 = _Dilation;
				float2 localDilationnotexture8_g1379 = Dilationnotexture8_g1379( inUV8_g1379 , ScaleMask8_g1379 , Dilation8_g1379 );
				float4 temp_output_9_0_g1359 = ( _Color * SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1379 : temp_output_4_0_g1379 ) ) );
				float4 Albedo112 = (( _PrepareforGIbake )?( temp_output_9_0_g1359 ):( temp_cast_0 ));
				
				float2 texCoord15_g1277 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1280 = ( texCoord15_g1277 * _Tiling );
				float2 temp_cast_3 = (0.5).xx;
				float2 temp_output_12_0_g1281 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1280 - temp_cast_3 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1280 ));
				float Depth17_g1281 = _Depth;
				float3 viewDir17_g1281 = ase_tanViewDir;
				float2 uv17_g1281 = temp_output_12_0_g1281;
				SamplerState ss17_g1281 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1281 = MyCustomExpression17_g1281( Depth17_g1281 , viewDir17_g1281 , uv17_g1281 , ss17_g1281 );
				float2 temp_output_4_0_g1278 = (( _EnableParallax )?( localMyCustomExpression17_g1281 ):( temp_output_12_0_g1281 ));
				float2 inUV8_g1278 = temp_output_4_0_g1278;
				float2 temp_output_7_0_g1279 = ( ( temp_output_4_0_g1278 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1279 = dot( temp_output_7_0_g1279 , temp_output_7_0_g1279 );
				float ScaleMask8_g1278 = ( 1.0 - pow( saturate( dotResult2_g1279 ) , 0.15 ) );
				float Dilation8_g1278 = _Dilation;
				float2 localDilationnotexture8_g1278 = Dilationnotexture8_g1278( inUV8_g1278 , ScaleMask8_g1278 , Dilation8_g1278 );
				float2 temp_output_26_0_g1270 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1278 : temp_output_4_0_g1278 );
				float3 unpack1_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_Trilinear_Repeat_Aniso4, temp_output_26_0_g1270 ), _NormalIntensity );
				unpack1_g1270.z = lerp( 1, unpack1_g1270.z, saturate(_NormalIntensity) );
				float3 normalizeResult20_g1270 = normalize( unpack1_g1270 );
				float3 unpack8_g1270 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_Trilinear_Repeat_Aniso4, ( temp_output_26_0_g1270 * _DetailNormalMapTile ) ), _DetailNormalIntensity );
				unpack8_g1270.z = lerp( 1, unpack8_g1270.z, saturate(_DetailNormalIntensity) );
				#ifdef _ENABLE_DETAIL_NORMAL
				float3 staticSwitch15_g1270 = BlendNormal( normalizeResult20_g1270 , unpack8_g1270 );
				#else
				float3 staticSwitch15_g1270 = normalizeResult20_g1270;
				#endif
				float3 temp_output_6_0_g1271 = staticSwitch15_g1270;
				float2 texCoord8_g1276 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1276 = texCoord8_g1276;
				float2 temp_cast_4 = (0.5).xx;
				float4 tex2DNode2_g1271 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1276 - temp_cast_4 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1276 )) );
				float3 lerpResult9_g1271 = lerp( temp_output_6_0_g1271 , float3( 0,0,1 ) , tex2DNode2_g1271.a);
				float3 Normal83 = (( _ScleraRing )?( lerpResult9_g1271 ):( temp_output_6_0_g1271 ));
				
				float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ScreenPos );
				float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
				float4 tex2DNode1_g1359 = SAMPLE_TEXTURE2D( _SSS_Blur, sampler_Trilinear_Clamp, ase_grabScreenPosNorm.xy );
				float4 temp_cast_6 = (1.0).xxxx;
				float2 texCoord866 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1374 = ( texCoord866 * _Tiling );
				float2 temp_cast_7 = (0.5).xx;
				float2 temp_output_12_0_g1375 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1374 - temp_cast_7 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1374 ));
				float Depth17_g1375 = _Depth;
				float3 viewDir17_g1375 = ase_tanViewDir;
				float2 uv17_g1375 = temp_output_12_0_g1375;
				SamplerState ss17_g1375 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1375 = MyCustomExpression17_g1375( Depth17_g1375 , viewDir17_g1375 , uv17_g1375 , ss17_g1375 );
				float2 temp_output_4_0_g1372 = (( _EnableParallax )?( localMyCustomExpression17_g1375 ):( temp_output_12_0_g1375 ));
				float2 inUV8_g1372 = temp_output_4_0_g1372;
				float2 temp_output_7_0_g1373 = ( ( temp_output_4_0_g1372 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1373 = dot( temp_output_7_0_g1373 , temp_output_7_0_g1373 );
				float ScaleMask8_g1372 = ( 1.0 - pow( saturate( dotResult2_g1373 ) , 0.15 ) );
				float Dilation8_g1372 = _Dilation;
				float2 localDilationnotexture8_g1372 = Dilationnotexture8_g1372( inUV8_g1372 , ScaleMask8_g1372 , Dilation8_g1372 );
				float2 temp_output_161_0_g1359 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1372 : temp_output_4_0_g1372 );
				float4 tex2DNode7_g1359 = SAMPLE_TEXTURE2D( _BaseMap, sampler_Trilinear_Repeat_Aniso8, temp_output_161_0_g1359 );
				float4 lerpResult127_g1359 = lerp( temp_cast_6 , tex2DNode7_g1359 , _AlbedoInfluence);
				float2 Final_UVs111_g1359 = temp_output_161_0_g1359;
				float4 tex2DNode168_g1359 = SAMPLE_TEXTURE2D( _OverlayAlbedo, sampler_Trilinear_Repeat_Aniso8, Final_UVs111_g1359 );
				float4 lerpResult169_g1359 = lerp( tex2DNode7_g1359 , tex2DNode168_g1359 , tex2DNode168_g1359.a);
				#ifdef _OVERLAY_ON
				float4 staticSwitch167_g1359 = lerpResult169_g1359;
				#else
				float4 staticSwitch167_g1359 = lerpResult127_g1359;
				#endif
				float3 WorldPos2_g1361 = WorldPosition;
				float3 temp_output_6_0_g1361 = WorldNormal;
				float3 Normal2_g1361 = temp_output_6_0_g1361;
				float r2_g1361 = _DiffuseRoughness;
				float3 WorldView2_g1361 = WorldViewDirection;
				float2 texCoord7_g1361 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g1361 = texCoord7_g1361;
				float2 texCoord9_g1361 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g1361 = ASEBakedGI( temp_output_6_0_g1361, texCoord7_g1361, true);
				float3 GI2_g1361 = bakedGI8_g1361;
				float LightClamp2_g1361 = 100.0;
				float3 localLightingFull2_g1361 = LightingFull2_g1361( WorldPos2_g1361 , Normal2_g1361 , r2_g1361 , WorldView2_g1361 , lightmapUV2_g1361 , GI2_g1361 , LightClamp2_g1361 );
				float3 bakedGI70_g1359 = ASEBakedGI( WorldNormal, float2( 0,0 ), true);
				float2 texCoord41_g1359 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_39_0_g1359 = ( texCoord41_g1359 + -0.5 );
				float dotResult40_g1359 = dot( temp_output_39_0_g1359 , temp_output_39_0_g1359 );
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 paralaxOffset35_g1359 = ParallaxOffset( dotResult40_g1359 , _CorneaDepth , ase_tanViewDir );
				float2 texCoord38_g1359 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_44_0_g1359 = ( ( paralaxOffset35_g1359 + texCoord38_g1359 ) + -0.5 );
				float dotResult43_g1359 = dot( temp_output_44_0_g1359 , temp_output_44_0_g1359 );
				float smoothstepResult47_g1359 = smoothstep( _CorneaSizeMin , 1.0 , ( 1.0 - dotResult43_g1359 ));
				float2 temp_output_51_0_g1359 = ( Final_UVs111_g1359 + -0.5 );
				float dotResult52_g1359 = dot( temp_output_51_0_g1359 , temp_output_51_0_g1359 );
				float smoothstepResult48_g1359 = smoothstep( _CorneaMaskMin , 1.0 , ( 1.0 - dotResult52_g1359 ));
				float Cornea_Turbidity63_g1359 = ( smoothstepResult47_g1359 * _CorneaOpacity * smoothstepResult48_g1359 );
				float4 lerpResult65_g1359 = lerp( ( tex2DNode1_g1359 * staticSwitch167_g1359 ) , float4( ( localLightingFull2_g1361 + bakedGI70_g1359 ) , 0.0 ) , Cornea_Turbidity63_g1359);
				#ifdef _CORNEATURBIDITY_ON
				float4 staticSwitch64_g1359 = lerpResult65_g1359;
				#else
				float4 staticSwitch64_g1359 = ( tex2DNode1_g1359 * staticSwitch167_g1359 );
				#endif
				float3 temp_output_6_0_g1362 = staticSwitch64_g1359.rgb;
				float4 temp_cast_10 = (1.0).xxxx;
				float4 Blurred_lighting119_g1359 = tex2DNode1_g1359;
				float2 texCoord8_g1367 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1367 = texCoord8_g1367;
				float2 temp_cast_14 = (0.5).xx;
				float4 tex2DNode2_g1362 = SAMPLE_TEXTURE2D( _ScleraRingMap, sampler_Trilinear_Repeat_Aniso4, (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1367 - temp_cast_14 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1367 )) );
				float4 lerpResult1_g1362 = lerp( float4( temp_output_6_0_g1362 , 0.0 ) , ( float4( Blurred_lighting119_g1359.rgb , 0.0 ) * tex2DNode2_g1362 ) , tex2DNode2_g1362.a);
				float4 lerpResult13_g1362 = lerp( temp_cast_10 , lerpResult1_g1362 , _AlbedoOpacity);
				float3 Diffuse110 = (( _ScleraRing )?( lerpResult13_g1362.rgb ):( temp_output_6_0_g1362 ));
				float4 temp_cast_17 = (1.0).xxxx;
				float2 texCoord15_g1264 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1267 = ( texCoord15_g1264 * _Tiling );
				float2 temp_cast_18 = (0.5).xx;
				float2 temp_output_12_0_g1268 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1267 - temp_cast_18 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1267 ));
				float Depth17_g1268 = _Depth;
				float3 viewDir17_g1268 = ase_tanViewDir;
				float2 uv17_g1268 = temp_output_12_0_g1268;
				SamplerState ss17_g1268 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1268 = MyCustomExpression17_g1268( Depth17_g1268 , viewDir17_g1268 , uv17_g1268 , ss17_g1268 );
				float2 temp_output_4_0_g1265 = (( _EnableParallax )?( localMyCustomExpression17_g1268 ):( temp_output_12_0_g1268 ));
				float2 inUV8_g1265 = temp_output_4_0_g1265;
				float2 temp_output_7_0_g1266 = ( ( temp_output_4_0_g1265 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1266 = dot( temp_output_7_0_g1266 , temp_output_7_0_g1266 );
				float ScaleMask8_g1265 = ( 1.0 - pow( saturate( dotResult2_g1266 ) , 0.15 ) );
				float Dilation8_g1265 = _Dilation;
				float2 localDilationnotexture8_g1265 = Dilationnotexture8_g1265( inUV8_g1265 , ScaleMask8_g1265 , Dilation8_g1265 );
				float4 tex2DNode3_g1263 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, ( 1.0 == _EyeDilation ? localDilationnotexture8_g1265 : temp_output_4_0_g1265 ) );
				float4 lerpResult26_g1263 = lerp( _OcclusionColor , temp_cast_17 , tex2DNode3_g1263.r);
				float4 lerpResult18_g1263 = lerp( float4( 1,1,1,0 ) , lerpResult26_g1263 , _Occlusionfinalpass);
				float4 Occlusion89 = lerpResult18_g1263;
				float3 normalizeResult33_g1251 = normalize( Normal83 );
				float3 worldRefl18_g1251 = reflect( -WorldViewDirection, float3( dot( tanToWorld0, normalizeResult33_g1251 ), dot( tanToWorld1, normalizeResult33_g1251 ), dot( tanToWorld2, normalizeResult33_g1251 ) ) );
				float3 reflectVector21_g1251 = worldRefl18_g1251;
				float3 positionWS21_g1251 = WorldPosition;
				float localUnitythings45_g1251 = ( 0.0 );
				float perceptualRoughness45_g1251 = 0;
				float2 texCoord15_g1317 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1320 = ( texCoord15_g1317 * _Tiling );
				float2 temp_cast_19 = (0.5).xx;
				float2 temp_output_12_0_g1321 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1320 - temp_cast_19 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1320 ));
				float Depth17_g1321 = _Depth;
				float3 viewDir17_g1321 = ase_tanViewDir;
				float2 uv17_g1321 = temp_output_12_0_g1321;
				SamplerState ss17_g1321 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1321 = MyCustomExpression17_g1321( Depth17_g1321 , viewDir17_g1321 , uv17_g1321 , ss17_g1321 );
				float2 temp_output_4_0_g1318 = (( _EnableParallax )?( localMyCustomExpression17_g1321 ):( temp_output_12_0_g1321 ));
				float2 inUV8_g1318 = temp_output_4_0_g1318;
				float2 temp_output_7_0_g1319 = ( ( temp_output_4_0_g1318 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1319 = dot( temp_output_7_0_g1319 , temp_output_7_0_g1319 );
				float ScaleMask8_g1318 = ( 1.0 - pow( saturate( dotResult2_g1319 ) , 0.15 ) );
				float Dilation8_g1318 = _Dilation;
				float2 localDilationnotexture8_g1318 = Dilationnotexture8_g1318( inUV8_g1318 , ScaleMask8_g1318 , Dilation8_g1318 );
				float2 temp_output_13_0_g1316 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1318 : temp_output_4_0_g1318 );
				float4 tex2DNode3_g1316 = SAMPLE_TEXTURE2D( _SpecGlossMap, sampler_Trilinear_Repeat_Aniso4, temp_output_13_0_g1316 );
				float temp_output_7_0_g1316 = ( tex2DNode3_g1316.a * _SpecColor.a * ( _Smoothness * _SmoothnessMult ) );
				float4 tex2DNode16_g1316 = SAMPLE_TEXTURE2D( _OverlaySpecular, sampler_Trilinear_Repeat_Aniso4, temp_output_13_0_g1316 );
				float Overlay_Alpha1136 = tex2DNode168_g1359.a;
				float temp_output_22_0_g1316 = Overlay_Alpha1136;
				float lerpResult20_g1316 = lerp( temp_output_7_0_g1316 , ( tex2DNode16_g1316.a * _OverlaySmoothness ) , temp_output_22_0_g1316);
				#ifdef _OVERLAY_ON
				float staticSwitch19_g1316 = lerpResult20_g1316;
				#else
				float staticSwitch19_g1316 = temp_output_7_0_g1316;
				#endif
				float Smoothness85 = staticSwitch19_g1316;
				float temp_output_22_0_g1251 = Smoothness85;
				float smoothness45_g1251 = temp_output_22_0_g1251;
				float roughness45_g1251 = 0;
				float roughness245_g1251 = 0;
				{
				perceptualRoughness45_g1251 = PerceptualSmoothnessToPerceptualRoughness(smoothness45_g1251);
				roughness45_g1251                      = max(PerceptualRoughnessToRoughness(perceptualRoughness45_g1251), HALF_MIN_SQRT);
				roughness245_g1251                    = max(roughness45_g1251 * roughness45_g1251, HALF_MIN);
				}
				float perceptualRoughness21_g1251 = perceptualRoughness45_g1251;
				float lerpResult6_g1263 = lerp( 1.0 , tex2DNode3_g1263.g , _SpecularOcclusion);
				float Specular_Occlusion130 = lerpResult6_g1263;
				float3 temp_cast_20 = (Specular_Occlusion130).xxx;
				float3 occlusion21_g1251 = temp_cast_20;
				float2 normalizedScreenSpaceUV21_g1251 = ase_grabScreenPosNorm.xy;
				float3 localGlossyEnvironmentReflection21_g1251 = GlossyEnvironmentReflection21_g1251( reflectVector21_g1251 , positionWS21_g1251 , perceptualRoughness21_g1251 , occlusion21_g1251 , normalizedScreenSpaceUV21_g1251 );
				float roughness42_g1251 = roughness45_g1251;
				float localSurfacereduction42_g1251 = Surfacereduction42_g1251( roughness42_g1251 );
				float3 temp_output_6_0_g1316 = (( tex2DNode3_g1316 * _SpecColor )).rgb;
				float4 lerpResult18_g1316 = lerp( float4( temp_output_6_0_g1316 , 0.0 ) , ( tex2DNode16_g1316 * _OverlaySpecularColor ) , temp_output_22_0_g1316);
				#ifdef _OVERLAY_ON
				float4 staticSwitch15_g1316 = lerpResult18_g1316;
				#else
				float4 staticSwitch15_g1316 = float4( temp_output_6_0_g1316 , 0.0 );
				#endif
				float lerpResult13_g1263 = lerp( 1.0 , tex2DNode3_g1263.b , _CavityStrength);
				float Cavity360 = ( 1.0 == _Cavity ? lerpResult13_g1263 : 1.0 );
				float4 temp_output_737_0 = ( staticSwitch15_g1316 * Cavity360 );
				float2 texCoord15_g1257 = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g1260 = ( texCoord15_g1257 * _Tiling );
				float2 temp_cast_25 = (0.5).xx;
				float2 temp_output_12_0_g1261 = (( _EnableUVScale )?( ( ( ( temp_output_1_0_g1260 - temp_cast_25 ) * _ScaleUV ) + 0.5 ) ):( temp_output_1_0_g1260 ));
				float Depth17_g1261 = _Depth;
				float3 viewDir17_g1261 = ase_tanViewDir;
				float2 uv17_g1261 = temp_output_12_0_g1261;
				SamplerState ss17_g1261 = sampler_Trilinear_Repeat_Aniso8;
				float2 localMyCustomExpression17_g1261 = MyCustomExpression17_g1261( Depth17_g1261 , viewDir17_g1261 , uv17_g1261 , ss17_g1261 );
				float2 temp_output_4_0_g1258 = (( _EnableParallax )?( localMyCustomExpression17_g1261 ):( temp_output_12_0_g1261 ));
				float2 inUV8_g1258 = temp_output_4_0_g1258;
				float2 temp_output_7_0_g1259 = ( ( temp_output_4_0_g1258 - float2( 0.5,0.5 ) ) / _DilationMaskRadius );
				float dotResult2_g1259 = dot( temp_output_7_0_g1259 , temp_output_7_0_g1259 );
				float ScaleMask8_g1258 = ( 1.0 - pow( saturate( dotResult2_g1259 ) , 0.15 ) );
				float Dilation8_g1258 = _Dilation;
				float2 localDilationnotexture8_g1258 = Dilationnotexture8_g1258( inUV8_g1258 , ScaleMask8_g1258 , Dilation8_g1258 );
				float2 temp_output_62_0_g1253 = ( 1.0 == _EyeDilation ? localDilationnotexture8_g1258 : temp_output_4_0_g1258 );
				float3x3 ase_worldToTangent = float3x3(WorldTangent,WorldBiTangent,WorldNormal);
				float3 worldToTangentDir6_g1253 = normalize( mul( ase_worldToTangent, SafeNormalize(_MainLightPosition.xyz)) );
				float2 appendResult4_g1253 = (float2(worldToTangentDir6_g1253.x , worldToTangentDir6_g1253.y));
				float2 temp_output_2_0_g1253 = ( temp_output_62_0_g1253 + ( appendResult4_g1253 * _IrisShadowDistance ) );
				float2 temp_output_7_0_g1256 = ( ( temp_output_2_0_g1253 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g1256 = dot( temp_output_7_0_g1256 , temp_output_7_0_g1256 );
				float3 temp_cast_26 = (( 1.0 - pow( saturate( dotResult2_g1256 ) , _IrisSelfShadowCircleHardness ) )).xxx;
				float2 temp_output_7_0_g1255 = ( ( temp_output_62_0_g1253 - float2( 0.5,0.5 ) ) / _IrisSelfShadowCircleRadius );
				float dotResult2_g1255 = dot( temp_output_7_0_g1255 , temp_output_7_0_g1255 );
				float3 tanNormal26_g1253 = Normal83;
				float3 worldNormal26_g1253 = float3(dot(tanToWorld0,tanNormal26_g1253), dot(tanToWorld1,tanNormal26_g1253), dot(tanToWorld2,tanNormal26_g1253));
				float dotResult27_g1253 = dot( SafeNormalize(_MainLightPosition.xyz) , worldNormal26_g1253 );
				float smoothstepResult31_g1253 = smoothstep( -0.31 , -0.02 , dotResult27_g1253);
				float temp_output_2_0_g1254 = ( _IrisShadowOpacity * ( 1.0 - pow( saturate( dotResult2_g1255 ) , _IrisSelfShadowCircleHardness ) ) * saturate( smoothstepResult31_g1253 ) );
				float temp_output_3_0_g1254 = ( 1.0 - temp_output_2_0_g1254 );
				float3 appendResult7_g1254 = (float3(temp_output_3_0_g1254 , temp_output_3_0_g1254 , temp_output_3_0_g1254));
				float temp_output_1187_0 = (( ( temp_cast_26 * temp_output_2_0_g1254 ) + appendResult7_g1254 )).x;
				float3 temp_cast_27 = (temp_output_1187_0).xxx;
				float3 temp_cast_28 = (0.0).xxx;
				float3 temp_cast_29 = (tex2DNode2_g1362.a).xxx;
				float3 temp_output_154_4_g1359 = (( _ScleraRing )?( temp_cast_29 ):( temp_cast_28 ));
				float3 Sclera_Ring_Alpha421 = temp_output_154_4_g1359;
				float lerpResult656 = lerp( temp_output_1187_0 , 1.0 , Sclera_Ring_Alpha421.x);
				float3 temp_cast_31 = (lerpResult656).xxx;
				float3 IrisShadow509 = (( _ScleraRing )?( temp_cast_31 ):( temp_cast_27 ));
				float3 temp_output_1031_0 = (( _IrisShadow )?( ( temp_output_737_0 * float4( IrisShadow509 , 0.0 ) ).rgb ):( temp_output_737_0.rgb ));
				float3 temp_output_425_0 = ( 1.0 - Sclera_Ring_Alpha421 );
				float3 temp_output_1033_0 = (( _ScleraRing )?( ( temp_output_1031_0 * temp_output_425_0 * temp_output_425_0 ) ):( temp_output_1031_0 ));
				float3 Specular87 = temp_output_1033_0;
				float3 temp_output_5_0_g1252 = Specular87;
				float4 appendResult9_g1252 = (float4(temp_output_5_0_g1252 , temp_output_22_0_g1251));
				float4 Specular7_g1252 = appendResult9_g1252;
				float3 tanNormal31_g1251 = normalizeResult33_g1251;
				float3 worldNormal31_g1251 = normalize( float3(dot(tanToWorld0,tanNormal31_g1251), dot(tanToWorld1,tanNormal31_g1251), dot(tanToWorld2,tanNormal31_g1251)) );
				float3 temp_output_3_0_g1252 = worldNormal31_g1251;
				float3 temp_output_4_0_g1252 = WorldViewDirection;
				float dotResult11_g1252 = dot( temp_output_3_0_g1252 , temp_output_4_0_g1252 );
				float NdotV7_g1252 = saturate( dotResult11_g1252 );
				float _FresnelIntensity7_g1252 = _FresnelIntensity;
				float3 temp_cast_34 = (Cavity360).xxx;
				float Cavity7_g1252 = temp_cast_34.x;
				float3 localFresnel7_g1252 = Fresnel7_g1252( Specular7_g1252 , NdotV7_g1252 , _FresnelIntensity7_g1252 , Cavity7_g1252 );
				float3 EnvironmentReflections721 = ( ( ( localGlossyEnvironmentReflection21_g1251 * localSurfacereduction42_g1251 ) * localFresnel7_g1252 ) * _EnvironmentReflectionsIntensity );
				float3 WorldPos708 = WorldPosition;
				float3 tanNormal710 = Normal83;
				float3 worldNormal710 = float3(dot(tanToWorld0,tanNormal710), dot(tanToWorld1,tanNormal710), dot(tanToWorld2,tanNormal710));
				float3 Normal708 = worldNormal710;
				float3 SpecColor708 = ( Specular87 * Cavity360 );
				float Smoothness708 = Smoothness85;
				float3 WorldView708 = WorldViewDirection;
				float2 texCoord1078 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV708 = texCoord1078;
				float3 localSpecularLightingFull708 = SpecularLightingFull708( WorldPos708 , Normal708 , SpecColor708 , Smoothness708 , WorldView708 , lightmapUV708 );
				float3 Specular_Highlight718 = ( localSpecularLightingFull708 * Specular_Occlusion130 * _SpecularHighlightIntensity );
				float temp_output_1204_0 = _SSS_DebugMode;
				float3 WorldPos2_g1384 = WorldPosition;
				float3 tanNormal1198 = Normal83;
				float3 worldNormal1198 = float3(dot(tanToWorld0,tanNormal1198), dot(tanToWorld1,tanNormal1198), dot(tanToWorld2,tanNormal1198));
				float3 temp_output_6_0_g1384 = worldNormal1198;
				float3 Normal2_g1384 = temp_output_6_0_g1384;
				float r2_g1384 = _DiffuseRoughness;
				float3 WorldView2_g1384 = WorldViewDirection;
				float2 texCoord7_g1384 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 lightmapUV2_g1384 = texCoord7_g1384;
				float2 texCoord9_g1384 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI8_g1384 = ASEBakedGI( temp_output_6_0_g1384, texCoord7_g1384, true);
				float3 GI2_g1384 = bakedGI8_g1384;
				float LightClamp2_g1384 = 100.0;
				float3 localLightingFull2_g1384 = LightingFull2_g1384( WorldPos2_g1384 , Normal2_g1384 , r2_g1384 , WorldView2_g1384 , lightmapUV2_g1384 , GI2_g1384 , LightClamp2_g1384 );
				float4 Albedo_for_Reflection_Probe1210 = temp_output_9_0_g1359;
				float GI_boost1219 = _GI;
				float2 texCoord1200 = IN.ase_texcoord8.zw * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord1201 = IN.ase_texcoord9.xy * float2( 1,1 ) + float2( 0,0 );
				float3 bakedGI1202 = ASEBakedGI( worldNormal1198, texCoord1200, true);
				float4 _SSS_Blur259 = tex2DNode1_g1359;
				float4 _SSS_LightPass258 = SAMPLE_TEXTURE2D( _SSS_LightPass, sampler_Trilinear_Clamp, ase_grabScreenPosNorm.xy );
				#ifdef _DEBUG_ON
				float4 staticSwitch1070 = ( 6.0 == temp_output_1204_0 ? ( ( float4( localLightingFull2_g1384 , 0.0 ) * ( Albedo_for_Reflection_Probe1210 * GI_boost1219 ) ) + float4( Specular_Highlight718 , 0.0 ) + ( float4( bakedGI1202 , 0.0 ) * ( Albedo_for_Reflection_Probe1210 * GI_boost1219 ) ) ) : ( 5.0 == temp_output_1204_0 ? float4( bakedGI1202 , 0.0 ) : ( 4.0 == temp_output_1204_0 ? _SSS_Blur259 : ( 3.0 == temp_output_1204_0 ? float4( EnvironmentReflections721 , 0.0 ) : ( 2.0 == temp_output_1204_0 ? float4( Specular_Highlight718 , 0.0 ) : ( 1.0 == temp_output_1204_0 ? _SSS_Blur259 : _SSS_LightPass258 ) ) ) ) ) );
				#else
				float4 staticSwitch1070 = ( ( float4( Diffuse110 , 0.0 ) * Occlusion89 ) + float4( EnvironmentReflections721 , 0.0 ) + float4( Specular_Highlight718 , 0.0 ) );
				#endif
				

				float3 BaseColor = Albedo112.rgb;
				float3 Normal = Normal83;
				float3 Emission = staticSwitch1070.rgb;
				float3 Specular = 0.5;
				float Metallic = 0;
				float Smoothness = 0.5;
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

			#pragma multi_compile_local_fragment __ _OVERLAY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);


			
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

			#pragma multi_compile_local_fragment __ _OVERLAY_ON
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
			float4 _TransmissionColor;
			float4 _SpecColor;
			float4 _OcclusionColor;
			float4 _OverlaySpecularColor;
			float4 _ProfileColor;
			float4 _Color;
			float _TravelDistancePointLights;
			float _Travel_Distance;
			float _Transmission_intensity;
			float _Transmission_Bias;
			float _IrisShadowDistance;
			float _Diffuseboost;
			float _TranslucencyDistanceFade;
			float _tsm_max;
			float _tsm_min;
			float _CancelMax;
			float _TravelDistanceMult;
			float _SSS_WorkflowMode;
			float _CorneaDepth;
			float _CancelMin;
			float _EnvironmentReflectionsIntensity;
			float _ScleraRing;
			float _ScaleUV;
			float _Tiling;
			float _EnableUVScale;
			float _EnableParallax;
			float _MicroShadowsOpacity;
			float _PrepareforGIbake;
			float _AlbedoInfluence;
			float _CorneaOpacity;
			float _CorneaMaskMax;
			float _CorneaMaskMin;
			float _CorneaSizeMax;
			float _CorneaSizeMin;
			float _DiffuseRoughness;
			float _GI;
			float _GradientMax;
			float _SpecularHighlightIntensity;
			float _StencilValue;
			float _FresnelIntensity;
			float _IrisSelfShadowCircleHardness;
			float _IrisSelfShadowCircleRadius;
			float _IrisShadowOpacity;
			float _DilationMaskHardness;
			float _DilationMaskRadius;
			float _Dilation;
			float _EyeDilation;
			float _Depth_Center;
			float _Depth;
			float _SpecularOcclusion;
			float _CavityStrength;
			float _Occlusionlightpass;
			float _LightClamp;
			float _Cavity;
			float _DetailNormalMapTile;
			float _DetailNormalIntensity;
			float _NormalIntensity;
			float _AlbedoOpacity;
			float _OverlaySmoothness;
			float _Smoothness;
			float _SmoothnessMult;
			float _Subsurface;
			float _Blur;
			float _EnableSubsurface;
			float _Transmission;
			float _MaskWithNormals;
			float _IrisShadow;
			float _GradientMin;
			float _Occlusionfinalpass;
			float _SSS_DebugMode;
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

			TEXTURE2D(_TransmissionGradient);
			SAMPLER(sampler_TransmissionGradient);
			TEXTURE2D(_OcclusionMap);
			SAMPLER(sampler_OcclusionMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			SAMPLER(sampler_SpecGlossMap);
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
			TEXTURE2D(_IrisDetailShadowMap);
			SAMPLER(sampler_IrisDetailShadowMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap1);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_OverlayAlbedo);
			SAMPLER(sampler_OverlayAlbedo);


			
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
	
	CustomEditor "SSS_URP.SSS_MaterialEditor"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;1080;-370.008,1106.29;Inherit;False;1979.066;2092.803;Comment;22;1202;1201;1200;1199;1198;1196;1169;1170;261;758;260;757;756;720;722;1203;1206;1208;1211;1207;1218;1217;Debug;0.654717,1,0.900964,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;826;-3559.687,95.62366;Inherit;False;422;474;Inspector;3;342;684;1081;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;740;-2714.47,2432.097;Inherit;False;1631.654;1253.971;Specular Highlight;14;708;718;731;730;729;713;714;715;716;90;712;710;709;1078;Specular Highlight;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;739;2111.165,1196.866;Inherit;False;289;213.8;Just for testing;2;725;724;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;736;2138.425,1428.564;Inherit;False;285;234;Kill Ambient;2;735;294;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;330;-3281.162,930.8612;Inherit;False;368.9976;100;MUST--> Pass Tags: LightMode: <None> to work in Deferred!!!;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;266;-3469.176,-842.4993;Inherit;False;595.4294;864.9869;Must be here to generate the properties;2;1219;1163;Shared parameters;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;246;2310.799,840.5842;Inherit;False;354;152.8;Turn ON to inject Albedo into GI calculation;1;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;126;-1488.427,115.1023;Inherit;False;2092.671;833.4029;Emission;12;721;205;719;374;114;373;361;215;207;212;206;733;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;61;-2866.708,-738.6234;Inherit;False;3560.018;749.8956;Texture input;15;469;468;656;425;422;509;417;85;529;423;470;87;738;1031;1137;Specular Data;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;111;-3116.264,1458.267;Inherit;False;1115.21;842.4526;Comment;9;1136;675;112;110;421;259;258;866;1210;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;108;-2628.034,479.4193;Inherit;False;518.688;220.7393;Comment;1;83;Normals;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;66;-2643.513,939.2572;Inherit;False;578.3468;333.7463;Occlusion;3;89;130;360;Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;470;-185.7287,-247.9832;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;-790.9999,-355.4987;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;529;-2805.847,-392.7971;Inherit;False;83;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;417;-1383.577,-480.3522;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;509;-1683.973,-414.7308;Inherit;False;IrisShadow;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;425;-1200.623,-222.629;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;469;-592.6277,-219.3833;Inherit;False;675;Iris Micro Shadows;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;-2354.186,1089.554;Inherit;False;Specular Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;360;-2350.102,1175.707;Inherit;False;Cavity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-2349.229,1011.862;Inherit;False;Occlusion;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;322;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;323;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;324;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;325;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;326;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormals;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;327;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;True;0;False;;255;False;;255;False;;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;328;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;329;790.2988,751.5161;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.StickyNoteNode;735;2186.425,1481.564;Inherit;False;181;164;;;1,0,0,1;Cancel ambient, since it comes already from Light pass;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;737;-1547.109,-629.2299;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;738;-1751.109,-551.2299;Inherit;False;360;Cavity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;709;-2428.072,2482.097;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;710;-2426.071,2637.096;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;712;-2658.47,2677.084;Inherit;False;83;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;90;-2071.913,2814.257;Inherit;False;130;Specular Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;716;-1624.969,2674.043;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;715;-2413.471,3104.085;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;713;-2664.47,2798.084;Inherit;False;87;Specular;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;729;-2631.233,2896.548;Inherit;False;360;Cavity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;730;-2399.234,2823.548;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;468;29.54244,-375.6852;Inherit;False;Property;_IrisMicroShadows;IrisMicroShadows;37;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;Fragment;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;731;-2050.675,2932.445;Inherit;False;Property;_SpecularHighlightIntensity;SpecularHighlightIntensity;102;0;Create;True;0;0;0;True;0;False;1;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;422;-2399.22,-142.5292;Inherit;False;421;Sclera Ring Alpha;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;87;-43.20871,-607.1618;Inherit;False;Specular;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;656;-2137.519,-227.5157;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1031;-1169.729,-630.4858;Inherit;False;Toggle IrisShadow;5;;664;afa7f85a60ebca04d9d1d2e0e9ea550e;0;2;3;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1033;-602.3444,-482.2697;Inherit;False;Toggle ScleraRing;7;;675;27e2f89b0c601184794ffae46d74611a;0;2;3;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1034;-1946.151,-297.0158;Inherit;False;Toggle ScleraRing;7;;676;27e2f89b0c601184794ffae46d74611a;0;2;3;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;708;-2069.461,2605.57;Inherit;False;return SpecularLightingFull(WorldPos, Normal, $SpecColor, Smoothness, WorldView, lightmapUV)@;3;Create;6;True;WorldPos;FLOAT3;0,0,0;In;;Inherit;False;True;Normal;FLOAT3;0,0,0;In;;Inherit;False;True;SpecColor;FLOAT3;0,0,0;In;;Inherit;False;True;Smoothness;FLOAT;0;In;;Inherit;False;True;WorldView;FLOAT3;0,0,0;In;;Inherit;False;True;lightmapUV;FLOAT2;0,0;In;;Inherit;False;SpecularLightingFull;True;False;0;;False;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;5;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1078;-2427.943,3371.98;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;206;-1309.283,462.2655;Inherit;False;85;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;-1341.591,618.3004;Inherit;False;83;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;-1382.279,536.8215;Inherit;False;130;Specular Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;215;-1344.133,693.6051;Inherit;False;87;Specular;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;361;-1337.958,781.7396;Inherit;False;360;Cavity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;205;303.717,467.6205;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;732;-473.0311,503.7661;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;721;-297.6163,497.3529;Inherit;False;EnvironmentReflections;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;719;41.31785,596.9714;Inherit;False;718;Specular Highlight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;54.54392,289.0824;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;-265.3644,217.7651;Inherit;False;110;Diffuse;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;374;-247.4563,323.0824;Inherit;False;89;Occlusion;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;320;1800.013,1138.33;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;113;2360.799,890.5836;Inherit;False;112;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;294;2217.146,1572.599;Inherit;False;Constant;_Float2;Float 2;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;724;2168.165,1246.866;Inherit;False;87;Specular;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;725;2161.165,1333.867;Inherit;False;85;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;2075.828,1051.967;Inherit;False;83;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;726;2205.073,1685.119;Inherit;False;130;Specular Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;820;2355.745,1076.642;Inherit;False;Constant;_Float1;Float 1;42;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;321;2740.063,1184.083;Float;False;True;-1;2;SSS_URP.SSS_MaterialEditor;0;12;SSS Object;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;True;True;True;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;True;True;True;0;True;_StencilValue;255;False;_StencilValue;255;False;_StencilValue;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=;False;False;2;Include;;False;;Native;False;0;0;;Include;Common.hlsl;False;;Custom;False;0;0;;;0;0;Standard;40;Workflow;0;638401455491889432;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;638401461778056554;Extra Pre Pass;0;0;DOTS Instancing;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;638401485206283443;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;0;Clear Coat;0;0;0;10;False;True;True;True;True;True;True;True;True;True;False;;True;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-2394.345,552.4193;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StickyNoteNode;1081;-3482.509,229.3689;Inherit;False;260;100;Editor name;;1,1,1,1;SSS_MaterialEditor;0;0
Node;AmplifyShaderEditor.RangedFloatNode;684;-3440.946,144.202;Inherit;False;Property;_SSS_WorkflowMode;WorkflowMode;103;0;Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;342;-3481.523,364.5172;Inherit;False;Property;_StencilValue;StencilValue;36;1;[IntRange];Create;True;0;0;0;True;0;False;1;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1137;-2557.073,-684.4205;Inherit;False;1136;Overlay Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1163;-3366.426,-796.1197;Inherit;True;Property;_TransmissionGradient;TransmissionGradient;4;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;b32de515c1a456243bbb09ea99b0fa2b;b32de515c1a456243bbb09ea99b0fa2b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;722;122.8485,1755.608;Inherit;False;721;EnvironmentReflections;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;720;91.05347,1515.25;Inherit;False;718;Specular Highlight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;756;323.9043,1306.938;Inherit;False;0;4;0;FLOAT;1;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;757;508.9044,1416.938;Inherit;False;0;4;0;FLOAT;2;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;260;4.275706,1409.485;Inherit;False;258;_SSS_LightPass;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;758;683.9044,1559.938;Inherit;False;0;4;0;FLOAT;3;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;39.94683,1319.02;Inherit;False;259;_SSS_Blur;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;714;-2445.471,3010.085;Inherit;False;85;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;-1956.287,-606.5863;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1180;-1067.372,511.2795;Inherit;False;GlossyEnvironmentReflection;9;;1251;1e7c1fa763860e14bace6e35d0b0b034;0;5;22;FLOAT;0.5;False;46;FLOAT;1;False;24;FLOAT3;0,0,1;False;26;FLOAT3;1,1,1;False;47;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1187;-2545.829,-342.8737;Inherit;False;FakeShadow;15;;1253;3932d1024f7e418439d796f08d8f40e9;0;5;30;FLOAT3;0,0,1;False;23;FLOAT;0;False;20;SAMPLER2D;0;False;19;FLOAT;1;False;18;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1188;-2593.242,1056.102;Inherit;False;Occlusion;200;;1263;fda21753bf015b5409b48b776edf6d06;0;0;4;COLOR;0;COLOR;17;FLOAT;5;FLOAT;12
Node;AmplifyShaderEditor.FunctionNode;1189;-2592.077,551.4408;Inherit;False;Normals;225;;1270;edf7abb8f1e0054499f2cbbdfb87b80b;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1192;-2293.788,-691.4227;Inherit;False;Specular Data;173;;1316;4ae1fe26604d3a842b5f4ef1a22e40fa;0;1;22;FLOAT;0;False;2;COLOR;0;FLOAT;1
Node;AmplifyShaderEditor.RangedFloatNode;733;-793.6397,584.5089;Inherit;False;Property;_EnvironmentReflectionsIntensity;EnvironmentReflectionsIntensity;101;0;Create;True;0;0;0;True;0;False;1;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1194;-3397.233,-607.8795;Inherit;False;SharedParameters;38;;1325;491c93288bd7b9949815d77536da7577;0;0;25;FLOAT;124;FLOAT;119;FLOAT;120;FLOAT;114;COLOR;24;FLOAT;35;FLOAT;127;FLOAT;36;FLOAT;37;FLOAT;44;COLOR;0;FLOAT;38;FLOAT;39;FLOAT;40;FLOAT;76;FLOAT;74;FLOAT;41;FLOAT;42;FLOAT;72;FLOAT;27;COLOR;29;FLOAT;30;COLOR;32;FLOAT;33;COLOR;34
Node;AmplifyShaderEditor.GetLocalVarNode;1170;528.2383,1790.296;Inherit;False;259;_SSS_Blur;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;1169;845.2531,1706.174;Inherit;False;0;4;0;FLOAT;4;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1070;1539.216,1408.222;Inherit;False;Property;_Debug;Debug;100;0;Create;True;0;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;Fragment;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1204;-246.8649,1539.724;Inherit;False;DebugMode;2;;1339;3f30ed554b982864b9d7771a34ca3477;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1196;1028.076,1812.506;Inherit;False;0;4;0;FLOAT;5;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;1203;1237.653,2057.692;Inherit;False;0;4;0;FLOAT;6;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;1198;-109.3714,2276.443;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;1199;-141.7724,2025.842;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BakedGINode;1202;152.8823,2313.783;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1206;458.7294,2598.504;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;718;-1448.558,2676.736;Inherit;False;Specular Highlight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1208;290.0294,2823.104;Inherit;False;718;Specular Highlight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;866;-3086.429,1804.484;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;-2394.57,2221.727;Inherit;False;_SSS_LightPass;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;-2397.57,2149.727;Inherit;False;_SSS_Blur;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;421;-2395.726,2074.388;Inherit;False;Sclera Ring Alpha;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-2386.041,1999.338;Inherit;False;Diffuse;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-2401.153,1709.649;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;675;-2401.47,1623.094;Inherit;False;Iris Micro Shadows;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1136;-2394.935,1523.088;Inherit;False;Overlay Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1210;-2394.408,1867.684;Inherit;False;Albedo for Reflection Probe;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1201;-145.4374,2563.479;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1200;-140.4374,2426.479;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1212;-2805.381,1802.934;Inherit;False;Diffuse MainPass;104;;1359;5a8455f12d4ea0e4d8bf97e65ef05fff;0;1;148;FLOAT2;0,0;False;8;FLOAT;170;FLOAT;107;COLOR;0;COLOR;171;FLOAT3;13;FLOAT3;33;COLOR;18;COLOR;21
Node;AmplifyShaderEditor.SimpleAddOpNode;1207;898.0295,2521.304;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1214;-300.0244,2297.072;Inherit;False;83;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1213;424.8498,2353.942;Inherit;False;DiffuseLighting;0;;1384;12daf9e505d347e46b046875d4f485a5;0;2;10;FLOAT;100;False;6;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1215;728.4047,2504.88;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;1216;80.40466,2822.88;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1211;-355.0502,2734.924;Inherit;False;1210;Albedo for Reflection Probe;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1218;-65.90527,2815.902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1219;-3095.162,-159.8753;Inherit;False;GI boost;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1221;-342.3708,2847.966;Inherit;False;1219;GI boost;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1217;-308.5953,2955.88;Inherit;False;Constant;_Float3;Float 3;64;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
WireConnection;470;0;1033;0
WireConnection;470;1;469;0
WireConnection;423;0;1031;0
WireConnection;423;1;425;0
WireConnection;423;2;425;0
WireConnection;417;0;737;0
WireConnection;417;1;509;0
WireConnection;509;0;1034;0
WireConnection;425;0;422;0
WireConnection;130;0;1188;5
WireConnection;360;0;1188;12
WireConnection;89;0;1188;17
WireConnection;737;0;1192;0
WireConnection;737;1;738;0
WireConnection;710;0;712;0
WireConnection;716;0;708;0
WireConnection;716;1;90;0
WireConnection;716;2;731;0
WireConnection;730;0;713;0
WireConnection;730;1;729;0
WireConnection;468;1;1033;0
WireConnection;468;0;470;0
WireConnection;87;0;1033;0
WireConnection;656;0;1187;0
WireConnection;656;2;422;0
WireConnection;1031;3;737;0
WireConnection;1031;2;417;0
WireConnection;1033;3;1031;0
WireConnection;1033;2;423;0
WireConnection;1034;3;1187;0
WireConnection;1034;2;656;0
WireConnection;708;0;709;0
WireConnection;708;1;710;0
WireConnection;708;2;730;0
WireConnection;708;3;714;0
WireConnection;708;4;715;0
WireConnection;708;5;1078;0
WireConnection;205;0;373;0
WireConnection;205;1;721;0
WireConnection;205;2;719;0
WireConnection;732;0;1180;0
WireConnection;732;1;733;0
WireConnection;721;0;732;0
WireConnection;373;0;114;0
WireConnection;373;1;374;0
WireConnection;321;0;113;0
WireConnection;321;1;84;0
WireConnection;321;2;1070;0
WireConnection;321;5;294;0
WireConnection;83;0;1189;0
WireConnection;756;1;1204;0
WireConnection;756;2;261;0
WireConnection;756;3;260;0
WireConnection;757;1;1204;0
WireConnection;757;2;720;0
WireConnection;757;3;756;0
WireConnection;758;1;1204;0
WireConnection;758;2;722;0
WireConnection;758;3;757;0
WireConnection;85;0;1192;1
WireConnection;1180;22;206;0
WireConnection;1180;46;207;0
WireConnection;1180;24;212;0
WireConnection;1180;26;215;0
WireConnection;1180;47;361;0
WireConnection;1187;30;529;0
WireConnection;1187;18;1194;74
WireConnection;1192;22;1137;0
WireConnection;1169;1;1204;0
WireConnection;1169;2;1170;0
WireConnection;1169;3;758;0
WireConnection;1070;1;205;0
WireConnection;1070;0;1203;0
WireConnection;1196;1;1204;0
WireConnection;1196;2;1202;0
WireConnection;1196;3;1169;0
WireConnection;1203;1;1204;0
WireConnection;1203;2;1207;0
WireConnection;1203;3;1196;0
WireConnection;1198;0;1214;0
WireConnection;1202;0;1199;0
WireConnection;1202;1;1198;0
WireConnection;1202;2;1200;0
WireConnection;1202;3;1201;0
WireConnection;1206;0;1202;0
WireConnection;1206;1;1216;0
WireConnection;718;0;716;0
WireConnection;258;0;1212;21
WireConnection;259;0;1212;18
WireConnection;421;0;1212;33
WireConnection;110;0;1212;13
WireConnection;112;0;1212;0
WireConnection;675;0;1212;107
WireConnection;1136;0;1212;170
WireConnection;1210;0;1212;171
WireConnection;1212;148;866;0
WireConnection;1207;0;1215;0
WireConnection;1207;1;1208;0
WireConnection;1207;2;1206;0
WireConnection;1213;6;1198;0
WireConnection;1215;0;1213;0
WireConnection;1215;1;1216;0
WireConnection;1216;0;1218;0
WireConnection;1218;0;1211;0
WireConnection;1218;1;1221;0
WireConnection;1219;0;1194;27
ASEEND*/
//CHKSM=BA63B4B62967E5CE25D848871E8C7D9C32E0BDD1