using System.Collections.Generic;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit
{
    public class LayeredSections
    {
        private readonly Material _material;

        public LayeredSections(Material material) =>
            _material = material;

        public MaterialSection GetLayer(uint layersCount = 2, int layerIndex = 0) =>
            new Layer(_material, null, layersCount, layerIndex);

        public IEnumerable<MaterialSection> GetLayers(uint layersCount = 2)
        {
            List<MaterialSection> sections = new List<MaterialSection>();
            for (int layerIndex = 0; layerIndex < layersCount; layerIndex++)
                sections.Add(new Layer(_material, null, layersCount, layerIndex));

            return sections;
        }
    }
}