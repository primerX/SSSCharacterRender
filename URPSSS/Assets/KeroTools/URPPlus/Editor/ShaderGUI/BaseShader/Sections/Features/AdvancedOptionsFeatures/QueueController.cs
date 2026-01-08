using EditorGUIPlus.Data.Range;
using EditorGUIPlus.MaterialEditor;
using EditorGUIPlus.MaterialEditor.ShaderGUI;
using KeroTools.URPPlus.Editor.ShaderGUI.Properties;
using KeroTools.URPPlus.Editor.ShaderGUI.Styles;
using UnityEditor;
using UnityEngine;

namespace KeroTools.URPPlus.Editor.ShaderGUI.BaseShader.Sections.Features.AdvancedOptionsFeatures
{
    public sealed class QueueController : IFeature
    {
        private const int QueueOffsetRange = 50;
        private ShaderProperty _queueOffset = new(LitAdvancedOptionsProperties.QueueOffset);

        public void FindProperties(MaterialProperty[] properties) =>
            _queueOffset.Find(properties);

        public void Draw(MaterialEditorGUIPlus editor) =>
            DrawQueueSlider(editor);

        public void SetKeywords(Material material)
        { }

        private void DrawQueueSlider(MaterialEditorGUIPlus editor)
        {
            editor.DrawIntSlider(AdvancedOptionsStyles.QueueSlider, _queueOffset.MaterialProperty,
                new IntRange(-QueueOffsetRange, QueueOffsetRange));
        }
    }
}