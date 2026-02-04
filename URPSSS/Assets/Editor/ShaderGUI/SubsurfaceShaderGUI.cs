using UnityEngine;
using UnityEditor;

public class SubsurfaceShaderGUI : ShaderGUI
{
    // 折叠面板状态
    private bool showBasicSettings = true;
    private bool showNormalSettings = true;
    private bool showMaskSettings = true;
    private bool showWeatherSettings = true;
    private bool showSweatBeadSettings = true;
    private bool showOcclusionSettings = true;
    private bool showTransmissionSettings = true;
    private bool showSpecularSettings = true;

    // Material属性
    private MaterialProperty baseMap;
    private MaterialProperty color;
    private MaterialProperty subsurfaceMap;
    private MaterialProperty subsurface;
    private MaterialProperty diffuseRoughness;
    private MaterialProperty lightClamp;
    private MaterialProperty diffuseboost;

    // Normal
    private MaterialProperty bumpMap;
    private MaterialProperty normalIntensity;

    // Mask
    private MaterialProperty maskMap;
    private MaterialProperty redCheekMap;
    private MaterialProperty redCheekIntensity;

    // Weather
    private MaterialProperty rainDropNormal;
    private MaterialProperty wetness;
    private MaterialProperty rainMaskMap;
    private MaterialProperty rainTiling;
    private MaterialProperty rainNormalMap;
    private MaterialProperty rainNormalScale;
    private MaterialProperty rainDropSize;
    private MaterialProperty rainAnimationSpeed;
    private MaterialProperty rainDistortionMap;
    private MaterialProperty rainDistortionScale;
    private MaterialProperty rainDistortionSize;

    // Sweat Bead
    private MaterialProperty rainDropProcedure;
    private MaterialProperty uvGridSize;
    private MaterialProperty rainAmount;
    private MaterialProperty dynamicRainDropSpeed;
    private MaterialProperty dynamiceLayer1Tiling;
    private MaterialProperty dynamiceLayer2Tiling;


    // Occlusion
    private MaterialProperty occlusionMap;
    private MaterialProperty occlusionColor;
    private MaterialProperty cavity;
    private MaterialProperty cavityStrength;
    private MaterialProperty occlusionfinalpass;
    private MaterialProperty occlusionlightpass;
    private MaterialProperty specularOcclusion;

    // Transmission
    private MaterialProperty transmissionMap;
    private MaterialProperty transmissionColor;
    private MaterialProperty transmissionIntensity;
    private MaterialProperty transmissionGradient;
    private MaterialProperty gradientMin;
    private MaterialProperty gradientMax;
    private MaterialProperty travelDistance;
    private MaterialProperty travelDistancePointLights;
    private MaterialProperty travelDistanceMult;
    private MaterialProperty transmissionBias;
    private MaterialProperty maskWithNormals;
    private MaterialProperty cancelMin;
    private MaterialProperty cancelMax;

    // Specular
    private MaterialProperty specGlossMap;
    private MaterialProperty specColor;
    private MaterialProperty smoothness;
    private MaterialProperty specularHighlightIntensity;
 
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        Material targetMat = materialEditor.target as Material;

        // 查找所有属性
        FindProperties(properties);

        // 绘制GUI
        EditorGUILayout.Space();
        DrawBasicSettings(materialEditor);
        EditorGUILayout.Space();
        DrawNormalSettings(materialEditor);
        EditorGUILayout.Space();
        DrawMaskSettings(materialEditor);
        EditorGUILayout.Space();
        DrawWeatherSettings(materialEditor, targetMat);
        EditorGUILayout.Space();
        DrawSweatBeadSettings(materialEditor, targetMat);
        EditorGUILayout.Space();
        DrawOcclusionSettings(materialEditor);
        EditorGUILayout.Space();
        DrawTransmissionSettings(materialEditor, targetMat);
        EditorGUILayout.Space();
        DrawSpecularSettings(materialEditor);
        EditorGUILayout.Space();

        // 渲染队列和其他设置
        materialEditor.RenderQueueField();
        materialEditor.EnableInstancingField();
        materialEditor.DoubleSidedGIField();
    }

    private void FindProperties(MaterialProperty[] props)
    {
        // Basic
        baseMap = FindProperty("_BaseMap", props);
        color = FindProperty("_Color", props);
        subsurfaceMap = FindProperty("_SubsurfaceMap", props);
        subsurface = FindProperty("_Subsurface", props);
        diffuseRoughness = FindProperty("_DiffuseRoughness", props);
        lightClamp = FindProperty("_LightClamp", props);
        diffuseboost = FindProperty("_Diffuseboost", props);

        // Normal
        bumpMap = FindProperty("_BumpMap", props);
        normalIntensity = FindProperty("_NormalIntensity", props);

        // Mask
        maskMap = FindProperty("_MaskMap", props);
        redCheekMap = FindProperty("_RedCheekMap", props);
        redCheekIntensity = FindProperty("_RedCheekIntensity", props);

        // Weather
        rainDropNormal = FindProperty("_RainDrop_Normal", props);
        wetness = FindProperty("_Wetness", props);
        rainMaskMap = FindProperty("_RainMaskMap", props);
        rainTiling = FindProperty("_RainTiling", props);
        rainNormalMap = FindProperty("_RainNormalMap", props);
        rainNormalScale = FindProperty("_RainNormalScale", props);
        rainDropSize = FindProperty("_RainDropSize", props);
        rainAnimationSpeed = FindProperty("_RainAnimationSpeed", props);
        rainDistortionMap = FindProperty("_RainDistortionMap", props);
        rainDistortionScale = FindProperty("_RainDistortionScale", props);
        rainDistortionSize = FindProperty("_RainDistortionSize", props);

        // Sweat Bead
        rainDropProcedure = FindProperty("_RainDrop_Procedure", props);
        uvGridSize = FindProperty("_UVGridSize", props);
        rainAmount = FindProperty("_RainAmount", props);
        dynamicRainDropSpeed = FindProperty("_DynamicRainDropSpeed", props);
        dynamiceLayer1Tiling = FindProperty("_DynamiceLayer1Tiling", props);
        dynamiceLayer2Tiling = FindProperty("_DynamiceLayer2Tiling", props);

        // Occlusion
        occlusionMap = FindProperty("_OcclusionMap", props);
        occlusionColor = FindProperty("_OcclusionColor", props);
        cavity = FindProperty("_Cavity", props);
        cavityStrength = FindProperty("_CavityStrength", props);
        occlusionfinalpass = FindProperty("_Occlusionfinalpass", props);
        occlusionlightpass = FindProperty("_Occlusionlightpass", props);
        specularOcclusion = FindProperty("_SpecularOcclusion", props);

        // Transmission
        transmissionMap = FindProperty("_TransmissionMap", props);
        transmissionColor = FindProperty("_TransmissionColor", props);
        transmissionIntensity = FindProperty("_Transmission_intensity", props);
        transmissionGradient = FindProperty("_TransmissionGradient", props);
        gradientMin = FindProperty("_GradientMin", props);
        gradientMax = FindProperty("_GradientMax", props);
        travelDistance = FindProperty("_Travel_Distance", props);
        travelDistancePointLights = FindProperty("_TravelDistancePointLights", props);
        travelDistanceMult = FindProperty("_TravelDistanceMult", props);
        transmissionBias = FindProperty("_Transmission_Bias", props);
        maskWithNormals = FindProperty("_MaskWithNormals", props);
        cancelMin = FindProperty("_CancelMin", props);
        cancelMax = FindProperty("_CancelMax", props);

        // Specular
        specGlossMap = FindProperty("_SpecGlossMap", props);
        specColor = FindProperty("_SpecColor", props);
        smoothness = FindProperty("_Smoothness", props);
        specularHighlightIntensity = FindProperty("_SpecularHighlightIntensity", props);
    }

    private void DrawBasicSettings(MaterialEditor materialEditor)
    {
        showBasicSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showBasicSettings, "基础设置 (Basic Settings)");
        if (showBasicSettings)
        {
            EditorGUI.indentLevel++;
            materialEditor.TexturePropertySingleLine(new GUIContent("Base Map", "基础颜色贴图"), baseMap, color);
            materialEditor.ShaderProperty(diffuseRoughness, new GUIContent("Diffuse Roughness", "漫反射粗糙度"));
            materialEditor.ShaderProperty(lightClamp, new GUIContent("Light Clamp", "光照限制"));
            materialEditor.ShaderProperty(diffuseboost, new GUIContent("Diffuse Boost", "漫反射增强"));
            
            EditorGUILayout.Space(5);
            EditorGUILayout.LabelField("Subsurface (次表面)", EditorStyles.boldLabel);
            materialEditor.TexturePropertySingleLine(new GUIContent("Subsurface Map", "次表面贴图"), subsurfaceMap);
            materialEditor.ShaderProperty(subsurface, new GUIContent("Subsurface Visibility", "次表面可见度"));
            
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private void DrawNormalSettings(MaterialEditor materialEditor)
    {
        showNormalSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showNormalSettings, "法线设置 (Normal Settings)");
        if (showNormalSettings)
        {
            EditorGUI.indentLevel++;
            materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", "法线贴图"), bumpMap);
            materialEditor.ShaderProperty(normalIntensity, new GUIContent("Normal Scale", "法线强度"));
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private void DrawMaskSettings(MaterialEditor materialEditor)
    {
        showMaskSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showMaskSettings, "遮罩设置 (Mask Settings)");
        if (showMaskSettings)
        {
            EditorGUI.indentLevel++;
            materialEditor.TexturePropertySingleLine(new GUIContent("Red Check Map", "脸红遮罩贴图"), redCheekMap);
            EditorGUILayout.HelpBox("R通道: 未知 | G通道: 脸颊部分 | B通道: 眼下部分 | A通道: 耳朵部分", MessageType.Info);
            materialEditor.ShaderProperty(redCheekIntensity, new GUIContent("脸红强度", "脸红强度"));

            materialEditor.TexturePropertySingleLine(new GUIContent("Mask Map", "遮罩贴图 (R: Smoothness, G: -, B: Cavity, A: -)"), maskMap);
            EditorGUILayout.HelpBox("R通道: Roughness | GB通道: Occlusion | A通道 : Thickness", MessageType.Info);
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private void DrawWeatherSettings(MaterialEditor materialEditor, Material targetMat)
    {
        showWeatherSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showWeatherSettings, "流汗设置 (Weather Settings)");
        if (showWeatherSettings)
        {
            EditorGUI.indentLevel++;
            
            materialEditor.ShaderProperty(rainDropNormal, new GUIContent("开启皮肤流汗效果(法线实现)", "启用流汗效果"));
            
            bool rainDropNormalEnabled = rainDropNormal.floatValue > 0.5f;
            if (rainDropNormalEnabled)
            {
                targetMat.EnableKeyword("_RAINDROP_NROMAL_ON");
            }
            else
            {
                targetMat.DisableKeyword("_RAINDROP_NROMAL_ON");
            }

            if (rainDropNormalEnabled)
            {
                EditorGUILayout.Space(5);
                materialEditor.ShaderProperty(wetness, new GUIContent("Wetness", "湿润度"));
                materialEditor.TexturePropertySingleLine(new GUIContent("Rain Mask Map", "雨水遮罩贴图"), rainMaskMap);
                materialEditor.ShaderProperty(rainTiling, new GUIContent("Rain Tiling", "Rain Tiling"));
                
                EditorGUILayout.LabelField("Rain Normal", EditorStyles.boldLabel);
                materialEditor.TexturePropertySingleLine(new GUIContent("Rain Normal Map", "雨水法线贴图"), rainNormalMap);
                materialEditor.ShaderProperty(rainNormalScale, new GUIContent("Rain Normal Scale", "雨水法线强度"));
                materialEditor.ShaderProperty(rainDropSize, new GUIContent("Rain Size", "雨滴大小"));
                materialEditor.ShaderProperty(rainAnimationSpeed, new GUIContent("Rain Animation Speed", "雨水动画速度"));
                
                EditorGUILayout.Space(5);
                EditorGUILayout.LabelField("Rain Distortion", EditorStyles.boldLabel);
                materialEditor.TexturePropertySingleLine(new GUIContent("Rain Distortion Map", "雨水扭曲贴图"), rainDistortionMap);
                materialEditor.ShaderProperty(rainDistortionScale, new GUIContent("Rain Distortion Scale", "扭曲强度"));
                materialEditor.ShaderProperty(rainDistortionSize, new GUIContent("Rain Distortion Size", "扭曲大小"));
            }
            
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private void DrawSweatBeadSettings(MaterialEditor materialEditor, Material targetMat)
    {
        showSweatBeadSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showSweatBeadSettings, "汗珠设置 (Sweat Bead)");
        if (showSweatBeadSettings)
        {
            EditorGUI.indentLevel++;
            
            materialEditor.ShaderProperty(rainDropProcedure, new GUIContent("开启皮肤汗珠效果(程序化实现)", "开启皮肤汗珠效果"));
            materialEditor.ShaderProperty(wetness, new GUIContent("Wetness", "湿润度"));
            
            bool sweatBeadEnabled = rainDropProcedure.floatValue > 0.5f;
            if (sweatBeadEnabled)
            {
                targetMat.EnableKeyword("_RAINDROP_PROCEDURE_ON");
            }
            else
            {
                targetMat.DisableKeyword("_RAINDROP_PROCEDURE_ON");
            }

            if (sweatBeadEnabled)
            {
                materialEditor.ShaderProperty(uvGridSize, new GUIContent("UV GridSize", "网格尺寸"));
                materialEditor.ShaderProperty(rainAmount, new GUIContent("Rain Amount", "总汗珠数量"));
                materialEditor.ShaderProperty(dynamicRainDropSpeed, new GUIContent("Dynamic RainDrop Speed", "下降速度"));
                materialEditor.ShaderProperty(dynamiceLayer1Tiling, new GUIContent("Dynamic Layer1 Tiling", "第一层水珠Tilling"));
                materialEditor.ShaderProperty(dynamiceLayer2Tiling, new GUIContent("Dynamic Layer2 Tiling", "第二层水珠Tilling"));
                
            }
            
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }


    private void DrawOcclusionSettings(MaterialEditor materialEditor)
    {
        showOcclusionSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showOcclusionSettings, "遮蔽设置 (Occlusion Settings)");
        if (showOcclusionSettings)
        {
            EditorGUI.indentLevel++;
            
            materialEditor.TexturePropertySingleLine(new GUIContent("Occlusion Map", "AO贴图"), occlusionMap);
            materialEditor.ColorProperty(occlusionColor, "Occlusion Color");
            
            EditorGUILayout.Space(5);
            materialEditor.ShaderProperty(cavity, new GUIContent("Enable Cavity", "启用腔体"));
            materialEditor.ShaderProperty(cavityStrength, new GUIContent("Cavity Strength", "腔体强度"));
            
            EditorGUILayout.Space(5);
            materialEditor.ShaderProperty(occlusionfinalpass, new GUIContent("Occlusion Final Pass", "最终遮蔽强度"));
            materialEditor.ShaderProperty(occlusionlightpass, new GUIContent("Occlusion Light Pass", "光照遮蔽强度"));
            materialEditor.ShaderProperty(specularOcclusion, new GUIContent("Specular Occlusion", "高光遮蔽"));
            
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private void DrawTransmissionSettings(MaterialEditor materialEditor, Material targetMat)
    {
        showTransmissionSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showTransmissionSettings, "透射设置 (Transmission Settings)");
        if (showTransmissionSettings)
        {
            EditorGUI.indentLevel++;
            
            materialEditor.TexturePropertySingleLine(new GUIContent("Transmission Map", "透射/厚度贴图"), transmissionMap);
            materialEditor.ColorProperty(transmissionColor, "Transmission Color");
            materialEditor.ShaderProperty(transmissionIntensity, new GUIContent("Transmission Intensity", "透射强度"));
            
            EditorGUILayout.Space(5);
            EditorGUILayout.LabelField("Gradient Settings", EditorStyles.boldLabel);
            materialEditor.TexturePropertySingleLine(new GUIContent("Transmission Gradient", "透射渐变"), transmissionGradient);
            
            // 检查是否启用了渐变
            bool hasGradient = transmissionGradient.textureValue != null;
            if (hasGradient)
            {
                targetMat.EnableKeyword("_ENABLETRANSMISSIONGRADIENT_ON");
                materialEditor.ShaderProperty(gradientMin, new GUIContent("Gradient Min", "渐变最小值"));
                materialEditor.ShaderProperty(gradientMax, new GUIContent("Gradient Max", "渐变最大值"));
            }
            else
            {
                targetMat.DisableKeyword("_ENABLETRANSMISSIONGRADIENT_ON");
            }
            
            EditorGUILayout.Space(5);
            EditorGUILayout.LabelField("Travel Distance", EditorStyles.boldLabel);
            materialEditor.ShaderProperty(travelDistance, new GUIContent("Travel Distance (MainLight)", "主光源传播距离"));
            materialEditor.ShaderProperty(travelDistancePointLights, new GUIContent("Travel Distance (Point Lights)", "点光源传播距离"));
            materialEditor.ShaderProperty(travelDistanceMult, new GUIContent("Travel Distance Multiplier", "传播距离倍增器"));
            materialEditor.ShaderProperty(transmissionBias, new GUIContent("Transmission Bias", "透射偏移"));
            
            EditorGUILayout.Space(5);
            materialEditor.ShaderProperty(maskWithNormals, new GUIContent("Mask With Normals", "使用法线遮罩"));
            if (maskWithNormals.floatValue > 0.5f)
            {
                materialEditor.ShaderProperty(cancelMin, new GUIContent("Cancel Min", "取消最小值"));
                materialEditor.ShaderProperty(cancelMax, new GUIContent("Cancel Max", "取消最大值"));
            }
            
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private void DrawSpecularSettings(MaterialEditor materialEditor)
    {
        showSpecularSettings = EditorGUILayout.BeginFoldoutHeaderGroup(showSpecularSettings, "高光设置 (Specular Settings)");
        if (showSpecularSettings)
        {
            EditorGUI.indentLevel++;
            
            materialEditor.TexturePropertySingleLine(new GUIContent("Specular Map", "高光贴图"), specGlossMap);
            materialEditor.ColorProperty(specColor, "Specular Color");
            materialEditor.ShaderProperty(smoothness, new GUIContent("Smoothness", "光滑度"));
            materialEditor.ShaderProperty(specularHighlightIntensity, new GUIContent("Specular Highlight Intensity", "高光强度"));
            

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }
}