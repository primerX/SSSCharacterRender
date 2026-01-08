using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public abstract class LayerFeature : IFeature
    {
        protected const int MaxLayersCount = 4;

        public abstract void FindProperties(MaterialProperty[] properties);

        public abstract void Draw(MaterialEditorGUIPlus editor);

        public abstract void SetKeywords(Material material);
    }
}