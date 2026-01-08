using System;
using EditorGUIPlus.Data.Enums;
using EditorGUIPlus.Data.Range;
using UnityEditor;

using KeroTools.URPPlus.Runtime;
using KeroTools.URPPlus.Runtime.Data;

namespace KeroTools.URPPlus.Editor
{
    [CustomEditor(typeof(URPPlusSettings))]
    public class UrpPlusSettingsEditor : UnityEditor.Editor
    {
        private EditorGUIPlus.EditorGUIPlus _editor;
        
        private SerializedProperty _iridescenceModel;
        private SerializedProperty _sheenModel;
        private SerializedProperty _enableCoatGeometricAA;
        private SerializedProperty _screenFadeDistance;
        
        private SerializedProperty _enableMicroShadows;
        private SerializedProperty _microShadowsOpacity;
        private SerializedProperty _enableHighQualityDepthNormals;
        
        private readonly string[] _sheenModelOptions = Enum.GetNames(typeof(SheenModel));
        private readonly string[] _iridescenceModelOptions = Enum.GetNames(typeof(IridescenceModel));
        
        private void OnEnable()
        {
            _editor = new EditorGUIPlus.EditorGUIPlus();
            
            _iridescenceModel = serializedObject.FindProperty("_iridescenceModel");
            _sheenModel = serializedObject.FindProperty("_sheenModel");
            _enableCoatGeometricAA = serializedObject.FindProperty("_enableCoatGeometricAA");
            _screenFadeDistance = serializedObject.FindProperty("_screenFadeDistance");

            _enableMicroShadows = serializedObject.FindProperty("_enableMicroShadows");
            _microShadowsOpacity = serializedObject.FindProperty("_microShadowsOpacity");
            _enableHighQualityDepthNormals = serializedObject.FindProperty("_enableHighQualityDepthNormals");
        }

        public override void OnInspectorGUI()
        {
            serializedObject.Update();
            DrawMaterialsSettings();
            DrawAmbientOcclusionSettings();
            serializedObject.ApplyModifiedProperties();
        }

        private void DrawMaterialsSettings()
        {
            _editor.DrawGroup(URPPlusStyles.MaterialQualityOptions, URPPlusSettings.IsDisabled, () =>
            {
                DrawIridescenceModel();
                DrawSheenModel();
                DrawCoatSpecularAAToggle();
                _editor.DrawSlider(URPPlusStyles.ScreenFadeDistanceText, _screenFadeDistance, new FloatRange(0.001f, 1.0f));
            });
        }

        private void DrawAmbientOcclusionSettings()
        {
            _editor.DrawGroup(URPPlusStyles.MaterialQualityOptions, URPPlusSettings.IsDisabled, () =>
            {
                DrawMicroShadowing();
                DrawHQDepthNormals();
            });
        }

        private void DrawSheenModel() => 
            _editor.DrawShaderGlobalKeywordBooleanPopup<SheenModel>(URPPlusStyles.SheenModelText, _sheenModel, GlobalVariables.PbSheenKeyword);

        private void DrawIridescenceModel()
        {
            _editor.DrawShaderGlobalKeywordBooleanPopup(URPPlusStyles.IridescenceModelText, _iridescenceModel, 
                _iridescenceModelOptions, GlobalVariables.PreIntegratedIridescenceKeyword);
        }

        private void DrawCoatSpecularAAToggle()
        {
            _editor.DrawShaderGlobalKeywordToggle(URPPlusStyles.CoatSpecularAAText, _enableCoatGeometricAA,
                GlobalVariables.CoatSpecularAAKeyword, ToggleAlign.Right);
        }

        private void DrawMicroShadowing()
        {
            _editor.DrawShaderGlobalKeywordToggle(URPPlusStyles.MicroShadowsText, _enableMicroShadows,
                GlobalVariables.MicroShadowsKeyword, ToggleAlign.Right);
            
            if (_enableMicroShadows.boolValue)
                _editor.DrawSlider(URPPlusStyles.MicroShadowsOpacityText, _microShadowsOpacity, 1);
        }

        private void DrawHQDepthNormals()
        {
            _editor.DrawShaderGlobalKeywordToggle(URPPlusStyles.HqDepthNormalsText, _enableHighQualityDepthNormals,
                GlobalVariables.HqDepthNormalsKeyword, ToggleAlign.Right);
        }
    }
}