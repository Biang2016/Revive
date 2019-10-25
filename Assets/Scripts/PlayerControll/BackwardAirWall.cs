using UnityEngine;

public class BackwardAirWall : MonoBehaviour
{
    [SerializeField] private BoxCollider BoxCollider;
    [SerializeField] private GameManager.TravelProcess DisappearAfterTravelProcess;

    void Update()
    {
        if (GameManager.Instance.CurTravelProcess >= DisappearAfterTravelProcess)
        {
            BoxCollider.enabled = true;
        }
    }
}