using System.Collections.Generic;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;

namespace KeroTools.URPPlus.Editor.ShaderGUI.Keywords
{
    public static class SurfaceOptionsKeywords
    {
        public const string SurfaceTypeTransparent = "_SURFACE_TYPE_TRANSPARENT";
        public const string SpecularSetup = "_SPECULAR_SETUP";
        public const string DoubleSided = "_DOUBLESIDED_ON";

        public const string MaterialFeatureSubsurfaceScattering = "_MATERIAL_FEATURE_SUBSURFACE_SCATTERING";
        public const string MaterialFeatureAnisotropy = "_MATERIAL_FEATURE_ANISOTROPY";
        public const string MaterialFeatureIridescence = "_MATERIAL_FEATURE_IRIDESCENCE";
        public const string MaterialFeatureTranslucency = "_MATERIAL_FEATURE_TRANSLUCENCY";
        public const string MaterialFeatureTransmission = "_MATERIAL_FEATURE_TRANSMISSION";
        public const string MaterialFeatureSheen = "_MATERIAL_FEATURE_SHEEN";

        public const string GeometricSpecularAA = "_ENABLE_GEOMETRIC_SPECULAR_AA";
        public const string AlphaTest = "_ALPHATEST_ON";
        public const string AlphaPremultiply = "_ALPHAPREMULTIPLY_ON";
        public const string AlphaModulate = "_ALPHAMODULATE_ON";

        public const string ShadowCutoff = "_SHADOW_CUTOFF";
        
        public static readonly Dictionary<MaterialTypeMode, string> MaterialTypeKeywordMap = new()
        {
            { MaterialTypeMode.SubSurfaceScattering, MaterialFeatureSubsurfaceScattering },
            { MaterialTypeMode.Anisotropy, MaterialFeatureAnisotropy },
            { MaterialTypeMode.Iridescence, MaterialFeatureIridescence },
            { MaterialTypeMode.Translucency, MaterialFeatureTranslucency },
        };
    }
}