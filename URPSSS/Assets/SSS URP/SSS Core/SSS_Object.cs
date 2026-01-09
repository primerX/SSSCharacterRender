//I don't like doing this but that's the price for not using the Unlit template (Keywords HELL)
//This is required because it is the only way to deactivate specular in the light pass

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SSS_URP
{
    [ExecuteAlways]
    public class SSS_Object : MonoBehaviour
    {
        Material SSS_mat;
        // Start is called before the first frame update
        void OnEnable()
        {
            SSS_mat = GetComponent<Renderer>().sharedMaterial;
            if (SSS_mat == null)//this solved the build problem :)
                SSS_mat = GetComponent<Renderer>().material;

            EnableSettings();
        }

        // Update is called once per frame
        void Update()
        {

            if (SSS_mat && SSS_mat.GetFloat("_SpecularHighlights") == 1)
            {
                EnableSettings();
            }

            //SSS_mat.EnableKeyword("_SPECULARHIGHLIGHTS_OFF");

        }

        public void DisableSettings()
        {
            if (SSS_mat != null)
            {

                SSS_mat.SetFloat("_DisableReflections", 1);
                SSS_mat.SetFloat("_GlossyEnvironmentColor", 1);

                SSS_mat.SetFloat("_SpecularHighlights", 1);
                SSS_mat.SetFloat("_EnvironmentReflections", 1);
                SSS_mat.DisableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
                SSS_mat.DisableKeyword("_SPECULARHIGHLIGHTS_OFF");
            }
        }

        public void EnableSettings()
        {
            if (SSS_mat != null)
            {

                SSS_mat.SetFloat("_GlossyEnvironmentColor", 0);

                SSS_mat.SetFloat("_SpecularHighlights", 0);
                SSS_mat.SetFloat("_EnvironmentReflections", 0);
                SSS_mat.EnableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
                SSS_mat.EnableKeyword("_SPECULARHIGHLIGHTS_OFF");
            }
        }

        private void OnDisable()
        {
            DisableSettings();
        }
    }

}