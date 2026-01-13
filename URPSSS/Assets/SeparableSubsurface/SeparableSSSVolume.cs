using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class SeparableSSSVolume : VolumeComponent, IPostProcessComponent
{
    public FloatParameter SubsurfaceScaler = new ClampedFloatParameter(2, 0, 20);
    public ColorParameter SubsurfaceColor = new ColorParameter(Color.white);
    public ColorParameter SubsurfaceFalloff = new ColorParameter(Color.white);

    public bool IsActive()
    {
        return SubsurfaceScaler.value > 0;
    }

    public bool IsTileCompatible() => true;
}
