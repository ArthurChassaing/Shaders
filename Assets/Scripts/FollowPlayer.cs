using UnityEngine;
using UnityEngine.AI;

public class FollowPlayer : MonoBehaviour
{
    public Transform Target;
    NavMeshAgent _agent;

    void Start()
    {
        _agent = GetComponent<NavMeshAgent>(); 
    }

    void Update()
    {
        _agent.SetDestination(Target.position);
    }
}
