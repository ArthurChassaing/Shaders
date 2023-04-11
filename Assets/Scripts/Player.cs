using UnityEngine;

public class Player : MonoBehaviour
{
    [SerializeField] private GameObject _spellToCast;

    public static Player Instance { get; private set; }

    private int _maxLife = 100;
    private int _life = 100;
    private bool _areInputsEnabled = true;


    private void Awake()
    {
        if (Instance == null)
            Instance = this;
        else
            Destroy(gameObject);
    }

    void Update()
    {
        Shader.SetGlobalVector("_WorldSpacePlayerPos", transform.position);

        if (_areInputsEnabled)
        {
            if (Input.GetKeyDown(KeyCode.M))
                CastSpell();
        }
    }

    public void CastSpell()
    {
        Instantiate(_spellToCast, transform.position, Quaternion.identity);
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
        // Dissolve effect
    }
}
