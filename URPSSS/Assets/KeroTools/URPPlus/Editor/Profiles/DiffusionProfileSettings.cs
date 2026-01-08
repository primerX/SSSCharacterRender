using EditorGUIPlus.MaterialEditor.AssetObject;
using UnityEngine;
using UnityEngine.Serialization;

namespace KeroTools.URPPlus.Editor.Profiles
{
    [CreateAssetMenu(fileName = "Diffusion Profile", menuName = "Rendering/URP+/Diffusion Profile")]
    public class DiffusionProfileSettings : MaterialAssetObject
    {
        [FormerlySerializedAs("diffusionLUT")] 
        public Texture2D DiffusionLUT;
        
        [FormerlySerializedAs("translucencyColor")]
        public Color TranslucencyColor = Color.white;
        [FormerlySerializedAs("translucencyScale")]
        public float TranslucencyScale = 1.0f;
        [FormerlySerializedAs("translucencyPower")]
        public float TranslucencyPower = 0.05f;
        [FormerlySerializedAs("translucencyAmbient")]
        public float TranslucencyAmbient;
        [FormerlySerializedAs("translucencyDistortion")]
        public float TranslucencyDistortion;
        [FormerlySerializedAs("translucencyShadows")]
        public float TranslucencyShadows = 0.5F;
        [FormerlySerializedAs("translucencyDiffuseInfluence")]
        public float TranslucencyDiffuseInfluence = 0.5f;
        
        public override void SetMaterialAssetObject(Material material)
        {
            if(material == null)
                return;
            
            if (material.HasProperty(DiffusionProfileIDs.TranslucencyColor))
                material.SetColor(DiffusionProfileIDs.TranslucencyColor, TranslucencyColor);
            
            if (material.HasProperty(DiffusionProfileIDs.DiffusionLut))
                material.SetTexture(DiffusionProfileIDs.DiffusionLut, DiffusionLUT);

            if (material.HasProperty(DiffusionProfileIDs.TranslucencyScale))
                material.SetFloat(DiffusionProfileIDs.TranslucencyScale, TranslucencyScale);
            
            if (material.HasProperty(DiffusionProfileIDs.TranslucencyPower))
                material.SetFloat(DiffusionProfileIDs.TranslucencyPower, TranslucencyPower);
            
            if (material.HasProperty(DiffusionProfileIDs.TranslucencyAmbient))
                material.SetFloat(DiffusionProfileIDs.TranslucencyAmbient, TranslucencyAmbient);
            
            if (material.HasProperty(DiffusionProfileIDs.TranslucencyDistortion))
                material.SetFloat(DiffusionProfileIDs.TranslucencyDistortion, TranslucencyDistortion);
            
            if (material.HasProperty(DiffusionProfileIDs.TranslucencyShadows))
                material.SetFloat(DiffusionProfileIDs.TranslucencyShadows, TranslucencyShadows);
            
            if (material.HasProperty(DiffusionProfileIDs.TranslucencyDiffuseInfluence))
                material.SetFloat(DiffusionProfileIDs.TranslucencyDiffuseInfluence, TranslucencyDiffuseInfluence);
        }
        
        public override void ResetToDefault()
        {
            TranslucencyColor = Color.white;
            DiffusionLUT = null;
            
            TranslucencyScale = 1.0f;
            TranslucencyPower = 0.05f;
            TranslucencyAmbient = 0.0f;
            TranslucencyDistortion = 0.0f;
            TranslucencyShadows = 0.5f;
            TranslucencyDiffuseInfluence = 0.5f;
            
            base.ResetToDefault();
        }
    }
}