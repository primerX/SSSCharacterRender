using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.PopupTypes;
using KeroTools.URPPlus.Editor.ShaderGUI.Keywords;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.LayeredLit.LayeredFeatures
{
    public sealed class LayerMaskMap : LayerFeature
    {
        private readonly Material _material;
        private readonly uint _layersCount;
        private readonly int _layerIndex;

        private readonly ShaderProperty _workflow = new(LitSurfaceOptionsProperties.WorkflowMode);
        private ShaderProperty[] _maskMapProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _metallicProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _smoothnessProperties = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _metallicMin = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _metallicMax = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _smoothnessMin = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _smoothnessMax = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _aoMin = new ShaderProperty[MaxLayersCount];
        private ShaderProperty[] _aoMax = new ShaderProperty[MaxLayersCount];

        public LayerMaskMap(Material material, uint layersCount, int layerIndex)
        {
            _material = material;
            _layersCount = layersCount;
            _layerIndex = layerIndex;
        }

        public override void FindProperties(MaterialProperty[] properties)
        {
            _maskMapProperties = GetLayerProperty(LitSurfaceInputsProperties.MaskMap);

            _metallicProperties = GetLayerProperty(LitSurfaceInputsProperties.Metallic);
            _smoothnessProperties = GetLayerProperty(LitSurfaceInputsProperties.Smoothness);

            _metallicMin = GetLayerProperty(LitSurfaceInputsProperties.MetallicMin);
            _metallicMax = GetLayerProperty(LitSurfaceInputsProperties.MetallicMax);
            _smoothnessMin = GetLayerProperty(LitSurfaceInputsProperties.SmoothnessMin);
            _smoothnessMax = GetLayerProperty(LitSurfaceInputsProperties.SmoothnessMax);
            _aoMin = GetLayerProperty(LitSurfaceInputsProperties.AOMin);
            _aoMax = GetLayerProperty(LitSurfaceInputsProperties.AOMax);
            return;

            ShaderProperty[] GetLayerProperty(string propertyName) =>
                LayerUtils.FindLayerProperty(propertyName, properties, _layersCount);
        }

        public override void Draw(MaterialEditorGUIPlus editor)
        {
            WorkflowMode workflowMode = GetWorkflow();
            bool isMetallic = workflowMode is WorkflowMode.Metallic;

            DrawRemapSliders(editor, isMetallic);
            DrawMaskMap(editor, isMetallic);
        }

        public override void SetKeywords(Material material)
        {
            string layerMaskMapPropertyName = GetLayerMaskMapPropertyName();
            string layerMaskMapKeywordName = LayerUtils.LayerPropertyName(SurfaceInputsKeywords.MaskMap, _layerIndex);
            bool hasLayerMaskMap = material.GetTexture(layerMaskMapPropertyName);
            
            CoreUtils.SetKeyword(material, layerMaskMapKeywordName, hasLayerMaskMap);
        }

        private void DrawMaskMap(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            GUIContent maskMapContent = isMetallic ? SurfaceInputsStyles.MaskMap : SurfaceInputsStyles.MaskMapSpecular;

            editor.DrawSingleLineTexture(maskMapContent, _maskMapProperties[_layerIndex].MaterialProperty);
        }

        private void DrawRemapSliders(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            if (HasMaskMap())
                DrawRemapping(editor, isMetallic);
            else
                DrawMetallicSmoothness(editor, isMetallic);
        }

        private void DrawRemapping(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            if (isMetallic)
                DrawMetallicRemapping(editor);

            DrawSmoothnessRemapping(editor);
            DrawAORemapping(editor);
        }

        private void DrawMetallicRemapping(MaterialEditorGUIPlus editor) => 
            editor.DrawMinMaxSlider(SurfaceInputsStyles.MetallicRemapping, 
                _metallicMin[_layerIndex].MaterialProperty, 
                _metallicMax[_layerIndex].MaterialProperty);

        private void DrawSmoothnessRemapping(MaterialEditorGUIPlus editor) => 
            editor.DrawMinMaxSlider(SurfaceInputsStyles.SmoothnessRemapping, 
                _smoothnessMin[_layerIndex].MaterialProperty, 
                _smoothnessMax[_layerIndex].MaterialProperty);

        private void DrawAORemapping(MaterialEditorGUIPlus editor) => 
            editor.DrawMinMaxSlider(SurfaceInputsStyles.AORemapping, 
                _aoMin[_layerIndex].MaterialProperty, 
                _aoMax[_layerIndex].MaterialProperty);

        private void DrawMetallicSmoothness(MaterialEditorGUIPlus editor, bool isMetallic)
        {
            if (isMetallic)
                DrawMetallicSlider(editor);

            DrawSmoothnessSlider(editor);
        }

        private void DrawMetallicSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SurfaceInputsStyles.Metallic, _metallicProperties[_layerIndex].MaterialProperty);

        private void DrawSmoothnessSlider(MaterialEditorGUIPlus editor) => 
            editor.DrawSlider(SurfaceInputsStyles.Smoothness, _smoothnessProperties[_layerIndex].MaterialProperty);

        private WorkflowMode GetWorkflow()
        {
            if (!_material.HasProperty(_workflow.ID))
                return WorkflowMode.Specular;

            return (WorkflowMode)_material.GetFloat(_workflow.ID);
        }

        private bool HasMaskMap()
        {
            string layerMaskMapID = GetLayerMaskMapPropertyName();
            if (!_material.HasProperty(layerMaskMapID))
                return false;

            return _maskMapProperties[_layerIndex].MaterialProperty.textureValue is not null;
        }

        private string GetLayerMaskMapPropertyName() =>
            LayerUtils.LayerPropertyName(LitSurfaceInputsProperties.MaskMap, _layerIndex);
    }
}