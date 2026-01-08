using EditorGUIPlus.MaterialEditor.ShaderGUI;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.Extensions
{
    public static class PropertyExtensions
    {
        public static bool IsToggleEnabled(this ShaderProperty property, Material material) => 
            material.HasProperty(property.ID) && material.GetFloat(property.ID) > 0.5f;
        
        public static bool HasTexture(this ShaderProperty property, Material material) => 
            material.HasProperty(property.ID) && material.GetTexture(property.ID) == true;
    }
}