using UnityEditor;

namespace KeroTools.URPPlus.Editor.Profiles.ProfilesEditor
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(WeatherProfileSettings))]
    public class WeatherProfileEditor : UnityEditor.Editor
    {
        private EditorGUIPlus.EditorGUIPlus _editor;
        
        private SerializedProperty _puddleNormal;
        private SerializedProperty _puddlesFramesSize;
        private SerializedProperty _puddlesSize;
        private SerializedProperty _puddlesAnimationSpeed;
        
        private SerializedProperty _rainNormal;
        private SerializedProperty _rainSize;
        private SerializedProperty _rainAnimationSpeed;
        
        public void OnEnable()
        {
            _editor = new EditorGUIPlus.EditorGUIPlus();
            
            FindPuddlesProperties();
            FindRainProperties();
        }
        
        private void FindPuddlesProperties()
        {
            _puddleNormal = serializedObject.FindProperty(nameof(WeatherProfileSettings.PuddleNormal));
            _puddlesFramesSize = serializedObject.FindProperty(nameof(WeatherProfileSettings.PuddlesFramesSize));
            _puddlesSize = serializedObject.FindProperty(nameof(WeatherProfileSettings.PuddlesSize));
            _puddlesAnimationSpeed = serializedObject.FindProperty(nameof(WeatherProfileSettings.PuddlesAnimationSpeed));
        }

        private void FindRainProperties()
        {
            _rainNormal = serializedObject.FindProperty(nameof(WeatherProfileSettings.RainNormal));
            _rainSize = serializedObject.FindProperty(nameof(WeatherProfileSettings.RainSize));
            _rainAnimationSpeed = serializedObject.FindProperty(nameof(WeatherProfileSettings.RainAnimationSpeed));
        }
        
        public override void OnInspectorGUI()
        {
            serializedObject.Update();
            DrawPuddlesProperties();
            DrawRainSettings();
            serializedObject.ApplyModifiedProperties();
        }
        
        private void DrawPuddlesProperties()
        {
            _editor.DrawGroup(WeatherProfileStyles.PuddlesSettingsLabel,  () =>
            {
                _editor.DrawTexture(WeatherProfileStyles.PuddleNormal, _puddleNormal);
                _editor.DrawVector2(WeatherProfileStyles.PuddlesFramesSize, _puddlesFramesSize);
                _editor.DrawMinFloat(WeatherProfileStyles.PuddlesSize, _puddlesSize);
                _editor.DrawMinFloat(WeatherProfileStyles.PuddlesAnimationSpeed, _puddlesAnimationSpeed);
            });
        }

        private void DrawRainSettings()
        {
            _editor.DrawGroup(WeatherProfileStyles.RainSettingsLabel,  () =>
            {
                _editor.DrawTexture(WeatherProfileStyles.RainNormal, _rainNormal);
                _editor.DrawMinFloat(WeatherProfileStyles.RainSize, _rainSize);
                _editor.DrawMinFloat(WeatherProfileStyles.RainAnimationSpeed, _rainAnimationSpeed);
            });
        }
    }
}