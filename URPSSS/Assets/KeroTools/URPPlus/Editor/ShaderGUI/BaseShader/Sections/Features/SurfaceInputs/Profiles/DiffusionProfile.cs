using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.AssetObject;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.Profiles;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Profiles
{
    public sealed class DiffusionProfile : IFeature
    {
        private readonly MaterialTypeMode? _overrideMode;
        private readonly Material _material;

        private readonly ShaderProperty _materialType = new(LitSurfaceOptionsProperties.MaterialType);
        private ShaderProperty _diffusionProfileAsset = new(LitSurfaceInputsProperties.DiffusionProfileAsset);
        private ShaderProperty _diffusionProfileHash = new(LitSurfaceInputsProperties.DiffusionProfileHash);

        public DiffusionProfile(Material material, MaterialTypeMode? overrideMode = null)
        {
            _material = material;
            _overrideMode = overrideMode;
        }

        public void FindProperties(MaterialProperty[] properties)
        {
            _diffusionProfileAsset.Find(properties);
            _diffusionProfileHash.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            MaterialTypeMode currentMaterialType = _overrideMode ?? GetMaterialType();

            bool isMaterialTypeScattered = currentMaterialType is MaterialTypeMode.SubSurfaceScattering or MaterialTypeMode.Translucency;
            if (isMaterialTypeScattered)
                editor.DrawMaterialAssetObject(_material, _diffusionProfileAsset.MaterialProperty, 
                    _diffusionProfileHash.MaterialProperty, DrawDiffusionProfile);
            return;
            
            MaterialAssetObject DrawDiffusionProfile()
            {
                string guid = _diffusionProfileAsset.MaterialProperty.vectorValue.ToGuid();
                DiffusionProfileSettings assetObject = editor.GetMaterialAssetObjectFromGuid<DiffusionProfileSettings>(guid);
            
                return EditorGUILayout.ObjectField(SubSurfaceScatteringStyles.DiffusionProfileLabel, assetObject, 
                    typeof(DiffusionProfileSettings), allowSceneObjects: false) as DiffusionProfileSettings;
            }
        }

        public void SetKeywords(Material material)
        { }

        private MaterialTypeMode GetMaterialType()
        {
            if (_material.HasProperty(_materialType.ID))
                return (MaterialTypeMode)_material.GetFloat(_materialType.ID);

            return MaterialTypeMode.Standard;
        }
    }
}