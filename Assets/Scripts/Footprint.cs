using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Footprint : MonoBehaviour
{
    public float Lifetime = 2.0f;
    private float mark;
    private Vector3 OrigSize;

    public void Start()
    {
        mark = Time.time;
        OrigSize = this.transform.localScale;
    }
    public void Update()
    {
        float ElapsedTime = Time.time - mark;
        if (ElapsedTime != 0)
        {
            float PercentTimeLeft = (Lifetime - ElapsedTime) / Lifetime;

            this.transform.localScale = new Vector3(OrigSize.x * PercentTimeLeft, OrigSize.y * PercentTimeLeft, OrigSize.z * PercentTimeLeft);
            if (ElapsedTime > Lifetime)
            {
                Destroy(gameObject);
            }
        }
    }
}
