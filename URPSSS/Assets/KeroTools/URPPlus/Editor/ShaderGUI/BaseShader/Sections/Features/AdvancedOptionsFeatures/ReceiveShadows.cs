using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class ReceiveShadows : IFeature
    {
        private ShaderProperty _receiveShadowsProperty = new(LitAdvancedOptionsProperties.ReceiveShadows);

        public void FindProperties(MaterialProperty[] properties) =>
            _receiveShadowsProperty.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawReceiveShadow(editor);

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.ReceiveShadowsOff, !_receiveShadowsProperty.IsToggleEnabled(material));

        private void DrawReceiveShadow(MaterialEditorGUIPlus editor) =>
            editor.DrawToggle(AdvancedOptionsStyles.ReceiveShadow, _receiveShadowsProperty.MaterialProperty,
                ToggleAlign.Right);
    }
}