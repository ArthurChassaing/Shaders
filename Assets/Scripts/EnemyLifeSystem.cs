using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyDestroy : MonoBehaviour
{
    private int _enemyHP = 100;
    private Renderer shaders;
    private WaitForSeconds wait = new WaitForSeconds(1);

    public void Start()
    {
        shaders = GetComponentInChildren<Renderer>();
    }
    private void OnCollisionEnter(Collision collision)
    {
        _enemyHP -= 50;
    }

    IEnumerator Test()
    {
        Debug.Log("TEST");
        shaders.material.SetFloat("isAnimated", 1);
        yield return new WaitForSeconds(10);
    }
    private void Update()
    {
        if (_enemyHP <= 0)
        {
            StartCoroutine(Test());
            Destroy(gameObject);
        }
    }
}
