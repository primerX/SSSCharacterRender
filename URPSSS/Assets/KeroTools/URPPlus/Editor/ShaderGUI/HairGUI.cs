using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Hair;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI
{
    public sealed class HairGUI : BaseShaderGUI
    {
        private IFeature[] _surfaceOptionsFeatures;
        private IFeature[] _surfaceInputsFeatures;
        private IFeature[] _advancedOptionsFeatures;

        public override void OnOpenGUI(Material material)
        {
            _surfaceOptionsFeatures = InitializeSurfaceOptions(material);
            _surfaceInputsFeatures = InitializeSurfaceInputs();
            _advancedOptionsFeatures = InitializeAdvancedOptions(material);

            Sections = new List<MaterialSection>(SetSections(material));
        }

        public override IEnumerable<MaterialSection> SetSections(Material material)
        {
            return new List<MaterialSection>
            {
                new SurfaceOptions(_surfaceOptionsFeatures),
                new SurfaceInputs(_surfaceInputsFeatures),
                new AdvancedOptions(_advancedOptionsFeatures)
            };
        }

        private IFeature[] InitializeSurfaceOptions(Material material)
        {
            return new IFeature[]
            {
                new SurfaceType(material),
                new RenderFace(material),
                new AlphaClipping(),
                new GeometricSpecularAA()
            };
        }

        private IFeature[] InitializeSurfaceInputs()
        {
            return new IFeature[]
            {
                new BaseMap(),
                new NormalMap(),
                new AmbientOcclusionMap(),
                new BaseMapTextureOffset(),
                new SpecularBlock(),
                new StaticLighting()
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
            };
        }
    }
}