using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Fabric
{
    public sealed class FuzzMap : IFeature
    {
        private ShaderProperty _fuzzTexture = new(FabricProperties.FuzzMap);
        private ShaderProperty _fuzzIntensity = new(FabricProperties.FuzzIntensity);
        private ShaderProperty _fuzzScale = new(FabricProperties.FuzzScale);

        public void FindProperties(MaterialProperty[] properties)
        {
            _fuzzTexture.Find(properties);
            _fuzzScale.Find(properties);
            _fuzzIntensity.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawFuzzMap(editor);
            DrawFuzzSettings(editor);
        }

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, DetailInputsKeywords.FuzzMap, _fuzzTexture.HasTexture(material));

        private void DrawFuzzMap(MaterialEditorGUIPlus editor) => 
            editor.DrawSingleLineTexture(FabricStyles.FuzzMap, _fuzzTexture.MaterialProperty);

        private void DrawFuzzSettings(MaterialEditorGUIPlus editor)
        {
            if(_fuzzTexture.MaterialProperty.textureValue is null)
                return;
            
            DrawFuzzScale(editor);
            DrawFuzzIntensity(editor);
        }

        private void DrawFuzzScale(MaterialEditorGUIPlus editor) => 
            editor.DrawMinFloat(FabricStyles.FuzzScale, _fuzzScale.MaterialProperty);

        private void DrawFuzzIntensity(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(FabricStyles.FuzzIntensity, _fuzzIntensity.MaterialProperty);
    }
}