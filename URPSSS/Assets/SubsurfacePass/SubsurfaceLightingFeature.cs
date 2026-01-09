using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class SubsurfaceLightingFeature : ScriptableRendererFeature
{
    public string passName; 
    public Shader shader;
    public RenderPassEvent passEvent = RenderPassEvent.BeforeRenderingOpaques;
    [Range(-10, 10)]
    public int queueOffset = 0;
    public LayerMask layerMask = 0;

    private SubsurfaceLightingPass lightingPass;

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        lightingPass.renderPassEvent = passEvent + queueOffset;
        renderer.EnqueuePass(lightingPass);
    }

    public override void Create()
    {
        lightingPass = new SubsurfaceLightingPass(passName, shader, layerMask);

    }

    protected override void Dispose(bool disposing)
    {
        lightingPass?.Dispose();
        lightingPass = null;
    }
}
