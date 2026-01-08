using System;
using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Data;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using BlendMode = UnityEngine.Rendering.BlendMode;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions
{
    public sealed class SurfaceType : IFeature
    {
        private readonly Material _material;
        
        private ShaderProperty _type = new(LitSurfaceOptionsProperties.SurfaceType);
        private ShaderProperty _blendMode = new(LitSurfaceOptionsProperties.BlendMode);
        private ShaderProperty _preserveSpecular = new(LitSurfaceOptionsProperties.BlendModePreserveSpecular);
        private ShaderProperty _depthWrite = new(LitSurfaceOptionsProperties.DepthWrite);
        private ShaderProperty _depthTest = new(LitSurfaceOptionsProperties.DepthTest);
        private readonly ShaderProperty _srcBlend = new(LitSurfaceOptionsProperties.SrcBlend);
        private readonly ShaderProperty _dstBlend = new(LitSurfaceOptionsProperties.DstBlend);
        private readonly ShaderProperty _srcBlendAlpha = new(LitSurfaceOptionsProperties.SrcBlendAlpha);
        private readonly ShaderProperty _dstBlendAlpha = new(LitSurfaceOptionsProperties.DstBlendAlpha);
        private readonly ShaderProperty _alphaCutoffEnable = new(LitSurfaceOptionsProperties.AlphaCutoffEnable);
        private readonly ShaderProperty _queueOffset = new(LitAdvancedOptionsProperties.QueueOffset);

        private TransparentBlendValues _transparentBlendValues;

        public SurfaceType(Material material) => 
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _type.Find(properties);
            _blendMode.Find(properties);
            _preserveSpecular.Find(properties);
            _depthWrite.Find(properties);
            _depthTest.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            bool isTransparent = DrawSurfaceType(editor) is SurfaceTypeMode.Transparent;
            if (!isTransparent)
                return;

            editor.DrawIndented(1, DrawSurfaceTypeSettings);
            return;

            void DrawSurfaceTypeSettings()
            {
                DrawBlendMode(editor);
                DrawDepthWrite(editor);
                DrawDepthTest(editor);
            }
        }


        public void SetKeywords(Material material)
        {
            SetupMaterialBlendModeInternal(material, out int renderQueue);

            // apply automatic render queue
            if (renderQueue != material.renderQueue)
                material.renderQueue = renderQueue;
        }

        private SurfaceTypeMode DrawSurfaceType(MaterialEditorGUIPlus editor)
        {
            editor.DrawEnumPopup<SurfaceTypeMode>(SurfaceOptionsStyles.SurfaceType, _type.MaterialProperty);

            return (SurfaceTypeMode)_type.MaterialProperty.floatValue;
        }

        private void DrawBlendMode(MaterialEditorGUIPlus editor)
        {
            editor.DrawEnumPopup<TransparentBlendMode>(SurfaceOptionsStyles.BlendingMode, _blendMode.MaterialProperty);

            DrawPreserveSpecular(editor);
        }

        private void DrawPreserveSpecular(MaterialEditorGUIPlus editor)
        {
            if (!_material.HasProperty(_preserveSpecular.ID))
                return;

            TransparentBlendMode transparentBlendMode = GetBlendMode(_material);
            bool isDisabled = transparentBlendMode is TransparentBlendMode.Multiply or TransparentBlendMode.Premultiply;

            if (isDisabled)
                return;

            editor.DrawToggle(SurfaceOptionsStyles.PreserveSpecular, _preserveSpecular.MaterialProperty, 1);
        }

        private void DrawDepthWrite(MaterialEditorGUIPlus editor) =>
            editor.DrawToggle(SurfaceOptionsStyles.ZWriteEnable, _depthWrite.MaterialProperty, ToggleAlign.Right);

        private void DrawDepthTest(MaterialEditorGUIPlus editor) =>
            editor.DrawEnumPopup<CompareFunction>(SurfaceOptionsStyles.TransparentZTest, _depthTest.MaterialProperty);

        private void SetupMaterialBlendModeInternal(Material material, out int automaticRenderQueue)
        {
            if (material == null)
                throw new ArgumentNullException(nameof(material));

            // Default is to use the shader render queue
            int renderQueue = material.shader.renderQueue;
            ClearOverrideRenderTypeTag(material);
            
            if (material.HasProperty(_type.ID))
            {
                SetSurfaceType(material, out bool zWrite, out renderQueue);
                SetMaterialZWriteProperty(material, zWrite);
                SetDepthOnlyPass(material, zWrite);
            }
            else
            {
                SetDepthOnlyPass(material, true);
            }

            // Must always apply queue offset, even if not set to material control
            if (material.HasProperty(_queueOffset.ID))
                renderQueue += (int)material.GetFloat(_queueOffset.ID);

            automaticRenderQueue = renderQueue;
        }

        private void SetSurfaceType(Material material, out bool zWrite, out int renderQueue)
        {
            SurfaceTypeMode surfaceType = (SurfaceTypeMode)material.GetFloat(_type.ID);
                
            if (surfaceType is SurfaceTypeMode.Opaque)
                SetupOpaqueSurface(material, out renderQueue, out zWrite);
            else // SurfaceType Transparent
                SetupTransparentSurface(material, out renderQueue, out zWrite);
        }

        private void ClearOverrideRenderTypeTag(Material material) => 
            material.SetOverrideTag("RenderType", "");

        private void SetDepthOnlyPass(Material material, bool zWrite) => 
            material.SetShaderPassEnabled("DepthOnly", zWrite);

        private void SetMaterialZWriteProperty(Material material, bool zWriteEnabled)
        {
            if (material.HasProperty(_depthWrite.ID))
                material.SetFloat(_depthWrite.ID, zWriteEnabled ? 1.0f : 0.0f);
        }

        private void SetupOpaqueSurface(Material material, out int renderQueue, out bool zWrite)
        {
            SetOpaqueBlendMode(material);

            bool alphaClip = material.HasProperty(_alphaCutoffEnable.ID) && _alphaCutoffEnable.IsToggleEnabled(material);
            material.SetOverrideTag("RenderType", alphaClip ? "TransparentCutout" : "Opaque");
            zWrite = true;
            material.DisableKeyword(SurfaceOptionsKeywords.SurfaceTypeTransparent);
            renderQueue = alphaClip ? (int)RenderQueue.AlphaTest : (int)RenderQueue.Geometry;
        }

        private void SetupTransparentSurface(Material material, out int renderQueue, out bool zWrite)
        {
            SetTransparentBlendMode(material);

            material.SetOverrideTag("RenderType", "Transparent");
            zWrite = _depthWrite.IsToggleEnabled(material);
            material.EnableKeyword(SurfaceOptionsKeywords.SurfaceTypeTransparent);
            renderQueue = (int)RenderQueue.Transparent;
        }

        private void SetOpaqueBlendMode(Material material)
        {
            _transparentBlendValues.SetupOpaque();
            SetMaterialBlendProperties(material, _transparentBlendValues);
            material.DisableKeyword(SurfaceOptionsKeywords.AlphaPremultiply);
            material.DisableKeyword(SurfaceOptionsKeywords.AlphaModulate);
        }
        
        private void SetTransparentBlendMode(Material material)
        {
            TransparentBlendMode transparentBlendMode = GetBlendMode(material);

            switch (transparentBlendMode)
            {
                case TransparentBlendMode.Alpha:
                    _transparentBlendValues.SetupTransparentAlpha();
                    break;
                case TransparentBlendMode.Premultiply:
                    _transparentBlendValues.SetupTransparentPremultiply();
                    break;
                case TransparentBlendMode.Additive:
                    _transparentBlendValues.SetupTransparentAdditive();
                    break;
                case TransparentBlendMode.Multiply:
                    _transparentBlendValues.SetupTransparentMultiply();
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            bool preserveSpecular = material.HasProperty(_preserveSpecular.ID) &&
                                    _preserveSpecular.IsToggleEnabled(material) &&
                                    transparentBlendMode != TransparentBlendMode.Multiply &&
                                    transparentBlendMode != TransparentBlendMode.Premultiply;

            if (preserveSpecular) 
                _transparentBlendValues.SrcBlendRGB = BlendMode.One;
            
            SetMaterialBlendProperties(material, _transparentBlendValues);
            
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.AlphaPremultiply, preserveSpecular);
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.AlphaModulate, transparentBlendMode is 
                TransparentBlendMode.Multiply);
        }

        private void SetMaterialBlendProperties(Material material, TransparentBlendValues transparentBlendValues)
        {
            SetMaterialBlendProperty(material, _srcBlend, transparentBlendValues.SrcBlendRGB);
            SetMaterialBlendProperty(material, _dstBlend, transparentBlendValues.DstBlendRGB);
            SetMaterialBlendProperty(material, _srcBlendAlpha, transparentBlendValues.SrcBlendAlpha);
            SetMaterialBlendProperty(material, _dstBlendAlpha, transparentBlendValues.DstBlendAlpha);
        }

        private void SetMaterialBlendProperty(Material material, ShaderProperty property, BlendMode blendMode)
        {
            if (material.HasProperty(property.ID))
                material.SetFloat(property.ID, (float)blendMode);
        }

        private TransparentBlendMode GetBlendMode(Material material) => 
            (TransparentBlendMode)material.GetFloat(_blendMode.ID);
    }
}