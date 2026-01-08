using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class GPUInstancing : IFeature
    {
        public void FindProperties(MaterialProperty[] properties)
        { }

        public void Draw(MaterialEditorGUIPlus editor) =>
            editor.MaterialEditor.EnableInstancingField();

        public void SetKeywords(Material material)
        { }
    }
}