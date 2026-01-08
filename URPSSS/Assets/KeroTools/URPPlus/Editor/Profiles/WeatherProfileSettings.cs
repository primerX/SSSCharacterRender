using EditorGUIPlus.MaterialEditor.AssetObject;
using UnityEngine;
using UnityEngine.Serialization;

namespace KeroTools.URPPlus.Editor.Profiles
{
    [CreateAssetMenu(fileName = "Weather Profile", menuName = "Rendering/URP+/Weather Profile")]
    public class WeatherProfileSettings : MaterialAssetObject
    {
        [FormerlySerializedAs("puddleNormal")] 
        public Texture2D PuddleNormal;
        [FormerlySerializedAs("puddlesFramesSize")]
        public Vector2 PuddlesFramesSize;
        [FormerlySerializedAs("puddlesSize")]
        public float PuddlesSize;
        [FormerlySerializedAs("puddlesAnimationSpeed")]
        public float PuddlesAnimationSpeed;
        
        [FormerlySerializedAs("rainNormal")] 
        public Texture2D RainNormal;
        [FormerlySerializedAs("rainSize")]
        public float RainSize;
        [FormerlySerializedAs("rainAnimationSpeed")]
        public float RainAnimationSpeed;
        
        public override void SetMaterialAssetObject(Material material)
        {
            if(material == null)
                return;
            
            SetPuddlesSettings(material);
            SetRainSettings(material);
        }

        private void SetPuddlesSettings(Material material)
        {
            if (material.HasProperty(WeatherProfileIDs.PuddlesNormal))
                material.SetTexture(WeatherProfileIDs.PuddlesNormal, PuddleNormal);

            if (material.HasProperty(WeatherProfileIDs.PuddlesFramesSize))
                material.SetVector(WeatherProfileIDs.PuddlesFramesSize, PuddlesFramesSize);
            
            if (material.HasProperty(WeatherProfileIDs.PuddlesSize))
                material.SetFloat(WeatherProfileIDs.PuddlesSize, PuddlesSize);
            
            if (material.HasProperty(WeatherProfileIDs.PuddlesAnimationSpeed))
                material.SetFloat(WeatherProfileIDs.PuddlesAnimationSpeed, PuddlesAnimationSpeed);
        }

        private void SetRainSettings(Material material)
        {
            if (material.HasProperty(WeatherProfileIDs.RainNormal))
                material.SetTexture(WeatherProfileIDs.RainNormal, RainNormal);
            
            if (material.HasProperty(WeatherProfileIDs.RainSize))
                material.SetFloat(WeatherProfileIDs.RainSize, RainSize);
            
            if (material.HasProperty(WeatherProfileIDs.RainAnimationSpeed))
                material.SetFloat(WeatherProfileIDs.RainAnimationSpeed, RainAnimationSpeed);
        }
        
        public override void ResetToDefault()
        {
            ResetPuddlesSettings();
            ResetRainSettings();
            
            base.ResetToDefault();
        }

        private void ResetPuddlesSettings()
        {
            PuddleNormal = null;
            PuddlesFramesSize = Vector2.zero;
            PuddlesSize = 1.0f;
            PuddlesAnimationSpeed = 1.0f;
        }

        private void ResetRainSettings()
        {
            RainNormal = null;
            RainSize = 1.0f;
            RainAnimationSpeed = 0.1f;
        }
    }
}