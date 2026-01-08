using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceInputs.Fabric
{
    public sealed class AnisotropyValue : IFeature
    {
        private readonly Material _material;

        private readonly ShaderProperty _fabricType = new(FabricProperties.FabricType);
        private ShaderProperty _anisotropyProperty = new(LitSurfaceInputsProperties.Anisotropy);

        public AnisotropyValue(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties) =>
            _anisotropyProperty.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) => 
            DrawAnisotropy(editor);

        public void SetKeywords(Material material)
        { }

        private void DrawAnisotropy(MaterialEditorGUIPlus editor)
        {
            FabricMaterialType fabricType = GetFabricType();

            if (fabricType != FabricMaterialType.Silk)
                return;

            editor.DrawSlider(AnisotropyStyles.Anisotropy, _anisotropyProperty.MaterialProperty, new FloatRange(-1.0f, 1.0f));
        }

        private FabricMaterialType GetFabricType()
        {
            if (!HasFabric())
                return FabricMaterialType.Silk;

            return (FabricMaterialType)_material.GetFloat(_fabricType.ID);
        }

        private bool HasFabric() =>
            _material.HasProperty(_fabricType.ID);
    }
}