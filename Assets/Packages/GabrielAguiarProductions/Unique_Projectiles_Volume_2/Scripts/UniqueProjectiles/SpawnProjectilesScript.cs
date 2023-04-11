//
//NOTES:
//This script is used for DEMONSTRATION porpuses of the Projectiles. I recommend everyone to create their own code for their own projects.
//This is just a basic example.
//

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SpawnProjectilesScript : MonoBehaviour
{
    public bool useTarget;
    public Text effectName;
    public RotateToMouseScript rotateToMouse;
    public GameObject firePoint;
    public GameObject target;
    public List<GameObject> VFXs = new List<GameObject>();

    private int count = 0;
    private float timeToFire = 0f;
    private GameObject effectToSpawn;
    private Camera singleCamera;

    void Start()
    {
        if (VFXs.Count > 0)
            effectToSpawn = VFXs[0];
        else
            Debug.Log("Please assign one or more VFXs in inspector");

        if (effectName != null)
            effectName.text = effectToSpawn.name;
    }

    void Update()
    {
        if (Input.GetMouseButton(0) && Time.time >= timeToFire)
        {
            timeToFire = Time.time + 1f / effectToSpawn.GetComponent<ProjectileMoveScript>().fireRate;
            SpawnVFX();
        }
    }

    private void SpawnVFX()
    {
        GameObject vfx;

        /*var cameraShakeScript = cameras.GetComponent<CameraShakeSimpleScript> ();

        if (cameraShake && cameraShakeScript != null)
            cameraShakeScript.ShakeCamera ();*/

        if (firePoint != null)
        {
            vfx = Instantiate(effectToSpawn, firePoint.transform.position, Quaternion.identity);
            if (!useTarget)
            {
                if (rotateToMouse != null)
                {
                    vfx.transform.localRotation = gameObject.transform.rotation;
                }
                else Debug.Log("No RotateToMouseScript found on firePoint.");
            }
            else
            {
                vfx.GetComponent<ProjectileMoveScript>().SetTarget(target, rotateToMouse);
                rotateToMouse.RotateToMouse(vfx, target.transform.position);
            }
        }
        else
            vfx = Instantiate(effectToSpawn);
    }
}