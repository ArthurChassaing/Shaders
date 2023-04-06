using UnityEngine;

public class MouseRaycast : MonoBehaviour
{
    [Range(1f, 50f)]
    [SerializeField] private float _rayMaxDistance = 20f;
    [SerializeField] LayerMask _groundLayer;
    [SerializeField] GameObject PrefabToClone;
   
    void Update()
    {
        if (!Input.GetMouseButtonDown(0))
            return;
        
        Ray cameraRay = Camera.main.ScreenPointToRay(Input.mousePosition);

        RaycastHit hitInfo;
        if (Physics.Raycast(cameraRay, out hitInfo, _rayMaxDistance, _groundLayer.value))
        {
            Vector3 offset = new Vector3(0f, 1f, 0f);
            Instantiate(PrefabToClone, hitInfo.point + offset, Quaternion.identity);
        }
    }
}
