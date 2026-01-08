using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Data
{
    public struct TransparentBlendValues
    {
        public BlendMode SrcBlendRGB;
        public BlendMode DstBlendRGB;
        public BlendMode SrcBlendAlpha;
        public BlendMode DstBlendAlpha;

        public void SetupOpaque()
        {
            SrcBlendRGB = BlendMode.One;
            DstBlendRGB = BlendMode.Zero;
            SrcBlendAlpha = BlendMode.One;
            DstBlendAlpha = BlendMode.Zero;
        }
        
        public void SetupTransparentAlpha()
        {
            SrcBlendRGB = BlendMode.SrcAlpha;
            DstBlendRGB = BlendMode.OneMinusSrcAlpha;
            SrcBlendAlpha = BlendMode.One;
            DstBlendAlpha = DstBlendRGB;
        }
        
        public void SetupTransparentPremultiply()
        {
            SrcBlendRGB = BlendMode.One;
            DstBlendRGB = BlendMode.OneMinusSrcAlpha;
            SrcBlendAlpha = SrcBlendRGB;
            DstBlendAlpha = DstBlendRGB;
        }
        
        public void SetupTransparentAdditive()
        {
            SrcBlendRGB = BlendMode.SrcAlpha;
            DstBlendRGB = BlendMode.One;
            SrcBlendAlpha = BlendMode.One;
            DstBlendAlpha = DstBlendRGB;
        }
        
        public void SetupTransparentMultiply()
        {
            SrcBlendRGB = BlendMode.DstColor;
            DstBlendRGB = BlendMode.Zero;
            SrcBlendAlpha = BlendMode.Zero;
            DstBlendAlpha = BlendMode.One;
        }
    }
}