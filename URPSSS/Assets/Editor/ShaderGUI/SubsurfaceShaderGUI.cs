using UnityEditor;
using UnityEngine;

public class SubsurfaceShaderGUI : ShaderGUI
{
    // 折叠栏状态变量，用于记录菜单的展开/收起状态
    static bool showBase = true;
    static bool showDiffuse = true;
    static bool showNormal = true;
    static bool showTransmission = true;
    static bool showSpecular = true;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        // ---------------------------------------------------------
        // 1. 获取 Shader 属性
        // ---------------------------------------------------------
        
        // Base Settings
        MaterialProperty _BaseMap = FindProperty("_BaseMap", properties);
        MaterialProperty _BaseColor = FindProperty("_BaseColor", properties);
        MaterialProperty _SubsurfaceMap = FindProperty("_SubsurfaceMap", properties);
        MaterialProperty _Subsurface = FindProperty("_Subsurface", properties);

        // Diffuse Settings
        MaterialProperty _DiffuseRoughness = FindProperty("_DiffuseRoughness", properties);
        MaterialProperty _LightClamp = FindProperty("_LightClamp", properties);
        MaterialProperty _Diffuseboost = FindProperty("_Diffuseboost", properties);

        // Normal Settings
        MaterialProperty _BumpMap = FindProperty("_BumpMap", properties);
        MaterialProperty _NormalIntensity = FindProperty("_NormalIntensity", properties);

        // Transmission Settings
        MaterialProperty _TransmissionGradient = FindProperty("_TransmissionGradient", properties);
        MaterialProperty _GradientMin = FindProperty("_GradientMin", properties);
        MaterialProperty _GradientMax = FindProperty("_GradientMax", properties);
        MaterialProperty _Travel_Distance = FindProperty("_Travel_Distance", properties);
        MaterialProperty _TravelDistancePointLights = FindProperty("_TravelDistancePointLights", properties);
        MaterialProperty _TransmissionMap = FindProperty("_TransmissionMap", properties);
        MaterialProperty _Transmission_intensity = FindProperty("_Transmission_intensity", properties);
        // MaterialProperty _TravelDistanceMult = FindProperty("_TravelDistanceMult", properties);
        MaterialProperty _Transmission_Bias = FindProperty("_Transmission_Bias", properties);
        MaterialProperty _CancelMin = FindProperty("_CancelMin", properties);
        MaterialProperty _CancelMax = FindProperty("_CancelMax", properties);
        MaterialProperty _MaskWithNormals = FindProperty("_MaskWithNormals", properties);

        // Specular Settings
        MaterialProperty _SpecColor = FindProperty("_SpecColor", properties);
        MaterialProperty _Smoothness = FindProperty("_Smoothness", properties);
        // MaterialProperty _CavityStrength = FindProperty("_CavityStrength", properties);
        // MaterialProperty _FresnelIntensity = FindProperty("_FresnelIntensity", properties);
        MaterialProperty _SpecularHighlightIntensity = FindProperty("_SpecularHighlightIntensity", properties);

        // 开始检测属性变化
        EditorGUI.BeginChangeCheck();

        // ---------------------------------------------------------
        // 2. 绘制界面
        // ---------------------------------------------------------

        // === Base Settings ===
        showBase = EditorGUILayout.BeginFoldoutHeaderGroup(showBase, "Base Settings");
        if (showBase)
        {
            // 绘制 BaseMap 和 BaseColor 在同一行
            materialEditor.TexturePropertySingleLine(new GUIContent("Base Map", "Base Color Texture"), _BaseMap, _BaseColor);
            
            // 绘制 SubsurfaceMap 和 Subsurface 强度在同一行
            materialEditor.TexturePropertySingleLine(new GUIContent("Subsurface Map", "Subsurface Visibility Map"), _SubsurfaceMap, _Subsurface);
            
            // 如果需要调整 Tiling/Offset，可以取消注释下面这行，但原 Shader 标记了 [NoScaleOffset]
            // materialEditor.TextureScaleOffsetProperty(_BaseMap); 
            
            EditorGUILayout.Space();
        }
        EditorGUILayout.EndFoldoutHeaderGroup();

        // === Diffuse Settings ===
        showDiffuse = EditorGUILayout.BeginFoldoutHeaderGroup(showDiffuse, "Diffuse Settings");
        if (showDiffuse)
        {
            materialEditor.ShaderProperty(_DiffuseRoughness, "Diffuse Roughness");
            materialEditor.ShaderProperty(_LightClamp, "Light Clamp");
            materialEditor.ShaderProperty(_Diffuseboost, "Diffuse Boost");
            EditorGUILayout.Space();
        }
        EditorGUILayout.EndFoldoutHeaderGroup();

        // === Normal Settings ===
        showNormal = EditorGUILayout.BeginFoldoutHeaderGroup(showNormal, "Normal Settings");
        if (showNormal)
        {
            // 绘制法线贴图和强度
            materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map"), _BumpMap, _NormalIntensity);
            EditorGUILayout.Space();
        }
        EditorGUILayout.EndFoldoutHeaderGroup();

        // === Transmission Settings ===
        showTransmission = EditorGUILayout.BeginFoldoutHeaderGroup(showTransmission, "Transmission Settings");
        if (showTransmission)
        {
            // Transmission Map 和强度
            materialEditor.TexturePropertySingleLine(new GUIContent("Transmission Map"), _TransmissionMap);
            materialEditor.ShaderProperty(_Transmission_intensity, "Transmission Intensity");
            

            materialEditor.TexturePropertySingleLine(new GUIContent("Gradient"), _TransmissionGradient);
            
            // 缩进显示 Gradient 的 Min/Max
            EditorGUI.indentLevel++;
            materialEditor.ShaderProperty(_GradientMin, "Gradient Min");
            materialEditor.ShaderProperty(_GradientMax, "Gradient Max");
            EditorGUI.indentLevel--;
            
            EditorGUILayout.Space();
            
            // Travel Distance
            materialEditor.ShaderProperty(_Travel_Distance, "Travel Distance (Main)");
            materialEditor.ShaderProperty(_TravelDistancePointLights, "Travel Distance (Point)");
            // materialEditor.ShaderProperty(_TravelDistanceMult, new GUIContent(_TravelDistanceMult.displayName, "Multiply slider value"));
            
            EditorGUILayout.Space();
            
            
            // 其他参数
            materialEditor.ShaderProperty(_Transmission_Bias, "Transmission Bias");
            
            EditorGUILayout.Space();
            materialEditor.ShaderProperty(_MaskWithNormals, "Mask With Normals");
            materialEditor.ShaderProperty(_CancelMin, "Cancel Min");
            materialEditor.ShaderProperty(_CancelMax, "Cancel Max");
            
            
            EditorGUILayout.Space();
        }
        EditorGUILayout.EndFoldoutHeaderGroup();

        // === Specular Settings ===
        showSpecular = EditorGUILayout.BeginFoldoutHeaderGroup(showSpecular, "Specular Settings");
        if (showSpecular)
        {
            materialEditor.ColorProperty(_SpecColor, "Specular Color");
            materialEditor.ShaderProperty(_Smoothness, "Smoothness");
            // materialEditor.ShaderProperty(_CavityStrength, "Cavity Strength");
            // materialEditor.ShaderProperty(_FresnelIntensity, "Fresnel Intensity");
            materialEditor.ShaderProperty(_SpecularHighlightIntensity, "Highlight Intensity");
            EditorGUILayout.Space();
        }
        EditorGUILayout.EndFoldoutHeaderGroup();

        // ---------------------------------------------------------
        // 3. 底部通用设置 (渲染队列、Instancing 等)
        // ---------------------------------------------------------
        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Advanced Options", EditorStyles.boldLabel);
        
        materialEditor.RenderQueueField();
        materialEditor.EnableInstancingField();
        materialEditor.DoubleSidedGIField();
    }
}