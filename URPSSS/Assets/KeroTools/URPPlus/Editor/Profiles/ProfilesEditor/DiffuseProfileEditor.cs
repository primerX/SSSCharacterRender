using UnityEditor;

namespace KeroTools.URPPlus.Editor.Profiles.ProfilesEditor
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(DiffusionProfileSettings))]
    public class DiffuseProfileEditor : UnityEditor.Editor
    {
        private EditorGUIPlus.EditorGUIPlus _editorGUIPlus;

        private SerializedProperty _diffusionLUT;
        private SerializedProperty _translucencyColor;
        private SerializedProperty _translucencyScale;
        private SerializedProperty _translucencyPower;
        private SerializedProperty _translucencyAmbient;
        private SerializedProperty _translucencyDistortion;
        private SerializedProperty _translucencyShadows;
        private SerializedProperty _translucencyDiffuseInfluence;

        public void OnEnable()
        {
            _editorGUIPlus = new EditorGUIPlus.EditorGUIPlus();

            FindDiffusionProperties();
            FindTranlucencyProperties();
        }

        private void FindDiffusionProperties() =>
            _diffusionLUT = serializedObject.FindProperty(nameof(DiffusionProfileSettings.DiffusionLUT));

        private void FindTranlucencyProperties()
        {
            _translucencyColor = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyColor));
            _translucencyScale = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyScale));
            _translucencyPower = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyPower));
            _translucencyAmbient = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyAmbient));
            _translucencyDistortion = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyDistortion));
            _translucencyShadows = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyShadows));
            _translucencyDiffuseInfluence = serializedObject.FindProperty(nameof(DiffusionProfileSettings.TranslucencyDiffuseInfluence));
        }

        public override void OnInspectorGUI()
        {
            serializedObject.Update();
            DrawDiffusionProperties();
            DrawTranlucencySettings();
            serializedObject.ApplyModifiedProperties();
        }

        private void DrawDiffusionProperties()
        {
            _editorGUIPlus.DrawGroup(DiffuseProfileStyles.DiffusionSettingsLabel,
                () => { _editorGUIPlus.DrawTexture(DiffuseProfileStyles.DiffusionLUT, _diffusionLUT); });
        }

        private void DrawTranlucencySettings()
        {
            _editorGUIPlus.DrawGroup(DiffuseProfileStyles.TranlucencySettingsLabel, () =>
            {
                _editorGUIPlus.DrawColor(DiffuseProfileStyles.TranlucencyColor, _translucencyColor);
                _editorGUIPlus.DrawMinFloat(DiffuseProfileStyles.TranlucencyIntensity, _translucencyScale);
                _editorGUIPlus.DrawSlider(DiffuseProfileStyles.TranlucencyPower, _translucencyPower);
                _editorGUIPlus.DrawMinFloat(DiffuseProfileStyles.TranlucencyAmbient, _translucencyAmbient);
                _editorGUIPlus.DrawSlider(DiffuseProfileStyles.TranlucencyDistortion, _translucencyDistortion);
                _editorGUIPlus.DrawSlider(DiffuseProfileStyles.TranlucencyShadows, _translucencyShadows);
                _editorGUIPlus.DrawSlider(DiffuseProfileStyles.TranlucencyDiffuseInfluence, _translucencyDiffuseInfluence);
            });
        }
    }
}