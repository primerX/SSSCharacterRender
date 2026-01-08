using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace SSS_URP
{
    [ExecuteInEditMode, VolumeComponentMenuForRenderPipeline("SSS", typeof(UniversalRenderPipeline))]
    public class SSS : VolumeComponent, IPostProcessComponent
    {
        public FloatParameter Radius = new ClampedFloatParameter(0, 0, .1f);
        public IntParameter blurPasses = new ClampedIntParameter(3, 0, 15);
        public IntParameter Iterations = new ClampedIntParameter(3, 1, 15);
        public IntParameter Downsample = new ClampedIntParameter(1, 1, 2);
        public FloatParameter Dither = new ClampedFloatParameter(.2f, 0, 1);
        public FloatParameter DitherScale = new ClampedFloatParameter(10, 0, 20);
        public FloatParameter FixPixelLeak = new ClampedFloatParameter(.2f, 0, 1);

        public FloatParameter SubsurfaceScaler = new ClampedFloatParameter(2f, 0, 6);
        public ColorParameter SubsurfaceColor = new ColorParameter(Color.red);
        public ColorParameter SubsurfaceFalloff = new ColorParameter(Color.red);
        public IntParameter SamplerSteps = new ClampedIntParameter(11, 3, 25);


        public FloatParameter DepthTest = new ClampedFloatParameter(.9f, 0, 1);
        public BoolParameter EnableProfileTest = new BoolParameter(false);
        [Tooltip("Searches for color discontinuities")]
        public FloatParameter ProfileColorTest = new ClampedFloatParameter(.1f, 0, 1);
        [Tooltip("Searches for blur radius discontinuities")]
        public FloatParameter ProfileRadiusTest = new ClampedFloatParameter(.9f, 0, 1);
        [Tooltip("Searches discontinuities in the normal buffer")]
        public BoolParameter EnableNormalTest = new BoolParameter(false);
        public FloatParameter NormalTest = new ClampedFloatParameter(.1f, 0, 1);

        public bool IsActive()
        {
            return Radius.value > 0;
        }
        public bool IsTileCompatible() => true;
    }
}
