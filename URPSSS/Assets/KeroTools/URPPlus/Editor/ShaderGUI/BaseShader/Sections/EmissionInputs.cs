using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public sealed class EmissionInputs : MaterialSection
    {
        private readonly Material _material;
        private ShaderProperty _emissionColor = new(EmissionInputsProperties.EmissionColor);
        private ShaderProperty _emissionMap = new(EmissionInputsProperties.EmissionMap);
        private ShaderProperty _emissionScale = new(EmissionInputsProperties.EmissionScale);
        private ShaderProperty _emissionWithBase = new(EmissionInputsProperties.EmissionWithBase);
        private ShaderProperty _enableEmissionFresnel = new(EmissionInputsProperties.EnableEmissionFresnel);
        private ShaderProperty _emissionFresnelPower = new(EmissionInputsProperties.EmissionFresnelPower);

        public EmissionInputs(Material material) : base(EmissionInputsStyles.Label) =>
            _material = material;

        public override void FindProperties(MaterialProperty[] properties)
        {
            _emissionColor.Find(properties);
            _emissionMap.Find(properties);
            _emissionScale.Find(properties);
            _emissionWithBase.Find(properties);
            _enableEmissionFresnel.Find(properties);
            _emissionFresnelPower.Find(properties);
        }

        public override void DrawProperties(MaterialEditorGUIPlus editor)
        {
            EditorGUI.BeginChangeCheck();
            DrawEmissionMap(editor);
            DrawEmissionScale(editor);

            if (EditorGUI.EndChangeCheck())
                UpdateGlobalIlluminationFlags();

            DrawMultipliedEmission(editor);
            if(_material.HasProperty(_enableEmissionFresnel.ID))
                DrawEmissionFresnel(editor);

            DrawLightmapEmissionProperty(editor);
        }

        public override void SetKeywords(Material material)
        {
            CoreUtils.SetKeyword(material, EmissionKeywords.Emission, 
                _emissionColor.MaterialProperty.colorValue != Color.black);
            
            SetKeyword(material, EmissionKeywords.EmissionWithBase, _emissionWithBase);
            SetKeyword(material, EmissionKeywords.EmissionFresnel, _enableEmissionFresnel);
        }

        private void DrawEmissionMap(MaterialEditorGUIPlus editor) =>
            editor.DrawSingleLineTextureWithHDRColor(EmissionInputsStyles.EmissiveMap, 
                _emissionMap.MaterialProperty, _emissionColor.MaterialProperty, false);

        private void DrawEmissionScale(MaterialEditorGUIPlus editor) =>
            editor.DrawMinFloat(EmissionInputsStyles.EmissiveIntensity, _emissionScale.MaterialProperty);

        private void DrawEmissionFresnel(MaterialEditorGUIPlus editor)
        {
            bool isEnabledEmissionFresnel = editor.DrawToggle(EmissionInputsStyles.EmissionFresnel,
                    _enableEmissionFresnel.MaterialProperty, 1);

            if (isEnabledEmissionFresnel)
                editor.DrawMinFloat(EmissionInputsStyles.EmissionFresnelPower,
                    _emissionFresnelPower.MaterialProperty, 0.01f, 2);
        }

        private void DrawMultipliedEmission(MaterialEditorGUIPlus editor) =>
            editor.DrawToggle(EmissionInputsStyles.AlbedoAffectEmissive, _emissionWithBase.MaterialProperty, 1);

        private void UpdateGlobalIlluminationFlags()
        {
            float brightness = _emissionColor.MaterialProperty.colorValue.maxColorComponent *
                               _emissionScale.MaterialProperty.floatValue;
            _material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.BakedEmissive;

            if (brightness <= 0f)
                _material.globalIlluminationFlags |= MaterialGlobalIlluminationFlags.EmissiveIsBlack;
        }

        private static void DrawLightmapEmissionProperty(MaterialEditorGUIPlus editor) => 
            editor.MaterialEditor.LightmapEmissionProperty();

        private void SetKeyword(Material material, string keyword, ShaderProperty property) =>
            CoreUtils.SetKeyword(material, keyword, property.IsToggleEnabled(material));
    }
}