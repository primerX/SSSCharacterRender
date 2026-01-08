using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Hair
{
    public sealed class SpecularBlock : IFeature
    {
        private ShaderProperty _smoothnessMaskMap = new(HairProperties.SmoothnessMaskMap);
        private ShaderProperty _smoothness = new(HairProperties.Smoothness);
        private ShaderProperty _smoothnessRemapMin = new(HairProperties.SmoothnessRemapMin);
        private ShaderProperty _smoothnessRemapMax = new(HairProperties.SmoothnessRemapMax);

        private ShaderProperty _specularColor = new(HairProperties.SpecularColor);
        private ShaderProperty _specularMultiplier = new(HairProperties.SpecularMultiplier);
        private ShaderProperty _specularShift = new(HairProperties.SpecularShift);
        private ShaderProperty _secondarySpecularMultiplier = new(HairProperties.SecondarySpecularMultiplier);
        private ShaderProperty _secondarySpecularShift = new(HairProperties.SecondarySpecularShift);

        private ShaderProperty _transmissionColor = new(HairProperties.TransmissionColor);
        private ShaderProperty _transmissionIntensity = new(HairProperties.TransmissionIntensity);

        public void FindProperties(MaterialProperty[] properties)
        {
            _smoothnessMaskMap.Find(properties);
            _smoothness.Find(properties);
            _smoothnessRemapMin.Find(properties);
            _smoothnessRemapMax.Find(properties);

            _specularColor.Find(properties);
            _specularMultiplier.Find(properties);
            _specularShift.Find(properties);
            _secondarySpecularMultiplier.Find(properties);
            _secondarySpecularShift.Find(properties);

            _transmissionColor.Find(properties);
            _transmissionIntensity.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            EditorGUILayout.Space();
            DrawSmoothnessMask(editor);
            EditorGUILayout.Space();
            DrawSpecularProperties(editor);
            EditorGUILayout.Space();
            DrawTransmission(editor);
            EditorGUILayout.Space();
        }

        public void SetKeywords(Material material) =>
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.SmoothnessMask, _smoothnessMaskMap.HasTexture(material));

        private void DrawSmoothnessMask(MaterialEditorGUIPlus editor)
        {
            DrawSmoothnessMaskMap(editor);

            if (_smoothnessMaskMap.MaterialProperty.textureValue is not null)
                DrawSmoothnessRemapping(editor);
            else
                DrawSmoothness(editor);

            DrawTextureScaleOffset(editor);
        }

        private void DrawSmoothnessRemapping(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxSlider(SurfaceInputsStyles.SmoothnessRemapping, _smoothnessRemapMin.MaterialProperty,
                _smoothnessRemapMax.MaterialProperty);

        private void DrawSmoothness(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SurfaceInputsStyles.Smoothness, _smoothness.MaterialProperty);

        private void DrawSmoothnessMaskMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(HairStyles.SmoothnessMask, _smoothnessMaskMap.MaterialProperty);

        private void DrawTextureScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_smoothnessMaskMap.MaterialProperty);

        private void DrawSpecularProperties(MaterialEditorGUIPlus editor)
        {
            DrawSpecularColorHair(editor);
            DrawSpecularMultiplier(editor);
            DrawSpecularShift(editor);
            DrawSecondarySpecularMultiplier(editor);
            DrawSecondarySpecularShift(editor);
        }

        private void DrawSpecularColorHair(MaterialEditorGUIPlus editor) => 
            editor.DrawColor(HairStyles.SpecularColorHair, _specularColor.MaterialProperty);

        private void DrawSpecularMultiplier(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HairStyles.SpecularMultiplier, _specularMultiplier.MaterialProperty);

        private void DrawSpecularShift(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HairStyles.SpecularShift, _specularShift.MaterialProperty);

        private void DrawSecondarySpecularMultiplier(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HairStyles.SecondarySpecularMultiplier, _secondarySpecularMultiplier.MaterialProperty);

        private void DrawSecondarySpecularShift(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HairStyles.SecondarySpecularShift, _secondarySpecularShift.MaterialProperty);

        private void DrawTransmission(MaterialEditorGUIPlus editor)
        {
            DrawTransmissionColor(editor);
            DrawTransmissionRim(editor);
        }

        private void DrawTransmissionColor(MaterialEditorGUIPlus editor) => 
            editor.DrawColor(HairStyles.TransmissionColor, _transmissionColor.MaterialProperty);

        private void DrawTransmissionRim(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HairStyles.TransmissionRim, _transmissionIntensity.MaterialProperty);
    }
}