using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Eye
{
    public sealed class Iris : IFeature
    {
        private ShaderProperty _irisMap = new(EyeProperties.IrisMap);
        private ShaderProperty _irisMaskMap = new(EyeProperties.IrisMaskMap);
        private ShaderProperty _irisClampColor = new(EyeProperties.IrisClampColor);
        private ShaderProperty _irisNormal = new(EyeProperties.IrisNormalMap);
        private ShaderProperty _irisNormalIntensity = new(EyeProperties.IrisNormalScale);
        private ShaderProperty _irisPositionOffset = new(EyeProperties.IrisPositionOffset);
        private ShaderProperty _corneaSmoothnessProperty = new(EyeProperties.CorneaSmoothness);

        public void FindProperties(MaterialProperty[] properties)
        {
            _irisMap.Find(properties);
            _irisMaskMap.Find(properties);
            _irisClampColor.Find(properties);
            _irisNormal.Find(properties);
            _irisNormalIntensity.Find(properties);
            _irisPositionOffset.Find(properties);
            _corneaSmoothnessProperty.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawIrisMap(editor);
            DrawIrisMaskMap(editor);
            DrawIrisColor(editor);
            DrawIrisNormalMap(editor);
            DrawIrisPositionOffset(editor);
            DrawCorneaSmoothness(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, EyeKeywords.IrisNormalMap, _irisNormal.HasTexture(material));

        private void DrawIrisMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(EyeStyles.IrisMap, _irisMap.MaterialProperty);

        private void DrawIrisMaskMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(EyeStyles.IrisMaskMap, _irisMaskMap.MaterialProperty);

        private void DrawIrisColor(MaterialEditorGUIPlus editor) => 
            editor.DrawColor(EyeStyles.IrisClampColor, _irisClampColor.MaterialProperty);

        private void DrawIrisNormalMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineNormalTexture(EyeStyles.IrisNormalMap, _irisNormal.MaterialProperty, 
                _irisNormalIntensity.MaterialProperty);

        private void DrawIrisPositionOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawVector3(EyeStyles.IrisPositionOffset, _irisPositionOffset.MaterialProperty);

        private void DrawCorneaSmoothness(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.CorneaSmoothness, _corneaSmoothnessProperty.MaterialProperty);
    }
}