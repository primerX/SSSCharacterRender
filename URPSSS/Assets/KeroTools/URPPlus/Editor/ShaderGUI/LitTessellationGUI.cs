using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI
{
    public sealed class LitTessellationGUI : LitGUI
    {
        public override IEnumerable<MaterialSection> SetSections(Material material)
        {
            return new List<MaterialSection>
            {
                new SurfaceOptions(SurfaceOptionsFeatures),
                new TessellationOptions(),
                new SurfaceInputs(SurfaceInputsFeatures),
                new DetailInputs(),
                new WeatherInputs(material),
                new TransparencyInputs(material),
                new EmissionInputs(material),
                new AdvancedOptions(AdvancedOptionsFeatures)
            };
        }
    }
}