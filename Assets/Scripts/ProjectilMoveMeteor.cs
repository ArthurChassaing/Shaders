using UnityEngine;

public class ProjectilMoveMeteor : MonoBehaviour
{

    public float speed;
    public GameObject impactPrefab;

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

            Destroy(gameObject);
        }
    }

}
