using UnityEngine;

public class Player : MonoBehaviour
{
    private void Start()
    {
        AudioManager.Instance.BGMFadeIn("bgm/Stream");
    }
}