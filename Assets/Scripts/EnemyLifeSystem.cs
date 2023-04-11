using UnityEngine;

public class EnemyDestroy : MonoBehaviour
{
    private int _enemyHP = 100;

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("TEST"); // This is a test
        _enemyHP -= 50;
        
        if(_enemyHP <= 0)
            Destroy(gameObject);
    }
}
