using UnityEngine;
using System.Collections;

public class PlatformerStone : MonoBehaviour
{
    [SerializeField] private Platformer3D ParentPlatformer3D;
    [SerializeField] private float SpawnEffectTime = 2;
    [SerializeField] private AnimationCurve fadeIn;
    [SerializeField] private ParticleSystem ParticleSystem;
    float timer = 0;
    [SerializeField] private Renderer Renderer;

    int shaderProperty;

    void Start()
    {
        shaderProperty = Shader.PropertyToID("_cutoff");
    }

    public void Show()
    {
        if (ParticleSystem != null)
        {
            ParticleSystem.MainModule main = ParticleSystem.main;
            main.duration = SpawnEffectTime;
            ParticleSystem.Play();
        }

        HasStarted = true;
    }

    public bool HasStarted = false;
    public bool HasEnded = false;

    void Update()
    {
        if (HasEnded) return;
        if (HasStarted)
        {
            if (timer < SpawnEffectTime)
            {
                timer += Time.deltaTime;
            }
            else
            {
                timer = 0;
                HasEnded = true;
            }

            Renderer.material.SetFloat(shaderProperty, fadeIn.Evaluate(Mathf.InverseLerp(0, SpawnEffectTime, timer)));
        }
    }

    public void Reset()
    {
        timer = 0;
        HasStarted = false;
        HasEnded = false;
    }

    private void OnTriggerEnter(Collider c)
    {
        Player player = c.gameObject.GetComponent<Player>();
        if (player != null)
        {
            player.transform.SetParent(transform);
            player.transform.rotation = Quaternion.Euler(0, 0, 0);
            ParentPlatformer3D.ShowNext(this);
        }
    }

    private void OnTriggerExit(Collider c)
    {
        Player player = c.gameObject.GetComponent<Player>();
        if (player != null)
        {
            player.transform.SetParent(GameManager.Instance.SurroundingRoot);
            player.transform.rotation = Quaternion.Euler(0, 0, 0);
        }
    }
}