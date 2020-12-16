using UnityEngine;

public class BackwardAirWall : MonoBehaviour
{
    [SerializeField] private BoxCollider BoxCollider;
    [SerializeField] private GameManager.TravelProcess AppearAfterTravelProcess;

    void Update()
    {
        if (GameManager.Instance.CurTravelProcess >= AppearAfterTravelProcess)
        {
            BoxCollider.enabled = true;
        }
    }
}