#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

namespace SSS_URP
{
    public class SSSPreparerWindow : EditorWindow
    {
        [MenuItem("Tools/Prepare SSS objects for GI")]
        public static void ShowWindow()
        {
            GetWindow<SSSPreparerWindow>("Prepare SSS objects for GI");
        }

        bool ready;
        string ShaderName = "SSS Object";
        public Shader shader;
        public List<Material> materials = new List<Material>();

        private void OnGUI()
        {
            this.maxSize = new Vector2(250, 140);
            this.minSize = new Vector2(250, 140);

            GUILayout.BeginHorizontal();
            {
                EditorGUIUtility.labelWidth = 1;
                EditorGUILayout.LabelField("Shader Name");
                ShaderName = EditorGUILayout.TextArea(ShaderName);
            }
            GUILayout.EndHorizontal();

            //if (GUILayout.Button("Find Shader"))
            //{
            //    FindShader();
            //}

            //if (GUILayout.Button("Find SSS Materials"))
            //{
            //    FindSSSObjects();
            //}

            if (GUILayout.Button("Prepare"))
            {
                FindShader();
                FindSSSObjects();
                Prepare();
            }

            if (GUILayout.Button("Revert"))
            {
                Revert();
            }

            GUILayout.Space(5);
            if(ready)
                GUI.color = Color.green;
            else
                GUI.color = Color.red;

            EditorGUILayout.LabelField(ready ? "Ready to Bake" : "Not ready", new GUIStyle(GUI.skin.label) { alignment = TextAnchor.MiddleCenter });
            GUILayout.Space(5);
            GUI.color = Color.white;

            if (ready)
                if (GUILayout.Button("Bake Lighting"))
                {
                    Lightmapping.BakeAsync();
                }
        }

        void FindShader()
        {
            shader = Shader.Find(ShaderName);

            if (shader != null)
                Debug.Log("Shader found");
            else
                Debug.Log("Shader not found");
        }

        void OnEnable()
        {
            //FindShader();
            //FindSSSObjects();
            //Prepare();
        }

        private void OnDisable()
        {
            //Revert();
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
                            Debug.Log("Found : " + mat.name);
                            ready = true;
                        }
                }
            }
            else
                ready = false;
        }

        private void Prepare()
        {
            foreach (Material material in materials)
            {
                //material.EnableKeyword("_PREPAREFORGIBAKE_ON");
                material.SetFloat("_PrepareforGIbake", 1);
            }
        }

        private void Revert()
        {
            foreach (Material material in materials)
            {
                //material.DisableKeyword("_PREPAREFORGIBAKE_ON");
                material.SetFloat("_PrepareforGIbake", 0);

            }

            ready = false;
        }
    }
}
#endif