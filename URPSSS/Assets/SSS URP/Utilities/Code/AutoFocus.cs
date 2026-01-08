//quitarle la colisión a la bola!
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using System.Collections;

namespace SSS_Demo
{
    class AutoFocus : MonoBehaviour
    {
        //public string mensaje = "Press both";
        public KeyCode KeyToFocus1 = KeyCode.Mouse0;
        public KeyCode KeyToFocus2 = KeyCode.Mouse1;
        float distance;
        public int FocalLengthFactor = 400;
        //public float ShootUpdate = .1f;

        RaycastHit hit;
        Ray RayPoint;
        Vector3 FocusTransform;
        public GameObject DEBUG_POSITION;
        public float smoothing = 50;

        DepthOfField depthOfField;
        //public Vector3 HitPoint;

        void Start()
        {

        }

        //IEnumerator Example()
        //{
        //    while (true)
        //    {

        //        yield return new WaitForSeconds(ShootUpdate);


        //    }
        //}

        public Volume volume;

        public void OnEnable()
        {
            if (volume)
            {
                VolumeProfile volumeProfile = volume.profile;

                volumeProfile.TryGet(out depthOfField);
            }

            if (DEBUG_POSITION)
            {
                FocusTransform = DEBUG_POSITION.transform.position;
            }

            RayPoint = new Ray(DEBUG_POSITION.transform.position, gameObject.transform.forward);
            hit.point = DEBUG_POSITION.transform.position;

            //StartCoroutine(Example());
        }

        void Update()
        {
            //HitPoint = hit.point;
            if (Input.GetKeyDown(KeyToFocus1) || Input.GetKeyDown(KeyToFocus2) || Input.GetKeyDown(KeyCode.Mouse2))
            {

                RayPoint = gameObject.GetComponent<Camera>().ScreenPointToRay(Input.mousePosition);
                CastRay();


            }
            if (hit.collider != null)
            {
                FocusTransform.x = Mathf.Lerp(FocusTransform.x, hit.point.x, 1f / smoothing);
                FocusTransform.y = Mathf.Lerp(FocusTransform.y, hit.point.y, 1f / smoothing);
                FocusTransform.z = Mathf.Lerp(FocusTransform.z, hit.point.z, 1f / smoothing);
            }

            if (DEBUG_POSITION)
                DEBUG_POSITION.transform.position = FocusTransform;

            distance = Vector3.Distance(transform.position, FocusTransform);
            if (Application.isPlaying)
                if (depthOfField != null)
                {
                    depthOfField.focusDistance.value = distance;
                    depthOfField.focalLength.value = distance * FocalLengthFactor;
                }
                else
                    print("No hay DOF");

        }

        private void OnDisable()
        {
            StopAllCoroutines();
        }

        void CastRay()
        {


            var RayDir = transform.forward;
            //Ray RayPoint = new Ray(transform.position, RayDir);

            Debug.DrawLine(transform.position, DEBUG_POSITION.transform.position, Color.green);

            // RaycastHit hit;
            if (Physics.Raycast(RayPoint, out hit) && hit.collider != null)
            {
                //MeshCollider meshCollider = hit.collider as MeshCollider;

                /*if (meshCollider != null && meshCollider.sharedMesh)
                {
                    Mesh mesh = meshCollider.sharedMesh;
                    //Vector3[] normals = mesh.normals;
                    int[] triangles = mesh.triangles;
                    //Vector3 n0 = normals[triangles[hit.triangleIndex * 3 + 0]];
                    //Vector3 n1 = normals[triangles[hit.triangleIndex * 3 + 1]];
                    //Vector3 n2 = normals[triangles[hit.triangleIndex * 3 + 2]];
                    Vector3 baryCenter = hit.barycentricCoordinate;
                    //Vector3 interpolatedNormal = n0 * baryCenter.x + n1 * baryCenter.y + n2 * baryCenter.z;
                    //interpolatedNormal = interpolatedNormal.normalized;
                    Transform hitTransform = hit.collider.transform;
                    //interpolatedNormal = hitTransform.TransformDirection(interpolatedNormal);
                    //Debug.DrawRay(hit.point, interpolatedNormal, Color.green, 1);
                    //   HitDistance = Vector3.Distance(transform.position, hitTransform.position);
                    //print("Hit distance: " + Vector3.Distance(transform.position, hitTransform.position));
                }*/
            }
            //else
            //    Debug.Log("No hit");

        }
    }
}