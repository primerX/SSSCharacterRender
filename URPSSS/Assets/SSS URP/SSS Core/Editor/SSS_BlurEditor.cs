using UnityEngine;
using UnityEditor;

namespace SSS_URP
{
    [CustomEditor(typeof(SSS_PassFeature))]
    internal class SSS_BlurEditor : Editor
    {
        #region Serialized Properties        
        private SerializedProperty RT_Format;
        private SerializedProperty renderPassEvent;
        private SerializedProperty blurMaterial;
        private SerializedProperty CopyLight;
        private SerializedProperty Radius;
        private SerializedProperty NoiseTexture;
        private SerializedProperty DepthTest;
        private SerializedProperty blurPasses;
        private SerializedProperty Iterations;
        private SerializedProperty downsample;
        private SerializedProperty Dither;
        private SerializedProperty DitherScale;
        private SerializedProperty FixPixelLeak;
        private SerializedProperty EnableProfileTest;
        private SerializedProperty ProfileColorTest;
        private SerializedProperty ProfileRadiusTest;
        private SerializedProperty targetName;
        private SerializedProperty EnableNormalTest;
        private SerializedProperty NormalTest;
        private SerializedProperty _RenderPipelineAsset;
        private SerializedProperty CascadeWeight0;
        private SerializedProperty CascadeWeight1;
        private SerializedProperty CascadeWeight2;
        private SerializedProperty CascadeWeight3;
        //private SerializedProperty TranslucencyDistanceFade;
        #endregion

        private HeaderBool m_Resources;
        private HeaderBool m_EdgeTest;
        private HeaderBool m_CascadeWeights;

        class HeaderBool
        {
            private string key;
            public bool value;

            internal HeaderBool(string _key, bool _default = false)
            {
                key = _key;
                if (EditorPrefs.HasKey(key))
                    value = EditorPrefs.GetBool(key);
                else
                    value = _default;
                EditorPrefs.SetBool(key, value);
            }

            internal void SetValue(bool newValue)
            {
                value = newValue;
                EditorPrefs.SetBool(key, value);
            }
        }
        private bool m_IsInitialized = false;

        private struct Styles
        {
            public static GUIContent Resources = EditorGUIUtility.TrTextContent("Resources", "Required assets");
            public static GUIContent m_EdgeTest = EditorGUIUtility.TrTextContent("Edge Test", "");
            public static GUIContent m_CascadeWeights = EditorGUIUtility.TrTextContent("Cascade weights", "Adjust cascades weight for the translucency");
        }

        private void Init()
        {
            m_Resources = new HeaderBool($"SSS.ResourcesFoldout", false);
            m_EdgeTest = new HeaderBool($"SSS.EdgeTestFoldout", false);
            m_CascadeWeights = new HeaderBool($"SSS.CascadeWeightsFoldout", false);

            SerializedProperty settings = serializedObject.FindProperty("settings");

            RT_Format = settings.FindPropertyRelative("RT_Format");
            renderPassEvent = settings.FindPropertyRelative("renderPassEvent");
            blurMaterial = settings.FindPropertyRelative("blurMaterial");
            CopyLight = settings.FindPropertyRelative("CopyLight");
            Radius = settings.FindPropertyRelative("Radius");
            //TranslucencyDistanceFade = settings.FindPropertyRelative("TranslucencyDistanceFade");
            NoiseTexture = settings.FindPropertyRelative("NoiseTexture");
            DepthTest = settings.FindPropertyRelative("DepthTest");
            blurPasses = settings.FindPropertyRelative("blurPasses");
            Iterations = settings.FindPropertyRelative("Iterations");
            downsample = settings.FindPropertyRelative("downsample");
            Dither = settings.FindPropertyRelative("Dither");
            DitherScale = settings.FindPropertyRelative("DitherScale");
            FixPixelLeak = settings.FindPropertyRelative("FixPixelLeak");
            FixPixelLeak = settings.FindPropertyRelative("FixPixelLeak");
            EnableProfileTest = settings.FindPropertyRelative("EnableProfileTest");
            ProfileColorTest = settings.FindPropertyRelative("ProfileColorTest");
            ProfileRadiusTest = settings.FindPropertyRelative("ProfileRadiusTest");
            targetName = settings.FindPropertyRelative("targetName");
            EnableNormalTest = settings.FindPropertyRelative("EnableNormalTest");
            NormalTest = settings.FindPropertyRelative("NormalTest");
            _RenderPipelineAsset = settings.FindPropertyRelative("_RenderPipelineAsset");
            CascadeWeight0 = settings.FindPropertyRelative("CascadeWeight0");
            CascadeWeight1 = settings.FindPropertyRelative("CascadeWeight1");
            CascadeWeight2 = settings.FindPropertyRelative("CascadeWeight2");
            CascadeWeight3 = settings.FindPropertyRelative("CascadeWeight3");

            m_IsInitialized = true;
        }

        public override void OnInspectorGUI()
        {
            if (!m_IsInitialized)
            {
                Init();
            }

            EditorGUILayout.PropertyField(RT_Format, EditorGUIUtility.TrTextContent("RT_Format", ""));
            EditorGUILayout.PropertyField(renderPassEvent, EditorGUIUtility.TrTextContent("Event", ""));
            EditorGUILayout.PropertyField(Radius, EditorGUIUtility.TrTextContent("Radius", ""));
            EditorGUILayout.PropertyField(blurPasses, EditorGUIUtility.TrTextContent("Passes", ""));
            EditorGUILayout.PropertyField(Iterations, EditorGUIUtility.TrTextContent("Iterations", "Each iteration performs a box blur (5 samplers)"));
            EditorGUILayout.PropertyField(downsample, EditorGUIUtility.TrTextContent("Downsample", ""));
            EditorGUILayout.PropertyField(Dither, EditorGUIUtility.TrTextContent("Dither", "Randomize sampler position. Makes the process slower at closer distances"));
            EditorGUILayout.PropertyField(DitherScale, EditorGUIUtility.TrTextContent("Dither Scale", ""));
            EditorGUILayout.PropertyField(FixPixelLeak, EditorGUIUtility.TrTextContent("Fix pixel leak", "Reduce edge blur"));

            EditorGUI.indentLevel++;
            m_EdgeTest.SetValue(EditorGUILayout.Foldout(m_EdgeTest.value, Styles.m_EdgeTest));
            if (m_EdgeTest.value)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.PropertyField(DepthTest, EditorGUIUtility.TrTextContent("Depth Test", ""));
                EditorGUILayout.PropertyField(EnableProfileTest, EditorGUIUtility.TrTextContent("Profile test", "Use profile texture to check edges"));

                if (EnableProfileTest.boolValue)
                {
                    EditorGUI.indentLevel++;
                    EditorGUILayout.PropertyField(ProfileColorTest, EditorGUIUtility.TrTextContent("RGB test", "Use profile texture to check edges"));
                    EditorGUILayout.PropertyField(ProfileRadiusTest, EditorGUIUtility.TrTextContent("Radius test", "Use profile alpha x radius to check edges"));
                    EditorGUI.indentLevel--;
                }

                EditorGUILayout.PropertyField(EnableNormalTest, EditorGUIUtility.TrTextContent("Normal test", "Use the normals to check discontinuities"));

                if (EnableNormalTest.boolValue)
                {
                    EditorGUI.indentLevel++;
                    EditorGUILayout.PropertyField(NormalTest, EditorGUIUtility.TrTextContent("Radius test", ""));
                    EditorGUI.indentLevel--;
                }
                EditorGUI.indentLevel--;
            }
            EditorGUI.indentLevel--;

            EditorGUI.indentLevel++;
            m_Resources.SetValue(EditorGUILayout.Foldout(m_Resources.value, Styles.Resources));
            if (m_Resources.value)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.PropertyField(targetName, EditorGUIUtility.TrTextContent("Target name", "The included shader will use _SSS_Blur as default. Won't work if changed"));
                EditorGUILayout.PropertyField(blurMaterial, EditorGUIUtility.TrTextContent("blur Material", "Blur material"));
                EditorGUILayout.PropertyField(CopyLight, EditorGUIUtility.TrTextContent("CopyLight Material", "Blit light pass"));
                EditorGUILayout.PropertyField(NoiseTexture, EditorGUIUtility.TrTextContent("Noise texture", "Used to dither the blur"));
                EditorGUI.indentLevel--;
            }
            EditorGUI.indentLevel--;

            EditorGUI.indentLevel++;
            m_CascadeWeights.SetValue(EditorGUILayout.Foldout(m_CascadeWeights.value, Styles.m_CascadeWeights));
            if (m_CascadeWeights.value)
            {
                EditorGUILayout.PropertyField(_RenderPipelineAsset, EditorGUIUtility.TrTextContent("Render Pipeline Asset", "Assign here your Pipeline Asset. It is used to read shadow values"));
                EditorGUILayout.PropertyField(CascadeWeight0, EditorGUIUtility.TrTextContent("CascadeWeight0", ""));
                EditorGUILayout.PropertyField(CascadeWeight1, EditorGUIUtility.TrTextContent("CascadeWeight1", ""));
                EditorGUILayout.PropertyField(CascadeWeight2, EditorGUIUtility.TrTextContent("CascadeWeight2", ""));
                EditorGUILayout.PropertyField(CascadeWeight3, EditorGUIUtility.TrTextContent("CascadeWeight3", ""));
            }
            EditorGUI.indentLevel--;

            GUILayout.Space(10);
            EditorGUILayout.LabelField("Add SSS to the posprocess volume to override");
            EditorGUILayout.LabelField("v1.2 March 2023");
        }
    }
}
