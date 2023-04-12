using System.Collections.Generic;
using UnityEngine;

public class ProjectilMoveMeteor : MonoBehaviour
{

    public float speed;
    public GameObject impactPrefab;
    public List<GameObject> impactList;

    private Rigidbody rb;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void FixedUpdate()
    {
        if (speed != 0 && rb != null)
        {
            rb.position += transform.forward * (speed * Time.deltaTime);
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.gameObject.tag == "MeteorGround")
        {

            speed = 0;

            ContactPoint contact = collision.contacts[0];
            Quaternion rot = Quaternion.FromToRotation(Vector3.up, contact.normal);
            Vector3 pos = contact.point;

            if (impactPrefab != null)
            {
                var impactVFX = Instantiate(impactPrefab, pos, rot) as GameObject;

                Destroy(impactVFX, 5);
            }
            if (impactList.Count > 0)
            {
                for (int i = 0; i < impactList.Count; i++)
                {
                    impactList[i].transform.parent = null;
                    var ps = impactList[i].GetComponent<ParticleSystem>();
                    if (ps != null) 
                    {
                        ps.Stop();
                        Destroy(ps.gameObject, ps.main.duration + ps.main.startLifetime.constantMax);
                    }
                }
            }

            Destroy(gameObject);
        }
    }

}
