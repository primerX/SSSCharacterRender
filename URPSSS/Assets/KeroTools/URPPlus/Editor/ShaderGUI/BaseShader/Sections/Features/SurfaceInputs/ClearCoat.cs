using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class ClearCoat : IFeature
    {
        private readonly Material _material;
        
        private ShaderProperty _clearCoatMap = new(LitSurfaceInputsProperties.ClearCoatMap);
        private ShaderProperty _clearCoatMask = new(LitSurfaceInputsProperties.ClearCoatMask);
        private ShaderProperty _clearCoatSmoothness = new(LitSurfaceInputsProperties.ClearCoatSmoothness);

        private ShaderProperty _coatNormalEnabled = new(LitAdvancedOptionsProperties.CoatNormalEnabled);
        private ShaderProperty _coatNormalMap = new(LitSurfaceInputsProperties.CoatNormalMap);
        private ShaderProperty _coatNormalScale = new(LitSurfaceInputsProperties.CoatNormalScale);
        
        public ClearCoat(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _clearCoatMap.Find(properties);
            _clearCoatMask.Find(properties);
            _clearCoatSmoothness.Find(properties);

            _coatNormalEnabled.Find(properties);
            _coatNormalMap.Find(properties);
            _coatNormalScale.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawClearCoatMap(editor);

            if (_clearCoatMask.MaterialProperty.floatValue <= 0.0f)
                return;

            DrawClearCoatSmoothness(editor);
            DrawClearCoatNormalMap(editor);
        }

        public void SetKeywords(Material material)
        {
            SetCleatCoatMapKeyword(material);
            SetCleatCoatKeyword(material);
        }

        private void DrawClearCoatMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(ClearCoatStyles.ClearCoatMask, 
                _clearCoatMap.MaterialProperty, 
                _clearCoatMask.MaterialProperty);

        private void DrawClearCoatSmoothness(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(ClearCoatStyles.ClearCoatSmoothness, _clearCoatSmoothness.MaterialProperty);

        private void DrawClearCoatNormalMap(MaterialEditorGUIPlus editor)
        {
            bool coatNormalEnabled = _coatNormalEnabled.IsToggleEnabled(_material);

            if (coatNormalEnabled)
                DrawCoatNormalMap(editor);
        }

        private void DrawCoatNormalMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(SurfaceInputsStyles.CoatNormalMap, 
                _coatNormalMap.MaterialProperty, 
                _coatNormalScale.MaterialProperty);

        private void SetCleatCoatKeyword(Material material)
        {
            bool clearCoatState = _clearCoatMask.MaterialProperty.floatValue > 0.0f;
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.CleatCoat, clearCoatState);
        }

        private void SetCleatCoatMapKeyword(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.CleatCoatMap, _clearCoatMap.HasTexture(material));
    }
}