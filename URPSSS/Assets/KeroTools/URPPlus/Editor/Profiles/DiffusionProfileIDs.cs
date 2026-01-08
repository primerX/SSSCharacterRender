using UnityEngine;

namespace KeroTools.URPPlus.Editor.Profiles
{
    public static class DiffusionProfileIDs
    {
        public static readonly int TranslucencyColor = Shader.PropertyToID("_DiffusionColor");
        public static readonly int DiffusionLut = Shader.PropertyToID("_DiffusionLUT");
        public static readonly int TranslucencyScale = Shader.PropertyToID("_TranslucencyScale");
        public static readonly int TranslucencyPower = Shader.PropertyToID("_TranslucencyPower");
        public static readonly int TranslucencyAmbient = Shader.PropertyToID("_TranslucencyAmbient");
        public static readonly int TranslucencyDistortion = Shader.PropertyToID("_TranslucencyDistortion");
        public static readonly int TranslucencyShadows = Shader.PropertyToID("_TranslucencyShadows");
        public static readonly int TranslucencyDiffuseInfluence = Shader.PropertyToID("_TranslucencyDiffuseInfluence");
    }
}