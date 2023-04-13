using UnityEngine;

public class SelectSpell : MonoBehaviour
{
    [SerializeField] private GameObject spellSpot;
    [SerializeField] private GameObject[] orbs;
    private int _indexOrb;
    private GameObject _currentOrb;
    
    private enum Spell
    {
        Fireball,
        Lightning,
        Water
    }
    
    private void Start()
    {
        _indexOrb = 0;
        _currentOrb = Instantiate(orbs[_indexOrb], spellSpot.transform.position, Quaternion.identity);
        _currentOrb.transform.parent = spellSpot.transform;
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.A))
            ChangeSpell(1);
        else if (Input.GetKeyDown(KeyCode.E))
            ChangeSpell(-1);
    }

    private void ChangeSpell(int value)
    {
        _indexOrb += value;
        if (_indexOrb < 0)
        {
            _indexOrb = orbs.Length - 1;
        }
        else if (_indexOrb > orbs.Length - 1)
        {
            _indexOrb = 0;
        }
        
        Destroy(_currentOrb);
        _currentOrb = Instantiate(orbs[_indexOrb], spellSpot.transform.position, Quaternion.identity);
        _currentOrb.transform.parent = spellSpot.transform;
    }
    
    public int GetSpell()
    {
        return _indexOrb;
    }
}
