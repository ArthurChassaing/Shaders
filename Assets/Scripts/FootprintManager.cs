using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class FootprintManager : MonoBehaviour
{
    public GameObject LeftPrefab;
    public float spawnDistance = 1.0f; // The distance between footprint spawns

    private Vector3 lastSpawnPosition;

    private void Start()
    {
        lastSpawnPosition = transform.position;
        SpawnDecal(LeftPrefab);
    }

    private void Update()
    {
        float distanceMoved = Vector3.Distance(transform.position, lastSpawnPosition);
        if (distanceMoved >= spawnDistance)
        {
            SpawnDecal(LeftPrefab);
            lastSpawnPosition = transform.position;
        }
    }

    private void SpawnDecal(GameObject prefab)
    {
        Vector3 from = this.transform.position;
        
        RaycastHit hit;
        if (Physics.Raycast(from, Vector3.down , out hit,1f))
        {
            GameObject decal = Instantiate(prefab);
            decal.transform.position = hit.point;
    
        }
    }
}
