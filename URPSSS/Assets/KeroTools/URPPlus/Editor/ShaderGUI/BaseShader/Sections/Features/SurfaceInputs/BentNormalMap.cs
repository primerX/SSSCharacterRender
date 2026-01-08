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
    public sealed class BentNormalMap : IFeature
    {
        private ShaderProperty _bentNormalTexture = new(LitSurfaceInputsProperties.BentNormalMap);

        public void FindProperties(MaterialProperty[] properties) => 
            _bentNormalTexture.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawBentNormalMap(editor);

        private void DrawBentNormalMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineNormalTexture(SurfaceInputsStyles.BentNormalMap, _bentNormalTexture.MaterialProperty);

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.BentNormalMap, _bentNormalTexture.HasTexture(material));
    }
}