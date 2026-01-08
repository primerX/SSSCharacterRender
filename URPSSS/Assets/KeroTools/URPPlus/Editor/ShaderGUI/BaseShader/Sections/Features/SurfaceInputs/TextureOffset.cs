using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs
{
    public sealed class TextureOffset : IFeature
    {
        private readonly string _propertyName;
        private MaterialProperty _textureProperty;

        public TextureOffset(string propertyName) =>
            _propertyName = propertyName;

        public void FindProperties(MaterialProperty[] properties) =>
            _textureProperty = ShaderPropertyFinder.FindOptionalProperty(_propertyName, properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawTextureScaleOffset(editor);

        public void SetKeywords(Material material)
        { }

        private void DrawTextureScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_textureProperty);
    }
}