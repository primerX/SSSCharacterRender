using System.Collections.Generic;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.Properties
{
    public static class LitSurfaceOptionsProperties
    {
        public const string SurfaceType = "_Surface";
        public const string BlendMode = "_Blend";
        public const string BlendModePreserveSpecular = "_BlendModePreserveSpecular";
        public const string DepthWrite = "_ZWrite";
        public const string DepthTest = "_ZTest";
        public const string SrcBlend = "_SrcBlend";
        public const string DstBlend = "_DstBlend";
        public const string SrcBlendAlpha = "_SrcBlendAlpha";
        public const string DstBlendAlpha = "_DstBlendAlpha";

        public const string WorkflowMode = "_WorkflowMode";

        public const string Cull = "_Cull";
        public const string DoubleSidedNormal = "_DoubleSidedNormalMode";
        public const string DoubleSidedConstants = "_DoubleSidedConstants";

        public const string AlphaCutoffEnable = "_AlphaCutoffEnable";
        public const string UseShadowThreshold = "_UseShadowThreshold";
        public const string AlphaCutoff = "_AlphaCutoff";
        public const string AlphaCutoffShadow = "_AlphaCutoffShadow";
        public const string AlphaToMask = "_AlphaToMask";

        public const string EnableGeometricSpecularAA = "_EnableGeometricSpecularAA";
        public const string SpecularAAScreenSpaceVariance = "_SpecularAAScreenSpaceVariance";
        public const string SpecularAAThreshold = "_SpecularAAThreshold";

        public const string MaterialType = "_MaterialType";
        public const string EnableTransmission = "_EnableTransmission";
        public const string EnableTranslucency = "_EnableTranslucency";
        
        public static readonly Dictionary<DoubleSidedNormalMode, Vector4> DoubleSidedNormalModeMap = new()
        {
            { DoubleSidedNormalMode.Mirror, new Vector4(1.0f, 1.0f, -1.0f, 0.0f) },
            { DoubleSidedNormalMode.Flip, new Vector4(-1.0f, -1.0f, -1.0f, 0.0f) },
            { DoubleSidedNormalMode.None, new Vector4(1.0f, 1.0f, 1.0f, 0.0f) }
        };
    }
}