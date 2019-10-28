using UnityEngine;
using UnityEngine.Events;

public class TravelTrigger : MonoBehaviour
{
    [SerializeField] private BoxCollider Collider;

    [SerializeField] private bool TriggerAnyTime;
    [SerializeField] private GameManager.TravelProcess OnlyTriggerOn;

    public void OnTriggerEnter(Collider c)
    {
        if (TriggerAnyTime)
        {
            Player p = c.gameObject.GetComponent<Player>();
            if (p != null)
            {
                EnterEvent?.Invoke();
            }
        }
        else
        {
            if (GameManager.Instance.CurTravelProcess == OnlyTriggerOn)
            {
                Player p = c.gameObject.GetComponent<Player>();
                if (p != null)
                {
                    Collider.enabled = false;
                    EnterEvent?.Invoke();
                }
            }
        }
    }

    public UnityEvent EnterEvent;
}