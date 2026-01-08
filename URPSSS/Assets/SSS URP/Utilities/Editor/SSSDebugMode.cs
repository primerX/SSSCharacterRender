#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

namespace SSS_URP
{
    public class SSSDebugModeWindow : EditorWindow
    {
        [MenuItem("Tools/SSS Debug Mode")]
        public static void ShowWindow()
        {
            GetWindow<SSSDebugModeWindow>("SSS Debug Mode");
        }

        bool debug_mode, debug_mode_changed=true;

        string[] _DebugMode = new string[] {
            "LightPass",
            "BlurPass",
            "SpecularHighlight",
            "EnvironmentReflections",
            "Transmission",
            "Light Map",
            "Reflection probe capture"
        };

        int _SSS_DebugMode;
        int reclick;
        int _SSS_DebugMode_changed;

        string ShaderName = "SSS Object";
        public Shader shader;
        public List<Material> materials = new List<Material>();

        private void OnEnable()
        {

        }

        void Button(string DebugModeName, int DebugMode)
        {
            //if (_SSS_DebugMode != _SSS_DebugMode_changed)
            //    reclick = 1;
            //else
            //    reclick = 0;
            GUI.color = Color.white;

            if (_SSS_DebugMode == DebugMode && debug_mode)
                GUI.color = Color.green;

            if (GUILayout.Button(DebugModeName))
            {

                _SSS_DebugMode = DebugMode;
                if (_SSS_DebugMode == _SSS_DebugMode_changed)
                {                  
                    reclick++;
                }
               
                if (reclick >= 1)
                {
                    reclick = 0;
                    //Debug.Log("Reclick");
                    debug_mode = !debug_mode;
                }
                
                //Debug.Log(reclick);
                if (!debug_mode && _SSS_DebugMode != _SSS_DebugMode_changed)
                {
                    debug_mode = true;
                    //Debug.Log("jump");
                }

                SetDebugMode(_SSS_DebugMode);
            }


        }

        private void OnGUI()
        {
            this.maxSize = new Vector2(250, 205);
            this.minSize = new Vector2(250, 205);
            EditorGUI.indentLevel++;

            GUILayout.BeginHorizontal();
            {
                EditorGUIUtility.labelWidth = 1;
                EditorGUILayout.LabelField("Shader Name");
                ShaderName = EditorGUILayout.TextArea(ShaderName);
            }
            GUILayout.EndHorizontal();

            debug_mode = GUILayout.Toggle(debug_mode, "Enable");
            GUILayout.Space(5);

            //if (debug_mode)
            //{
            //    _SSS_DebugMode = EditorGUILayout.Popup(_SSS_DebugMode, _DebugMode);
            //    SetDebugMode(_SSS_DebugMode);
            //}

            Button("Light pass", 0);
            Button("Blur pass", 1);
            Button("Specular Highlight", 2);
            Button("Environment Reflections", 3);
            Button("Transmission", 4);
            Button("Lightmap", 5);
            Button("Reflection probe capture", 6);


            //SetDebugMode(_SSS_DebugMode);

            EnableDebugMode();

            DisableDebugMode();
            EditorGUI.indentLevel--;

        }

        void SetDebugMode(int mode)
        {
            //if (_SSS_DebugMode != _SSS_DebugMode_changed)
            {
                foreach (Material mat in materials)
                {
                    mat.SetFloat("_SSS_DebugMode", _SSS_DebugMode);
                }
                _SSS_DebugMode_changed = _SSS_DebugMode;
                //reclick = 0;
            }

        }

        void FindShader()
        {
            shader = Shader.Find(ShaderName);

            //if (shader != null)
            //    Debug.Log("Shader found");
            //else
            //    Debug.Log("Shader not found");
        }

        void EnableDebugMode()
        {
            if (debug_mode && debug_mode_changed != debug_mode)
            {
                FindShader();
                FindSSSObjects();
                foreach (Material mat in materials)
                {
                    mat.EnableKeyword("_DEBUG_ON");
                    mat.SetFloat("_Debug", 1);
                }
                debug_mode_changed = debug_mode;
            }
        }

        void DisableDebugMode()
        {
            if (!debug_mode && debug_mode_changed != debug_mode)
            {
                FindShader();
                FindSSSObjects();
                foreach (Material mat in materials)
                {
                    mat.DisableKeyword("_DEBUG_ON");
                    mat.SetFloat("_Debug", 0);
                }
                debug_mode_changed = debug_mode;
            }
        }

        private void OnDisable()
        {
            //FindShader();
            //FindSSSObjects();
            //foreach (Material mat in materials)
            //{
            //    mat.DisableKeyword("_DEBUG_ON");
            //    mat.SetFloat("_Debug", 0);
            //}
            //_SSS_DebugMode = 0;
            //foreach (Material mat in materials)
            //{
            //    mat.SetFloat("_SSS_DebugMode", _SSS_DebugMode);
            //}
            //_SSS_DebugMode_changed = _SSS_DebugMode;
        }

        private void FindSSSObjects()
        {
            if (shader != null)
            {
                materials.Clear();

                foreach (GameObject go in GameObject.FindObjectsOfType(typeof(GameObject)))
                {
                    if (go.GetComponent<Renderer>())
                        if (go.GetComponent<Renderer>().sharedMaterial.shader == shader)
                        {
                            Material mat = go.GetComponent<Renderer>().sharedMaterial;
                            materials.Add(mat);
                            //Debug.Log("Found : " + mat.name);

                        }
                }
            }


        }


    }
}
#endif