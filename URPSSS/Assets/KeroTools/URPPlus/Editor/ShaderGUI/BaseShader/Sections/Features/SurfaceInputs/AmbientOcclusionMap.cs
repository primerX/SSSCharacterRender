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
    public sealed class AmbientOcclusionMap : IFeature
    {
        private ShaderProperty _occlusionMap = new(LitSurfaceInputsProperties.AmbientOcclusionMap);
        private ShaderProperty _aoRemapMin = new(LitSurfaceInputsProperties.AOMin);
        private ShaderProperty _aoRemapMax = new(LitSurfaceInputsProperties.AOMax);

        public void FindProperties(MaterialProperty[] properties)
        {
            _occlusionMap.Find(properties);
            _aoRemapMin.Find(properties);
            _aoRemapMax.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawAOMap(editor);

            if (_occlusionMap.MaterialProperty.textureValue is not null) 
                DrawAORemapping(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.AmbientOcclusionMap, _occlusionMap.HasTexture(material));

        private void DrawAOMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(SurfaceInputsStyles.AOMap, _occlusionMap.MaterialProperty);

        private void DrawAORemapping(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxSlider(SurfaceInputsStyles.AORemapping, _aoRemapMin.MaterialProperty,
                _aoRemapMax.MaterialProperty);
    }
}