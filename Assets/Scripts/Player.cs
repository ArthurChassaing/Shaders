using UnityEngine;

public class Player : MonoBehaviour
{
    public static Player Instance { get; private set; }

    [SerializeField] private SkinnedMeshRenderer _meshRenderer;
    private Material[] _materials;
    private int _maxLife = 100;
    private int _life = 100;


    private void Awake()
    {
        if (Instance == null)
            Instance = this;
        else
            Destroy(gameObject);
    }
    
    private void Start()
    {
        _materials = _meshRenderer.materials;
        foreach (var m in _materials)
        {
            m.SetFloat("_Max_Life_Points", _maxLife);
            m.SetFloat("_LifePoints", _life);
        }
    }

    public void UpdateLife(int valueToAdd)
    {
        _life = Mathf.Clamp(_life + valueToAdd, 0, _maxLife);
        
        foreach (var m in _materials)
        {
            m.SetFloat("_LifePoints", _life);
        }
        
        if (_life == 0)
            Die();
    }

    public void RefillHealth()
    {
        _life = _maxLife;
    }

    private void Die()
    {
        Debug.LogWarning("Player died");
    }
}
