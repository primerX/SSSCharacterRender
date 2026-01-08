using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class TransparentCastShadow : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _surfaceType = new(LitSurfaceOptionsProperties.SurfaceType);
        private ShaderProperty _castShadows = new(LitAdvancedOptionsProperties.CastShadows);

        public TransparentCastShadow(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties) =>
            _castShadows.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor)
        {
            if (!IsTransparent())
                return;

            DrawCastShadow(editor);
        }

        public void SetKeywords(Material material)
        {
            bool castShadow = IsTransparent() ? IsShadowCastingEnabled(material) : IsOpaque();
            material.SetShaderPassEnabled("ShadowCaster", castShadow);
        }

        private void DrawCastShadow(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(AdvancedOptionsStyles.CastShadow, _castShadows.MaterialProperty, ToggleAlign.Right);

        private bool IsTransparent() => 
            (SurfaceTypeMode)_material.GetFloat(_surfaceType.ID) == SurfaceTypeMode.Transparent;

        private bool IsShadowCastingEnabled(Material material) => 
            _castShadows.IsToggleEnabled(material);
        
        private bool IsOpaque() => 
            (SurfaceTypeMode)_material.GetFloat(_surfaceType.ID) == SurfaceTypeMode.Opaque;
    }
}