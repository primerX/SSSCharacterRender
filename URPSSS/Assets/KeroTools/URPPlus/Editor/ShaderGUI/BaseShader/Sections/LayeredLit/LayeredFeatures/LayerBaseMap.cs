using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public sealed class LayerBaseMap : LayerFeature
    {
        private readonly uint _layersCount;
        private readonly int _layerIndex;
        
        private readonly ShaderProperty _color = new(LitSurfaceInputsProperties.Color);
        private readonly ShaderProperty _mainTex = new(LitSurfaceInputsProperties.MainTex);

        private ShaderProperty[] _baseColorProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _baseMapProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _alphaMinProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _alphaMaxProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _invTilingScaleProperties = new ShaderProperty[MaxLayersCount];

        private static readonly int BaseColorID = Shader.PropertyToID(LitSurfaceInputsProperties.BaseColor);
        private static readonly int BaseMapID = Shader.PropertyToID(LitSurfaceInputsProperties.BaseMap);

        public LayerBaseMap(uint layersCount, int layerIndex)
        {
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _baseColorProperties = GetLayerProperty(LitSurfaceInputsProperties.BaseColor);
            _baseMapProperties = GetLayerProperty(LitSurfaceInputsProperties.BaseMap);
            _alphaMinProperties = GetLayerProperty(LitSurfaceInputsProperties.AlphaRemapMin);
            _alphaMaxProperties = GetLayerProperty(LitSurfaceInputsProperties.AlphaRemapMax);
            _invTilingScaleProperties = GetLayerProperty(LitSurfaceInputsProperties.InvTilingScale);
            return;

            ShaderProperty[] GetLayerProperty(string propertyName) =>
                LayerUtils.FindLayerProperty(propertyName, properties, _layersCount);
        }

        public override void Draw(MaterialEditorGUIPlus editor)
        {
            DrawBaseMap(editor);

            if (_baseMapProperties[_layerIndex].MaterialProperty.textureValue is not null) 
                DrawAlphaRemapping(editor);
        }

        public override void SetKeywords(Material material)
        {
            SetMainTexture(material);
            SetColor(material);
            SetInvTilingScale();
        }

        private void DrawBaseMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(SurfaceInputsStyles.BaseMap, _baseMapProperties[_layerIndex].MaterialProperty, 
                _baseColorProperties[_layerIndex].MaterialProperty);

        private void DrawAlphaRemapping(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxSlider(SurfaceInputsStyles.AlphaRemapping, _alphaMinProperties[_layerIndex].MaterialProperty, 
                _alphaMaxProperties[_layerIndex].MaterialProperty);
        
        private void SetMainTexture(Material material)
        {
            if (!material.HasProperty(_mainTex.ID)) 
                return;
            
            material.SetTexture(_mainTex.ID, material.GetTexture(BaseMapID));
            material.SetTextureScale(_mainTex.ID, material.GetTextureScale(BaseMapID));
            material.SetTextureOffset(_mainTex.ID, material.GetTextureOffset(BaseMapID));
        }

        private void SetColor(Material material)
        {
            if (material.HasProperty(_color.ID))
                material.SetColor(_color.ID, material.GetColor(BaseColorID));
        }
        
        private void SetInvTilingScale()
        {
            float absoluteXTextureScaleAndOffset = Mathf.Abs(_baseMapProperties[_layerIndex].MaterialProperty.textureScaleAndOffset.x);
            float absoluteYTextureScaleAndOffset = Mathf.Abs(_baseMapProperties[_layerIndex].MaterialProperty.textureScaleAndOffset.y);
            _invTilingScaleProperties[_layerIndex].MaterialProperty.floatValue = 2.0f / (absoluteXTextureScaleAndOffset + absoluteYTextureScaleAndOffset);
        }
    }
}