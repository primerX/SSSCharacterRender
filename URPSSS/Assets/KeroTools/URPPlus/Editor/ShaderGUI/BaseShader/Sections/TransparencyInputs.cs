using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEditor;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public class TransparencyInputs : MaterialSection
    {
        private readonly Material _material;
        
        private readonly ShaderProperty _surfaceType = new(LitSurfaceOptionsProperties.SurfaceType);
        private ShaderProperty _refractionEnable = new(TransparencyInputsProperties.RefractionEnable);
        private ShaderProperty _ior = new(TransparencyInputsProperties.Ior);

        private ShaderProperty _thickness = new(TransparencyInputsProperties.Thickness);
        private ShaderProperty _thicknessCurvatureMap = new(TransparencyInputsProperties.ThicknessCurvatureMap);
        private ShaderProperty _thicknessCurvatureRemap = new(TransparencyInputsProperties.ThicknessCurvatureRemap);

        private ShaderProperty _transmittanceColor = new(TransparencyInputsProperties.TransmittanceColor);
        private ShaderProperty _transmittanceColorMap = new(TransparencyInputsProperties.TransmittanceColorMap);
        private ShaderProperty _atDistance = new(TransparencyInputsProperties.AtDistance);

        private ShaderProperty _refractionShadowAttenuation = new(TransparencyInputsProperties.RefractionShadowAttenuation);
        private ShaderProperty _chromaticAberrationEnable = new(TransparencyInputsProperties.ChromaticAberrationEnable);
        private ShaderProperty _chromaticAberration = new(TransparencyInputsProperties.ChromaticAberration);

        public TransparencyInputs(Material material) : base(TransparencyStyles.Label) => 
            _material = material;

        public override void FindProperties(MaterialProperty[] properties)
        {
            SurfaceTypeMode surfaceType = (SurfaceTypeMode)_material.GetFloat(_surfaceType.ID);
            IsRendered = surfaceType == SurfaceTypeMode.Transparent;

            _refractionEnable.Find(properties);
            _ior.Find(properties);
            _thickness.Find(properties);
            _thicknessCurvatureMap.Find(properties);
            _thicknessCurvatureRemap.Find(properties);
            _transmittanceColor.Find(properties);
            _transmittanceColorMap.Find(properties);
            _atDistance.Find(properties);
            _refractionShadowAttenuation.Find(properties);
            _chromaticAberrationEnable.Find(properties);
            _chromaticAberration.Find(properties);
        }

        public override void DrawProperties(MaterialEditorGUIPlus editor)
        {
            bool refractionToggle = DrawRefractionToggle(editor);

            if (!refractionToggle)
                return;

            editor.DrawIndented(1, () =>
            {
                DrawIorSlider(editor);
                DrawTransmittanceMap(editor);
                DrawChromaticAberration(editor);
                DrawRefractionShadowAttenuationSlider(editor);
            });
        }

        public override void SetKeywords(Material material)
        {
            CoreUtils.SetKeyword(material, "_REFRACTION", _refractionEnable.IsToggleEnabled(material) && IsRendered);
            CoreUtils.SetKeyword(material, "_CHROMATIC_ABERRATION", _chromaticAberrationEnable.IsToggleEnabled(material));
        }

        private bool DrawRefractionToggle(MaterialEditorGUIPlus editor) => 
            editor.DrawBooleanPopup<BoolMode>(TransparencyStyles.EnableRefraction, _refractionEnable.MaterialProperty) is BoolMode.On;

        private void DrawIorSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(TransparencyStyles.RefractionIor, _ior.MaterialProperty, new FloatRange(-1.0f, 1.0f));

        private void DrawTransmittanceMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTexture(TransparencyStyles.TransmittanceColor, 
                _transmittanceColorMap.MaterialProperty, _transmittanceColor.MaterialProperty);

        private void DrawChromaticAberration(MaterialEditorGUIPlus editor)
        {
            bool chromaticAberrationToggle = DrawChromaticAberrationToggle(editor);

            if (!chromaticAberrationToggle)
                return;
            
            editor.DrawIndented(1, () => DrawAberrationSlider(editor));
        }

        private bool DrawChromaticAberrationToggle(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(TransparencyStyles.EnableChromaticAberration, _chromaticAberrationEnable.MaterialProperty, ToggleAlign.Right);

        private void DrawAberrationSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(TransparencyStyles.ChromaticAberration, _chromaticAberration.MaterialProperty);
        
        private void DrawRefractionShadowAttenuationSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(TransparencyStyles.RefractionShadowAttenuation, _refractionShadowAttenuation.MaterialProperty);
    }
}