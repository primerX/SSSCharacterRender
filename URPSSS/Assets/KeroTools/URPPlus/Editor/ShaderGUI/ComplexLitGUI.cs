using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Profiles;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI
{
    public class ComplexLitGUI : BaseShaderGUI
    {
        protected IFeature[] SurfaceOptionsFeatures;
        protected IFeature[] SurfaceInputsFeatures;
        protected IFeature[] AdvancedOptionsFeatures;

        public override void OnOpenGUI(Material material)
        {
            SurfaceOptionsFeatures = InitializeSurfaceOptions(material);
            SurfaceInputsFeatures = InitializeSurfaceInputs(material);
            AdvancedOptionsFeatures = InitializeAdvancedOptions(material);

            Sections = new List<MaterialSection>(SetSections(material));
        }

        public override IEnumerable<MaterialSection> SetSections(Material material)
        {
            return new List<MaterialSection>
            {
                new SurfaceOptions(SurfaceOptionsFeatures),
                new SurfaceInputs(SurfaceInputsFeatures),
                new DetailInputs(),
                new WeatherInputs(material),
                new TransparencyInputs(material),
                new EmissionInputs(material),
                new AdvancedOptions(AdvancedOptionsFeatures)
            };
        }

        private IFeature[] InitializeSurfaceOptions(Material material)
        {
            return new IFeature[]
            {
                new Workflow(),
                new SurfaceType(material),
                new RenderFace(material),
                new AlphaClipping(),
                new MaterialType(),
                new GeometricSpecularAA(),
                new DisplacementType(material)
            };
        }

        private IFeature[] InitializeSurfaceInputs(Material material)
        {
            return new IFeature[]
            {
                new BaseMap(),
                new MaskMap(material),
                new SpecularMap(material),
                new NormalMap(),
                new BentNormalMap(),
                new Anisotropy(material),
                new ClearCoat(material),
                new HeightMap(material),
                new DiffusionProfile(material),
                new ThicknessCurvatureMap(material),
                new Transmission(material),
                new Iridescence(material),
                new BaseMapTextureOffset()
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
                new ClearCoatNormal(material),
                new HorizonOcclusion(),
                new SpecularOcclusion()
            };
        }
    }
}