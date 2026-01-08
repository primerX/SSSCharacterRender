Shader "Hidden/SSS_Blur"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}

		SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile _ PROFILE_TEST
			#pragma multi_compile _ NORMAL_TEST

			#include "UnityCG.cginc"
			#include "SSS_Common.hlsl"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				//UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _NoiseTexture;
			sampler2D _SSS_LightPass;
			sampler2D _CameraDepthTexture;
			sampler2D _CameraNormalsTexture;
			sampler2D _CameraDepthNormalsTexture;
			sampler2D _SSS_ProfilePass;
			int _SSS_NUM_SAMPLES = 10;

			float4 _MainTex_TexelSize;
			float4 _MainTex_ST;

			float _offset;
			float _Dither;
			float DitherScale;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			fixed4 frag(v2f input) : SV_Target
			{
				float2 uv = input.uv;
				float4 profile = max(1e-6, tex2D(_SSS_ProfilePass, uv));
				float4 p1, p2, p3, p4;
				float4 n0 = tex2D(_CameraNormalsTexture, uv);
				float4 n1, n2, n3, n4;
				float  centerDepth = tex2D(_CameraDepthTexture, uv).r;
				float  d0 = LinearEyeDepth(centerDepth);

				float2 res = _MainTex_TexelSize.xy;
				//float i = _offset;
				float scale = _offset * (1.0 / d0);
				scale *= profile.a;
				float3 weight;
				float3 weightSum = 0.0f;
				float EdgeTest = 0;
				float DebugNormalTest = 1;
				float d1, d2, d3, d4;
				fixed4 col = 0;
				
				scale = min(.2, scale);//Limit radius going crazy
				if (scale > 0.0)
				for (int k = 0; k < _SSS_NUM_SAMPLES; k++)
				{
					float step = (float)k / _SSS_NUM_SAMPLES;
					float2 offset = (float2)step * (float2)scale;

					//Dither
					float2 random = RandN2(1, tex2Dlod(_NoiseTexture, float4(uv / float2(1, res.y / res.x) * DitherScale.xx + _Time.xx * 200, 0, 0)).xy) * 2.0 - 1.0;

					float2x2 RotationMatrix = float2x2(random.x, random.y, -random.y, random.x);
					float2x2 identityMatrix = float2x2(1.0, 0.0, 0.0, 1.0);
					float2x2 tapMatrix = identityMatrix;
					tapMatrix = RotationMatrix;
					offset = mul(offset, tapMatrix);
					offset = lerp(step * scale, offset, _Dither);
					//


					//Depth test
					d1 = LinearEyeDepth(tex2Dlod(_CameraDepthTexture, float4(uv + float2(offset.x, offset.y), 0, 0)).r);
					d2 = LinearEyeDepth(tex2Dlod(_CameraDepthTexture, float4(uv + float2(offset.x, -offset.y), 0, 0)).r);
					d3 = LinearEyeDepth(tex2Dlod(_CameraDepthTexture, float4(uv + float2(-offset.x, offset.y), 0, 0)).r);
					d4 = LinearEyeDepth(tex2Dlod(_CameraDepthTexture, float4(uv + float2(-offset.x, -offset.y), 0, 0)).r);

					float DepthTest1 = DepthTest(d0, d1);
					float DepthTest2 = DepthTest(d0, d2);
					float DepthTest3 = DepthTest(d0, d3);
					float DepthTest4 = DepthTest(d0, d4);

					float EdgeTest1 = DepthTest1;
					float EdgeTest2 = DepthTest2;
					float EdgeTest3 = DepthTest3;
					float EdgeTest4 = DepthTest4;

					//Profile test
					#ifdef PROFILE_TEST
						p1 = tex2Dlod(_SSS_ProfilePass, saturate(float4(uv + float2(offset.x, offset.y), 0, 0)));
						p2 = tex2Dlod(_SSS_ProfilePass, saturate(float4(uv + float2(offset.x, -offset.y), 0, 0)));
						p3 = tex2Dlod(_SSS_ProfilePass, saturate(float4(uv + float2(-offset.x, offset.y), 0, 0)));
						p4 = tex2Dlod(_SSS_ProfilePass, saturate(float4(uv + float2(-offset.x, -offset.y), 0, 0)));

						float Profile1 = ProfileTest(profile, p1);
						float Profile2 = ProfileTest(profile, p2);
						float Profile3 = ProfileTest(profile, p3);
						float Profile4 = ProfileTest(profile, p4);

						EdgeTest1 *= Profile1;
						EdgeTest2 *= Profile2;
						EdgeTest3 *= Profile3;
						EdgeTest4 *= Profile4;

					#endif

						//Normal test
						#ifdef NORMAL_TEST
							n1 = tex2Dlod(_CameraNormalsTexture, saturate(float4(uv + float2(offset.x, offset.y), 0, 0)));
							n2 = tex2Dlod(_CameraNormalsTexture, saturate(float4(uv + float2(offset.x, -offset.y), 0, 0)));
							n3 = tex2Dlod(_CameraNormalsTexture, saturate(float4(uv + float2(-offset.x, offset.y), 0, 0)));
							n4 = tex2Dlod(_CameraNormalsTexture, saturate(float4(uv + float2(-offset.x, -offset.y), 0, 0)));

							float NormalCheck1 = NormalTest(n0, n1);
							float NormalCheck2 = NormalTest(n0, n2);
							float NormalCheck3 = NormalTest(n0, n3);
							float NormalCheck4 = NormalTest(n0, n4);

							EdgeTest1 *= NormalCheck1;
							EdgeTest2 *= NormalCheck2;
							EdgeTest3 *= NormalCheck3;
							EdgeTest4 *= NormalCheck4;

							DebugNormalTest = NormalCheck1;
							DebugNormalTest *= NormalCheck2;
							DebugNormalTest *= NormalCheck3;
							DebugNormalTest *= NormalCheck4;
						#endif

						float3 weight = exp(-Pow2(step / profile));
						weightSum += weight;

						//Fix pixel leaks by decreasing the offset value
						float OffsetConstrain = _FixPixelLeak;
						float2 Offset1 = float2(offset.x * EdgeTest1, offset.y * EdgeTest1) * OffsetConstrain;
						float2 Offset2 = float2(offset.x * EdgeTest2, -offset.y * EdgeTest2) * OffsetConstrain;
						float2 Offset3 = float2(-offset.x * EdgeTest3, offset.y * EdgeTest3) * OffsetConstrain;
						float2 Offset4 = float2(-offset.x * EdgeTest4, -offset.y * EdgeTest4) * OffsetConstrain;

						col.rgb += tex2Dlod(_MainTex, saturate(float4(uv + Offset1, 0, 0))).rgb * weight * .25;
						col.rgb += tex2Dlod(_MainTex, saturate(float4(uv + Offset2, 0, 0))).rgb * weight * .25;
						col.rgb += tex2Dlod(_MainTex, saturate(float4(uv + Offset3, 0, 0))).rgb * weight * .25;
						col.rgb += tex2Dlod(_MainTex, saturate(float4(uv + Offset4, 0, 0))).rgb * weight * .25;
						//col.rgb = tex2Dlod(_MainTex, saturate(float4(uv, 0, 0))).rgb;

					}
					col.rgb = max(1e-6, col.rgb / weightSum);
					//col.rgb = tex2Dlod(_MainTex, saturate(float4(uv, 0, 0))).rgb;
					//return EdgeTest;
					//col.rgb = DecodeNormal(tex2D(_CameraDepthNormalsTexture, uv));
					//return DebugNormalTest;
					return col;
				}
				ENDCG
			}
	}
}
