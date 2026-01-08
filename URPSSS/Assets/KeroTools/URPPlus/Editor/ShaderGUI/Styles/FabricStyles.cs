using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.Styles
{
    public static class FabricStyles
    {
        public static readonly GUIContent EnableTranslucency =
            EditorGUIUtility.TrTextContent("Enable Translucency",
                "When enabled, the Material turns on translucency.");

        public static readonly GUIContent FuzzMap =
            EditorGUIUtility.TrTextContent("Fuzz Map",
                "Assign a Texture that adds fuzz detail to the Base Color of your Material.");

        public static readonly GUIContent FuzzScale =
            EditorGUIUtility.TrTextContent("Fuzz Scale",
                "Sets the scale of the Thread UV used to sample the Fuzz Map.");

        public static readonly GUIContent FuzzIntensity =
            EditorGUIUtility.TrTextContent("Fuzz Intensity",
                "Sets the strength of the Fuzz Color added to the Base Color.");

        public static readonly GUIContent ThreadMap =
            EditorGUIUtility.TrTextContent("Thread Map",
                "Assign a Texture that defines parameters for fabric thread, with the following maps in its RGBA channels.");

        public static readonly GUIContent ThreadAOScale =
            EditorGUIUtility.TrTextContent("Thread AO Scale",
                "Modifies the strength of the AO stored in the Thread Map.");

        public static readonly GUIContent ThreadNormalScale =
            EditorGUIUtility.TrTextContent("Thread Normal Scale",
                "Modifies the strength of the Normal stored in the Thread Map.");

        public static readonly GUIContent ThreadSmoothnessScale =
            EditorGUIUtility.TrTextContent("Thread Smoothness Scale",
                "Modifies the scale of the Smoothness stored in the Thread Map.");
    }
}