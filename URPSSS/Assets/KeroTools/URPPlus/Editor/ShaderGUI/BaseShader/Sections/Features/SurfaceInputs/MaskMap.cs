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

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class MaskMap : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _workflow = new(LitSurfaceOptionsProperties.WorkflowMode);
        private ShaderProperty _maskTexture = new(LitSurfaceInputsProperties.MaskMap);
        private ShaderProperty _metallic = new(LitSurfaceInputsProperties.Metallic);
        private ShaderProperty _metallicMin = new(LitSurfaceInputsProperties.MetallicMin);
        private ShaderProperty _metallicMax = new(LitSurfaceInputsProperties.MetallicMax);
        private ShaderProperty _smoothness = new(LitSurfaceInputsProperties.Smoothness);
        private ShaderProperty _smoothnessMin = new(LitSurfaceInputsProperties.SmoothnessMin);
        private ShaderProperty _smoothnessMax = new(LitSurfaceInputsProperties.SmoothnessMax);
        private ShaderProperty _aoMin = new(LitSurfaceInputsProperties.AOMin);
        private ShaderProperty _aoMax = new(LitSurfaceInputsProperties.AOMax);

        public MaskMap(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _maskTexture.Find(properties);
            _metallic.Find(properties);
            _smoothness.Find(properties);
            _metallicMin.Find(properties);
            _metallicMax.Find(properties);
            _smoothnessMin.Find(properties);
            _smoothnessMax.Find(properties);
            _aoMin.Find(properties);
            _aoMax.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            WorkflowMode workflowMode = GetWorkflow();
            bool isMetallic = workflowMode is WorkflowMode.Metallic;

            DrawRemapSliders(editor, isMetallic);
            DrawMaskMap(editor, isMetallic);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceInputsKeywords.MaskMap, _maskTexture.HasTexture(material));

        private void DrawMaskMap(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            GUIContent maskMapContent = isMetallic ? SurfaceInputsStyles.MaskMap : SurfaceInputsStyles.MaskMapSpecular;

            editor.DrawSingleLineTexture(maskMapContent, _maskTexture.MaterialProperty);
        }

        private void DrawRemapSliders(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            if (HasMaskMap())
                DrawRemapping(editor, isMetallic);
            else
                DrawMetallicSmoothness(editor, isMetallic);
        }

        private void DrawRemapping(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            if (isMetallic)
                DrawMetallicRemapping(editor);

            DrawSmoothnessRemapping(editor);
            DrawAORemapping(editor);
        }

        private void DrawMetallicRemapping(MaterialEditorGUIPlus editor) => 
            editor.DrawMinMaxSlider(SurfaceInputsStyles.MetallicRemapping, _metallicMin.MaterialProperty, _metallicMax.MaterialProperty);

        private void DrawSmoothnessRemapping(MaterialEditorGUIPlus editor) => 
            editor.DrawMinMaxSlider(SurfaceInputsStyles.SmoothnessRemapping, _smoothnessMin.MaterialProperty, _smoothnessMax.MaterialProperty);

        private void DrawAORemapping(MaterialEditorGUIPlus editor) => 
            editor.DrawMinMaxSlider(SurfaceInputsStyles.AORemapping, _aoMin.MaterialProperty, _aoMax.MaterialProperty);

        private void DrawMetallicSmoothness(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            if (isMetallic)
                DrawMetallicSlider(editor);

            DrawSmoothnessSlider(editor);
        }

        private void DrawMetallicSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SurfaceInputsStyles.Metallic, _metallic.MaterialProperty);

        private void DrawSmoothnessSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SurfaceInputsStyles.Smoothness, _smoothness.MaterialProperty);

        private WorkflowMode GetWorkflow()
        {
            if (!_material.HasProperty(_workflow.ID))
                return WorkflowMode.Specular;

            return (WorkflowMode)_material.GetFloat(_workflow.ID);
        }

        private bool HasMaskMap() => 
            _maskTexture.HasTexture(_material);
    }
}