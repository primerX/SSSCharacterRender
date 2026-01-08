using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Fabric;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Profiles;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions.Fabric;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI
{
    public sealed class FabricGUI : BaseShaderGUI
    {
        private IFeature[] _surfaceOptionsFeatures;
        private IFeature[] _surfaceInputsFeatures;
        private IFeature[] _advancedOptionsFeatures;

        public override void OnOpenGUI(Material material)
        {
            _surfaceOptionsFeatures = InitializeSurfaceOptions(material);
            _surfaceInputsFeatures = InitializeSurfaceInputs(material);
            _advancedOptionsFeatures = InitializeAdvancedOptions(material);

            Sections = new List<MaterialSection>(SetSections(material));
        }

        public override IEnumerable<MaterialSection> SetSections(Material material)
        {
            return new List<MaterialSection>
            {
                new SurfaceOptions(_surfaceOptionsFeatures),
                new SurfaceInputs(_surfaceInputsFeatures),
                new WeatherInputs(material),
                new EmissionInputs(material),
                new AdvancedOptions(_advancedOptionsFeatures)
            };
        }

        private IFeature[] InitializeSurfaceOptions(Material material)
        {
            return new IFeature[]
            {
                new SurfaceType(material),
                new RenderFace(material),
                new FabricType(),
                new FabricTranslucency(),
                new AlphaClipping(),
                new GeometricSpecularAA(),
                new DisplacementType(material)
            };
        }

        private IFeature[] InitializeSurfaceInputs(Material material)
        {
            return new IFeature[]
            {
                new BaseMap(),
                new AnisotropyValue(material),
                new MaskMap(material),
                new SpecularMap(material),
                new NormalMap(),
                new HeightMap(material),
                new DiffusionProfile(material, MaterialTypeMode.Translucency),
                new ThicknessCurvatureMap(material, MaterialTypeMode.Translucency),
                new BaseMapTextureOffset(),
                new ThreadMap(),
                new ThreadTextureOffset(),
                new FuzzMap()
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