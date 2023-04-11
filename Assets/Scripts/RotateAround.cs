using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;

public class RotateAround : MonoBehaviour
{
    [SerializeField] private Transform _target;
    [SerializeField] float _speed = 20f;
    [SerializeField] Vector3 _axis = Vector3.up;
    
    private Vector3 _center;

    private void Start()
    {
        if (_target == null)
            _center = Vector3.zero;
        else
            _center = _target.position;
    }
    
    void Update()
    {
        transform.RotateAround(_center, _axis, _speed * Time.deltaTime);
    }
}
