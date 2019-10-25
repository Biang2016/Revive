using UnityEngine;

public class Cave1WaterStone : MonoBehaviour
{
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

    public void PuzzleSolved()
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
                HasEnded = true;
            }

            Renderer.material.SetFloat(shaderProperty, fadeIn.Evaluate(Mathf.InverseLerp(0, SpawnEffectTime, timer)));
        }
    }
}