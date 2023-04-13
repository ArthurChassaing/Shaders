using UnityEngine;

public class Player : MonoBehaviour
{
    public static Player Instance { get; private set; }

    private int _maxLife = 100;
    private int _life = 100;


    private void Awake()
    {
        if (Instance == null)
            Instance = this;
        else
            Destroy(gameObject);
    }

    public void UpdateLife(int valueToAdd)
    {
        _life = Mathf.Clamp(_life + valueToAdd, 0, _maxLife);

        if (_life == 0)
            Die();
    }

    public void RefillHealth()
    {
        _life = _maxLife;
    }

    public void Die()
    {
        Debug.LogWarning("Player died");
    }
}
