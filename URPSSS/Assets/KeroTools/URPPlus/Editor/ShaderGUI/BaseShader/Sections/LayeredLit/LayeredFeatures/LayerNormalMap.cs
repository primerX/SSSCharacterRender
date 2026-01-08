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
    public sealed class LayerNormalMap : LayerFeature
    {
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private ShaderProperty[] _normalMapProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _normalScaleProperties = new ShaderProperty[MaxLayersCount];

        public LayerNormalMap(uint layersCount, int layerIndex)
        {
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _normalMapProperties = GetLayerProperty(LitSurfaceInputsProperties.NormalMap);
            _normalScaleProperties = GetLayerProperty(LitSurfaceInputsProperties.NormalScale);
            return;

            ShaderProperty[] GetLayerProperty(string propertyName) =>
                LayerUtils.FindLayerProperty(propertyName, properties, _layersCount);
        }

        public override void Draw(MaterialEditorGUIPlus editor) =>
            DrawLayeredNormalMap(editor);

        public override void SetKeywords(Material material)
        {
            string layerNormalMapName = LayerUtils.LayerPropertyName(LitSurfaceInputsProperties.NormalMap, _layerIndex);
            string layerNormalKeywordName = LayerUtils.LayerPropertyName(SurfaceInputsKeywords.NormalMap, _layerIndex);
            bool hasLayerNormalMap = material.GetTexture(layerNormalMapName);
            
            CoreUtils.SetKeyword(material, layerNormalKeywordName, hasLayerNormalMap);
        }

        private void DrawLayeredNormalMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineNormalTexture(SurfaceInputsStyles.NormalMap, 
                _normalMapProperties[_layerIndex].MaterialProperty, 
                _normalScaleProperties[_layerIndex].MaterialProperty);
    }
}