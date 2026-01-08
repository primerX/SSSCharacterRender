using System.Collections.Generic;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.MaterialConvertor
{
    public class MaterialConverterWindow : EditorWindow
    {
        private URPPlusShaderList _selectedShader;

        private int _selectedMaterialCount;

        [MenuItem("Tools/ShadowShard/URP+ Material Converter")]
        public static void ShowWindow() =>
            GetWindow<MaterialConverterWindow>("URP+ Material Converter");

        private List<MaterialUpgrader> GetUpgraders()
        {
            List<MaterialUpgrader> upgraders = new()
            {
                new LitConverter("Universal Render Pipeline/Simple Lit", "KeroTools/URP+/" + _selectedShader),
                new LitConverter("Universal Render Pipeline/Lit", "KeroTools/URP+/" + _selectedShader),
                new LitConverter("Universal Render Pipeline/Complex Lit", "KeroTools/URP+/" + _selectedShader)
            };

            return upgraders;
        }

        private void OnGUI()
        {
            GUILayout.Label("Convert Selected Materials", EditorStyles.boldLabel);
            
            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            DrawURPPlusShaderSelection();
            DrawSelectedMaterials();
            DrawConvertButton();
            EditorGUILayout.EndVertical();
        }

        private void DrawURPPlusShaderSelection() =>
            _selectedShader = (URPPlusShaderList)EditorGUILayout.EnumPopup("Target Shader", _selectedShader);

        private void DrawSelectedMaterials()
        {
            _selectedMaterialCount = 0;

            if (Selection.objects != null)
            {
                foreach (Object obj in Selection.objects)
                    if (obj is Material) 
                        _selectedMaterialCount++;
            }

            GUILayout.Label("Selected Materials: " + _selectedMaterialCount);
        }

        private void DrawConvertButton()
        {
            if (GUILayout.Button("Convert Selected Materials"))
                MaterialUpgrader.UpgradeSelection(GetUpgraders(), "Upgrade to URP+ Material");
        }
    }
}