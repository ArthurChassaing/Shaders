using UnityEngine;

public class Player : MonoBehaviour
{
    [SerializeField] private GameObject _spellToCast;

    private int _maxLife = 100;
    private int _life = 100;
    private bool _areInputsEnabled = true;

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
        _life += valueToAdd;
        _life = Mathf.Clamp(_life, 0, _maxLife);

        if (_life == 0)
            Die();
    }

    public void Die()
    {
        // Dissolve effect
    }
}
