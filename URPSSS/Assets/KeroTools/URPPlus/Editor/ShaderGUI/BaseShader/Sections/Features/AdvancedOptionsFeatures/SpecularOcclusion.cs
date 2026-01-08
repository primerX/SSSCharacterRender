using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class SpecularOcclusion : IFeature
    {
        private ShaderProperty _specularOcclusionMode = new(LitAdvancedOptionsProperties.SpecularOcclusionMode);
        private ShaderProperty _giOcclusionBias = new(LitAdvancedOptionsProperties.GIOcclusionBias);

        public void FindProperties(MaterialProperty[] properties)
        {
            _specularOcclusionMode.Find(properties);
            _giOcclusionBias.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawSpecularOcclusion(editor);
            DrawGIOcclusion(editor, 1);
        }

        public void SetKeywords(Material material)
        {
            SpecularOcclusionMode specularOcclusionMode = GetSpecularOcclusionMode();

            bool isFromAmbientOcclusion = specularOcclusionMode is SpecularOcclusionMode.FromAmbientOcclusion;
            bool isFromBentNormal = specularOcclusionMode is SpecularOcclusionMode.FromBentNormals;
            bool isFromGI = specularOcclusionMode is SpecularOcclusionMode.FromGI;
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.AoSpecularOcclusion, isFromAmbientOcclusion);
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.BentNormalSpecularOcclusion, isFromBentNormal);
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.GiSpecularOcclusion, isFromGI);
        }

        private void DrawSpecularOcclusion(MaterialEditorGUIPlus editor, int indentLevel = 0)
        {
            editor.DrawEnumPopup<SpecularOcclusionMode>(AdvancedOptionsStyles.SpecularOcclusionMode, 
                _specularOcclusionMode.MaterialProperty, indentLevel);
        }

        private void DrawGIOcclusion(MaterialEditorGUIPlus editor, int indentLevel = 0)
        {
            if (GetSpecularOcclusionMode() != SpecularOcclusionMode.FromGI)
                return;

            editor.DrawSlider(AdvancedOptionsStyles.GIOcclusionBias, _giOcclusionBias.MaterialProperty, indentLevel);
        }

        private SpecularOcclusionMode GetSpecularOcclusionMode() => 
            (SpecularOcclusionMode)_specularOcclusionMode.MaterialProperty.floatValue;
    }
}