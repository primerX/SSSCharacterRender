using UnityEditor;
using UnityEditor.Rendering;

namespace SSS_URP
{
    [CustomEditor(typeof(SSS))]
    public class SSS_VolumeEditor : VolumeComponentEditor
    {
        #region Serialized Properties
        SerializedDataParameter Radius;
        SerializedDataParameter DepthTest;
        SerializedDataParameter blurPasses;
        SerializedDataParameter Iterations;
        SerializedDataParameter downsample;
        SerializedDataParameter Dither;
        SerializedDataParameter DitherScale;
        SerializedDataParameter FixPixelLeak;
        SerializedDataParameter SubsurfaceScaler;
        SerializedDataParameter SubsurfaceColor;
        SerializedDataParameter SubsurfaceFalloff;
        SerializedDataParameter SamplerSteps;
        SerializedDataParameter EnableProfileTest;
        SerializedDataParameter ProfileColorTest;
        SerializedDataParameter ProfileRadiusTest;
        SerializedDataParameter EnableNormalTest;
        SerializedDataParameter NormalTest;
        #endregion

        HeaderBool m_EdgeTest;

        public override void OnEnable()
        {
            base.OnEnable();

            var o = new PropertyFetcher<SSS>(serializedObject);
            Radius = Unpack(o.Find(x => x.Radius));
            blurPasses = Unpack(o.Find(x => x.blurPasses));
            DepthTest = Unpack(o.Find(x => x.DepthTest));
            Iterations = Unpack(o.Find(x => x.Iterations));
            downsample = Unpack(o.Find(x => x.Downsample));
            Dither = Unpack(o.Find(x => x.Dither));
            DitherScale = Unpack(o.Find(x => x.DitherScale));
            FixPixelLeak = Unpack(o.Find(x => x.FixPixelLeak));

            SubsurfaceScaler = Unpack(o.Find(x => x.SubsurfaceScaler));
            SubsurfaceColor = Unpack(o.Find(x => x.SubsurfaceColor));
            SubsurfaceFalloff = Unpack(o.Find(x => x.SubsurfaceFalloff));
            SamplerSteps = Unpack(o.Find(x => x.SamplerSteps));

            EnableProfileTest = Unpack(o.Find(x => x.EnableProfileTest));
            ProfileColorTest = Unpack(o.Find(x => x.ProfileColorTest));
            ProfileRadiusTest = Unpack(o.Find(x => x.ProfileRadiusTest));
            EnableNormalTest = Unpack(o.Find(x => x.EnableNormalTest));
            NormalTest = Unpack(o.Find(x => x.NormalTest));

            m_EdgeTest = new HeaderBool($"SSS.EdgeTestFoldout", false);
        }

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

        public override void OnInspectorGUI()
        {
            serializedObject.Update();

            PropertyField(Radius, EditorGUIUtility.TrTextContent(Radius.displayName, ""));
            PropertyField(blurPasses, EditorGUIUtility.TrTextContent(blurPasses.displayName, ""));
            PropertyField(Iterations, EditorGUIUtility.TrTextContent(Iterations.displayName, ""));
            PropertyField(downsample, EditorGUIUtility.TrTextContent(downsample.displayName, ""));
            PropertyField(Dither, EditorGUIUtility.TrTextContent(Dither.displayName, ""));
            PropertyField(DitherScale, EditorGUIUtility.TrTextContent(DitherScale.displayName, ""));
            PropertyField(FixPixelLeak, EditorGUIUtility.TrTextContent(FixPixelLeak.displayName, ""));

            PropertyField(SubsurfaceScaler, EditorGUIUtility.TrTextContent(SubsurfaceScaler.displayName, ""));
            PropertyField(SubsurfaceColor, EditorGUIUtility.TrTextContent(SubsurfaceColor.displayName, ""));
            PropertyField(SubsurfaceFalloff, EditorGUIUtility.TrTextContent(SubsurfaceFalloff.displayName, ""));
            PropertyField(SamplerSteps, EditorGUIUtility.TrTextContent(SamplerSteps.displayName, ""));


            m_EdgeTest.SetValue(EditorGUILayout.Foldout(m_EdgeTest.value, EditorGUIUtility.TrTextContent("Edge Test", "Reduce edge blur")));
            if (m_EdgeTest.value)
            {
                EditorGUI.indentLevel++;
                PropertyField(DepthTest, EditorGUIUtility.TrTextContent("Depth Test", ""));
                PropertyField(EnableProfileTest, EditorGUIUtility.TrTextContent("Profile test", "Use profile texture to check edges"));

                if (EnableProfileTest.value.boolValue)
                {
                    EditorGUI.indentLevel++;
                    PropertyField(ProfileColorTest, EditorGUIUtility.TrTextContent("�RGB test", "Checks color only"));
                    PropertyField(ProfileRadiusTest, EditorGUIUtility.TrTextContent("�Radius test", "Use profile alpha x radius to check edges"));
                    EditorGUI.indentLevel--;
                }

                PropertyField(EnableNormalTest, EditorGUIUtility.TrTextContent("Normal test", "Use the normals to check discontinuities"));

                if (EnableNormalTest.value.boolValue)
                {
                    EditorGUI.indentLevel++;
                    PropertyField(NormalTest, EditorGUIUtility.TrTextContent("�Radius test", ""));
                    EditorGUI.indentLevel--;
                }

                EditorGUI.indentLevel--;
            }

            serializedObject.ApplyModifiedProperties();
        }
    }
}
