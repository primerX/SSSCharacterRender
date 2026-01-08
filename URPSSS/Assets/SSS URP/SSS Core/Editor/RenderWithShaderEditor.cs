using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering;
using UnityEditor;

namespace SSS_URP
{
    [CustomEditor(typeof(RenderWithShader))]
    internal class RenderWithShaderEditor : Editor
    {
        #region Serialized Properties        
        private SerializedProperty UseRenderingLayers;
        private SerializedProperty m_RenderingLayerMask;
        private SerializedProperty targetName;
        private SerializedProperty Event;
        private SerializedProperty layer;
        private SerializedProperty ReplacementShader;
        private SerializedProperty RT_Format;
        #endregion

        private bool m_IsInitialized = false;
        RenderPipelineAsset asset;

        internal class Styles
        {
            public static GUIContent renderingLayerMask = new GUIContent("Rendering Layer Mask", "Only render objects that match the given rendering layer mask.");
            public static float defaultLineSpace = EditorGUIUtility.singleLineHeight + EditorGUIUtility.standardVerticalSpacing;
        }

        private void Init()
        {
            asset = UniversalRenderPipeline.asset;
            SerializedProperty settings = serializedObject.FindProperty("settings");
            UseRenderingLayers = settings.FindPropertyRelative("UseRenderingLayers");
            m_RenderingLayerMask = settings.FindPropertyRelative("RenderingLayerMask");
            targetName = settings.FindPropertyRelative("targetName");
            Event = settings.FindPropertyRelative("Event");
            layer = settings.FindPropertyRelative("layer");
            ReplacementShader = settings.FindPropertyRelative("ReplacementShader");
            RT_Format = settings.FindPropertyRelative("RT_Format");
            m_IsInitialized = true;
        }

        public override void OnInspectorGUI()
        {
            if (!m_IsInitialized)
            {
                Init();
            }

            EditorGUILayout.PropertyField(ReplacementShader, EditorGUIUtility.TrTextContent("Shader", ""));
            EditorGUILayout.PropertyField(layer, EditorGUIUtility.TrTextContent("Layer", "Render only the given layer"));
            EditorGUILayout.PropertyField(UseRenderingLayers, EditorGUIUtility.TrTextContent("Use Rendering Layers", ""));
            string[] layerNames = asset != null ? asset.renderingLayerMaskNames : EditorUtils.defaultRenderingLayerNames;
            if (UseRenderingLayers.boolValue)
            {
                m_RenderingLayerMask.intValue = EditorGUILayout.MaskField(Styles.renderingLayerMask, m_RenderingLayerMask.intValue, layerNames);
            }

            EditorGUILayout.PropertyField(targetName, EditorGUIUtility.TrTextContent("targetName", "Render Texture name (global variable)"));
            EditorGUILayout.PropertyField(RT_Format, EditorGUIUtility.TrTextContent("RT_Format", ""));
            EditorGUILayout.PropertyField(Event, EditorGUIUtility.TrTextContent("Event", ""));
        }
    }

    static class EditorUtils
    {
        private static string[] m_DefaultRenderingLayerNames;
        internal static string[] defaultRenderingLayerNames
        {
            get
            {
                if (m_DefaultRenderingLayerNames == null)
                {
                    m_DefaultRenderingLayerNames = new string[32];
                    for (int i = 0; i < m_DefaultRenderingLayerNames.Length; ++i)
                    {
                        m_DefaultRenderingLayerNames[i] = string.Format("Layer{0}", i + 1);
                    }
                }
                return m_DefaultRenderingLayerNames;
            }
        }
    }
}
