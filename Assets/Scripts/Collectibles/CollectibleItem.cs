using UnityEngine;

public class CollectibleItem : MonoBehaviour
{
    public event System.Action OnCollect;
    [SerializeField] GameObject _FXToSpawn = null;
    [SerializeField] AudioClip _clipToPlay = null;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (_FXToSpawn != null)
                Instantiate(_FXToSpawn, transform.position, Quaternion.identity);

            if (_clipToPlay != null)
                AudioSource.PlayClipAtPoint(_clipToPlay, transform.position);

            OnCollect?.Invoke();

            Destroy(gameObject);
        }
    }
}
