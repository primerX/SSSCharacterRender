using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI
{
    public class LayeredLitGUI : BaseShaderGUI
    {
        protected IFeature[] SurfaceOptionsFeatures;
        protected IFeature[] SurfaceInputsFeatures;
        protected IFeature[] AdvancedOptionsFeatures;

        protected uint PreviousLayerCount = 2;
        private static readonly int LayerCountID = Shader.PropertyToID("_LayerCount");

        public override void OnOpenGUI(Material material)
        {
            SurfaceOptionsFeatures = InitializeSurfaceOptions(material);
            SurfaceInputsFeatures = InitializeSurfaceInputs(material);
            AdvancedOptionsFeatures = InitializeAdvancedOptions(material);

            PreviousLayerCount = (uint)material.GetFloat(LayerCountID);
            Sections = new List<MaterialSection>(SetSections(material));
        }

        public override void OnUpdateGUI(Material material)
        {
            uint currentLayerCount = (uint)material.GetFloat(LayerCountID);

            if (currentLayerCount == PreviousLayerCount)
                return;

            PreviousLayerCount = currentLayerCount;
            Sections = new List<MaterialSection>(SetSections(material));
        }

        public override IEnumerable<MaterialSection> SetSections(Material material)
        {
            List<MaterialSection> sectionsList = new()
            {
                new SurfaceOptions(SurfaceOptionsFeatures),
                new SurfaceInputs(SurfaceInputsFeatures),
                new WeatherInputs(material),
                new EmissionInputs(material),
                new AdvancedOptions(AdvancedOptionsFeatures)
            };

            //Hardcoded insert of LayersSections after SurfaceInputs
            IEnumerable<MaterialSection> layeredSections = new LayeredSections(material).GetLayers(PreviousLayerCount);
            sectionsList.InsertRange(2, layeredSections);

            return sectionsList;
        }

        private IFeature[] InitializeSurfaceOptions(Material material)
        {
            return new IFeature[]
            {
                new SurfaceType(material),
                new RenderFace(material),
                new AlphaClipping(),
                new GeometricSpecularAA(),
                new DisplacementType(material)
            };
        }

        private IFeature[] InitializeSurfaceInputs(Material material)
        {
            return new IFeature[]
            {
                new LayeredLitSurfaceInputs(material)
            };
        }

        private IFeature[] InitializeAdvancedOptions(Material material)
        {
            return new IFeature[]
            {
                new TransparentCastShadow(material),
                new ReceiveShadows(),
                new HighlightReflections(),
                new QueueController(),
                new GPUInstancing(),
                new HorizonOcclusion(),
                new SpecularOcclusion()
            };
        }
    }
}