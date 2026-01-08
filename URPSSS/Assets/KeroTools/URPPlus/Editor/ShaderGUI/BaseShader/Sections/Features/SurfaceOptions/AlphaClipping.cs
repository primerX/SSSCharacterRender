using System;
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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions
{
    public sealed class AlphaClipping : IFeature
    {
        private ShaderProperty _alphaCutoffEnable = new(LitSurfaceOptionsProperties.AlphaCutoffEnable);
        private ShaderProperty _alphaCutoff = new(LitSurfaceOptionsProperties.AlphaCutoff);
        private ShaderProperty _useShadowThreshold = new(LitSurfaceOptionsProperties.UseShadowThreshold);
        private ShaderProperty _alphaCutoffShadow = new(LitSurfaceOptionsProperties.AlphaCutoffShadow);
        private ShaderProperty _alphaToMask = new(LitSurfaceOptionsProperties.AlphaToMask);

        public void FindProperties(MaterialProperty[] properties)
        {
            _alphaCutoffEnable.Find(properties);
            _alphaCutoff.Find(properties);

            _useShadowThreshold.Find(properties);
            _alphaCutoffShadow.Find(properties);

            _alphaToMask.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            bool alphaCutoffEnabled = DrawAlphaCutoff(editor);

            if (!alphaCutoffEnabled)
                return;

            DrawShadowAlphaCutoff(editor);
            DrawAlphaToMask(editor);
        }

        public void SetKeywords(Material material)
        {
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.AlphaTest, _alphaCutoffEnable.IsToggleEnabled(material));
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.ShadowCutoff, _useShadowThreshold.IsToggleEnabled(material));
        }

        private bool DrawAlphaCutoff(MaterialEditorGUIPlus editor)
        {
            return DrawCutoff(editor, SurfaceOptionsStyles.AlphaCutoffEnable, _alphaCutoffEnable,
                DrawIndentedAlphaThreshold);
            
            void DrawIndentedAlphaThreshold() =>
                DrawAlphaThreshold(editor);
        }

        private bool DrawShadowAlphaCutoff(MaterialEditorGUIPlus editor)
        {
            return DrawCutoff(editor, SurfaceOptionsStyles.UseShadowThreshold, _useShadowThreshold,
                DrawIndentedShadowAlphaThreshold, 1);
            
            void DrawIndentedShadowAlphaThreshold() =>
                DrawShadowAlphaThreshold(editor);
        }

        private void DrawAlphaThreshold(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(SurfaceOptionsStyles.AlphaCutoff, _alphaCutoff.MaterialProperty);

        private void DrawShadowAlphaThreshold(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(SurfaceOptionsStyles.AlphaCutoffShadow, _alphaCutoffShadow.MaterialProperty);

        private void DrawAlphaToMask(MaterialEditorGUIPlus editor) =>
            editor.DrawToggle(SurfaceOptionsStyles.AlphaToMask, _alphaToMask.MaterialProperty, ToggleAlign.Right, 1);

        private bool DrawCutoff(MaterialEditorGUIPlus editor, GUIContent label, ShaderProperty property, Action drawAction, int indentLevel = 0)
        {
            bool isEnabled = editor.DrawToggle(label, property.MaterialProperty, ToggleAlign.Right, indentLevel);
            if (isEnabled) 
                editor.DrawIndented(indentLevel + 1, drawAction);
            
            return isEnabled;
        }
    }
}