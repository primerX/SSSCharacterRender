using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class SubsurfaceLightingPass : ScriptableRenderPass
{

    public RenderTextureFormat RT_Format = RenderTextureFormat.DefaultHDR;

    RTHandle RT;
    private Shader PassShader;

    ProfilingSampler m_ProfilingSampler;

    FilteringSettings m_FilteringSettings;
    RenderStateBlock m_RenderStateBlock;

    List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

    public SubsurfaceLightingPass(String passName, Shader shader, int layerMask)
    {
        PassShader = shader;

        m_ProfilingSampler = new ProfilingSampler("SubsurfaceLightingPass");
    

        m_FilteringSettings = new FilteringSettings(RenderQueueRange.opaque, layerMask);
        m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

        m_ShaderTagIdList.Add(new ShaderTagId("UniversalForward"));
        m_ShaderTagIdList.Add(new ShaderTagId("LightweightForward"));
        m_ShaderTagIdList.Add(new ShaderTagId("SRPDefaultUnlit"));
    }

    public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
    {
        var width = cameraTextureDescriptor.width;
        var height = cameraTextureDescriptor.height;
        cameraTextureDescriptor.depthBufferBits = 0;

        RT = RTHandles.Alloc("_SSS_LightPass", name: "_SSS_LightPass");
        cmd.GetTemporaryRT(Shader.PropertyToID(RT.name), width, height, 24, FilterMode.Bilinear, RT_Format);
        ConfigureTarget(RT);

        ConfigureClear(ClearFlag.All, Color.black);
    }

    public override void FrameCleanup(CommandBuffer cmd)
    {
        cmd.ReleaseTemporaryRT(Shader.PropertyToID(RT.name));
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        SortingCriteria sortingCriteria = renderingData.cameraData.defaultOpaqueSortFlags;
                
        DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
        drawingSettings.overrideShader = PassShader;

        CommandBuffer cmd = CommandBufferPool.Get();
        using (new ProfilingScope(cmd, m_ProfilingSampler))
        {
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear(); // 执行完必须 Clear，否则下次 Execute 会重复执行 BeginSample

            context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings, ref m_RenderStateBlock);
            cmd.SetGlobalTexture("_SSS_LightPass", RT);
        }

        context.ExecuteCommandBuffer(cmd);
        CommandBufferPool.Release(cmd);
    }

    public void Dispose()
    {
        
    }
}
