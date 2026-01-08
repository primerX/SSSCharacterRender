using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions.Fabric
{
    public sealed class FabricType : IFeature
    {
        private ShaderProperty _type = new(FabricProperties.FabricType);

        public void FindProperties(MaterialProperty[] properties) =>
            _type.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            editor.DrawEnumPopup<FabricMaterialType>(SurfaceOptionsStyles.MaterialID, _type.MaterialProperty);

        public void SetKeywords(Material material) => 
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.MaterialFeatureSheen, IsCottonWoolType(material));

        private bool IsCottonWoolType(Material material) => 
            GetFabricMaterialType(material) == FabricMaterialType.CottonWool;

        private FabricMaterialType GetFabricMaterialType(Material material) => 
            (FabricMaterialType)material.GetFloat(_type.ID);
    }
}