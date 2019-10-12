using UnityEngine;

public class Player : MonoBehaviour
{
    private void Start()
    {
        AudioManager.Instance.BGMFadeIn("bgm/Stream");

        RenderSettings.fog = true;
        RenderSettings.fogDensity = 1.0f;
    }
}