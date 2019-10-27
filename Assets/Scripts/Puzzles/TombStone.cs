using UnityEngine;
using System.Collections;
using UnityEngine.Events;

public class TombStone : MonoBehaviour
{
    [SerializeField] private MeshRenderer Renderer;
    [SerializeField] private float SpawnEffectTime = 2;
    [SerializeField] private AnimationCurve fadeIn;
    [SerializeField] private ParticleSystem ParticleSystem;
    [SerializeField] private AudioSource AudioSource;

    void Start()
    {
        Hide();
        shaderProperty = Shader.PropertyToID("_cutoff");
    }

    void OnTriggerEnter(Collider c)
    {
        Player p = c.gameObject.GetComponent<Player>();
        if (p != null)
        {
            Show();
        }
    }

    void OnTriggerExit(Collider c)
    {
        Player p = c.gameObject.GetComponent<Player>();
        if (p != null)
        {
            Hide();
        }
    }

    int shaderProperty;

    public void Show()
    {
        timer = 0;
        ParticleSystem?.Play();
        ShowHasStarted = true;
        HasEnded = false;
        AudioSource.Play();
    }

    public void Hide()
    {
        timer = 0;
        ParticleSystem?.Stop();
        HideHasStarted = true;
        HasEnded = false;
    }

    public bool ShowHasStarted = false;
    public bool HideHasStarted = false;
    public bool HasEnded = false;

    void Update()
    {
        if (HasEnded) return;
        if (ShowHasStarted)
        {
            if (timer < SpawnEffectTime)
            {
                timer += Time.deltaTime;
            }
            else
            {
                ShowHasStarted = false;
                HasEnded = true;
            }

            Renderer.materials[0].SetFloat(shaderProperty, fadeIn.Evaluate(timer / SpawnEffectTime));
            Renderer.materials[1].SetFloat(shaderProperty, fadeIn.Evaluate(timer / SpawnEffectTime));
        }

        if (HideHasStarted)
        {
            if (timer < SpawnEffectTime)
            {
                timer += Time.deltaTime;
            }
            else
            {
                HideHasStarted = false;
                HasEnded = true;
            }

            Renderer.materials[0].SetFloat(shaderProperty, fadeIn.Evaluate(1 - timer / SpawnEffectTime));
            Renderer.materials[1].SetFloat(shaderProperty, fadeIn.Evaluate(1 - timer / SpawnEffectTime));
        }
    }

    private float timer = 0;

    [SerializeField] private UnityEvent EnterEvent;

    public void OnDeadRoad()
    {
    }

    public void OnWaterfall()
    {
    }

    public void OnBraveJump()
    {
    }
}