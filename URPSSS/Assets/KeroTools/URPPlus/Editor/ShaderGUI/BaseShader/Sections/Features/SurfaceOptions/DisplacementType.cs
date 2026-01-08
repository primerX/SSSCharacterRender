using System;
using EditorGUIPlus.Data.Range;
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
    public sealed class DisplacementType : IFeature
    {
        private readonly Material _material;

        private ShaderProperty _displacementMode = new(DisplacementProperties.DisplacementMode);
        private readonly ShaderProperty _tessellationMode = new(DisplacementProperties.TessellationMode);
        private ShaderProperty _lockWithObjectScale = new(DisplacementProperties.DisplacementLockObjectScale);
        private ShaderProperty _lockTilingScale = new(DisplacementProperties.DisplacementLockTilingScale);

        private ShaderProperty _ppdMinSamples = new(DisplacementProperties.PPDMinSamples);
        private ShaderProperty _ppdMaxSamples = new(DisplacementProperties.PPDMaxSamples);
        private ShaderProperty _ppdLodThreshold = new(DisplacementProperties.PPDLodThreshold);
        private ShaderProperty _ppdPrimitiveLength = new(DisplacementProperties.PPDPrimitiveLength);
        private ShaderProperty _ppdPrimitiveWidth = new(DisplacementProperties.PPDPrimitiveWidth);
        private ShaderProperty _invPrimScale = new(DisplacementProperties.InvPrimScale);
        private ShaderProperty _depthOffset = new(DisplacementProperties.DepthOffset);

        public DisplacementType(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _displacementMode.Find(properties);
            _lockWithObjectScale.Find(properties);
            _lockTilingScale.Find(properties);

            _ppdMinSamples.Find(properties);
            _ppdMaxSamples.Find(properties);
            _ppdLodThreshold.Find(properties);
            _ppdPrimitiveLength.Find(properties);
            _ppdPrimitiveWidth.Find(properties);
            _invPrimScale.Find(properties);
            _depthOffset.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DisplacementMode mode = GetDisplacementMode();

            DrawDisplacementMode(editor);
            if (mode != DisplacementMode.None)
            {
                DrawLockWithObjectScale(editor);
                DrawLockWithTilingRate(editor);
            }
            if (mode == DisplacementMode.PixelDisplacement)
            {
                DrawPPDProperties(editor);
            }
        }

        public void SetKeywords(Material material)
        {
            float displacementModeValue = material.GetFloat(_displacementMode.ID);
            
            if (HasTessellationMode())
                SetTessellationDisplacementKeywords(material, displacementModeValue);
            else
                SetDisplacementKeywords(material, displacementModeValue);

            SetLockWithObjectScaleKeywords(material);
            SetDepthOffsetKeyword(material);
        }

        private DisplacementMode GetDisplacementMode() => 
            (DisplacementMode)_displacementMode.MaterialProperty.floatValue;

        private bool HasTessellationMode() => 
            _material.HasProperty(_tessellationMode.ID);

        private void DrawDisplacementMode(MaterialEditorGUIPlus editor)
        {
            if (HasTessellationMode())
                editor.DrawEnumPopup<TessDisplacementMode>(SurfaceOptionsStyles.DisplacementMode,
                    _displacementMode.MaterialProperty);
            else
                editor.DrawEnumPopup<DisplacementMode>(SurfaceOptionsStyles.DisplacementMode, 
                    _displacementMode.MaterialProperty);
        }

        private void DrawLockWithObjectScale(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(SurfaceOptionsStyles.LockWithObjectScale, _lockWithObjectScale.MaterialProperty, 1);

        private void DrawLockWithTilingRate(MaterialEditorGUIPlus editor) => 
            editor.DrawToggle(SurfaceOptionsStyles.LockWithTilingRate, _lockTilingScale.MaterialProperty, 1);

        private void DrawPPDProperties(MaterialEditorGUIPlus editor)
        {
            EditorGUILayout.Space();
            editor.DrawIntSlider(PPDStyles.PpdMinSamples, _ppdMinSamples.MaterialProperty, new IntRange(1, 64), 1);
            editor.DrawIntSlider(PPDStyles.PpdMaxSamples, _ppdMaxSamples.MaterialProperty, new IntRange(1, 64),1);
            editor.DrawSlider(PPDStyles.PpdLodThreshold, _ppdLodThreshold.MaterialProperty, new FloatRange(0, 16),1);
            DrawPrimitiveScale(editor, 1);
            editor.DrawToggle(PPDStyles.DepthOffsetEnable, _depthOffset.MaterialProperty, 1);
        }

        private void DrawPrimitiveScale(MaterialEditorGUIPlus editor, int indentLevel = 0)
        {
            editor.DrawMinFloat(PPDStyles.PpdPrimitiveLength, _ppdPrimitiveLength.MaterialProperty, 0.01f,
                indentLevel);
            editor.DrawMinFloat(PPDStyles.PpdPrimitiveWidth, _ppdPrimitiveWidth.MaterialProperty, 0.01f,
                indentLevel);
            _invPrimScale.MaterialProperty.vectorValue =
                new Vector4(1.0f / _ppdPrimitiveLength.MaterialProperty.floatValue,
                    1.0f / _ppdPrimitiveWidth.MaterialProperty.floatValue);
        }

        private void SetDisplacementKeywords(Material material, float displacementModeValue)
        {
            DisableAllKeywords(material);

            DisplacementMode displacementModeEnum = (DisplacementMode)displacementModeValue;
            switch (displacementModeEnum)
            {
                case DisplacementMode.VertexDisplacement:
                    material.EnableKeyword(DisplacementKeywords.VertexDisplacement);
                    break;
                case DisplacementMode.PixelDisplacement:
                    material.EnableKeyword(DisplacementKeywords.PixelDisplacement);
                    break;
                case DisplacementMode.None:
                    DisableAllKeywords(material);
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private void SetTessellationDisplacementKeywords(Material material, float displacementModeValue)
        {
            bool isTessellationMode = (TessDisplacementMode)displacementModeValue == TessDisplacementMode.Tessellation;
            
            if (isTessellationMode)
                material.EnableKeyword(DisplacementKeywords.TessellationDisplacement);
            else
                DisableAllKeywords(material);
        }

        private void DisableAllKeywords(Material material)
        {
            material.DisableKeyword(DisplacementKeywords.VertexDisplacement);
            material.DisableKeyword(DisplacementKeywords.PixelDisplacement);
            material.DisableKeyword(DisplacementKeywords.TessellationDisplacement);
        }

        private void SetLockWithObjectScaleKeywords(Material material)
        {
            bool lockObjectScaleEnabled = _lockWithObjectScale.IsToggleEnabled(material);
            CoreUtils.SetKeyword(material, DisplacementKeywords.VertexDisplacementLockObjectScale, lockObjectScaleEnabled);
            CoreUtils.SetKeyword(material, DisplacementKeywords.PixelDisplacementLockObjectScale, lockObjectScaleEnabled);
            CoreUtils.SetKeyword(material, DisplacementKeywords.LockTilingScale, _lockTilingScale.IsToggleEnabled(material));
        }

        private void SetDepthOffsetKeyword(Material material) => 
            CoreUtils.SetKeyword(material, DisplacementKeywords.DepthOffset, _depthOffset.IsToggleEnabled(material));
    }
}