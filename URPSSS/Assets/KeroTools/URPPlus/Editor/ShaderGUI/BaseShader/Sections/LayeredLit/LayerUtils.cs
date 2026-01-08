using EditorGUIPlus.MaterialEditor.ShaderGUI;
using UnityEditor;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit
{
    public static class LayerUtils
    {
        private static readonly string[] Prefixes = { "", "1", "2", "3" };

        public static string LayerPropertyName(string keyWord, int layerIndex)
        {
            keyWord = $"{keyWord}{Prefixes[layerIndex]}";
            return keyWord;
        }

        public static ShaderProperty[] FindLayerProperty(string propertyName, MaterialProperty[] properties, uint layerCount = 2)
        {
            ShaderProperty[] arrayProperties = new ShaderProperty[layerCount];

            string[] prefixes = layerCount > 1 ? Prefixes : new[] { "" };

            for (int i = 0; i < layerCount; i++)
            {
                string propName = $"{propertyName}{prefixes[i]}";
                arrayProperties[i] = new ShaderProperty(propName);
                arrayProperties[i].Find(properties);
            }

            return arrayProperties;
        }
        
        public static ShaderProperty[] FindLayerPropertiesInRange(string propertyName, MaterialProperty[] properties,
            int startLayer = 1, int maxLayers = 4)
        {
            ShaderProperty[] inheritProperties = new ShaderProperty[maxLayers - 1];

            for (int i = startLayer; i < maxLayers; ++i)
            {
                inheritProperties[i - startLayer] = new ShaderProperty($"{propertyName}{i}");
                inheritProperties[i - startLayer].Find(properties);
            }

            return inheritProperties;
        }
    }
}