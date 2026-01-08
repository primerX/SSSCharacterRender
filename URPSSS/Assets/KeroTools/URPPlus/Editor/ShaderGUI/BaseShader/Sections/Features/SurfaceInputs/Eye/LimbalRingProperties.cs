using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Eye
{
    public sealed class LimbalRingProperties : IFeature
    {
        private ShaderProperty _limbalRingSizeIris = new(EyeProperties.LimbalRingSizeIris);
        private ShaderProperty _limbalRingSizeSclera = new(EyeProperties.LimbalRingSizeSclera);
        private ShaderProperty _limbalRingFade = new(EyeProperties.LimbalRingFade);
        private ShaderProperty _limbalRingIntensity = new(EyeProperties.LimbalRingIntensity);

        public void FindProperties(MaterialProperty[] properties)
        {
            _limbalRingSizeIris.Find(properties);
            _limbalRingSizeSclera.Find(properties);
            _limbalRingFade.Find(properties);
            _limbalRingIntensity.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawLimbalRingSizeIris(editor);
            DrawLimbalRingSizeSclera(editor);
            DrawLimbalRingFade(editor);
            DrawLimbalRingIntensity(editor);
        }

        public void SetKeywords(Material material)
        { }

        private void DrawLimbalRingSizeIris(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.LimbalRingSizeIris, _limbalRingSizeIris.MaterialProperty);

        private void DrawLimbalRingSizeSclera(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.LimbalRingSizeSclera, _limbalRingSizeSclera.MaterialProperty);

        private void DrawLimbalRingFade(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.LimbalRingFade, _limbalRingFade.MaterialProperty);

        private void DrawLimbalRingIntensity(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(EyeStyles.LimbalRingIntensity, _limbalRingIntensity.MaterialProperty);
    }
}