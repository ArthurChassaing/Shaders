using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySpawner : MonoBehaviour
{
    [SerializeField] private GameObject enemyPrefab; 
    [SerializeField] private Transform spawnPoint; 
    [SerializeField] private float spawnInterval = 40f; 
    [SerializeField] private int enemiesPerWave = 15; 
    [SerializeField] private float delayBetweenEnemies = 1.5f;
    [SerializeField] private GameObject Target;

    private void Start()
    {
        StartCoroutine(SpawnEnemies());
    }

    private IEnumerator SpawnEnemies()
    {
        while (true)
        {
            for (int i = 0; i < enemiesPerWave; i++)
            {
                Instantiate(enemyPrefab, spawnPoint.position, spawnPoint.rotation);
                yield return new WaitForSeconds(delayBetweenEnemies);
            }
            yield return new WaitForSeconds(spawnInterval);
        }
    }
}
