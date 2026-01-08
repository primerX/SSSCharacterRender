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
    public sealed class ThicknessCurvatureMap : IFeature
    {
        private readonly Material _material;
        private readonly MaterialTypeMode? _overrideMode;

        private readonly ShaderProperty _materialType = new(LitSurfaceOptionsProperties.MaterialType);
        private ShaderProperty _thicknessCurvatureTexture = new(LitSurfaceInputsProperties.ThicknessCurvatureMap);
        private ShaderProperty _curvature = new(LitSurfaceInputsProperties.Curvature);
        private ShaderProperty _thickness = new(LitSurfaceInputsProperties.Thickness);
        private ShaderProperty _thicknessCurvatureRemap = new(LitSurfaceInputsProperties.ThicknessCurvatureRemap);

        public ThicknessCurvatureMap(Material material, MaterialTypeMode? overrideMode = null)
        {
            _material = material;
            _overrideMode = overrideMode;
        }

        public void FindProperties(MaterialProperty[] properties)
        {
            _thicknessCurvatureTexture.Find(properties);
            _thickness.Find(properties);
            _curvature.Find(properties);
            _thicknessCurvatureRemap.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            MaterialTypeMode currentMaterialType = _overrideMode ?? GetMaterialType();

            if (currentMaterialType is MaterialTypeMode.SubSurfaceScattering)
                DrawThicknessCurvature(editor);
            else if (currentMaterialType is MaterialTypeMode.Translucency)
                DrawThickness(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.ThicknessCurvatureMap, 
                _thicknessCurvatureTexture.HasTexture(material));

        private void DrawThickness(MaterialEditorGUIPlus editor)
        {
            DrawThicknessMap(editor);

            if (_thicknessCurvatureTexture.HasTexture(_material))
                DrawThicknessRemap(editor);
            else
                DrawThicknessSlider(editor);
        }

        private void DrawThicknessMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(SubSurfaceScatteringStyles.ThicknessMap, _thicknessCurvatureTexture.MaterialProperty);

        private void DrawThicknessCurvature(MaterialEditorGUIPlus editor)
        {
            DrawThicknessCurvatureMap(editor);

            if (_thicknessCurvatureTexture.HasTexture(_material))
            {
                DrawThicknessRemap(editor);
                DrawCurvatureRemap(editor);
            }
            else
            {
                DrawThicknessSlider(editor);
                DrawCurvatureSlider(editor);
            }
        }

        private void DrawThicknessCurvatureMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(SubSurfaceScatteringStyles.ThicknessCurvatureMap, 
                _thicknessCurvatureTexture.MaterialProperty);

        private void DrawThicknessSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SubSurfaceScatteringStyles.Thickness, _thickness.MaterialProperty);

        private void DrawCurvatureSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SubSurfaceScatteringStyles.Curvature, _curvature.MaterialProperty);

        private void DrawThicknessRemap(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxVector4StartSlider(SubSurfaceScatteringStyles.ThicknessRemap,
                _thicknessCurvatureRemap.MaterialProperty);

        private void DrawCurvatureRemap(MaterialEditorGUIPlus editor) =>
            editor.DrawMinMaxVector4EndSlider(SubSurfaceScatteringStyles.CurvatureRemap,
                _thicknessCurvatureRemap.MaterialProperty);

        private MaterialTypeMode GetMaterialType()
        {
            if (_material.HasProperty(_materialType.ID))
                return (MaterialTypeMode)_material.GetFloat(_materialType.ID);

            return MaterialTypeMode.Standard;
        }
    }
}