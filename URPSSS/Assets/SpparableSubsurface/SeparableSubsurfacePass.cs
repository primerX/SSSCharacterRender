using System.Collections;
using System.Collections.Generic;
using SSS_URP;
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

    SSS SSS_volume;

	private List<Vector4> KernelArray = new List<Vector4>();

	static int Kernel = Shader.PropertyToID("_Kernel");
    static int SSSScaler = Shader.PropertyToID("_SSSScale");

    private RTHandle blurTexture1;
    private RTHandle blurTexture2;

    protected ProfilingSampler executeSampler;
    private ScriptableRenderer m_Renderer = null;

    public SeparableSubsurfacePass(Shader shader, Material mat)
    {
		SubsurfaceMat = new Material(shader);
        executeSampler = new ProfilingSampler("SeparableSubsurfacePass");

        CopyLight = mat;
    }

    internal bool Setup(ref ScriptableRenderer renderer)
    {
        m_Renderer = renderer;

        return SubsurfaceMat != null;
    }

    public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
    {
        RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
        RenderTextureDescriptor descriptor = cameraTargetDescriptor;
        descriptor.msaaSamples = 1;
        descriptor.depthBufferBits = 0;
        descriptor.colorFormat = RenderTextureFormat.DefaultHDR;

        RenderingUtils.ReAllocateIfNeeded(ref blurTexture1, descriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, name: "blurTexture1");
        RenderingUtils.ReAllocateIfNeeded(ref blurTexture2, descriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, name: "blurTexture2");
    
        // cmd.SetGlobalTexture(XblurTexture.name, XblurTexture.nameID);
    
        ConfigureTarget(blurTexture2);
        ConfigureClear(ClearFlag.None, Color.white);
    }

    public void SetKernel()
    {

        SSS_volume = VolumeManager.instance.stack.GetComponent<SSS>();
        if (SSS_volume != null && SSS_volume.IsActive())
        {
            SubsurfaceScaler = SSS_volume.SubsurfaceScaler.value;
            SubsurfaceColor = SSS_volume.SubsurfaceColor.value;
            SubsurfaceFalloff = SSS_volume.SubsurfaceFalloff.value;
            SamplerSteps = SSS_volume.SamplerSteps.value;
        }

        Vector3 SSSC = Vector3.Normalize(new Vector3 (SubsurfaceColor.r, SubsurfaceColor.g, SubsurfaceColor.b));
		Vector3 SSSFC = Vector3.Normalize(new Vector3 (SubsurfaceFalloff.r, SubsurfaceFalloff.g, SubsurfaceFalloff.b));
		// SeparableSSS.CalculateKernel(KernelArray, SamplerSteps, SSSC, SSSFC);
		SeparableSSS.CalculateKernel(KernelArray, 11, SSSC, SSSFC);

        SubsurfaceMat.SetVectorArray (Kernel, KernelArray);
		SubsurfaceMat.SetFloat (SSSScaler, SubsurfaceScaler);
		SubsurfaceMat.SetInt (Shader.PropertyToID("_SamplerSteps"), SamplerSteps);
    }

    // 配置 RenderTarget (这里我们主要是在 Execute 里申请临时 RT，所以 Configure 可以留空或做简单配置)
    public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
    {
        
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        var cmd = CommandBufferPool.Get();
        using (new ProfilingScope(cmd, executeSampler))
        {
            SetKernel();

            // cmd.Blit(null, blurTexture1, CopyLight);

            // cmd.SetGlobalTexture("_MainTex", blurTexture1);
            // cmd.Blit(blurTexture1, blurTexture2, SubsurfaceMat, 0);
            // // cmd.SetGlobalTexture("_MainTex", XblurTexture);
            // cmd.Blit(blurTexture2, blurTexture1, SubsurfaceMat, 1);

            // cmd.SetGlobalTexture("_SSS_Blur", blurTexture1);


            // --------------------------------
            CoreUtils.SetKeyword(SubsurfaceMat, "_FIRST_BLUR", true);

            cmd.Blit(null, blurTexture1, SubsurfaceMat, 0);

            cmd.Blit(blurTexture1, blurTexture2, SubsurfaceMat, 1);

            cmd.SetGlobalTexture("_SSS_Blur", blurTexture2);
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
