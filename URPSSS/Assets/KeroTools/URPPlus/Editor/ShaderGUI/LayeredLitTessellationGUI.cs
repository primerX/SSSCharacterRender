using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI
{
    public sealed class LayeredLitTessellationGUI : LayeredLitGUI
    {
        public override IEnumerable<MaterialSection> SetSections(Material material)
        {
            List<MaterialSection> sectionsList = new()
            {
                new SurfaceOptions(SurfaceOptionsFeatures),
                new TessellationOptions(),
                new SurfaceInputs(SurfaceInputsFeatures),
                new WeatherInputs(material),
                new EmissionInputs(material),
                new AdvancedOptions(AdvancedOptionsFeatures)
            };

            //Hardcoded insert of LayersSections after SurfaceInputs
            IEnumerable<MaterialSection> layeredSections = new LayeredSections(material).GetLayers(PreviousLayerCount);
            sectionsList.InsertRange(3, layeredSections);

            return sectionsList;
        }
    }
}