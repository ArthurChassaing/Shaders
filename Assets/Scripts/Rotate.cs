using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    [SerializeField] float _speed = 10f;
    [SerializeField] Vector3 _axis = Vector3.up;
    private Rigidbody _rigidbody;
    
    private void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
    }
    
    void Update()
    {
        if (_rigidbody == null)
            transform.Rotate(_axis * _speed * Time.deltaTime);
        else
            _rigidbody.MoveRotation(_rigidbody.rotation * Quaternion.Euler(_axis * _speed * Time.deltaTime));
    }
}
