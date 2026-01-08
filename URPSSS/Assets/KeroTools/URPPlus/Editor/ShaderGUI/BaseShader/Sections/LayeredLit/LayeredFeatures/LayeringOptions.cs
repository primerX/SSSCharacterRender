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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public sealed class LayeringOptions : LayerFeature
    {
        private readonly Material _material;
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private ShaderProperty _layerInfluenceMaskMap = new(LayeringOptionsProperties.LayerInfluenceMaskMap);
        private ShaderProperty[] _opacityAsDensityProperties;
        private ShaderProperty[] _inheritBaseColorProperties = new ShaderProperty[MaxLayersCount - 1];
        private ShaderProperty[] _inheritBaseNormalProperties = new ShaderProperty[MaxLayersCount - 1];
        private ShaderProperty[] _inheritBaseHeightProperties = new ShaderProperty[MaxLayersCount - 1];

        private ShaderProperty _useMainLayerInfluence = new(LayeredLitSurfaceInputsProperties.UseMainLayerInfluence);

        public LayeringOptions(Material material, uint layersCount, int layerIndex)
        {
            _material = material;
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _layerInfluenceMaskMap.Find(properties);
            _useMainLayerInfluence.Find(properties);
            
            _opacityAsDensityProperties = LayerUtils.FindLayerProperty(LayeringOptionsProperties.OpacityAsDensity, properties, _layersCount);
            _inheritBaseColorProperties = LayerUtils.FindLayerPropertiesInRange(LayeringOptionsProperties.InheritBaseColor, properties);
            _inheritBaseNormalProperties = LayerUtils.FindLayerPropertiesInRange(LayeringOptionsProperties.InheritBaseNormal, properties);
            _inheritBaseHeightProperties = LayerUtils.FindLayerPropertiesInRange(LayeringOptionsProperties.InheritBaseHeight, properties);
        }

        public override void Draw(MaterialEditorGUIPlus editor)
        {
            if (_layerIndex == 0)
                DrawLayerInfluenceMaskMap(editor);
            else
                DrawInfluenceProperties(editor);
        }

        private void DrawLayerInfluenceMaskMap(MaterialEditorGUIPlus editor)
        {
            editor.DrawSingleLineTexture(LayeredStyles.LayerInfluenceMaskMap, _layerInfluenceMaskMap.MaterialProperty);
            EditorGUILayout.Space();
        }

        private void DrawInfluenceProperties(MaterialEditorGUIPlus editor)
        {
            DrawOpacityAsDensity(editor);

            bool mainInfluenceState = _useMainLayerInfluence.IsToggleEnabled(_material);
            if (!mainInfluenceState)
                return;

            int inheritIndex = _layerIndex - 1;
            DrawInheritBaseColor(editor, inheritIndex);
            DrawInheritBaseNormal(editor, inheritIndex);
            DrawInheritBaseHeight(editor, inheritIndex);
            EditorGUILayout.Space();
        }

        private void DrawOpacityAsDensity(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(LayeredStyles.OpacityAsDensity, _opacityAsDensityProperties[_layerIndex].MaterialProperty, ToggleAlign.Right);

        private void DrawInheritBaseColor(MaterialEditorGUIPlus editor, int inheritIndex) => 
            editor.DrawSlider(LayeredStyles.InheritBaseColor, _inheritBaseColorProperties[inheritIndex].MaterialProperty);

        private void DrawInheritBaseNormal(MaterialEditorGUIPlus editor, int inheritIndex) => 
            editor.DrawSlider(LayeredStyles.InheritBaseNormal, _inheritBaseNormalProperties[inheritIndex].MaterialProperty);

        private void DrawInheritBaseHeight(MaterialEditorGUIPlus editor, int inheritIndex) => 
            editor.DrawSlider(LayeredStyles.InheritBaseHeight, _inheritBaseHeightProperties[inheritIndex].MaterialProperty);

        public override void SetKeywords(Material material)
        {
            bool hasInfluenceMaskMap = _layerInfluenceMaskMap.HasTexture(material);
            bool useMainLayerInfluence = _useMainLayerInfluence.IsToggleEnabled(material);
            bool influenceMaskMapState = hasInfluenceMaskMap && useMainLayerInfluence;

            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.InfluenceMaskMap, influenceMaskMapState);
        }
    }
}