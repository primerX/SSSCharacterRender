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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class Anisotropy : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _materialType = new(LitSurfaceOptionsProperties.MaterialType);
        private ShaderProperty _tangentMap = new(LitSurfaceInputsProperties.TangentMap);
        private ShaderProperty _anisotropyValue = new(LitSurfaceInputsProperties.Anisotropy);
        private ShaderProperty _anisotropyMap = new(LitSurfaceInputsProperties.AnisotropyMap);

        public Anisotropy(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _tangentMap.Find(properties);
            _anisotropyValue.Find(properties);
            _anisotropyMap.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            MaterialTypeMode materialType = GetMaterialType();

            if (materialType != MaterialTypeMode.Anisotropy)
                return;

            DrawProperties(editor);
        }

        public void SetKeywords(Material material)
        {
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.TangentMap, _tangentMap.HasTexture(material));
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.AnisotropyMap, _anisotropyMap.HasTexture(material));
        }

        private void DrawProperties(MaterialEditorGUIPlus editor)
        {
            DrawTangentMap(editor);
            DrawAnisotropy(editor);
            DrawAnisotropyMap(editor);
        }

        private void DrawTangentMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(AnisotropyStyles.TangentMap, _tangentMap.MaterialProperty);

        private void DrawAnisotropy(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(AnisotropyStyles.Anisotropy, _anisotropyValue.MaterialProperty, new FloatRange(-1.0f, 1.0f));
        
        private void DrawAnisotropyMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(AnisotropyStyles.AnisotropyMap, _anisotropyMap.MaterialProperty);

        private MaterialTypeMode GetMaterialType() => 
            (MaterialTypeMode)_material.GetFloat(_materialType.ID);
    }
}