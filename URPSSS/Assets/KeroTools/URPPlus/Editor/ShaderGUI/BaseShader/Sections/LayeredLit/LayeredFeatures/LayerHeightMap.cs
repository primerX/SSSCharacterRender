using System;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public sealed class LayerHeightMap : LayerFeature
    {
        private readonly Material _material;
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private readonly ShaderProperty _displacementMode = new(DisplacementProperties.DisplacementMode);
        private ShaderProperty[] _heightMapProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightParametrizationProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightTessCenterProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightTessAmplitudeProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightMinProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightMaxProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightOffsetProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _heightPoMAmplitudeProperties = new ShaderProperty[MaxLayersCount];

        private float _heightAmplitude;
        private float _heightCenter = 1.0f;

        private const float CentimetersToMeters = 0.01f;
        private const float MinAmplitudeThreshold = 1e-6f;

        private static readonly int[] HeightAmplitudeIDs =
        {
            Shader.PropertyToID("_HeightAmplitude"),
            Shader.PropertyToID("_HeightAmplitude1"),
            Shader.PropertyToID("_HeightAmplitude2"),
            Shader.PropertyToID("_HeightAmplitude3"),
        };

        private static readonly int[] HeightCenterIDs =
        {
            Shader.PropertyToID("_HeightCenter"),
            Shader.PropertyToID("_HeightCenter1"),
            Shader.PropertyToID("_HeightCenter2"),
            Shader.PropertyToID("_HeightCenter3"),
        };

        public LayerHeightMap(Material material, uint layersCount, int layerIndex)
        {
            _material = material;
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _heightMapProperties = GetLayerProperty(DisplacementProperties.HeightMap);
            _heightParametrizationProperties = GetLayerProperty(DisplacementProperties.HeightParametrization);
            _heightTessCenterProperties = GetLayerProperty(DisplacementProperties.HeightTessCenter);
            _heightTessAmplitudeProperties = GetLayerProperty(DisplacementProperties.HeightTessAmplitude);
            _heightMinProperties = GetLayerProperty(DisplacementProperties.HeightMin);
            _heightMaxProperties = GetLayerProperty(DisplacementProperties.HeightMax);
            _heightOffsetProperties = GetLayerProperty(DisplacementProperties.HeightOffset);
            _heightPoMAmplitudeProperties = GetLayerProperty(DisplacementProperties.HeightPoMAmplitude);
            return;

            ShaderProperty[] GetLayerProperty(string propertyName) =>
                LayerUtils.FindLayerProperty(propertyName, properties, _layersCount);
        }

        public override void Draw(MaterialEditorGUIPlus editor)
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

        public override void SetKeywords(Material material)
        {
            string layerHeightMapPropertyName = LayerUtils.LayerPropertyName(DisplacementProperties.HeightMap, _layerIndex);
            string layerHeightMapKeywordName = LayerUtils.LayerPropertyName(SurfaceInputsKeywords.HeightMap, _layerIndex);
            bool hasLayerHeightMap = material.GetTexture(layerHeightMapPropertyName);
            
            CoreUtils.SetKeyword(material, layerHeightMapKeywordName, hasLayerHeightMap);
        }

        private DisplacementMode GetDisplacementMode() => 
            (DisplacementMode)_material.GetFloat(_displacementMode.ID);

        private void DrawHeightMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(HeightBlockStyles.HeightMap, _heightMapProperties[_layerIndex].MaterialProperty);

        private void DrawHeightParametrizationMode(MaterialEditorGUIPlus editor) =>
            editor.DrawEnumPopup<HeightParametrization>(HeightBlockStyles.HeightMapParametrization, 
                _heightParametrizationProperties[_layerIndex].MaterialProperty);

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
            editor.DrawFloat(HeightBlockStyles.HeightMapAmplitude, 
                _heightPoMAmplitudeProperties[_layerIndex].MaterialProperty);

        private void SetPixelHeightProperties()
        {
            _material.SetFloat(HeightAmplitudeIDs[_layerIndex], 
                _heightPoMAmplitudeProperties[_layerIndex].MaterialProperty.floatValue * CentimetersToMeters);
            _material.SetFloat(HeightCenterIDs[_layerIndex], 1.0f);
        }

        private void DrawVertexHeightProperties(MaterialEditorGUIPlus editor)
        {
            DrawHeightParametrizationMode(editor);
            DrawHeightParametrizationProperties(editor);
            DrawHeightOffset(editor);
        }

        private void SetVertexHeightProperties()
        {
            _material.SetFloat(HeightAmplitudeIDs[_layerIndex], _heightAmplitude);
            _material.SetFloat(HeightCenterIDs[_layerIndex], _heightCenter);
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
            (HeightParametrization)_material.GetFloat(_heightParametrizationProperties[_layerIndex].ID);

        private void DrawAmplitudeMode(MaterialEditorGUIPlus editor)
        {
            DrawHeightMapAmplitude(editor);
            DrawHeightMapCenter(editor);
            AmplitudeHeightRemap();
        }

        private void DrawHeightMapAmplitude(MaterialEditorGUIPlus editor) =>
            editor.DrawFloat(HeightBlockStyles.HeightMapAmplitude, _heightTessAmplitudeProperties[_layerIndex].MaterialProperty);

        private void DrawHeightMapCenter(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(HeightBlockStyles.HeightMapCenter, _heightTessCenterProperties[_layerIndex].MaterialProperty);

        private void AmplitudeHeightRemap()
        {
            float offset = _heightOffsetProperties[_layerIndex].MaterialProperty.floatValue;
            float amplitude = _heightTessAmplitudeProperties[_layerIndex].MaterialProperty.floatValue;
            float center = _heightTessCenterProperties[_layerIndex].MaterialProperty.floatValue;
            _heightAmplitude = amplitude * CentimetersToMeters;
            _heightCenter = -offset / Mathf.Max(MinAmplitudeThreshold, amplitude) + center;
        }

        private void DrawMinMaxMode(MaterialEditorGUIPlus editor)
        {
            DrawHeightMapMin(editor);
            DrawHeightMapMax(editor);
            MinMaxHeightRemap();
        }

        private void DrawHeightMapMin(MaterialEditorGUIPlus editor) => 
            editor.DrawFloat(HeightBlockStyles.HeightMapMin, _heightMinProperties[_layerIndex].MaterialProperty);

        private void DrawHeightMapMax(MaterialEditorGUIPlus editor) => 
            editor.DrawFloat(HeightBlockStyles.HeightMapMax, _heightMaxProperties[_layerIndex].MaterialProperty);

        private void MinMaxHeightRemap()
        {
            float offset = _heightOffsetProperties[_layerIndex].MaterialProperty.floatValue;
            float minHeight = _heightMinProperties[_layerIndex].MaterialProperty.floatValue;
            float maxHeight = _heightMaxProperties[_layerIndex].MaterialProperty.floatValue - minHeight;
            _heightAmplitude = maxHeight * CentimetersToMeters;
            _heightCenter = -(minHeight + offset) / Mathf.Max(MinAmplitudeThreshold, maxHeight);
        }

        private void DrawHeightOffset(MaterialEditorGUIPlus editor) =>
            editor.DrawFloat(HeightBlockStyles.HeightMapOffset, _heightOffsetProperties[_layerIndex].MaterialProperty);
    }
}