using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace SSS_Demo
{
    public class MSAA : MonoBehaviour
    {
        public UniversalRenderPipelineAsset _RenderPipelineAsset;

        // Start is called before the first frame update
        void Start()
        {

        }

        public void ToggleMSAA(bool value)
        {
            if (value)
                _RenderPipelineAsset.msaaSampleCount = 8;
            else
                _RenderPipelineAsset.msaaSampleCount = 0;
        }
        // Update is called once per frame
        void Update()
        {

        }
    }
}