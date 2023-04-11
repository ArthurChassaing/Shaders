using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    [SerializeField] float _speed = 10f;
    
    void Update()
    {
        transform.Rotate(Vector3.up, _speed * Time.deltaTime);
    }
}
