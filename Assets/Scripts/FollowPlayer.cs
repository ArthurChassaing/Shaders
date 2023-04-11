using UnityEngine;
using UnityEngine.AI;

public class FollowPlayer : MonoBehaviour
{
    NavMeshAgent _agent;

    void Start()
    {
        _agent = GetComponent<NavMeshAgent>(); 
    }

    void Update()
    {
        _agent.SetDestination(Player.Instance.transform.position);
    }
}
