using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.Styles
{
    public static class EyeStyles
    {
        public static readonly GUIContent MeshScale =
            EditorGUIUtility.TrTextContent("Mesh Scale",
                "The Eye Shader expects a Mesh of size 1 in Object space. " +
                "If needed, set this parameter to compensate the mesh size. " +
                "This is independant of the scale on the Transform component.");

        public static readonly GUIContent IrisMap =
            EditorGUIUtility.TrTextContent("Iris Map",
                "Assign a Texture that controls color of the eye’s Iris." +
                "Assign a Texture that controls color of the eye’s Iris.");

        public static readonly GUIContent IrisMaskMap =
            EditorGUIUtility.TrTextContent("Iris Mask Map",
                "Assign a Texture that controls color of the eye’s Iris." +
                "Assign a Texture that controls color of the eye’s Iris.");

        public static readonly GUIContent IrisClampColor =
            EditorGUIUtility.TrTextContent("Iris Clamp Color",
                "Sets the color that will be used if the refraction ray reached the inside of the Cornea.");

        public static readonly GUIContent IrisNormalMap =
            EditorGUIUtility.TrTextContent("Iris NormalMap",
                "Assign a Texture that defines the normal map for the eye’s Iris.");

        public static readonly GUIContent IrisPositionOffset =
            EditorGUIUtility.TrTextContent("Iris Position Offset",
                "Sets the offset of the Iris placement, useful since real world eyes are never symmetrical and centered.");

        public static readonly GUIContent CorneaSmoothness =
            EditorGUIUtility.TrTextContent("Cornea Smoothness",
                "Sets the offset of the Iris placement, useful since real world eyes are never symmetrical and centered.");

        public static readonly GUIContent ScleraMap =
            EditorGUIUtility.TrTextContent("Sclera Map",
                "Assign a Texture that controls color of the Sclera.");

        public static readonly GUIContent ScleraSmoothness =
            EditorGUIUtility.TrTextContent("Sclera Smoothness",
                "Sets the smoothness of the Sclera.");

        public static readonly GUIContent ScleraNormalMap =
            EditorGUIUtility.TrTextContent("Sclera Normal Map",
                "Assign a Texture that defines the normal map for the Sclera.");

        public static readonly GUIContent LimbalRingSizeIris =
            EditorGUIUtility.TrTextContent("Limbal Ring Size Iris",
                "Sets the relative size of the Limbal Ring in the Iris.");

        public static readonly GUIContent LimbalRingSizeSclera =
            EditorGUIUtility.TrTextContent("Limbal Ring Size Sclera",
                "Sets the relative size of the Limbal Ring in the Sclera.");

        public static readonly GUIContent LimbalRingFade =
            EditorGUIUtility.TrTextContent("Limbal Ring Fade",
                "Sets the fade out strength of the Limbal Ring.");

        public static readonly GUIContent LimbalRingIntensity =
            EditorGUIUtility.TrTextContent("Limbal Ring Intensity",
                "Sets the darkness of the Limbal Ring.");

        public static readonly GUIContent PupilRadius =
            EditorGUIUtility.TrTextContent("Pupil Radius",
                "Sets the radius of the Pupil in the Iris Map as a percentage.");

        public static readonly GUIContent PupilAperture =
            EditorGUIUtility.TrTextContent("Pupil Aperture",
                "Sets the state of the pupil’s aperture, 0 being the smallest aperture (Min Pupil Aperture) and 1 the widest aperture (Max Pupil Aperture).");

        public static readonly GUIContent MinimalPupilAperture =
            EditorGUIUtility.TrTextContent("Minimal Pupil Aperture",
                "Sets the minimum pupil aperture value.");

        public static readonly GUIContent MaximalPupilAperture =
            EditorGUIUtility.TrTextContent("Maximal Pupil Aperture",
                "Sets the maximum pupil aperture value.");
    }
}