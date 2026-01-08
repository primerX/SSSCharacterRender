using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public sealed class SurfaceOptions : ConstructedSection
    {
        public SurfaceOptions(IFeature[] features) : base(features, SurfaceOptionsStyles.Label)
        { }
    }
}