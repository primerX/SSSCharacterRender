using System;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class HeightMap : IFeature
    {
        private const float CentimetersToMeters = 0.01f;
        private const float MinAmplitudeThreshold = 1e-6f;
        private float _heightAmplitudeTemp;
        private float _heightCenterTemp = 1.0f;

        private readonly Material _material;

        private readonly ShaderProperty _displacement = new(DisplacementProperties.DisplacementMode);
        private ShaderProperty _heightTexture = new(DisplacementProperties.HeightMap);
        private ShaderProperty _heightMin = new(DisplacementProperties.HeightMin);
        private ShaderProperty _heightMax = new(DisplacementProperties.HeightMax);
        private ShaderProperty _heightOffset = new(DisplacementProperties.HeightOffset);
        private ShaderProperty _heightParametrization = new(DisplacementProperties.HeightParametrization);
        private ShaderProperty _heightTessAmplitude = new(DisplacementProperties.HeightTessAmplitude);
        private ShaderProperty _heightTessCenter = new(DisplacementProperties.HeightTessCenter);

        private readonly ShaderProperty _heightAmplitude = new(DisplacementProperties.HeightAmplitude);
        private ShaderProperty _heightPoMAmplitude = new(DisplacementProperties.HeightPoMAmplitude);
        private readonly ShaderProperty _heightCenter = new(DisplacementProperties.HeightCenter);

        public HeightMap(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _heightTexture.Find(properties);
            _heightParametrization.Find(properties);
            _heightTessCenter.Find(properties);
            _heightTessAmplitude.Find(properties);
            _heightMin.Find(properties);
            _heightMax.Find(properties);
            _heightOffset.Find(properties);
            _heightPoMAmplitude.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DisplacementMode displacementMode = GetDisplacementMode();

            if (displacementMode == DisplacementMode.None)
                return;

            DrawHeightMap(editor);
            editor.DrawIndented(1, DrawIndentedHeightParametrization);
            return;

            void DrawIndentedHeightParametrization() => 
                DrawHeightParametrization(editor, displacementMode);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.HeightMap, _heightTexture.HasTexture(_material));

        private DisplacementMode GetDisplacementMode() => 
            (DisplacementMode)_material.GetFloat(_displacement.ID);

        private void DrawHeightMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(HeightBlockStyles.HeightMap, _heightTexture.MaterialProperty);

        private void DrawHeightParametrizationMode(MaterialEditorGUIPlus editor) => 
            editor.DrawEnumPopup<HeightParametrization>(HeightBlockStyles.HeightMapParametrization, 
                _heightParametrization.MaterialProperty);

        private void DrawHeightParametrization(MaterialEditorGUIPlus editor, DisplacementMode displacementMode)
        {
            if (displacementMode == DisplacementMode.PixelDisplacement)
            {
                DrawPPDHeightProperties(editor);
                SetPixelHeightProperties();
            }
            else
            {
                DrawVertexHeightProperties(editor);
                SetVertexHeightProperties();
            }
        }

        private void DrawPPDHeightProperties(MaterialEditorGUIPlus editor) =>
            editor.DrawFloat(HeightBlockStyles.HeightMapAmplitude, _heightPoMAmplitude.MaterialProperty);

        private void SetPixelHeightProperties()
        {
            _material.SetFloat(_heightAmplitude.ID, _heightPoMAmplitude.MaterialProperty.floatValue * CentimetersToMeters);
            _material.SetFloat(_heightCenter.ID, 1.0f);
        }

        private void DrawVertexHeightProperties(MaterialEditorGUIPlus editor)
        {
            DrawHeightParametrizationMode(editor);
            DrawHeightParametrizationProperties(editor);
            DrawHeightOffset(editor);
        }

        private void SetVertexHeightProperties()
        {
            _material.SetFloat(_heightAmplitude.ID, _heightAmplitudeTemp);
            _material.SetFloat(_heightCenter.ID, _heightCenterTemp);
        }

        private void DrawHeightParametrizationProperties(MaterialEditorGUIPlus editor)
        {
            HeightParametrization selectedParametrization = GetHeightParametrization();
            switch (selectedParametrization)
            {
                case HeightParametrization.Amplitude:
                    DrawAmplitudeMode(editor);
                    break;
                case HeightParametrization.MinMax:
                    DrawMinMaxMode(editor);
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private HeightParametrization GetHeightParametrization() => 
            (HeightParametrization)_material.GetFloat(_heightParametrization.ID);

        private void DrawAmplitudeMode(MaterialEditorGUIPlus editor)
        {
            DrawHeightMapAmplitude(editor);
            DrawHeightMapCenter(editor);
            AmplitudeHeightRemap();
        }

        private void AmplitudeHeightRemap()
        {
            float offset = _heightOffset.MaterialProperty.floatValue;
            float amplitude = _heightTessAmplitude.MaterialProperty.floatValue;
            float center = _heightTessCenter.MaterialProperty.floatValue;
            _heightAmplitudeTemp = amplitude * CentimetersToMeters;
            _heightCenterTemp = -offset / Mathf.Max(MinAmplitudeThreshold, amplitude) + center;
        }

        private void DrawHeightMapAmplitude(MaterialEditorGUIPlus editor) => 
            editor.DrawFloat(HeightBlockStyles.HeightMapAmplitude, _heightTessAmplitude.MaterialProperty);

        private void DrawHeightMapCenter(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HeightBlockStyles.HeightMapCenter, _heightTessCenter.MaterialProperty);

        private void DrawMinMaxMode(MaterialEditorGUIPlus editor)
        {
            DrawHeightMapMin(editor);
            DrawHeightMapMax(editor);
            MinMaxHeightRemap();
        }

        private void MinMaxHeightRemap()
        {
            float offset = _heightOffset.MaterialProperty.floatValue;
            float minHeight = _heightMin.MaterialProperty.floatValue;
            float maxHeight = _heightMax.MaterialProperty.floatValue - minHeight;
            _heightAmplitudeTemp = maxHeight * CentimetersToMeters;
            _heightCenterTemp = -(minHeight + offset) / Mathf.Max(MinAmplitudeThreshold, maxHeight);
        }

        private void DrawHeightMapMin(MaterialEditorGUIPlus editor) => 
            editor.DrawFloat(HeightBlockStyles.HeightMapMin, _heightMin.MaterialProperty);

        private void DrawHeightMapMax(MaterialEditorGUIPlus editor) => 
            editor.DrawFloat(HeightBlockStyles.HeightMapMax, _heightMax.MaterialProperty);

        private void DrawHeightOffset(MaterialEditorGUIPlus editor) =>
            editor.DrawFloat(HeightBlockStyles.HeightMapOffset, _heightOffset.MaterialProperty);
    }
}