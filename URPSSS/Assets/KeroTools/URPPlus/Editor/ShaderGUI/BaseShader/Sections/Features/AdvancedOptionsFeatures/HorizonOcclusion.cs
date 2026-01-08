using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Extensions;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class HorizonOcclusion : IFeature
    {
        private ShaderProperty _horizonOcclusionEnable = new(LitAdvancedOptionsProperties.HorizonOcclusion);
        private ShaderProperty _horizonFade = new(LitAdvancedOptionsProperties.HorizonFade);

        public void FindProperties(MaterialProperty[] properties)
        {
            _horizonOcclusionEnable.Find(properties);
            _horizonFade.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor) => 
            DrawHorizonFade(editor);
        
        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, AdvancedOptionsKeywords.HorizonOcclusion, _horizonOcclusionEnable.IsToggleEnabled(material));

        private void DrawHorizonFade(MaterialEditorGUIPlus editor)
        {
            bool enableHorizonOcclusion = editor.DrawToggle(AdvancedOptionsStyles.HorizonOcclusion,
                _horizonOcclusionEnable.MaterialProperty, ToggleAlign.Right);
            
            if (!enableHorizonOcclusion)
                return;
            
            editor.DrawSlider(AdvancedOptionsStyles.HorizonFade, _horizonFade.MaterialProperty,
                new FloatRange(0.0f, 2.0f), 1);
        }
    }
}