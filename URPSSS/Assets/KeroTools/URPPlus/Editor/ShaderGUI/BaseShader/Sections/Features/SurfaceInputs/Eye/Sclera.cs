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
    public sealed class Sclera : IFeature
    {
        private ShaderProperty _scleraMap = new(EyeProperties.ScleraMap);
        private ShaderProperty _scleraSmoothness = new(EyeProperties.ScleraSmoothness);
        private ShaderProperty _scleraNormalMap = new(EyeProperties.ScleraNormalMap);
        private ShaderProperty _scleraNormalScale = new(EyeProperties.ScleraNormalScale);

        public void FindProperties(MaterialProperty[] properties)
        {
            _scleraMap.Find(properties);
            _scleraSmoothness.Find(properties);
            _scleraNormalMap.Find(properties);
            _scleraNormalScale.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawScleraMap(editor);
            DrawScleraSmoothness(editor);
            DrawScleraNormalMap(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, EyeKeywords.ScleraNormalMap, _scleraNormalMap.HasTexture(material));

        private void DrawScleraMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(EyeStyles.ScleraMap, _scleraMap.MaterialProperty);

        private void DrawScleraSmoothness(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.ScleraSmoothness, _scleraSmoothness.MaterialProperty);

        private void DrawScleraNormalMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineNormalTexture(EyeStyles.ScleraNormalMap,
                _scleraNormalMap.MaterialProperty, _scleraNormalScale.MaterialProperty);
    }
}