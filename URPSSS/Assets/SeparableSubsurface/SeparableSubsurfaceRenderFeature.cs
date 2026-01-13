using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class SeparableSubsurfaceRenderFeature : ScriptableRendererFeature
{
    public Shader shader;

    public Material copyLightMat;

    public RenderPassEvent renderPassEvent = RenderPassEvent.AfterRenderingOpaques;

    private SeparableSubsurfacePass pass;

    public override void Create()
    {
        pass = new SeparableSubsurfacePass(shader, copyLightMat);
        pass.renderPassEvent = renderPassEvent;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (shader == null)
        {
            Debug.LogWarning("shader is missing!");
            return;
        }

        renderer.EnqueuePass(pass);
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;

    }
}
