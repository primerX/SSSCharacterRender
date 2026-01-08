using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Eye
{
    public sealed class GeometryProperties : IFeature
    {
        private ShaderProperty _meshScale = new(EyeProperties.MeshScale);

        public void FindProperties(MaterialProperty[] properties) =>
            _meshScale.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawMeshScale(editor);

        private void DrawMeshScale(MaterialEditorGUIPlus editor) => 
            editor.DrawMinFloat(EyeStyles.MeshScale, _meshScale.MaterialProperty);

        public void SetKeywords(Material material)
        { }
    }
}