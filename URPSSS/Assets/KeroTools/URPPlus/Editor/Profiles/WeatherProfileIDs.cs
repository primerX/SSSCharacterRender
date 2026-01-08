using UnityEngine;

namespace KeroTools.URPPlus.Editor.Profiles
{
    public static class WeatherProfileIDs
    {
        public static readonly int PuddlesNormal = Shader.PropertyToID("_PuddlesNormal");
        public static readonly int PuddlesFramesSize = Shader.PropertyToID("_PuddlesFramesSize");
        public static readonly int PuddlesSize = Shader.PropertyToID("_PuddlesSize");
        public static readonly int PuddlesAnimationSpeed = Shader.PropertyToID("_PuddlesAnimationSpeed");
        
        public static readonly int RainNormal = Shader.PropertyToID("_RainNormal");
        public static readonly int RainSize = Shader.PropertyToID("_RainSize");
        public static readonly int RainAnimationSpeed = Shader.PropertyToID("_RainAnimationSpeed");
        
        public static readonly int SnowAlbedoMap = Shader.PropertyToID("_SnowAlbedoMap");
        public static readonly int SnowDetailMap = Shader.PropertyToID("_SnowDetailMap");
        public static readonly int SnowHeightMap = Shader.PropertyToID("_SnowHeightMap");
        public static readonly int SnowSize = Shader.PropertyToID("_SnowSize");
        public static readonly int SnowHeightMapSize = Shader.PropertyToID("_SnowHeightMapSize");
    }
}