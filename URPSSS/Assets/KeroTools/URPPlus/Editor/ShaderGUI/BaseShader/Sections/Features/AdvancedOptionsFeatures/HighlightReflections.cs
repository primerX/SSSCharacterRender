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
    public sealed class HighlightReflections : IFeature
    {
        private ShaderProperty _specularHighlights = new(LitAdvancedOptionsProperties.SpecularHighlights);
        private ShaderProperty _environmentReflections = new(LitAdvancedOptionsProperties.EnvironmentReflections);

        public void FindProperties(MaterialProperty[] properties)
        {
            _specularHighlights.Find(properties);
            _environmentReflections.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawHighlights(editor);
            DrawReflections(editor);
            EditorGUILayout.Space();
        }

        public void SetKeywords(Material material)
        {
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.SpecularHighlightsOff, !_specularHighlights.IsToggleEnabled(material));
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.EnvironmentReflectionsOff, !_environmentReflections.IsToggleEnabled(material));
        }

        private void DrawHighlights(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(AdvancedOptionsStyles.Highlights, _specularHighlights.MaterialProperty, ToggleAlign.Right);

        private void DrawReflections(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(AdvancedOptionsStyles.Reflections, _environmentReflections.MaterialProperty, ToggleAlign.Right);
    }
}