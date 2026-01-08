using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions.Fabric
{
    public sealed class FabricTranslucency : IFeature
    {
        private ShaderProperty _enableTranslucency = new(LitSurfaceOptionsProperties.EnableTranslucency);

        public void FindProperties(MaterialProperty[] properties) =>
            _enableTranslucency.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            editor.DrawToggle(FabricStyles.EnableTranslucency, _enableTranslucency.MaterialProperty, 1);

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.MaterialFeatureTranslucency, _enableTranslucency.IsToggleEnabled(material));
    }
}