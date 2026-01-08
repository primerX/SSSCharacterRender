using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class ClearCoatNormal : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _clearCoatMask = new(LitSurfaceInputsProperties.ClearCoatMask);
        private ShaderProperty _coatNormalEnable = new(LitAdvancedOptionsProperties.CoatNormalEnabled);

        public ClearCoatNormal(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties) =>
            _coatNormalEnable.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) => 
            DrawSecondaryClearCoatNormalToggle(editor);

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.CoatNormalMap, _coatNormalEnable.IsToggleEnabled(material));

        private void DrawSecondaryClearCoatNormalToggle(MaterialEditorGUIPlus editor)
        {
            float clearCoatMask = _material.GetFloat(_clearCoatMask.ID);
            if (clearCoatMask <= 0.0f)
                return;
            
            editor.DrawToggle(AdvancedOptionsStyles.SecondaryClearCoatNormal, _coatNormalEnable.MaterialProperty,
                ToggleAlign.Right);
        }
    }
}