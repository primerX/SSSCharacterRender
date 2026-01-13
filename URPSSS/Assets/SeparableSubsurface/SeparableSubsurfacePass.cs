using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class SeparableSubsurfacePass : ScriptableRenderPass
{
    [Range(0,6)]
	public float SubsurfaceScaler = 0.25f;
    public Color SubsurfaceColor;
    public Color SubsurfaceFalloff;

    public int SamplerSteps;

	private Material SubsurfaceMat = null;

    public Material CopyLight = null;

    SeparableSSSVolume SSSS_volume;

	private List<Vector4> KernelArray = new List<Vector4>();

	static int Kernel = Shader.PropertyToID("_Kernel");
    static int SSSScaler = Shader.PropertyToID("_SSSScale");

    private RTHandle blurTexture1;
    private RTHandle blurTexture2;

    protected ProfilingSampler m_ProfilingSampler;

    public SeparableSubsurfacePass(Shader shader, Material mat)
    {
		SubsurfaceMat = CoreUtils.CreateEngineMaterial(shader);
        m_ProfilingSampler = new ProfilingSampler("SeparableSubsurfacePass");

        CopyLight = mat;
    }


    public override void Configure(CommandBuffer cmd,  RenderTextureDescriptor cameraTextureDescriptor)
    {
        RenderTextureDescriptor descriptor = cameraTextureDescriptor;
        descriptor.msaaSamples = 1;
        descriptor.depthBufferBits = 0;
        descriptor.colorFormat = RenderTextureFormat.DefaultHDR;

        RenderingUtils.ReAllocateIfNeeded(ref blurTexture1, descriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, name: "blurTexture1");
        RenderingUtils.ReAllocateIfNeeded(ref blurTexture2, descriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, name: "blurTexture2");
    
        // cmd.SetGlobalTexture(XblurTexture.name, XblurTexture.nameID);
    
        ConfigureTarget(blurTexture2);
        // ConfigureClear(ClearFlag.None, Color.white);
        ConfigureClear(ClearFlag.All, Color.black);
        
    }

    public void SetKernel()
    {

        SSSS_volume = VolumeManager.instance.stack.GetComponent<SeparableSSSVolume>();
        if (SSSS_volume != null && SSSS_volume.IsActive())
        {
            SubsurfaceScaler = SSSS_volume.SubsurfaceScaler.value;
            SubsurfaceColor = SSSS_volume.SubsurfaceColor.value;
            SubsurfaceFalloff = SSSS_volume.SubsurfaceFalloff.value;
        }

        Vector3 SSSC = Vector3.Normalize(new Vector3 (SubsurfaceColor.r, SubsurfaceColor.g, SubsurfaceColor.b));
		Vector3 SSSFC = Vector3.Normalize(new Vector3 (SubsurfaceFalloff.r, SubsurfaceFalloff.g, SubsurfaceFalloff.b));
		// SeparableSSS.CalculateKernel(KernelArray, SamplerSteps, SSSC, SSSFC);
		SeparableSSS.CalculateKernel(KernelArray, 11, SSSC, SSSFC);

        SubsurfaceMat.SetVectorArray (Kernel, KernelArray);
		SubsurfaceMat.SetFloat (SSSScaler, SubsurfaceScaler);
		SubsurfaceMat.SetInt (Shader.PropertyToID("_SamplerSteps"), SamplerSteps);
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        var cmd = CommandBufferPool.Get();
        using (new ProfilingScope(cmd, m_ProfilingSampler))
        {
            SetKernel();

            cmd.Blit(null, blurTexture1, CopyLight);

            cmd.SetGlobalTexture("_MainTex", blurTexture1);
            cmd.Blit(blurTexture1, blurTexture2, SubsurfaceMat, 0);
            // cmd.SetGlobalTexture("_MainTex", XblurTexture);
            cmd.Blit(blurTexture2, blurTexture1, SubsurfaceMat, 1);

            cmd.SetGlobalTexture("_SSS_Blur", blurTexture1);


            // --------------------------------
            // CoreUtils.SetKeyword(SubsurfaceMat, "_FIRST_BLUR", true);

            // cmd.Blit(null, blurTexture1, SubsurfaceMat, 0);

            // // cmd.Blit(blurTexture1, blurTexture2, SubsurfaceMat, 1);

            // cmd.SetGlobalTexture("_SSS_Blur", blurTexture1);
        }

        context.ExecuteCommandBuffer(cmd);
        CommandBufferPool.Release(cmd);
    }

    public void Dispose()
    {
        blurTexture1?.Release();
        blurTexture2?.Release();
    }

}
