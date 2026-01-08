using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public sealed class LayerDetailMap : LayerFeature
    {
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private ShaderProperty[] _detailMapProperties;
        private ShaderProperty[] _detailAlbedoScaleProperties;
        private ShaderProperty[] _detailNormalScaleProperties;
        private ShaderProperty[] _detailSmoothnessScaleProperties;

        public LayerDetailMap(uint layersCount, int layerIndex)
        {
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _detailMapProperties = GetLayerProperty(DetailInputsProperties.DetailMap);
            _detailAlbedoScaleProperties = GetLayerProperty(DetailInputsProperties.DetailAlbedoScale);
            _detailNormalScaleProperties = GetLayerProperty(DetailInputsProperties.DetailNormalScale);
            _detailSmoothnessScaleProperties = GetLayerProperty(DetailInputsProperties.DetailSmoothnessScale);
            return;

            ShaderProperty[] GetLayerProperty(string propertyName) =>
                LayerUtils.FindLayerProperty(propertyName, properties, _layersCount);
        }

        public override void Draw(MaterialEditorGUIPlus editor)
        {
            DrawDetailMap(editor);
            DrawDetailMapProperties(editor);
        }

        public override void SetKeywords(Material material)
        {
            string layerDetailMapPropertyName = LayerUtils.LayerPropertyName(DetailInputsProperties.DetailMap, _layerIndex);
            string layerDetailMapKeywordName = LayerUtils.LayerPropertyName(DetailInputsKeywords.DetailMap, _layerIndex);
            bool hasLayerMaskMap = material.GetTexture(layerDetailMapPropertyName);

            CoreUtils.SetKeyword(material, layerDetailMapKeywordName, hasLayerMaskMap);
        }

        private void DrawDetailMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(DetailInputsStyles.DetailMap, _detailMapProperties[_layerIndex].MaterialProperty);

        private void DrawDetailMapProperties(MaterialEditorGUIPlus editor)
        {
            if (_detailMapProperties[_layerIndex].MaterialProperty.textureValue is null)
                return;

            editor.DrawIndented(1, DrawProperties);
            DrawDetailMapScaleOffset(editor);
            return;

            void DrawProperties()
            {
                DrawDetailAlbedoScale(editor);
                DrawDetailNormalScale(editor);
                DrawDetailSmoothnessScale(editor);
            }
        }

        private void DrawDetailAlbedoScale(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(DetailInputsStyles.DetailAlbedoScale, _detailAlbedoScaleProperties[_layerIndex].MaterialProperty, new FloatRange(0.0f, 2.0f));

        private void DrawDetailNormalScale(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(DetailInputsStyles.DetailNormalScale, _detailNormalScaleProperties[_layerIndex].MaterialProperty, new FloatRange(0.0f, 2.0f));

        private void DrawDetailSmoothnessScale(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(DetailInputsStyles.DetailSmoothnessScale, _detailSmoothnessScaleProperties[_layerIndex].MaterialProperty, new FloatRange(0.0f, 2.0f));

        private void DrawDetailMapScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_detailMapProperties[_layerIndex].MaterialProperty);
    }
}