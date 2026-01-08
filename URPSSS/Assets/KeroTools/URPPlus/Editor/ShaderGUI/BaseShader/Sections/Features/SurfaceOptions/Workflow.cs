using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions
{
    public sealed class Workflow : IFeature
    {
        private ShaderProperty _mode = new(LitSurfaceOptionsProperties.WorkflowMode);

        public void FindProperties(MaterialProperty[] properties) =>
            _mode.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            editor.DrawEnumPopup<WorkflowMode>(SurfaceOptionsStyles.WorkflowMode, _mode.MaterialProperty);

        public void SetKeywords(Material material)
        {
            bool isSpecularWorkflow = IsSpecularWorkflow(material);
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.SpecularSetup, isSpecularWorkflow);
        }

        private bool IsSpecularWorkflow(Material material) => 
            (WorkflowMode)material.GetFloat(_mode.ID) == WorkflowMode.Specular;
    }
}