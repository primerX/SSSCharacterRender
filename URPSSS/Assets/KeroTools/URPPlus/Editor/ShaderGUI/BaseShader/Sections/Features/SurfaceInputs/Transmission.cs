using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class Transmission : IFeature
    {
        private readonly Material _material;
        private readonly MaterialTypeMode? _overrideMode;

        private readonly ShaderProperty _materialType = new(LitSurfaceOptionsProperties.MaterialType);
        private readonly ShaderProperty _enableTransmission = new(LitSurfaceOptionsProperties.EnableTransmission);
        private ShaderProperty _transmissionScale = new(LitSurfaceInputsProperties.TransmissionScale);

        public Transmission(Material material, MaterialTypeMode? overrideMode = null)
        {
            _material = material;
            _overrideMode = overrideMode;
        }

        public void FindProperties(MaterialProperty[] properties) =>
            _transmissionScale.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor)
        {
            MaterialTypeMode currentMaterialType = _overrideMode ?? GetMaterialType();
            bool transmissionEnabled = _enableTransmission.IsToggleEnabled(_material);

            bool enabled = currentMaterialType == MaterialTypeMode.SubSurfaceScattering && transmissionEnabled;
            if (enabled)
                DrawTransmissionScale(editor);
        }

        public void SetKeywords(Material material)
        { }

        private void DrawTransmissionScale(MaterialEditorGUIPlus editor) => 
            editor.DrawMinFloat(SubSurfaceScatteringStyles.TransmissionScale, _transmissionScale.MaterialProperty);

        private MaterialTypeMode GetMaterialType() => 
            (MaterialTypeMode)_material.GetFloat(_materialType.ID);
    }
}