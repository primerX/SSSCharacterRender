using UnityEngine;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;
using static Unity.Rendering.Universal.ShaderUtils;
using UnityEditor;

namespace SSS_URP
{

    internal class SSS_MaterialEditor : ShaderGUI
    {
        Material material;

        #region Tabs

        private bool DebugTab
        {
            get { return EditorPrefs.GetBool("DebugTab" + material.name, false); }
            set { EditorPrefs.SetBool("DebugTab" + material.name, value); }
        }

        private bool CoordsTab
        {
            get { return EditorPrefs.GetBool("CoordsTab" + material.name, false); }
            set { EditorPrefs.SetBool("CoordsTab" + material.name, value); }
        }

        private bool LightingTab
        {
            get { return EditorPrefs.GetBool("LightingTab" + material.name, false); }
            set { EditorPrefs.SetBool("LightingTab" + material.name, value); }
        }


        private bool AlbedoTab
        {
            get { return EditorPrefs.GetBool("AlbedoTab" + material.name, false); }
            set { EditorPrefs.SetBool("AlbedoTab" + material.name, value); }
        }

        private bool TranslucencyTab
        {
            get { return EditorPrefs.GetBool("TranslucencyTab" + material.name, false); }
            set { EditorPrefs.SetBool("TranslucencyTab" + material.name, value); }
        }

        private bool AOTab
        {
            get { return EditorPrefs.GetBool("AOTab" + material.name, false); }
            set { EditorPrefs.SetBool("AOTab" + material.name, value); }
        }

        private bool SpecularTab
        {
            get { return EditorPrefs.GetBool("SpecularTab" + material.name, false); }
            set { EditorPrefs.SetBool("SpecularTab" + material.name, value); }
        }

        private bool BumpTab
        {
            get { return EditorPrefs.GetBool("BumpTab" + material.name, false); }
            set { EditorPrefs.SetBool("BumpTab" + material.name, value); }
        }

        private bool ProfileTab
        {
            get { return EditorPrefs.GetBool("ProfileTab" + material.name, false); }
            set { EditorPrefs.SetBool("ProfileTab" + material.name, value); }
        }

        private bool SettingsTab
        {
            get { return EditorPrefs.GetBool("SettingsTab" + material.name, false); }
            set { EditorPrefs.SetBool("SettingsTab" + material.name, value); }
        }

        #endregion

        #region ShaderProperties
        MaterialProperty _Debug = null;
        MaterialProperty _DebugMode = null;
        MaterialProperty _StencilValue = null;
        MaterialProperty _Color = null;
        MaterialProperty _GI = null;
        MaterialProperty _DiffuseRoughness = null;
        MaterialProperty _Diffuseboost = null;
        MaterialProperty _PrepareforGIbake = null;
        MaterialProperty _BaseMap = null;
        MaterialProperty _AlbedoInfluence = null;
        MaterialProperty _EnableSubsurface = null;
        MaterialProperty _Subsurface = null;
        MaterialProperty _SubsurfaceMap = null;
        MaterialProperty _ProfileColor = null;
        MaterialProperty _Blur = null;
        MaterialProperty _ProfileMap = null;
        MaterialProperty _Transmission = null;
        //MaterialProperty _TranslucencyDistanceFade = null;
        MaterialProperty _TransmissionColor = null;
        MaterialProperty _TransmissionMap = null;
        MaterialProperty _TransmissionTintMap = null;
        MaterialProperty _LightClamp = null;
        MaterialProperty _EnableTransmissionGradient = null;
        MaterialProperty _TransmissionGradient = null;
        MaterialProperty _GradientMin = null;
        MaterialProperty _GradientMax = null;
        MaterialProperty _Transmission_intensity = null;
        MaterialProperty _Travel_Distance = null;
        MaterialProperty _TravelDistancePointLights = null;
        MaterialProperty _TravelDistanceMult = null;
        MaterialProperty _Transmission_Bias = null;
        MaterialProperty _MaskWithNormals = null;
        MaterialProperty _CancelMin = null;
        MaterialProperty _CancelMax = null;
        //MaterialProperty _tsm_min = null;
        //MaterialProperty _tsm_max = null;
        MaterialProperty _OcclusionMap = null;
        MaterialProperty _OcclusionColor = null;
        MaterialProperty _Occlusionlightpass = null;
        MaterialProperty _Occlusionfinalpass = null;
        MaterialProperty _SpecularOcclusion = null;
        MaterialProperty _FresnelIntensity = null;
        MaterialProperty _SpecColor = null;
        MaterialProperty _EnvironmentReflectionsIntensity = null;
        MaterialProperty _SpecularHighlightIntensity = null;
        MaterialProperty _SpecGlossMap = null;
        //MaterialProperty _FresnelIntensity = null;
        MaterialProperty _Smoothness = null;
        MaterialProperty _SmoothnessMult = null;
        //MaterialProperty _CavityMap = null;
        MaterialProperty _CavityStrength = null;
        MaterialProperty _Cavity = null;
        MaterialProperty _BumpMap = null;
        MaterialProperty _NormalIntensity = null;
        MaterialProperty _DetailNormalMapTile = null;
        MaterialProperty _DetailNormalMap = null;
        MaterialProperty _EnableDetailNormal = null;
        MaterialProperty _DetailNormalIntensity = null;
        MaterialProperty _Depth = null;
        //MaterialProperty _Depth_Center = null;
        //MaterialProperty _ParallaxMap = null;
        MaterialProperty _EnableParallax = null;
        MaterialProperty _EyeDilation = null;
        MaterialProperty _Dilation = null;
        MaterialProperty _DilationMaskRadius = null;
        //MaterialProperty _DilationMaskHardness = null;
        //MaterialProperty _ScaleMask = null;
        MaterialProperty _ScleraRing = null;
        MaterialProperty _ScleraRingMap = null;
        MaterialProperty _IrisShadow = null;
        //MaterialProperty _IrisShadowMap = null;
        MaterialProperty _IrisShadowDistance = null;
        MaterialProperty _IrisSelfShadowCircleRadius = null;
        MaterialProperty _IrisSelfShadowCircleHardness = null;
        //MaterialProperty _Shadowsmin = null;
        //MaterialProperty _Shadowsmax = null;
        MaterialProperty _IrisShadowOpacity = null;
        //MaterialProperty _IrisMicroShadows = null;
        //MaterialProperty _IrisDetailShadowMap = null;
        //MaterialProperty _MicroShadowsDistance = null;
        //MaterialProperty _MicroShadowsOpacity = null;
        MaterialProperty _CorneaDepth = null;
        MaterialProperty _CorneaTurbidity = null;
        MaterialProperty _CorneaSizeMin = null;
        MaterialProperty _CorneaSizeMax = null;
        MaterialProperty _CorneaOpacity = null;
        MaterialProperty _CorneaMaskMax = null;
        MaterialProperty _CorneaMaskMin = null;
        MaterialProperty _WorkflowMode = null;
        MaterialProperty _Overlay = null;
        MaterialProperty _OverlayAlbedo = null;
        MaterialProperty _OverlaySpecular = null;
        MaterialProperty _OverlaySmoothness = null;
        MaterialProperty _OverlaySpecularColor = null;
        MaterialProperty _ScaleUV = null;
        MaterialProperty _EnableUVScale = null;
        MaterialProperty _Tiling = null;
        #endregion

        MaterialEditor m_MaterialEditor;
        bool m_FirstTimeApply = true;

        private HeaderBool m_IrisShadowsFoldout;
        private HeaderBool m_IrisMicroShadowsFoldout;
        private HeaderBool m_TurbidityFoldout;

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

        public string[] WorkFlow = new string[]
        {
            "Standard",
            "Eye"
        };

        public void FindProperties(MaterialProperty[] properties)
        {
            m_IrisShadowsFoldout = new HeaderBool($"SSS.m_IrisShadowsFoldout", false);
            m_IrisMicroShadowsFoldout = new HeaderBool($"SSS.m_IrisMicroShadowsFoldout", false);
            m_TurbidityFoldout = new HeaderBool($"SSS.m_TurbidityFoldout", false);

            #region ShaderProperties

            _Debug = FindProperty("_Debug", properties);
            _DebugMode = FindProperty("_SSS_DebugMode", properties);
            _WorkflowMode = FindProperty("_SSS_WorkflowMode", properties);
            _Overlay = FindProperty("_Overlay", properties);
            _OverlayAlbedo = FindProperty("_OverlayAlbedo", properties);
            _OverlaySpecular = FindProperty("_OverlaySpecular", properties);
            _OverlaySpecularColor = FindProperty("_OverlaySpecularColor", properties);
            _OverlaySmoothness = FindProperty("_OverlaySmoothness", properties);
            _StencilValue = FindProperty("_StencilValue", properties);
            _Color = FindProperty("_Color", properties);
            _GI = FindProperty("_GI", properties);
            _DiffuseRoughness = FindProperty("_DiffuseRoughness", properties);
            _Diffuseboost = FindProperty("_Diffuseboost", properties);
            _PrepareforGIbake = FindProperty("_PrepareforGIbake", properties);
            _Blur = FindProperty("_Blur", properties);
            _BaseMap = FindProperty("_BaseMap", properties);
            _EnableSubsurface = FindProperty("_EnableSubsurface", properties);
            _SubsurfaceMap = FindProperty("_SubsurfaceMap", properties);
            _AlbedoInfluence = FindProperty("_AlbedoInfluence", properties);

            _Subsurface = FindProperty("_Subsurface", properties);
            //_SubsurfaceMap = FindProperty("_SubsurfaceMap", properties);
            _ProfileColor = FindProperty("_ProfileColor", properties);
            _ProfileMap = FindProperty("_ProfileMap", properties);
            _Transmission = FindProperty("_Transmission", properties);
            //_TranslucencyDistanceFade = FindProperty("_TranslucencyDistanceFade", properties);
            _TransmissionColor = FindProperty("_TransmissionColor", properties);
            _TransmissionMap = FindProperty("_TransmissionMap", properties);
            _TransmissionTintMap = FindProperty("_TransmissionTintMap", properties);
            _LightClamp = FindProperty("_LightClamp", properties);
            _EnableTransmissionGradient = FindProperty("_EnableTransmissionGradient", properties);
            _GradientMin = FindProperty("_GradientMin", properties);
            _GradientMax = FindProperty("_GradientMax", properties);

            _TransmissionGradient = FindProperty("_TransmissionGradient", properties);
            _Transmission_intensity = FindProperty("_Transmission_intensity", properties);
            _Travel_Distance = FindProperty("_Travel_Distance", properties);
            _TravelDistancePointLights = FindProperty("_TravelDistancePointLights", properties);
            _TravelDistanceMult = FindProperty("_TravelDistanceMult", properties);
            _Transmission_Bias = FindProperty("_Transmission_Bias", properties);
            _MaskWithNormals = FindProperty("_MaskWithNormals", properties);
            _CancelMin = FindProperty("_CancelMin", properties);
            _CancelMax = FindProperty("_CancelMax", properties);
            //_tsm_min = FindProperty("_tsm_min", properties);
            //_tsm_max = FindProperty("_tsm_max", properties);
            _OcclusionMap = FindProperty("_OcclusionMap", properties);
            _OcclusionColor = FindProperty("_OcclusionColor", properties);
            _Occlusionlightpass = FindProperty("_Occlusionlightpass", properties);
            _Occlusionfinalpass = FindProperty("_Occlusionfinalpass", properties);
            _SpecularOcclusion = FindProperty("_SpecularOcclusion", properties);
            _FresnelIntensity = FindProperty("_FresnelIntensity", properties);
            _SpecColor = FindProperty("_SpecColor", properties);
            _EnvironmentReflectionsIntensity = FindProperty("_EnvironmentReflectionsIntensity", properties);
            _SpecularHighlightIntensity = FindProperty("_SpecularHighlightIntensity", properties);
            _SpecGlossMap = FindProperty("_SpecGlossMap", properties);
            _Smoothness = FindProperty("_Smoothness", properties);
            _SmoothnessMult = FindProperty("_SmoothnessMult", properties);
            //_CavityMap = FindProperty("_CavityMap", properties);
            _CavityStrength = FindProperty("_CavityStrength", properties);
            _Cavity = FindProperty("_Cavity", properties);
            _BumpMap = FindProperty("_BumpMap", properties);
            _NormalIntensity = FindProperty("_NormalIntensity", properties);
            _DetailNormalIntensity = FindProperty("_DetailNormalIntensity", properties);
            _EnableDetailNormal = FindProperty("_EnableDetailNormal", properties);
            _DetailNormalMap = FindProperty("_DetailNormalMap", properties);
            _DetailNormalMapTile = FindProperty("_DetailNormalMapTile", properties);
            _Depth = FindProperty("_Depth", properties);
            //_Depth_Center = FindProperty("_Depth_Center", properties);
            //_ParallaxMap = FindProperty("_ParallaxMap", properties);
            _EnableParallax = FindProperty("_EnableParallax", properties);
            _EyeDilation = FindProperty("_EyeDilation", properties);
            _Dilation = FindProperty("_Dilation", properties);
            _DilationMaskRadius = FindProperty("_DilationMaskRadius", properties);
            //_DilationMaskHardness = FindProperty("_DilationMaskHardness", properties);

            _ScleraRing = FindProperty("_ScleraRing", properties);
            _ScleraRingMap = FindProperty("_ScleraRingMap", properties);
            _IrisShadow = FindProperty("_IrisShadow", properties);

            // _ScaleMask = FindProperty("_ScaleMask", properties);
            //_IrisDetailShadowMap = FindProperty("_IrisDetailShadowMap", properties);

            //_MicroShadowsDistance = FindProperty("_MicroShadowsDistance", properties);
            //_MicroShadowsOpacity = FindProperty("_MicroShadowsOpacity", properties);
            //_IrisShadowMap = FindProperty("_IrisShadowMap", properties);

            _IrisShadowOpacity = FindProperty("_IrisShadowOpacity", properties);
            _IrisShadowDistance = FindProperty("_IrisShadowDistance", properties);
            _IrisSelfShadowCircleRadius = FindProperty("_IrisSelfShadowCircleRadius", properties);
            _IrisSelfShadowCircleHardness = FindProperty("_IrisSelfShadowCircleHardness", properties);
            //_Shadowsmax = FindProperty("_Shadowsmax", properties);
            //_Shadowsmin = FindProperty("_Shadowsmin", properties);
            //_IrisMicroShadows = FindProperty("_IrisMicroShadows", properties);

            _CorneaDepth = FindProperty("_CorneaDepth", properties);
            _CorneaTurbidity = FindProperty("_CorneaTurbidity", properties);
            _CorneaSizeMin = FindProperty("_CorneaSizeMin", properties);
            _CorneaSizeMax = FindProperty("_CorneaSizeMax", properties);
            _CorneaOpacity = FindProperty("_CorneaOpacity", properties);
            _CorneaMaskMax = FindProperty("_CorneaMaskMax", properties);
            _CorneaMaskMin = FindProperty("_CorneaMaskMin", properties);
            _EnableUVScale = FindProperty("_EnableUVScale", properties);
            _ScaleUV = FindProperty("_ScaleUV", properties);
            _Tiling = FindProperty("_Tiling", properties);
            #endregion
        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {

            FindProperties(properties); // MaterialProperties can be animated so we do not cache them but fetch them every event to ensure animated values are updated correctly

            m_MaterialEditor = materialEditor;
            material = materialEditor.target as Material;
            //Turn off default ones and do my own.
            /*material.EnableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
            material.EnableKeyword("_SPECULARHIGHLIGHTS_OFF");
            material.SetFloat("_SpecularHighlights", 0);
            material.SetFloat("_EnvironmentReflections", 0);
           */
            if (m_FirstTimeApply)
            {
                m_FirstTimeApply = false;

                Renderer[] rend = GameObject.FindObjectsOfType(typeof(Renderer)) as Renderer[];
                foreach (Renderer renderer in rend)
                {

                    if (renderer.sharedMaterial == material)
                    {
                        //Debug.Log("Found match: " + renderer.gameObject.name);
                        //check if it has the script
                        if (!renderer.gameObject.TryGetComponent(typeof(SSS_Object), out Component component))
                        {
                            //Debug.Log("Doesn't have SSS_Object");
                            //Debug.Log("Adding SSS_Object");
                            renderer.gameObject.AddComponent<SSS_Object>();
                            UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene());
                        }
                        else
                        {
                            //Debug.Log("SSS_Object present");
                        }
                    }
                }



            }
            EditorGUI.BeginChangeCheck();



            #region Settings
            if (GUILayout.Button("Settings", EditorStyles.toolbarButton))
                SettingsTab = !SettingsTab;

            if (SettingsTab)
            {

                GUILayout.BeginVertical("box");

                _WorkflowMode.floatValue = EditorGUILayout.Popup(new GUIContent("Workflow Mode", "Affects interface only"), (int)_WorkflowMode.floatValue, WorkFlow);


                m_MaterialEditor.ShaderProperty(_Overlay, "Enable Overlay");
                m_MaterialEditor.ShaderProperty(_Debug, "Enter debug mode");

                if (_Debug.floatValue == 1)
                    m_MaterialEditor.ShaderProperty(_DebugMode, "Debug Mode");

                m_MaterialEditor.ShaderProperty(_StencilValue, new GUIContent("Stencil Value", "Used to mask occlusion mesh. Use 2 for eyes and 1 for skin"));

                GUILayout.EndVertical();
            }
            #endregion

            GUILayout.Space(10);

            #region Coords

            if (GUILayout.Button("Coords", EditorStyles.toolbarButton))
                CoordsTab = !CoordsTab;

            if (CoordsTab)
            {
                GUILayout.BeginVertical("box");

                m_MaterialEditor.ShaderProperty(_Tiling, _Tiling.displayName);
                m_MaterialEditor.ShaderProperty(_EnableParallax, "Parallax");

                EditorGUI.indentLevel++;

                if (_EnableParallax.floatValue == 1)
                {
                    //m_MaterialEditor.TexturePropertySingleLine(new GUIContent(_ParallaxMap.displayName, ""), _ParallaxMap);
                    m_MaterialEditor.ShaderProperty(_Depth, "� Depth");
                    //m_MaterialEditor.ShaderProperty(_Depth_Center, "DepthCenter");
                }
                EditorGUI.indentLevel--;

                GUILayout.Space(5);
                if (_WorkflowMode.floatValue == 1)
                {
                    m_MaterialEditor.ShaderProperty(_EyeDilation, "Pupil dilation");
                    EditorGUI.indentLevel++;

                    if (_EyeDilation.floatValue == 1)
                    {
                        //if(_ScaleMask != null)
                        //m_MaterialEditor.TexturePropertySingleLine(new GUIContent(_ScaleMask.displayName, ""), _ScaleMask);
                        m_MaterialEditor.ShaderProperty(_Dilation, "� Dilation");
                        m_MaterialEditor.ShaderProperty(_DilationMaskRadius, "� Mask Radius");
                        //m_MaterialEditor.ShaderProperty(_DilationMaskHardness, "Mask Hardness");
                    }
                    EditorGUI.indentLevel--;
                    GUILayout.Space(5);


                    m_MaterialEditor.ShaderProperty(_EnableUVScale, "Scale UVs");
                    EditorGUI.indentLevel++;

                    if (_EnableUVScale.floatValue == 1)
                        m_MaterialEditor.ShaderProperty(_ScaleUV, "� Scale");
                    EditorGUI.indentLevel--;

                }
                GUILayout.EndVertical();
            }
            #endregion

            GUILayout.Space(10);

            #region Lighting
            if (GUILayout.Button("Lighting", EditorStyles.toolbarButton))
                LightingTab = !LightingTab;

            if (LightingTab)
            {
                GUILayout.BeginVertical("box");
                m_MaterialEditor.ShaderProperty(_GI, new GUIContent(_GI.displayName, "GI Intensity"));
                m_MaterialEditor.ShaderProperty(_DiffuseRoughness, new GUIContent(_DiffuseRoughness.displayName, "Rough diffuse"));
                m_MaterialEditor.ShaderProperty(_LightClamp, new GUIContent(_LightClamp.displayName, "Limit the maximum light intensity"));
                m_MaterialEditor.ShaderProperty(_Diffuseboost, new GUIContent(_Diffuseboost.displayName, "Dynamic lights intensity"));
                m_MaterialEditor.ShaderProperty(_PrepareforGIbake, new GUIContent(_PrepareforGIbake.displayName,
                    "Enable before baking lighting to make Albedo influence GI. Use the tool to do this automatically (Tools/Prepare SSS objects for GI)\nThis is because diffuse comes from a postprocess effect and base color is simply 0, so the lightbaker doesn't have any color information"));

                EditorGUI.indentLevel++;

                if (_WorkflowMode.floatValue == 1)
                {
                    m_IrisShadowsFoldout.SetValue(EditorGUILayout.Foldout(m_IrisShadowsFoldout.value, EditorGUIUtility.TrTextContent("Iris Shadows", "Works only for the Directional light (WIP)")));

                    if (m_IrisShadowsFoldout.value)
                    {
                        //EditorGUI.indentLevel++;

                        m_MaterialEditor.ShaderProperty(_IrisShadow, "Enable");

                        if (_IrisShadow.floatValue == 1)
                        {

                            // m_MaterialEditor.TexturePropertySingleLine(EditorGUIUtility.TrTextContent("Map", ""), _IrisShadowMap);
                            m_MaterialEditor.ShaderProperty(_IrisShadowDistance, "Distance");
                            m_MaterialEditor.ShaderProperty(_IrisSelfShadowCircleRadius, "Mask Radius");
                            m_MaterialEditor.ShaderProperty(_IrisSelfShadowCircleHardness, "Mask Hardness");
                            //m_MaterialEditor.ShaderProperty(_Shadowsmin, _Shadowsmin.displayName);
                            //m_MaterialEditor.ShaderProperty(_Shadowsmax, _Shadowsmax.displayName);
                            m_MaterialEditor.ShaderProperty(_IrisShadowOpacity, "Opacity");


                        }
                        //EditorGUI.indentLevel--;


                    }



                    /*m_IrisMicroShadowsFoldout.SetValue(EditorGUILayout.Foldout(m_IrisMicroShadowsFoldout.value, EditorGUIUtility.TrTextContent("Iris Micro Shadows", "")));

                    if (m_IrisMicroShadowsFoldout.value && _IrisMicroShadows!=null)
                    {

                        //EditorGUI.indentLevel++;
                        m_MaterialEditor.ShaderProperty(_IrisMicroShadows, "Enable");

                        if (_IrisMicroShadows.floatValue == 1)
                        {
                            m_MaterialEditor.TexturePropertySingleLine(EditorGUIUtility.TrTextContent("Map", ""), _IrisDetailShadowMap);

                            m_MaterialEditor.ShaderProperty(_MicroShadowsDistance, "Distance");
                            m_MaterialEditor.ShaderProperty(_MicroShadowsOpacity, "Opacity");
                        }
                        //EditorGUI.indentLevel--;
                    }*/
                }
                EditorGUI.indentLevel--;

                GUILayout.EndVertical();



            }
            #endregion

            GUILayout.Space(10);

            #region Albedo
            if (GUILayout.Button("Albedo", EditorStyles.toolbarButton))
                AlbedoTab = !AlbedoTab;

            if (AlbedoTab)
            {
                GUILayout.BeginVertical("box");
                m_MaterialEditor.TexturePropertySingleLine(new GUIContent(_BaseMap.displayName, "Base texture"), _BaseMap, _Color);

                GUILayout.BeginVertical("box");
                {
                    m_MaterialEditor.ShaderProperty(_AlbedoInfluence, new GUIContent("Visibility", "Blends to white. Useful when mixing with Subsurface"));

                    m_MaterialEditor.ShaderProperty(_EnableSubsurface, "Subsurface");

                    EditorGUI.indentLevel++;
                    if (_EnableSubsurface.floatValue == 1)
                    {
                        m_MaterialEditor.TexturePropertySingleLine(EditorGUIUtility.TrTextContent(_SubsurfaceMap.displayName, "Will be sampled in the lighting stage thus affected by blur"), _SubsurfaceMap);
                        m_MaterialEditor.ShaderProperty(_Subsurface, new GUIContent("Visibility", "Blends to white. Useful when mixing with Subsurface"));
                    }
                    EditorGUI.indentLevel--;

                    if (_Overlay.floatValue == 1)
                    {

                        m_MaterialEditor.ShaderProperty(_OverlayAlbedo, "Overlay");

                    }

                    if (_WorkflowMode.floatValue == 1)
                    {
                        m_MaterialEditor.ShaderProperty(_ScleraRing, _ScleraRing.displayName);

                        if (_ScleraRing.floatValue == 1)
                        {
                            m_MaterialEditor.TexturePropertySingleLine(EditorGUIUtility.TrTextContent(_ScleraRingMap.displayName, ""), _ScleraRingMap);

                        }

                        EditorGUI.indentLevel++;

                        m_TurbidityFoldout.SetValue(EditorGUILayout.Foldout(m_TurbidityFoldout.value, EditorGUIUtility.TrTextContent("Cornea turbidity", "")));

                        if (m_TurbidityFoldout.value)
                        {
                            m_MaterialEditor.ShaderProperty(_CorneaTurbidity, "Enable");

                            if (_CorneaTurbidity.floatValue == 1)
                            {

                                m_MaterialEditor.ShaderProperty(_CorneaDepth, _CorneaDepth.displayName);
                                m_MaterialEditor.ShaderProperty(_CorneaSizeMin, _CorneaSizeMin.displayName);
                                m_MaterialEditor.ShaderProperty(_CorneaSizeMax, _CorneaSizeMax.displayName);
                                m_MaterialEditor.ShaderProperty(_CorneaOpacity, _CorneaOpacity.displayName);
                                m_MaterialEditor.ShaderProperty(_CorneaMaskMin, _CorneaMaskMin.displayName);
                                m_MaterialEditor.ShaderProperty(_CorneaMaskMax, _CorneaMaskMax.displayName);

                            }
                            EditorGUI.indentLevel--;
                        }
                    }

                }
                GUILayout.EndVertical();

                GUILayout.EndVertical();
            }
            #endregion

            GUILayout.Space(10);

            #region Profile

            if (GUILayout.Button("Profile", EditorStyles.toolbarButton))
                ProfileTab = !ProfileTab;

            if (ProfileTab)
            {

                GUILayout.BeginVertical("box");
                m_MaterialEditor.TexturePropertySingleLine(new GUIContent(_ProfileMap.displayName, "Blur color texture. \nRGB: color\nA: radius"), _ProfileMap, _ProfileColor);

                m_MaterialEditor.ShaderProperty(_Blur, new GUIContent(_Blur
                    .displayName, "Blur radius"));

                GUILayout.EndVertical();
            }

            #endregion

            GUILayout.Space(10);

            #region Transmission

            if (GUILayout.Button("Transmission", EditorStyles.toolbarButton))
                TranslucencyTab = !TranslucencyTab;

            if (TranslucencyTab)
            {
                GUILayout.BeginVertical("box");

                m_MaterialEditor.ShaderProperty(_Transmission, "Enable");

                if (_Transmission.floatValue == 1)
                {
                    //m_MaterialEditor.TexturePropertySingleLine(new GUIContent("Map",
                       // ""), _TransmissionMap, _TransmissionColor);
                    m_MaterialEditor.ShaderProperty(_TransmissionMap, "Thickness");
                    //m_MaterialEditor.ShaderProperty(_TransmissionColor, "Color");
                    
                        m_MaterialEditor.TexturePropertySingleLine(new GUIContent("Tint",
                     ""), _TransmissionTintMap, _TransmissionColor);
                    m_MaterialEditor.ShaderProperty(_EnableTransmissionGradient, new GUIContent("Enable Gradient Map", "(wip - experimental)"));

                    EditorGUI.indentLevel++;
                    if (_EnableTransmissionGradient.floatValue == 1)
                    {
                        m_MaterialEditor.ShaderProperty(_TransmissionGradient, new GUIContent("Gradient Map", ""));
                        m_MaterialEditor.ShaderProperty(_GradientMin, new GUIContent("Gradient Min", ""));
                        m_MaterialEditor.ShaderProperty(_GradientMax, new GUIContent("Gradient Max", ""));
                    }
                    EditorGUI.indentLevel--;

                    m_MaterialEditor.ShaderProperty(_Transmission_intensity, new GUIContent("Intensity", ""));

                    GUILayout.Label("Travel Distance");
                    EditorGUI.indentLevel++;
                    {
                        GUILayout.BeginVertical("box");
                        {
                            m_MaterialEditor.ShaderProperty(_Travel_Distance, new GUIContent("Directional", "For directional light"));
                            m_MaterialEditor.ShaderProperty(_TravelDistancePointLights, new GUIContent("Point and Spot", "For point and spot lights"));


                            EditorGUI.indentLevel++;
                            {
                                m_MaterialEditor.ShaderProperty(_TravelDistanceMult, new GUIContent(_TravelDistanceMult.displayName, "Multiply slider value"));
                            }
                            EditorGUI.indentLevel--;
                        }
                        GUILayout.EndVertical();
                    }
                    EditorGUI.indentLevel--;

                    m_MaterialEditor.ShaderProperty(_Transmission_Bias, new GUIContent("Bias", "Adds a constant value to the given map"));

                    //m_MaterialEditor.ShaderProperty(_TranslucencyDistanceFade, new GUIContent("Max Distance", "Fades the effect at a given distance"));

                    //m_MaterialEditor.ShaderProperty(_tsm_min, new GUIContent("Remap min", "Remap translucent shadow"));
                    //m_MaterialEditor.ShaderProperty(_tsm_max, new GUIContent("Remap max", "Remap translucent shadow"));

                    m_MaterialEditor.ShaderProperty(_MaskWithNormals, new GUIContent(_MaskWithNormals.displayName, "Use an inverted Lambert to cancel/mask the effect"));

                    if (_MaskWithNormals.floatValue == 1)
                    {
                        m_MaterialEditor.ShaderProperty(_CancelMin, new GUIContent("Remap min", "Remap NdotL"));

                        m_MaterialEditor.ShaderProperty(_CancelMax, new GUIContent("Remap max", "Remap NdotL"));
                    }



                }

                GUILayout.EndVertical();

            }
            #endregion

            GUILayout.Space(10);

            #region AO

            if (GUILayout.Button("Occlusion", EditorStyles.toolbarButton))
                AOTab = !AOTab;

            if (AOTab)
            {
                GUILayout.BeginVertical("box");

                m_MaterialEditor.TexturePropertySingleLine(new GUIContent("Map", "R: Affects diffuse\nG: For specular Occlusion\nB: Cavity"), _OcclusionMap, _OcclusionColor);
                //m_MaterialEditor.ShaderProperty(_OcclusionColor, new GUIContent("Color", ""));
                m_MaterialEditor.ShaderProperty(_Occlusionlightpass, new GUIContent("Occlusion (light pass)", "Affects diffuse light pass"));
                m_MaterialEditor.ShaderProperty(_Occlusionfinalpass, new GUIContent("Occlusion (final pass)", "Affects composition pass"));
                m_MaterialEditor.ShaderProperty(_SpecularOcclusion, new GUIContent("Specular Occlusion", "Affects specular. Channel G"));



                GUILayout.EndVertical();


            }

            #endregion

            GUILayout.Space(10);


            #region Specular

            if (GUILayout.Button("Specular", EditorStyles.toolbarButton))
                SpecularTab = !SpecularTab;

            if (SpecularTab)
            {
                GUILayout.BeginVertical("box");
                GUILayout.BeginHorizontal();


                m_MaterialEditor.TexturePropertySingleLine(
                    new GUIContent("Map", "RGB: specular color\nA: smoothness"), _SpecGlossMap, _SpecColor);

                GUILayout.EndHorizontal();

                m_MaterialEditor.ShaderProperty(_Smoothness, new GUIContent("Smoothness", ""));
                
                EditorGUI.indentLevel++;
                {
                    m_MaterialEditor.ShaderProperty(_SmoothnessMult, new GUIContent(_SmoothnessMult.displayName, ""));
                }
                EditorGUI.indentLevel--;

                if (_Overlay.floatValue == 1)
                {
                    GUILayout.Label("Overlay");
                    GUILayout.BeginVertical("box");

                    EditorGUI.indentLevel++;
                    m_MaterialEditor.TexturePropertySingleLine(
                    new GUIContent("Map", "RGB: specular color\nA: smoothness"), _OverlaySpecular, _OverlaySpecularColor);


                    //m_MaterialEditor.ShaderProperty(_OverlaySpecular, new GUIContent("Overlay", ""));
                    //m_MaterialEditor.ShaderProperty(_OverlaySpecularColor, new GUIContent("Specular Color", ""));
                    m_MaterialEditor.ShaderProperty(_OverlaySmoothness, new GUIContent("Smoothness", ""));
                    EditorGUI.indentLevel--;
                    GUILayout.EndVertical();

                }

                m_MaterialEditor.ShaderProperty(_Cavity, new GUIContent("Enable Cavity", ""));

                if (_Cavity.floatValue == 1)
                {
                    //m_MaterialEditor.TexturePropertySingleLine(EditorGUIUtility.TrTextContent(_CavityMap.displayName, "Affects fresnel"), _CavityMap);
                    m_MaterialEditor.ShaderProperty(_CavityStrength, new GUIContent("Cavity strength", "Affects fresnel"));
                }
                m_MaterialEditor.ShaderProperty(_FresnelIntensity, new GUIContent("Fresnel", ""));
                m_MaterialEditor.ShaderProperty(_EnvironmentReflectionsIntensity,
                    new GUIContent("Reflections intensity", ""));
                m_MaterialEditor.ShaderProperty(_SpecularHighlightIntensity,
                   new GUIContent("Highlight intensity", ""));


                GUILayout.EndVertical();
            }

            #endregion

            GUILayout.Space(10);


            #region Bump

            if (GUILayout.Button("Normal", EditorStyles.toolbarButton))
                BumpTab = !BumpTab;

            if (BumpTab)
            {
                GUILayout.BeginVertical("box");

                m_MaterialEditor.TexturePropertySingleLine(new GUIContent(_BumpMap.displayName, ""), _BumpMap, _NormalIntensity);

                m_MaterialEditor.ShaderProperty(_EnableDetailNormal, _EnableDetailNormal.displayName);

                if (_EnableDetailNormal.floatValue == 1)
                {
                    //GUILayout.BeginVertical("box");
                    GUILayout.BeginHorizontal();
                    m_MaterialEditor.TexturePropertySingleLine(new GUIContent(_DetailNormalMap.displayName, ""), _DetailNormalMap);
                    GUILayout.EndHorizontal();

                    m_MaterialEditor.ShaderProperty(_DetailNormalMapTile, _DetailNormalMapTile.displayName);
                    m_MaterialEditor.ShaderProperty(_DetailNormalIntensity, _DetailNormalIntensity.displayName);

                    //GUILayout.EndVertical();
                }
                GUILayout.EndVertical();
            }
            #endregion          

        }

    }
}