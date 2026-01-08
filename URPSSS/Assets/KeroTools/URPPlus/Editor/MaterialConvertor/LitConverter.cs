using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using UnityEditor.Rendering;

namespace KeroTools.URPPlus.Editor.MaterialConvertor
{
    public class LitConverter : MaterialUpgrader
    {
        public LitConverter(string sourceShaderName, string destShaderName, MaterialFinalizer finalizer = null)
        {
            RenameShader(sourceShaderName, destShaderName, finalizer);
            ConvertSurfaceInputs();
            ConvertDetailInputs();
        }

        private void ConvertSurfaceInputs()
        {
            RenameFloat("_AlphaClip", "_AlphaCutoffEnable");
            RenameFloat("_Cutoff", "_AlphaCutoff");

            RenameTexture("_MetallicGlossMap", LitSurfaceInputsProperties.MaskMap);
            RenameTexture("_BumpMap", LitSurfaceInputsProperties.NormalMap);
            RenameFloat("_BumpScale", LitSurfaceInputsProperties.NormalScale);

            RenameTexture("_ParallaxMap", DisplacementProperties.HeightMap);
        }

        private void ConvertDetailInputs()
        {
            RenameTexture("_DetailNormalMap", DetailInputsProperties.DetailMap);
            RenameFloat("_DetailAlbedoMapScale", DetailInputsProperties.DetailAlbedoScale);
            RenameFloat("_DetailNormalMapScale", DetailInputsProperties.DetailNormalScale);
        }
    }
}