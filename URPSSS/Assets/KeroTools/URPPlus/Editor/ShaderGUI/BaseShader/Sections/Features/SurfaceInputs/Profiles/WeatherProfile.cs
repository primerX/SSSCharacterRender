using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.AssetObject;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.Profiles;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Profiles
{
    public sealed class WeatherProfile : IFeature
    {
        private readonly Material _material;

        private ShaderProperty _weatherProfileAsset = new(LitSurfaceInputsProperties.WeatherProfileAsset);
        private ShaderProperty _weatherProfileHash = new(LitSurfaceInputsProperties.WeatherProfileHash);

        public WeatherProfile(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _weatherProfileAsset.Find(properties);
            _weatherProfileHash.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            editor.DrawMaterialAssetObject(_material, _weatherProfileAsset.MaterialProperty,
                _weatherProfileHash.MaterialProperty, DrawWeatherProfile);
            return;
            
            MaterialAssetObject DrawWeatherProfile()
            {
                string guid = _weatherProfileAsset.MaterialProperty.vectorValue.ToGuid();
                WeatherProfileSettings assetObject = editor.GetMaterialAssetObjectFromGuid<WeatherProfileSettings>(guid);
            
                return EditorGUILayout.ObjectField(WeatherInputsStyles.WeatherProfileLabel, assetObject, 
                    typeof(WeatherProfileSettings), allowSceneObjects: false) as WeatherProfileSettings;
            }
        } 

        public void SetKeywords(Material material)
        { }
    }
}