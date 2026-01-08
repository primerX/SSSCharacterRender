using System;
using EditorGUIPlus.Data.Enums;
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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public sealed class TessellationOptions : MaterialSection
    {
        private ShaderProperty _tessellationMode = new(TessellationOptionsProperties.TessellationMode);
        private ShaderProperty _phongTessellationEnable = new(TessellationOptionsProperties.PhongTessellationEnable);
        private ShaderProperty _tessellationShapeFactor = new(TessellationOptionsProperties.TessellationShapeFactor);
        private ShaderProperty _tessellationFactor = new(TessellationOptionsProperties.TessellationFactor);
        private ShaderProperty _tessellationEdgeLength = new(TessellationOptionsProperties.TessellationEdgeLength);

        private ShaderProperty _tessellationFactorMinDistance = new(TessellationOptionsProperties.TessellationFactorMinDistance);
        private ShaderProperty _tessellationFactorMaxDistance = new(TessellationOptionsProperties.TessellationFactorMaxDistance);
        private ShaderProperty _tessellationBackFaceCullEpsilon = new(TessellationOptionsProperties.TessellationBackFaceCullEpsilon);

        public TessellationOptions() : base(TessellationStyles.Label)
        { }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _tessellationMode.Find(properties);
            _phongTessellationEnable.Find(properties);
            _tessellationShapeFactor.Find(properties);
            _tessellationFactor.Find(properties);
            _tessellationEdgeLength.Find(properties);
            _tessellationFactorMinDistance.Find(properties);
            _tessellationFactorMaxDistance.Find(properties);
            _tessellationBackFaceCullEpsilon.Find(properties);
        }

        public override void DrawProperties(MaterialEditorGUIPlus editor)
        {
            DrawTessellationMode(editor);
            DrawPhongTessellationToggle(editor);
            DrawTessellationFactor(editor);
            DrawModeBasedProperties(editor);
            DrawCullingSlider(editor);
        }

        public override void SetKeywords(Material material)
        {
            SetTessellationModeKeywords(material);
            SetPhongTessellationKeyword(material);
        }
        
        private void SetTessellationModeKeywords(Material material)
        {
            TessellationMode tessellationModeEnum = (TessellationMode)material.GetFloat(_tessellationMode.ID);

            switch (tessellationModeEnum)
            {
                case TessellationMode.None:
                    material.DisableKeyword(TessellationKeywords.TessellationDistance);
                    material.DisableKeyword(TessellationKeywords.TessellationEdge);
                    break;
                case TessellationMode.EdgeLength:
                    material.DisableKeyword(TessellationKeywords.TessellationDistance);
                    material.EnableKeyword(TessellationKeywords.TessellationEdge);
                    break;
                case TessellationMode.Distance:
                    material.DisableKeyword(TessellationKeywords.TessellationEdge);
                    material.EnableKeyword(TessellationKeywords.TessellationDistance);
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private void SetPhongTessellationKeyword(Material material)
        {
            bool phongTessellationState = _phongTessellationEnable.IsToggleEnabled(material);
            CoreUtils.SetKeyword(material, TessellationKeywords.TessellationPhong, phongTessellationState);
        }

        private void DrawTessellationMode(MaterialEditorGUIPlus editor) => 
            editor.DrawEnumPopup<TessellationMode>(TessellationStyles.Mode, _tessellationMode.MaterialProperty);

        private void DrawPhongTessellationToggle(MaterialEditorGUIPlus editor)
        {
            bool phongTessellation = editor.DrawToggle(TessellationStyles.PhongTessellation, 
                _phongTessellationEnable.MaterialProperty, ToggleAlign.Right);

            if (phongTessellation)
                editor.DrawSlider(TessellationStyles.ShapeFactor, _tessellationShapeFactor.MaterialProperty);
        }

        private void DrawModeBasedProperties(MaterialEditorGUIPlus editor)
        {
            TessellationMode mode = GetTessellationMode();
            
            if (mode == TessellationMode.EdgeLength)
                DrawTriangleSizeTessellation(editor);

            if (mode == TessellationMode.Distance)
                DrawDistanceTessellation(editor);
        }

        private void DrawTessellationFactor(MaterialEditorGUIPlus editor) =>
            editor.DrawIntSlider(TessellationStyles.Factor, _tessellationFactor.MaterialProperty, new IntRange(1, 64));

        private void DrawTriangleSizeTessellation(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(TessellationStyles.FactorTriangleSize, _tessellationEdgeLength.MaterialProperty, new FloatRange(5.0f, 100.0f));

        private void DrawDistanceTessellation(MaterialEditorGUIPlus editor)
        {
            editor.DrawFloat(TessellationStyles.FactorMinDistance, _tessellationFactorMinDistance.MaterialProperty);
            editor.DrawFloat(TessellationStyles.FactorMaxDistance, _tessellationFactorMaxDistance.MaterialProperty);
        }

        private void DrawCullingSlider(MaterialEditorGUIPlus editor) =>
            editor.DrawSlider(TessellationStyles.BackFaceCullEpsilon, _tessellationBackFaceCullEpsilon.MaterialProperty, new FloatRange(-1.0f, 0.0f));

        private TessellationMode GetTessellationMode() =>
            (TessellationMode)_tessellationMode.MaterialProperty.floatValue;
    }
}