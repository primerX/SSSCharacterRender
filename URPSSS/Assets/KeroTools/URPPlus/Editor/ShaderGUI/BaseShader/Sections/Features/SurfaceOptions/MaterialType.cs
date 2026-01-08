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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions
{
    public sealed class MaterialType : IFeature
    {
        private ShaderProperty _type = new(LitSurfaceOptionsProperties.MaterialType);
        private ShaderProperty _enableTransmission = new(LitSurfaceOptionsProperties.EnableTransmission);
        private readonly ShaderProperty _diffusionLut = new(LitSurfaceInputsProperties.DiffusionLUT);

        public void FindProperties(MaterialProperty[] properties)
        {
            _type.Find(properties);
            _enableTransmission.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawMaterialType(editor);

            if (IsSubSurfaceScatteringMode()) 
                DrawEnableTransmission(editor);
        }

        public void SetKeywords(Material material)
        {
            ResetKeywords(material);

            if (SurfaceOptionsKeywords.MaterialTypeKeywordMap.TryGetValue(GetMaterialTypeMode(), out string keyword)) 
                CoreUtils.SetKeyword(material, keyword, true);

            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.DiffusionLut, _diffusionLut.HasTexture(material));
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.MaterialFeatureTransmission, _enableTransmission.IsToggleEnabled(material));
        }

        private void DrawMaterialType(MaterialEditorGUIPlus editor) => 
            editor.DrawEnumPopup<MaterialTypeMode>(SurfaceOptionsStyles.MaterialID, _type.MaterialProperty);

        private void DrawEnableTransmission(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(SurfaceOptionsStyles.EnableTransmission, _enableTransmission.MaterialProperty, 1);

        private bool IsSubSurfaceScatteringMode() => 
            GetMaterialTypeMode() == MaterialTypeMode.SubSurfaceScattering;

        private MaterialTypeMode GetMaterialTypeMode() => 
            (MaterialTypeMode)_type.MaterialProperty.floatValue;

        private void ResetKeywords(Material material)
        {
            foreach (string keyword in SurfaceOptionsKeywords.MaterialTypeKeywordMap.Values) 
                CoreUtils.SetKeyword(material, keyword, false);
        }
    }
}