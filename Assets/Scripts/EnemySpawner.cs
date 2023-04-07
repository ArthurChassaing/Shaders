using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySpawner : MonoBehaviour
{
    [SerializeField] private GameObject enemyPrefab; // Assignez le prefab d'ennemi dans l'éditeur Unity
    [SerializeField] private Transform spawnPoint; // Assignez un Transform pour déterminer le point d'apparition
    [SerializeField] private float spawnInterval = 40f; // Intervalle en secondes entre les vagues d'apparitions
    [SerializeField] private int enemiesPerWave = 15; // Nombre d'ennemis à faire apparaître par vague
    [SerializeField] private float delayBetweenEnemies = 1.5f; // Délai en secondes entre chaque ennemi

    private void Start()
    {
        StartCoroutine(SpawnEnemies());
    }

    private IEnumerator SpawnEnemies()
    {
        while (true)
        {
            // Faire apparaître 15 ennemis dans une boucle
            for (int i = 0; i < enemiesPerWave; i++)
            {
                Instantiate(enemyPrefab, spawnPoint.position, spawnPoint.rotation);
                yield return new WaitForSeconds(delayBetweenEnemies);
            }

            // Attendre 20 secondes avant de faire apparaître la prochaine vague d'ennemis
            yield return new WaitForSeconds(spawnInterval);
        }
    }
}
