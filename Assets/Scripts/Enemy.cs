using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour
{
    [SerializeField] int _damageToPlayer;
    NavMeshAgent _agent;
    float _triggerCooldown;

    void Start()
    {
        _agent = GetComponent<NavMeshAgent>(); 
    }

    void Update()
    {
        _agent.SetDestination(Player.Instance.transform.position);
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            Debug.Log("Player entered enemy trigger");
            _triggerCooldown = 0;
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            Debug.Log("Player exited enemy trigger");
        }
    }

    void OnTriggerStay(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            _triggerCooldown += Time.deltaTime;
            if (_triggerCooldown >= 1)
            {
                Debug.Log("Player is taking damage");
                Player.Instance.UpdateLife(-_damageToPlayer);
                _triggerCooldown = 0;
            }
        }
    }
}
