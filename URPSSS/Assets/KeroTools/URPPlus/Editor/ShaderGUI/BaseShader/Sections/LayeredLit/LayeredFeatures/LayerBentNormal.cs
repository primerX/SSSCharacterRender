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
    public sealed class LayerBentNormalMap : LayerFeature
    {
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private ShaderProperty[] _bentNormalMapProperties = new ShaderProperty[MaxLayersCount];

        public LayerBentNormalMap(uint layersCount, int layerIndex)
        {
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _bentNormalMapProperties = GetLayerProperty(LitSurfaceInputsProperties.BentNormalMap);
            return;

            ShaderProperty[] GetLayerProperty(string propertyName) =>
                LayerUtils.FindLayerProperty(propertyName, properties, _layersCount);
        }

        public override void Draw(MaterialEditorGUIPlus editor) =>
            DrawLayeredBentNormalMap(editor);

        public override void SetKeywords(Material material)
        {
            string layerBentNormalMapName = LayerUtils.LayerPropertyName(LitSurfaceInputsProperties.BentNormalMap, _layerIndex);
            string layerBentNormalKeywordName = LayerUtils.LayerPropertyName(SurfaceInputsKeywords.BentNormalMap, _layerIndex);
            bool hasLayerBentNormalMap = material.GetTexture(layerBentNormalMapName);
            
            CoreUtils.SetKeyword(material, layerBentNormalKeywordName, hasLayerBentNormalMap);
        }

        private void DrawLayeredBentNormalMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineNormalTexture(SurfaceInputsStyles.BentNormalMap, 
                _bentNormalMapProperties[_layerIndex].MaterialProperty);
    }
}