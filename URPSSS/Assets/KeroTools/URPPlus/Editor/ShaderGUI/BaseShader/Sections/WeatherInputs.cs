using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Profiles;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEditor;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections
{
    public class WeatherInputs : MaterialSection
    {
        private readonly WeatherProfile _weatherProfile;
        
        private ShaderProperty _weatherEnable = new(WeatherInputsProperties.WeatherEnable);
        private ShaderProperty _rainMode = new(WeatherInputsProperties.RainMode);

        private ShaderProperty _puddlesNormalScale = new(WeatherInputsProperties.PuddlesNormalScale);
        private ShaderProperty _rainNormalScale = new(WeatherInputsProperties.RainNormalScale);

        private ShaderProperty _rainDistortion = new(WeatherInputsProperties.RainDistortionMap);
        private ShaderProperty _rainDistortionScale = new(WeatherInputsProperties.RainDistortionScale);
        private ShaderProperty _rainDistortionSize = new(WeatherInputsProperties.RainDistortionSize);

        private ShaderProperty _rainMask = new(WeatherInputsProperties.RainMask);
        private ShaderProperty _rainWetnessFactor = new(WeatherInputsProperties.RainWetnessFactor);

        private static readonly int PuddlesNormalMapID = Shader.PropertyToID("_PuddlesNormal");
        private static readonly int RainNormalMapID = Shader.PropertyToID("_RainNormal");
        
        public WeatherInputs(Material material) : base(new GUIContent("Weather Inputs")) => 
            _weatherProfile = new WeatherProfile(material);

        public override void FindProperties(MaterialProperty[] properties)
        {
            _weatherEnable.Find(properties);
            _rainMode.Find(properties);
            
            _weatherProfile.FindProperties(properties);

            _puddlesNormalScale.Find(properties);
            _rainNormalScale.Find(properties);

            _rainDistortion.Find(properties);
            _rainDistortionScale.Find(properties);
            _rainDistortionSize.Find(properties);
            _rainMask.Find(properties);
            _rainWetnessFactor.Find(properties);
        }

        public override void DrawProperties(MaterialEditorGUIPlus editor)
        {
            bool drawSettings = editor.DrawToggle(WeatherInputsStyles.WeatherEnable, _weatherEnable.MaterialProperty, ToggleAlign.Right);

            if (!drawSettings)
                return;

            editor.DrawEnumPopup<RainMode>(WeatherInputsStyles.RainMode, _rainMode.MaterialProperty);
            
            _weatherProfile.Draw(editor);

            editor.DrawSlider(WeatherInputsStyles.PuddlesNormalIntensity, _puddlesNormalScale.MaterialProperty, new FloatRange(0.0f, 8.0f));
            editor.DrawSlider(WeatherInputsStyles.RainNormalIntensity, _rainNormalScale.MaterialProperty, new FloatRange(0.0f, 8.0f));

            editor.DrawSingleLineTexture(WeatherInputsStyles.RainDistortion, 
                _rainDistortion.MaterialProperty, 
                _rainDistortionScale.MaterialProperty);
            editor.DrawMinFloat(WeatherInputsStyles.RainDistortionSize, _rainDistortionSize.MaterialProperty, 0.001f);
            editor.DrawSingleLineTexture(WeatherInputsStyles.RainMask, _rainMask.MaterialProperty);
            editor.DrawSlider(WeatherInputsStyles.RainWetnessFactor, _rainWetnessFactor.MaterialProperty);
        }

        public override void SetKeywords(Material material)
        {
            CoreUtils.SetKeyword(material, "_WEATHER_ON", _weatherEnable.MaterialProperty.floatValue > 0.5f);
            CoreUtils.SetKeyword(material, "_RAIN_TRIPLANAR", (RainMode)_rainMode.MaterialProperty.floatValue == RainMode.Triplanar);
            CoreUtils.SetKeyword(material, "_RAIN_NORMALMAP", material.GetTexture(PuddlesNormalMapID) || material.GetTexture(RainNormalMapID));
        }
    }
}