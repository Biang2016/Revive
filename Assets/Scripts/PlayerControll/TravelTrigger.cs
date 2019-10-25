using UnityEngine;
using UnityEngine.Events;

public class TravelTrigger : MonoBehaviour
{
    [SerializeField] private BoxCollider Collider;

    public void OnTriggerEnter()
    {
        Collider.enabled = false;
        EnterEvent?.Invoke();
    }

    public UnityEvent EnterEvent;
}