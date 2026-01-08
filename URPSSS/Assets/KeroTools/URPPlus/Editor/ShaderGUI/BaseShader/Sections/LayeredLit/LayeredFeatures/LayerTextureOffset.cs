using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public sealed class LayerTextureOffset : LayerFeature
    {
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private ShaderProperty[] _baseMapProperties = new ShaderProperty[MaxLayersCount];

        public LayerTextureOffset(uint layersCount, int layerIndex)
        {
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties) =>
            _baseMapProperties = LayerUtils.FindLayerProperty(LitSurfaceInputsProperties.BaseMap, properties, _layersCount);

        public override void Draw(MaterialEditorGUIPlus editor) =>
            DrawTextureScaleOffset(editor);

        public override void SetKeywords(Material material)
        { }

        private void DrawTextureScaleOffset(MaterialEditorGUIPlus editor) => 
            editor.DrawTextureScaleOffset(_baseMapProperties[_layerIndex].MaterialProperty);
    }
}