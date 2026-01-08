using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit
{
    public class Layer : ConstructedSection
    {
        public Layer(Material material, IFeature[] features, uint layersCount = 1, int layerIndex = 0) : base(features,
            LayeredStyles.Layers[layerIndex])
        {
            Label = LayeredStyles.Layers[layerIndex];

            Features = new IFeature[]
            {
                new LayeringOptions(material, layersCount, layerIndex),
                new LayerBaseMap(layersCount, layerIndex),
                new LayerMaskMap(material, layersCount, layerIndex),
                new LayerNormalMap(layersCount, layerIndex),
                new LayerBentNormalMap(layersCount, layerIndex),
                new LayerHeightMap(material, layersCount, layerIndex),
                new LayerTextureOffset(layersCount, layerIndex),
                new LayerDetailMap(layersCount, layerIndex)
            };
        }
    }
}