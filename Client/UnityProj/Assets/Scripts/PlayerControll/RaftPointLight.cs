using DG.Tweening;
using UnityEngine;

public class RaftPointLight : MonoBehaviour
{
    [SerializeField] private Light Light;

    public void Start()
    {
        Light.DOIntensity(1.5f, 3f).SetLoops(-1, LoopType.Yoyo);
    }
}