using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Fabric
{
    public class ThreadTextureOffset : IFeature
    {
        private ShaderProperty _textureOffsetProperty = new(FabricProperties.ThreadMap);

        public void FindProperties(MaterialProperty[] properties) =>
            _textureOffsetProperty.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawTextureScaleOffset(editor);

        public void SetKeywords(Material material)
        { }

        private void DrawTextureScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_textureOffsetProperty.MaterialProperty);
    }
}