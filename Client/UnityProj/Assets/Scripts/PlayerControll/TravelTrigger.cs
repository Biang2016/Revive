using UnityEngine;
using UnityEngine.Events;

public class TravelTrigger : MonoBehaviour
{
    [SerializeField] private BoxCollider Collider;

    private bool AlreadyTriggered = false;
    [SerializeField] private bool MultipleTrigger;
    [SerializeField] private bool TriggerAnyTime;
    [SerializeField] private GameManager.TravelProcess OnlyTriggerOn;

    public void OnTriggerEnter(Collider c)
    {
        Player p = c.gameObject.GetComponent<Player>();
        if (p != null)
        {
            if (TriggerAnyTime || GameManager.Instance.CurTravelProcess == OnlyTriggerOn)
            {
                AlreadyTriggered = true;
                EnterEvent?.Invoke();
            }

            if (!MultipleTrigger)
            {
                Collider.enabled = false;
            }
        }
    }

    public void OnTriggerExit(Collider c)
    {
        Player p = c.gameObject.GetComponent<Player>();
        if (p != null)
        {
            if (AlreadyTriggered)
            {
                LeaveEvent?.Invoke();
            }

            if (!MultipleTrigger && AlreadyTriggered)
            {
                Collider.enabled = false;
            }
        }
    }

    public UnityEvent EnterEvent;
    public UnityEvent LeaveEvent;
}