using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using KeroTools.URPPlus.Runtime;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class Iridescence : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _materialType = new(LitSurfaceOptionsProperties.MaterialType);
        private ShaderProperty _iridescenceLUT = new(LitSurfaceInputsProperties.IridescenceLUT);
        private ShaderProperty _iridescenceMaskMap = new(LitSurfaceInputsProperties.IridescenceMaskMap);
        private ShaderProperty _iridescenceMaskScale = new(LitSurfaceInputsProperties.IridescenceMaskScale);
        private ShaderProperty _iridescenceShift = new(LitSurfaceInputsProperties.IridescenceShift);
        private ShaderProperty _iridescenceThicknessMap = new(LitSurfaceInputsProperties.IridescenceThicknessMap);
        private ShaderProperty _iridescenceThickness = new(LitSurfaceInputsProperties.IridescenceThickness);
        private ShaderProperty _iridescenceThicknessRemap = new(LitSurfaceInputsProperties.IridescenceThicknessRemap);

        public Iridescence(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _iridescenceLUT.Find(properties);
            _iridescenceShift.Find(properties);
            _iridescenceThicknessMap.Find(properties);
            _iridescenceThickness.Find(properties);
            _iridescenceThicknessRemap.Find(properties);
            _iridescenceMaskMap.Find(properties);
            _iridescenceMaskScale.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            MaterialTypeMode currentMaterialType = GetMaterialType();

            if (currentMaterialType != MaterialTypeMode.Iridescence)
                return;

            DrawIridescenceLUT(editor);
            DrawIridescenceMask(editor);
            DrawIridescenceThickness(editor);
        }

        public void SetKeywords(Material material) =>
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.IridescenceThicknessMap,
                _iridescenceThicknessMap.HasTexture(material));

        private void DrawIridescenceLUT(MaterialEditorGUIPlus editor)
        {
            if (URPPlusSettings.useIridescenceLUT) 
                DrawIridescenceLut(editor);
        }

        private void DrawIridescenceLut(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(IridescenceStyles.IridescenceLut,
                _iridescenceLUT.MaterialProperty, _iridescenceShift.MaterialProperty);

        private void DrawIridescenceMask(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(IridescenceStyles.IridescenceMask,
                _iridescenceMaskMap.MaterialProperty, _iridescenceMaskScale.MaterialProperty);

        private void DrawIridescenceThickness(MaterialEditorGUIPlus editor)
        {
            if (_iridescenceThicknessMap.MaterialProperty.textureValue != null)
            {
                editor.DrawSingleLineTexture(IridescenceStyles.IridescenceThicknessMap, _iridescenceThicknessMap.MaterialProperty);
                DrawIridescenceThicknessRemap(editor);
            }
            else
            {
                editor.DrawSingleLineTexture(IridescenceStyles.IridescenceThicknessMap,
                    _iridescenceThicknessMap.MaterialProperty, _iridescenceThickness.MaterialProperty);
            }
        }

        private void DrawIridescenceThicknessRemap(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxVector4StartSlider(IridescenceStyles.IridescenceThicknessRemap,
                _iridescenceThicknessRemap.MaterialProperty);

        private MaterialTypeMode GetMaterialType()
        {
            if (_material.HasProperty(_materialType.ID))
                return (MaterialTypeMode)_material.GetFloat(_materialType.ID);

            return MaterialTypeMode.Standard;
        }
    }
}