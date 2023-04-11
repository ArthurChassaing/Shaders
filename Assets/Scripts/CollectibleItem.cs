using UnityEngine;

public class CollectibleItem : MonoBehaviour
{
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

            Destroy(gameObject);
        }
    }
}
