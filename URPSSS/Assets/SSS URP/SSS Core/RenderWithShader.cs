/*Replacement for RenderWithShader. Result is stored in RT*/

using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering;
using UnityEngine;

namespace SSS_URP
{
    public class RenderWithShader : ScriptableRendererFeature
    {
        public enum RenderQueueType
        {
            Opaque,
            Transparent,
            All,
        }

        [System.Serializable]
        public class RenderWithShaderSettings
        {
            //[Range(1, 50)] public int DummySlider = 10;

            [HideInInspector]
            public string passTag/* = "RenderWithShader"*/;
            public RenderPassEvent Event = RenderPassEvent.BeforeRenderingOpaques;
            public string targetName = "_TargetTexture";

            [HideInInspector]
            public string ReplacementShaderPassName;

            //[HideInInspector] public FilterSettings filterSettings = new FilterSettings();
            public LayerMask layer = new FilterSettings().LayerMask;
            public uint RenderingLayerMask = 1;
            public bool UseRenderingLayers = false;

            //public Material overrideMaterial = null;
            public Shader ReplacementShader = null;

            //[HideInInspector]
            //public int overrideMaterialPassIndex = 0;
            public RenderQueueType renderQueueType = RenderQueueType.All;
            public RenderTextureFormat RT_Format = RenderTextureFormat.DefaultHDR;


        }


        public class RenderWithShaderPass : ScriptableRenderPass
        {
            public string PassName;
            public string targetName;
            public RenderTextureFormat RT_Format = RenderTextureFormat.DefaultHDR;
            Color ClearColor;
            RTHandle RT;
            public bool UseRenderingLayers = false;

            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
            {
                var width = cameraTextureDescriptor.width;
                var height = cameraTextureDescriptor.height;
                cameraTextureDescriptor.depthBufferBits = 0;

                RT = RTHandles.Alloc(targetName, name: targetName);
                cmd.GetTemporaryRT(Shader.PropertyToID(RT.name), width, height, 24, FilterMode.Bilinear, RT_Format);
                ConfigureTarget(RT);

                // clear the screen with a specific color for the packed data
                //ConfigureClear(ClearFlag.All, ClearColor);
                ConfigureClear(ClearFlag.All, Color.black);
            }

            public override void FrameCleanup(CommandBuffer cmd)
            {
                cmd.ReleaseTemporaryRT(Shader.PropertyToID(RT.name));

            }

            RenderQueueType renderQueueType;
            FilteringSettings m_FilteringSettings;

            string m_ProfilerTag;
            ProfilingSampler m_ProfilingSampler;

            //public Material overrideMaterial { get; set; }
            public Shader PassShader { get; set; }

            //public int overrideMaterialPassIndex { get; set; }

            List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

            RenderStateBlock m_RenderStateBlock;

            public RenderWithShaderPass(string profilerTag, RenderPassEvent renderPassEvent, string[] shaderTags, RenderQueueType renderQueueType, int layerMask, uint renderingLayerMask, bool useRenderingLayers)
            {
                m_ProfilerTag = profilerTag;
                m_ProfilingSampler = new ProfilingSampler(profilerTag);
                this.renderPassEvent = renderPassEvent;
                this.renderQueueType = renderQueueType;
                //this.overrideMaterial = null;
                this.PassShader = null;
                this.UseRenderingLayers = useRenderingLayers;
                //this.overrideMaterialPassIndex = 0;
                //RenderQueueRange renderQueueRange = (renderQueueType == RenderQueueType.Transparent)
                //                                  ? RenderQueueRange.transparent
                //                                   : RenderQueueRange.opaque;
                //if (!UseRenderingLayers)
                //    renderingLayerMask = 1;

                //15.08.24 Haciendo la versión de EF corrijo el eliminar la renderingLayerMask
                switch (renderQueueType)
                {
                    case RenderQueueType.Transparent:
                        if (UseRenderingLayers)
                            m_FilteringSettings = new FilteringSettings(RenderQueueRange.transparent, layerMask, renderingLayerMask);
                        else
                            m_FilteringSettings = new FilteringSettings(RenderQueueRange.transparent, layerMask);

                        break;

                    case RenderQueueType.Opaque:
                        if (UseRenderingLayers)
                            m_FilteringSettings = new FilteringSettings(RenderQueueRange.opaque, layerMask, renderingLayerMask);
                        else
                            m_FilteringSettings = new FilteringSettings(RenderQueueRange.opaque, layerMask);

                        break;

                    case RenderQueueType.All:
                        if (UseRenderingLayers)
                            m_FilteringSettings = new FilteringSettings(null, layerMask, renderingLayerMask);
                        else
                            m_FilteringSettings = new FilteringSettings(null, layerMask);


                        break;
                }


                if (shaderTags != null && shaderTags.Length > 0)
                {
                    foreach (var passName in shaderTags)
                        m_ShaderTagIdList.Add(new ShaderTagId(passName));
                }
                else
                {
                    m_ShaderTagIdList.Add(new ShaderTagId("UniversalForward"));
                    m_ShaderTagIdList.Add(new ShaderTagId("LightweightForward"));
                    m_ShaderTagIdList.Add(new ShaderTagId("SRPDefaultUnlit"));
                }

                m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

                //Debug.Log("UseRenderingLayers: " + UseRenderingLayers);

            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                SortingCriteria sortingCriteria = (renderQueueType == RenderQueueType.Transparent)
                    ? SortingCriteria.CommonTransparent
                    : renderingData.cameraData.defaultOpaqueSortFlags;

                ClearColor = renderingData.cameraData.camera.backgroundColor;
                DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
                drawingSettings.overrideShader = PassShader;

                CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);

                using (new ProfilingScope(cmd, m_ProfilingSampler))
                {
                    //context.ExecuteCommandBuffer(cmdProfile);
                    //cmdProfile.Clear();

                    context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings, ref m_RenderStateBlock);

                }
                //Debug.Log("m_RenderingLayerMask: " + m_FilteringSettings.renderingLayerMask);

                cmd.SetGlobalTexture(targetName, RT);

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                CommandBufferPool.Release(cmd);
            }
        }

        [System.Serializable]
        public class FilterSettings
        {
            // TODO: expose opaque, transparent, all ranges as drop down
            public RenderQueueType RenderQueueType;
            public LayerMask LayerMask;
            public uint RenderingLayerMask = 1;
            public string[] PassNames;

            public FilterSettings()
            {
                RenderQueueType = RenderQueueType.All;
                LayerMask = 0;
                RenderingLayerMask = 0;
            }
        }

        public RenderWithShaderSettings settings = new RenderWithShaderSettings();

        RenderWithShaderPass ReplacementShaderPass;

        public override void Create()
        {
            settings.passTag = settings.targetName;

            ReplacementShaderPass = new RenderWithShaderPass(settings.passTag, settings.Event, null, settings.renderQueueType, settings.layer, settings.RenderingLayerMask, settings.UseRenderingLayers);

            ReplacementShaderPass.PassShader = settings.ReplacementShader;

            ReplacementShaderPass.UseRenderingLayers = settings.UseRenderingLayers;


            ReplacementShaderPass.PassName = settings.targetName;
            ReplacementShaderPass.targetName = settings.targetName;
            ReplacementShaderPass.RT_Format = settings.RT_Format;
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            renderer.EnqueuePass(ReplacementShaderPass);
        }
    }
}