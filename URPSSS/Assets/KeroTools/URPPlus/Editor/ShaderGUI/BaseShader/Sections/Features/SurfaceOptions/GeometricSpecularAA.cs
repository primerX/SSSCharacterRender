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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions
{
    public sealed class GeometricSpecularAA : IFeature
    {
        private ShaderProperty _enableSpecularAA = new(LitSurfaceOptionsProperties.EnableGeometricSpecularAA);
        private ShaderProperty _specularAAScreenSpaceVariance = new(LitSurfaceOptionsProperties.SpecularAAScreenSpaceVariance);
        private ShaderProperty _specularAAThreshold = new(LitSurfaceOptionsProperties.SpecularAAThreshold);

        public void FindProperties(MaterialProperty[] properties)
        {
            _enableSpecularAA.Find(properties);
            _specularAAScreenSpaceVariance.Find(properties);
            _specularAAThreshold.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            bool isEnabled = editor.DrawToggle(SurfaceOptionsStyles.GeometricSpecularAA, 
                _enableSpecularAA.MaterialProperty, ToggleAlign.Right);

            if (!isEnabled)
                return;

            DrawScreenSpaceVariance(editor);
            DrawThreshold(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.GeometricSpecularAA, 
                _enableSpecularAA.IsToggleEnabled(material));

        private void DrawThreshold(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(SurfaceOptionsStyles.SpecularAAThreshold,
                    _specularAAThreshold.MaterialProperty, 1);

        private void DrawScreenSpaceVariance(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(SurfaceOptionsStyles.SpecularAAScreenSpaceVariance,
                    _specularAAScreenSpaceVariance.MaterialProperty, 1);
    }
}