using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class BaseMap : IFeature
    {
        private readonly ShaderProperty _color = new(LitSurfaceInputsProperties.Color);
        private readonly ShaderProperty _mainTex = new(LitSurfaceInputsProperties.MainTex);
        
        private ShaderProperty _baseColor = new(LitSurfaceInputsProperties.BaseColor);
        private ShaderProperty _baseMap = new(LitSurfaceInputsProperties.BaseMap);
        private ShaderProperty _alphaMax = new(LitSurfaceInputsProperties.AlphaRemapMax);
        private ShaderProperty _alphaMin = new(LitSurfaceInputsProperties.AlphaRemapMin);
        private ShaderProperty _invTilingScale = new(LitSurfaceInputsProperties.InvTilingScale);

        public void FindProperties(MaterialProperty[] properties)
        {
            _baseColor.Find(properties);
            _baseMap.Find(properties);
            _alphaMin.Find(properties);
            _alphaMax.Find(properties);
            _invTilingScale.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawBaseMap(editor);
            
            if (_baseMap.MaterialProperty.textureValue is not null) 
                DrawAlphaRemapping(editor);
        }

        public void SetKeywords(Material material)
        {
            SetMainTexture(material);
            SetColor(material);
            SetInvTilingScale(material);
        }
        private void DrawBaseMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(SurfaceInputsStyles.BaseMap, _baseMap.MaterialProperty, _baseColor.MaterialProperty);

        private void DrawAlphaRemapping(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxSlider(SurfaceInputsStyles.AlphaRemapping,
                _alphaMin.MaterialProperty, _alphaMax.MaterialProperty);

        private void SetMainTexture(Material material)
        {
            if (!material.HasProperty(_mainTex.ID)) 
                return;
            
            material.SetTexture(_mainTex.ID, material.GetTexture(_baseMap.ID));
            material.SetTextureScale(_mainTex.ID, material.GetTextureScale(_baseMap.ID));
            material.SetTextureOffset(_mainTex.ID, material.GetTextureOffset(_baseMap.ID));
        }

        private void SetColor(Material material)
        {
            if (material.HasProperty(_color.ID))
                material.SetColor(_color.ID, material.GetColor(_baseColor.ID));
        }
        
        private void SetInvTilingScale(Material material)
        {
            if (!material.HasProperty(_invTilingScale.ID)) 
                return;
            
            float absoluteXTextureScaleAndOffset = Mathf.Abs(_baseMap.MaterialProperty.textureScaleAndOffset.x);
            float absoluteYTextureScaleAndOffset = Mathf.Abs(_baseMap.MaterialProperty.textureScaleAndOffset.y);
            _invTilingScale.MaterialProperty.floatValue = 2.0f / (absoluteXTextureScaleAndOffset + absoluteYTextureScaleAndOffset);
        }
    }
}