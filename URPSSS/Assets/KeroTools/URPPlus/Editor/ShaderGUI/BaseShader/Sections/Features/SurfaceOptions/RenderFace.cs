using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.SurfaceOptions
{
    public sealed class RenderFace : IFeature
    {
        private readonly Material _material;
        private ShaderProperty _cull = new(LitSurfaceOptionsProperties.Cull);
        private ShaderProperty _doubleSidedNormal = new(LitSurfaceOptionsProperties.DoubleSidedNormal);
        private readonly ShaderProperty _doubleSidedConstants = new(LitSurfaceOptionsProperties.DoubleSidedConstants);

        public RenderFace(Material material) =>
            _material = material;

        public void FindProperties(MaterialProperty[] properties)
        {
            _cull.Find(properties);
            _doubleSidedNormal.Find(properties);
        }

        public void Draw(MaterialEditorGUIPlus editor)
        {
            DrawRenderFace(editor);
            
            if (IsRenderBoth()) 
                DrawDoubleSidedNormals(editor);
        }

        public void SetKeywords(Material material)
        {
            material.doubleSidedGI = GetRenderFaceMode() != RenderFaceMode.Front;

            bool isDoubleSidedNormals = IsRenderBoth() && IsDoubleSidedNormals();
            CoreUtils.SetKeyword(material, SurfaceOptionsKeywords.DoubleSided, isDoubleSidedNormals);
        }

        private void DrawRenderFace(MaterialEditorGUIPlus editor) =>
            editor.DrawEnumPopup<RenderFaceMode>(SurfaceOptionsStyles.Culling, _cull.MaterialProperty);

        private void DrawDoubleSidedNormals(MaterialEditorGUIPlus editor)
        {
            editor.DrawEnumPopup<DoubleSidedNormalMode>(SurfaceOptionsStyles.DoubleSidedNormalMode, 
                _doubleSidedNormal.MaterialProperty, 1);

            SetDoubleSidedConstants(_material);
        }

        private void SetDoubleSidedConstants(Material material)
        {
            bool hasConstants = LitSurfaceOptionsProperties.DoubleSidedNormalModeMap
                .TryGetValue(GetDoubleSidedNormalsMode(), out Vector4 constants);
            Vector4 sidedConstants = hasConstants ? constants : Vector4.one;

            material.SetVector(_doubleSidedConstants.ID, sidedConstants);
        }

        private bool IsRenderBoth() => 
            GetRenderFaceMode() == RenderFaceMode.Both;

        private bool IsDoubleSidedNormals() =>
            GetDoubleSidedNormalsMode() != DoubleSidedNormalMode.None;

        private RenderFaceMode GetRenderFaceMode() => 
            (RenderFaceMode)_material.GetFloat(_cull.ID);

        private DoubleSidedNormalMode GetDoubleSidedNormalsMode() => 
            (DoubleSidedNormalMode)_doubleSidedNormal.MaterialProperty.floatValue;
    }
}