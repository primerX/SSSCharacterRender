using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Fabric
{
    public sealed class ThreadMap : IFeature
    {
        private ShaderProperty _threadTexture = new(FabricProperties.ThreadMap);
        private ShaderProperty _threadAOScale = new(FabricProperties.ThreadAOScale);
        private ShaderProperty _threadNormalScale = new(FabricProperties.ThreadNormalScale);
        private ShaderProperty _threadSmoothnessScale = new(FabricProperties.ThreadSmoothnessScale);

        public void FindProperties(MaterialProperty[] properties)
        {
            _threadTexture.Find(properties);
            _threadAOScale.Find(properties);
            _threadNormalScale.Find(properties);
            _threadSmoothnessScale.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawThreadMap(editor);
            DrawThreadMapSettings(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, DetailInputsKeywords.ThreadMap, _threadTexture.HasTexture(material));

        private void DrawThreadMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(FabricStyles.ThreadMap, _threadTexture.MaterialProperty);

        private void DrawThreadMapSettings(MaterialEditorGUIPlus editor)
        {
            if (_threadTexture.MaterialProperty.textureValue is null)
                return;

            DrawThreadAOScale(editor);
            DrawThreadNormalScale(editor);
            DrawThreadSmoothnessScale(editor);
        }

        private void DrawThreadAOScale(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(FabricStyles.ThreadAOScale, _threadAOScale.MaterialProperty);

        private void DrawThreadNormalScale(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(FabricStyles.ThreadNormalScale, _threadNormalScale.MaterialProperty);

        private void DrawThreadSmoothnessScale(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(FabricStyles.ThreadSmoothnessScale, _threadSmoothnessScale.MaterialProperty);
    }
}