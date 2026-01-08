using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace SSS_URP
{
    [System.Serializable]
    public class SSS_PassFeature : ScriptableRendererFeature
    {
        [System.Serializable]
        public class SSS_BlurSettings
        {           
            public RenderTextureFormat RT_Format = RenderTextureFormat.DefaultHDR;
            public RenderPassEvent renderPassEvent = RenderPassEvent.BeforeRenderingOpaques;
            public Material blurMaterial = null;
            public Material CopyLight;
            [Range(0, .1f)]
            public float Radius = .1f;

            [Range(0, 15)]
            public int blurPasses = 2;
            [Range(1, 15)]
            public int Iterations = 2;

            [Range(1, 4)]
            public int downsample = 1;

            [Range(0, 1)]
            public float Dither = .02f;
            [Range(0, 20)]
            public float DitherScale = 1;

            [Range(0, 1)]
            public float DepthTest = .02f;

            [Range(0, 1)]
            public float FixPixelLeak = .2f;

            public bool EnableProfileTest = true;

            [Range(0, 1)]
            public float ProfileColorTest = .02f;

            [Range(0, 1)]
            public float ProfileRadiusTest = .02f;

            public Texture NoiseTexture;

            public string targetName = "_SSS_Blur";

            public bool EnableNormalTest = false;

            [Range(0, 2)]
            public float NormalTest = 1;

            //Cascade thing
            public UniversalRenderPipelineAsset _RenderPipelineAsset;

            [Range(0, 1.2f)]
            public float CascadeWeight0 = 1;
            [Range(0, 1)]
            public float CascadeWeight1 = 0.537f;
            [Range(0, .3f)]
            public float CascadeWeight2 = 0.209f;
            [Range(0, .2f)]
            public float CascadeWeight3 = 0.158f;
            public float TranslucencyDistanceFade = 2000;


        }

        public SSS_BlurSettings settings = new SSS_BlurSettings();

        class CustomRenderPass : ScriptableRenderPass
        {
            public RenderTextureFormat RT_Format = RenderTextureFormat.DefaultHDR;
            public Material blurMaterial;
            public Material CopyLight = null;
            public Texture NoiseTexture;
            public float Dither;
            public float DitherScale;
            public float ProfileColorTest;
            public float ProfileRadiusTest;
            public bool EnableProfileTest = true;
            public bool EnableNormalTest;
            public float NormalTest;
            public float FixPixelLeak;

            public float Radius = 1;
            public float DepthTest = 10;
            public int blurPasses;
            public int Iterations;

            public int downsample;
            public string targetName;

            public UniversalRenderPipelineAsset _RenderPipelineAsset;


            public float CascadeWeight0 = 1;

            public float CascadeWeight1 = 0.537f;

            public float CascadeWeight2 = 0.209f;

            public float CascadeWeight3 = 0.158f;
            public float TranslucencyDistanceFade = 2000;

            Vector4 _CascadeWeights;
            string profilerTag;

            int tmpId1;
            int tmpId2;

            RenderTargetIdentifier tmpRT1;
            RenderTargetIdentifier tmpRT2;

            public CustomRenderPass(string profilerTag)
            {
                this.profilerTag = profilerTag;
            }

            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
            {
                var width = cameraTextureDescriptor.width / downsample;
                var height = cameraTextureDescriptor.height / downsample;

                tmpId1 = Shader.PropertyToID("tmpBlurRT1");
                tmpId2 = Shader.PropertyToID("tmpBlurRT2");

                cmd.GetTemporaryRT(tmpId1, width, height, 0, FilterMode.Trilinear, RT_Format);
                cmd.GetTemporaryRT(tmpId2, width, height, 0, FilterMode.Trilinear, RT_Format);

                tmpRT1 = new RenderTargetIdentifier(tmpId1);
                tmpRT2 = new RenderTargetIdentifier(tmpId2);

                //no sé qué hace esto
                //ConfigureTarget(tmpRT1);
                //ConfigureTarget(tmpRT2);

                //Tell the engine to generate _CameraNormalsTexture
                if (EnableNormalTest)
                    ConfigureInput(ScriptableRenderPassInput.Normal);


            }
            SSS SSS_volume;

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                SSS_volume = VolumeManager.instance.stack.GetComponent<SSS>();

                if (SSS_volume != null && SSS_volume.IsActive())
                {
                    Radius = SSS_volume.Radius.value;
                    blurPasses = SSS_volume.blurPasses.value;
                    Iterations = SSS_volume.Iterations.value;
                    downsample = SSS_volume.Downsample.value;
                    Dither = SSS_volume.Dither.value;
                    DitherScale = SSS_volume.DitherScale.value;
                    FixPixelLeak = SSS_volume.FixPixelLeak.value;
                    DepthTest = SSS_volume.DepthTest.value;
                    ProfileColorTest = SSS_volume.ProfileColorTest.value;
                    EnableProfileTest = SSS_volume.EnableProfileTest.value;
                    ProfileRadiusTest = SSS_volume.ProfileRadiusTest.value;
                    EnableNormalTest = SSS_volume.EnableNormalTest.value;
                    NormalTest = SSS_volume.NormalTest.value;

                }
                CommandBuffer cmd = CommandBufferPool.Get(profilerTag);

                RenderTextureDescriptor opaqueDesc = renderingData.cameraData.cameraTargetDescriptor;
                opaqueDesc.depthBufferBits = 0;



                blurMaterial.SetFloat("_SSS_NUM_SAMPLES", Iterations);
                blurMaterial.SetFloat("_DepthTest", 1.0f - DepthTest);
                blurMaterial.SetFloat("_Dither", Dither);
                blurMaterial.SetTexture("_NoiseTexture", NoiseTexture);
                blurMaterial.SetFloat("DitherScale", DitherScale);
                blurMaterial.SetFloat("ProfileColorTest", 1.0f - ProfileColorTest);
                blurMaterial.SetFloat("ProfileRadiusTest", 1.0f - ProfileRadiusTest);
                blurMaterial.SetFloat("_NormalTest", 1.0f - NormalTest);
                blurMaterial.SetFloat("_FixPixelLeak", 1.0f - FixPixelLeak);

                if (EnableProfileTest)
                    blurMaterial.EnableKeyword("PROFILE_TEST");
                else
                    blurMaterial.DisableKeyword("PROFILE_TEST");

                if (EnableNormalTest)
                    blurMaterial.EnableKeyword("NORMAL_TEST");
                else
                    blurMaterial.DisableKeyword("NORMAL_TEST");


                float FOV_compensation = 0;
                float fov = renderingData.cameraData.camera.fieldOfView;


                FOV_compensation = 60 / fov;
                //Share with other shaders. Tearline for example
                Shader.SetGlobalFloat("_FOV_compensation", FOV_compensation);

                cmd.Blit(null, tmpRT1, CopyLight);

                for (var i = 0; i < blurPasses; i++)
                {
                    blurMaterial.SetFloat("_offset", Radius * FOV_compensation);
                    cmd.Blit(tmpRT1, tmpRT2, blurMaterial);

                    // pingpong
                    var rttmp = tmpRT1;
                    tmpRT1 = tmpRT2;
                    tmpRT2 = rttmp;
                }

                cmd.Blit(tmpRT1, tmpRT2);
                cmd.SetGlobalTexture(targetName, tmpRT2);

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                CommandBufferPool.Release(cmd);

                //Cascade thing
                if (_RenderPipelineAsset)
                {


                    //float MaxDistance = _RenderPipelineAsset.shadowDistance * .01f;//maintain proportion
                    float MaxDistance = .1f;
                    //print(_RenderPipelineAsset.cascade4Split);
                    _CascadeWeights = new Vector4(
                        CascadeWeight0 * _RenderPipelineAsset.cascade4Split.x / MaxDistance
                       , CascadeWeight1 * _RenderPipelineAsset.cascade4Split.y / MaxDistance
                        , CascadeWeight2 * _RenderPipelineAsset.cascade4Split.z / MaxDistance
                        , CascadeWeight3 * _RenderPipelineAsset .cascadeBorder / MaxDistance);

                    //print(_CascadeWeights);

                    Shader.SetGlobalVector("_CascadeWeight", _CascadeWeights);
                    Shader.SetGlobalFloat("_TranslucencyDistanceFade", TranslucencyDistanceFade);
                }
            }

            public override void FrameCleanup(CommandBuffer cmd)
            {

            }

        }

        CustomRenderPass scriptablePass;
        public override void Create()
        {
            scriptablePass = new CustomRenderPass("SSS_Blur");

            //Override with Volume settings
            /*if (SSS_volume)
            {
                scriptablePass.Radius = SSS_volume.Radius.value;
              
            }
            else
            {
            }*/

            if (settings.blurMaterial == null)
                settings.blurMaterial = Resources.Load("SSS_Blur") as Material;

            if (settings.CopyLight == null)
                settings.CopyLight = Resources.Load("CopyLight") as Material;

            if (settings.NoiseTexture == null)
                settings.NoiseTexture = Resources.Load("bluenoise") as Texture2D;

            scriptablePass.Radius = settings.Radius;
            scriptablePass.blurMaterial = settings.blurMaterial;
            scriptablePass.CopyLight = settings.CopyLight;
            scriptablePass.blurPasses = settings.blurPasses;
            scriptablePass.DepthTest = settings.DepthTest;
            scriptablePass.Iterations = settings.Iterations;
            scriptablePass.downsample = settings.downsample;
            scriptablePass.targetName = settings.targetName;
            scriptablePass.renderPassEvent = settings.renderPassEvent;
            scriptablePass.NoiseTexture = settings.NoiseTexture;
            scriptablePass.Dither = settings.Dither;
            scriptablePass.DitherScale = settings.DitherScale;
            scriptablePass.RT_Format = settings.RT_Format;
            scriptablePass.ProfileColorTest = settings.ProfileColorTest;
            scriptablePass.ProfileRadiusTest = settings.ProfileRadiusTest;
            scriptablePass.EnableProfileTest = settings.EnableProfileTest;
            scriptablePass.EnableNormalTest = settings.EnableNormalTest;
            scriptablePass.NormalTest = settings.NormalTest;
            scriptablePass.FixPixelLeak = settings.FixPixelLeak;
            scriptablePass.CascadeWeight0 = settings.CascadeWeight0;
            scriptablePass.CascadeWeight1 = settings.CascadeWeight1;
            scriptablePass.CascadeWeight2 = settings.CascadeWeight2;
            scriptablePass.CascadeWeight3 = settings.CascadeWeight3;
            settings.TranslucencyDistanceFade = Mathf.Max(1, settings.TranslucencyDistanceFade);
            scriptablePass.TranslucencyDistanceFade = settings.TranslucencyDistanceFade;
            scriptablePass._RenderPipelineAsset = settings._RenderPipelineAsset;
        }

       
        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
                  
            renderer.EnqueuePass(scriptablePass);
        }
    }
}

