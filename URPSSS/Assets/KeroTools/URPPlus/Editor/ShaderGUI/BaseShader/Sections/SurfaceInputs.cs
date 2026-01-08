using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public sealed class SurfaceInputs : ConstructedSection
    {
        public SurfaceInputs(IFeature[] features) : base(features, SurfaceInputsStyles.Label)
        { }
    }
}