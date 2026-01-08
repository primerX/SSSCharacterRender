#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;

namespace SSS_Demo
{
    [ExecuteInEditMode]
    public class SavePosition : MonoBehaviour
    {
        [Header("Frames between savings")]
        public int Frequency = 50;
        [SerializeField] Vector3 position;
        public Vector3 Position
        {
            get
            {
                Vector3 RotVector;
                RotVector.x = EditorPrefs.GetFloat("Capture Point Position X " + this.GetInstanceID() + " " + name, gameObject.transform.localPosition.x);
                RotVector.y = EditorPrefs.GetFloat("Capture Point Position Y " + this.GetInstanceID() + " " + name, gameObject.transform.localPosition.y);
                RotVector.z = EditorPrefs.GetFloat("Capture Point Position Z " + this.GetInstanceID() + " " + name, gameObject.transform.localPosition.z);
                return RotVector;

            }
            set
            {
                EditorPrefs.SetFloat("Capture Point Position X " + this.GetInstanceID() + " " + name, value.x);
                EditorPrefs.SetFloat("Capture Point Position Y " + this.GetInstanceID() + " " + name, value.y);
                EditorPrefs.SetFloat("Capture Point Position Z " + this.GetInstanceID() + " " + name, value.z);
            }
        }

        [SerializeField] Vector3 rotation;
        public Vector3 Rotation
        {
            get
            {
                Vector3 RotVector;
                RotVector.x = EditorPrefs.GetFloat("Capture Point Rotation X " + this.GetInstanceID() + " " + name, gameObject.transform.localEulerAngles.x);
                RotVector.y = EditorPrefs.GetFloat("Capture Point Rotation Y " + this.GetInstanceID() + " " + name, gameObject.transform.localEulerAngles.y);
                RotVector.z = EditorPrefs.GetFloat("Capture Point Rotation Z " + this.GetInstanceID() + " " + name, gameObject.transform.localEulerAngles.z);
                return RotVector;

            }
            set
            {
                EditorPrefs.SetFloat("Capture Point Rotation X " + this.GetInstanceID() + " " + name, value.x);
                EditorPrefs.SetFloat("Capture Point Rotation Y " + this.GetInstanceID() + " " + name, value.y);
                EditorPrefs.SetFloat("Capture Point Rotation Z " + this.GetInstanceID() + " " + name, value.z);
            }
        }


        // Use this for initialization
        void OnEnable()
        {
            //Restore
            rotation = Rotation;
            transform.localEulerAngles = rotation;

            position = Position;
            transform.localPosition = position;
        }
        bool TimeSnap(int Frames)
        {
            bool refresh = true;
            if (Application.isPlaying)
            {
                refresh = Time.frameCount <= 3 || (Time.frameCount % (1 + Frames)) == 0;

                return refresh;
            }
            else
                return true;


        }
        // Update is called once per frame
        void Update()
        {
            if (TimeSnap(Frequency))
            {
                Rotation = transform.localEulerAngles;
                rotation = Rotation;

                Position = transform.localPosition;
                position = Position;
            }
        }
    }
}
#endif