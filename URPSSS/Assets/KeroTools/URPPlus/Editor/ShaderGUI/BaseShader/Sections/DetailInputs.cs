using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public sealed class DetailInputs : MaterialSection
    {
        private ShaderProperty _detailMap = new(DetailInputsProperties.DetailMap);
        private ShaderProperty _detailAlbedoScale = new(DetailInputsProperties.DetailAlbedoScale);
        private ShaderProperty _detailNormalScale = new(DetailInputsProperties.DetailNormalScale);
        private ShaderProperty _detailSmoothnessScale = new(DetailInputsProperties.DetailSmoothnessScale);

        public DetailInputs() : base(DetailInputsStyles.Label)
        { }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _detailMap.Find(properties);
            _detailAlbedoScale.Find(properties);
            _detailNormalScale.Find(properties);
            _detailSmoothnessScale.Find(properties);
        }

        public override void DrawProperties(MaterialEditorGUIPlus editor)
        {
            DrawDetailMap(editor);
            DrawDetailMapProperties(editor);
            DrawDetailMapScaleOffset(editor);
        }

        public override void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, DetailInputsKeywords.Detail, material.GetTexture(_detailMap.ID));

        private void DrawDetailMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(DetailInputsStyles.DetailMap, _detailMap.MaterialProperty);

        private void DrawDetailMapProperties(MaterialEditorGUIPlus editor)
        {
            if (_detailMap.MaterialProperty.textureValue is null)
                return;

            editor.DrawSlider(DetailInputsStyles.DetailAlbedoScale, _detailAlbedoScale.MaterialProperty, new FloatRange(0.0f, 2.0f),  1);
            editor.DrawSlider(DetailInputsStyles.DetailNormalScale, _detailNormalScale.MaterialProperty, new FloatRange(0.0f, 2.0f),  1);
            editor.DrawSlider(DetailInputsStyles.DetailSmoothnessScale, _detailSmoothnessScale.MaterialProperty, new FloatRange(0.0f, 2.0f),  1);
        }

        private void DrawDetailMapScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_detailMap.MaterialProperty);
    }
}