using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class SpecularMap : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _workflow = new(LitSurfaceOptionsProperties.WorkflowMode);
        private ShaderProperty _specularColor = new(LitSurfaceInputsProperties.SpecularColor);
        private ShaderProperty _specularColorMap = new(LitSurfaceInputsProperties.SpecularColorMap);

        public SpecularMap(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _specularColor.Find(properties);
            _specularColorMap.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            WorkflowMode workflowMode = GetWorkflow();
            if (workflowMode is WorkflowMode.Metallic)
                return;

            DrawSpecularMap(editor);
        }

        public void SetKeywords(Material material)
        { }

        private void DrawSpecularMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(SurfaceInputsStyles.SpecularColor, 
                _specularColorMap.MaterialProperty, _specularColor.MaterialProperty);

        private WorkflowMode GetWorkflow()
        {
            if (!HasWorkflow())
                return WorkflowMode.Specular;

            return (WorkflowMode)_material.GetFloat(_workflow.ID);
        }

        private bool HasWorkflow() =>
            _material.HasProperty(_workflow.ID);
    }
}