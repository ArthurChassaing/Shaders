using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Rendering;

public class EnemyDestroy : MonoBehaviour
{
    private int _enemyHP = 100;
    private Renderer rend;
    private bool isDying = false;
    private float animation = 0;

    public void Start()
    {
        rend = GetComponentInChildren<Renderer>();
    }
    private void OnCollisionEnter(Collision collision)
    {
        _enemyHP -= 50;
        if (_enemyHP <=0)
        {
            isDying = true;
            gameObject.GetComponent<Enemy>().enabled = false;
            gameObject.GetComponent<NavMeshAgent>().enabled = false;
            gameObject.GetComponent<Collider>().enabled = false;
        }
        
    }

    private void Update()
    {
        if(isDying)
        {
            animation += Time.deltaTime;
            if (animation >= 1)
            {
                Destroy(gameObject);
            }
            
            foreach (Material m in rend.materials)
            {
                m.SetFloat("_testFloat", animation);
            }
        }
    }
}