using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public sealed class AdvancedOptions : ConstructedSection
    {
        public AdvancedOptions(IFeature[] features) : base(features, AdvancedOptionsStyles.Label)
        { }
    }
}