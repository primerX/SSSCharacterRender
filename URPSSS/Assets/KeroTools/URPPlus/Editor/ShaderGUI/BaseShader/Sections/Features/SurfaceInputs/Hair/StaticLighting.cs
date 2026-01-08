using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Hair
{
    public sealed class StaticLighting : IFeature
    {
        private ShaderProperty _staticSpecularHighlight = new(HairProperties.StaticSpecularHighlight);
        private ShaderProperty _staticLightColor = new(HairProperties.StaticLightColor);
        private ShaderProperty _staticLightVector = new(HairProperties.StaticLightVector);

        public void FindProperties(MaterialProperty[] properties)
        {
            _staticSpecularHighlight.Find(properties);
            _staticLightColor.Find(properties);
            _staticLightVector.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            bool isStaticLightEnabled = DrawStaticHighlight(editor);
            if (!isStaticLightEnabled)
                return;

            DrawStaticLightColor(editor);
            DrawStaticLightVector(editor);
            DrawStaticLightIntensity(editor);
        }

        public void SetKeywords(Material material)
        {
            bool staticSpecularState = _staticSpecularHighlight.IsToggleEnabled(material);
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.StaticSpecularHighlight, staticSpecularState);
        }

        private bool DrawStaticHighlight(MaterialEditorGUIPlus editor)
        {
            bool isStaticLightEnabled = editor.DrawToggle(HairStyles.StaticHighlight, 
                _staticSpecularHighlight.MaterialProperty, ToggleAlign.Right);
            
            return isStaticLightEnabled;
        }

        private void DrawStaticLightColor(MaterialEditorGUIPlus editor) => 
            editor.DrawColor(HairStyles.StaticLightColor, _staticLightColor.MaterialProperty);

        private void DrawStaticLightVector(MaterialEditorGUIPlus editor) => 
            editor.DrawVector4(HairStyles.StaticLightVector, _staticLightVector.MaterialProperty);

        private void DrawStaticLightIntensity(MaterialEditorGUIPlus editor) =>
            editor.DrawMinFloatFromVector4(HairStyles.StaticLightIntensity, _staticLightVector.MaterialProperty,
                Vector4Param.W);
    }
}