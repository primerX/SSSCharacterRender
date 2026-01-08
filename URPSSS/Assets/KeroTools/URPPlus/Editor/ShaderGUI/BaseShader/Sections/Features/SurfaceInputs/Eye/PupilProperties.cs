using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Eye
{
    public sealed class PupilProperties : IFeature
    {
        private ShaderProperty _pupilRadius = new(EyeProperties.PupilRadius);
        private ShaderProperty _pupilAperture = new(EyeProperties.PupilAperture);
        private ShaderProperty _minimalPupilAperture = new(EyeProperties.MinimalPupilAperture);
        private ShaderProperty _maximalPupilAperture = new(EyeProperties.MaximalPupilAperture);

        public void FindProperties(MaterialProperty[] properties)
        {
            _pupilRadius.Find(properties);
            _pupilAperture.Find(properties);
            _minimalPupilAperture.Find(properties);
            _maximalPupilAperture.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawPupilRadius(editor);
            DrawPupilAperture(editor);
            DrawMinimalPupilAperture(editor);
            DrawMaximalPupilAperture(editor);
        }

        public void SetKeywords(Material material)
        { }

        private void DrawPupilRadius(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.PupilRadius, _pupilRadius.MaterialProperty);

        private void DrawPupilAperture(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.PupilAperture, _pupilAperture.MaterialProperty);

        private void DrawMinimalPupilAperture(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.MinimalPupilAperture, _minimalPupilAperture.MaterialProperty);

        private void DrawMaximalPupilAperture(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.MaximalPupilAperture, _maximalPupilAperture.MaterialProperty);
    }
}