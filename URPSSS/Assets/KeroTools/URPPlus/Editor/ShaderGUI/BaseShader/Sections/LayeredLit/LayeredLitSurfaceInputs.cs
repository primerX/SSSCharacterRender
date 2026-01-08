using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.Data.Range;
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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit
{
    public sealed class LayeredLitSurfaceInputs : IFeature
    {
        private readonly Material _material;
        
        private ShaderProperty _layerCount = new(LayeredLitSurfaceInputsProperties.LayerCount);
        private ShaderProperty _layerMask = new(LayeredLitSurfaceInputsProperties.LayerMask);
        private ShaderProperty _vertexColor = new(LayeredLitSurfaceInputsProperties.VertexColorMode);
        private ShaderProperty _useMainLayerInfluence = new(LayeredLitSurfaceInputsProperties.UseMainLayerInfluence);
        private ShaderProperty _useHeightBasedBlending = new(LayeredLitSurfaceInputsProperties.UseHeightBasedBlending);
        private ShaderProperty _heightTransition = new(LayeredLitSurfaceInputsProperties.HeightTransition);

        private readonly ShaderProperty _opacityAsDensity1 = new(LayeredLitSurfaceInputsProperties.OpacityAsDensity1);
        private readonly ShaderProperty _opacityAsDensity2 = new(LayeredLitSurfaceInputsProperties.OpacityAsDensity2);
        private readonly ShaderProperty _opacityAsDensity3 = new(LayeredLitSurfaceInputsProperties.OpacityAsDensity3);
        
        public LayeredLitSurfaceInputs(Material material) =>
            _material = material;
        
        public void FindProperties(MaterialProperty[] properties)
        {
            _layerCount.Find(properties);
            _layerMask.Find(properties);
            _vertexColor.Find(properties);
            _useMainLayerInfluence.Find(properties);
            _useHeightBasedBlending.Find(properties);
            _heightTransition.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawLayerCount(editor);
            DrawLayerMaskMap(editor);
            DrawLayerMaskMapScaleOffset(editor);
            DrawVertexColorMode(editor);
            DrawUseMainLayerInfluenceMode(editor);
            DrawHeightBaseBlending(editor);
        }

        public void SetKeywords(Material material)
        {
            SetLayerCountKeywords(material);
            SetVertexColorModeKeywords(material);
            SetMainLayerInfluenceKeyword(material);
            SetHeightBasedBlendKeyword(material);
            SetDensityMode(material);
        }

        private void DrawLayerCount(MaterialEditorGUIPlus editor) => 
            editor.DrawIntSlider(LayeredStyles.LayerCount, _layerCount.MaterialProperty, new IntRange(2, 4));

        private void DrawLayerMaskMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(LayeredStyles.LayerMaskMap, _layerMask.MaterialProperty);

        private void DrawLayerMaskMapScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_layerMask.MaterialProperty);

        private void DrawVertexColorMode(MaterialEditorGUIPlus editor) => 
            editor.DrawEnumPopup<VertexColorMode>(LayeredStyles.VertexColorMode, _vertexColor.MaterialProperty);

        private void DrawUseMainLayerInfluenceMode(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(LayeredStyles.UseMainLayerInfluenceMode, _useMainLayerInfluence.MaterialProperty, ToggleAlign.Right);

        private void DrawHeightBaseBlending(MaterialEditorGUIPlus editor)
        {
            DrawUseHeightBasedBlend(editor);
            if (_useHeightBasedBlending.IsToggleEnabled(_material))
                DrawHeightTransition(editor);
        }

        private void DrawUseHeightBasedBlend(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(LayeredStyles.UseHeightBasedBlend, _useHeightBasedBlending.MaterialProperty, ToggleAlign.Right);

        private void DrawHeightTransition(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(LayeredStyles.HeightTransition, _heightTransition.MaterialProperty, 1);

        private void SetLayerCountKeywords(Material material)
        {
            int numLayers = (int)material.GetFloat(_layerCount.ID);

            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.LayeredLit4Layers, numLayers == 4);
            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.LayeredLit3Layers, numLayers == 3);
        }

        private void SetVertexColorModeKeywords(Material material)
        {
            VertexColorMode vcMode = (VertexColorMode)material.GetFloat(_vertexColor.ID);

            bool vertexColorIsMultiply = vcMode is VertexColorMode.Multiply;
            bool vertexColorIsAdd = vcMode is VertexColorMode.Add;
            
            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.VertexColorMultiply, vertexColorIsMultiply);
            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.VertexColorAdd, vertexColorIsAdd);
        }

        private void SetDensityMode(Material material)
        {
            bool opacityAsDensity1State = _opacityAsDensity1.IsToggleEnabled(material);
            bool opacityAsDensity2State = _opacityAsDensity2.IsToggleEnabled(material);
            bool opacityAsDensity3State = _opacityAsDensity3.IsToggleEnabled(material);
            bool opacityAsDensityState = opacityAsDensity1State || opacityAsDensity2State || opacityAsDensity3State;
            
            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.DensityMode, opacityAsDensityState);
        }

        private void SetMainLayerInfluenceKeyword(Material material)
        {
            bool mainInfluenceState = _useMainLayerInfluence.IsToggleEnabled(material);
            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.MainLayerInfluence, mainInfluenceState);
        }

        private void SetHeightBasedBlendKeyword(Material material)
        {
            bool heightBasedBlendingState = _useHeightBasedBlending.IsToggleEnabled(material);
            CoreUtils.SetKeyword(material, LayeredSurfaceInputsKeywords.HeightBasedBlend, heightBasedBlendingState);
        }
    }
}