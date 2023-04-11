using UnityEngine;

public class HealthRefill : MonoBehaviour
{
    private void Start()
    {
        GetComponent<CollectibleItem>().OnCollect += RefillHealth;
    }

    private void RefillHealth()
    {
        Player.Instance.RefillHealth();
    }
}
