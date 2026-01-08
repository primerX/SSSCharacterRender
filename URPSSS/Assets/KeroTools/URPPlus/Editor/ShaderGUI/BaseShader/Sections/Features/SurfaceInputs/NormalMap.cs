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
    public sealed class NormalMap : IFeature
    {
        private ShaderProperty _normalTexture = new(LitSurfaceInputsProperties.NormalMap);
        private ShaderProperty _normalMapScale = new(LitSurfaceInputsProperties.NormalScale);

        public void FindProperties(MaterialProperty[] properties)
        {
            _normalTexture.Find(properties);
            _normalMapScale.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawNormalMap(editor);

        private void DrawNormalMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineNormalTexture(SurfaceInputsStyles.NormalMap, _normalTexture.MaterialProperty, _normalMapScale.MaterialProperty);

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.NormalMap, _normalTexture.HasTexture(material));
    }
}