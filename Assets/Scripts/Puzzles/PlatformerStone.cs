using UnityEngine;

public class PlatformerStone : MonoBehaviour
{
    [SerializeField] private Platformer3D ParentPlatformer3D;
    [SerializeField] private float SpawnEffectTime = 2;
    [SerializeField] private AnimationCurve fadeIn;
    [SerializeField] private ParticleSystem ParticleSystem;
    [SerializeField] private Animator MoveAnimator;
    float timer = 0;
    [SerializeField] private Renderer Renderer;
    [SerializeField] private AudioSource AudioSource;

    int shaderProperty;

    void Start()
    {
        shaderProperty = Shader.PropertyToID("_cutoff");
    }

    public void Show()
    {
        if (ParticleSystem != null)
        {
            ParticleSystem.Play();
        }

        HasStarted = true;
        AudioSource.Play();
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

            Renderer.material.SetFloat(shaderProperty, fadeIn.Evaluate(Mathf.Min(0.8f, timer / SpawnEffectTime)));
        }
    }

    public void Reset()
    {
        timer = 0;
        HasStarted = false;
        HasEnded = false;
        MoveAnimator.enabled = true;
    }

    private void OnTriggerEnter(Collider c)
    {
        Player player = c.gameObject.GetComponent<Player>();
        if (player != null)
        {
            AudioManager.Instance.SoundPlay("sfx/StepOn3DPlatformStone");
            player.transform.SetParent(transform);
            ParentPlatformer3D.ShowNext(this);
            Renderer.material.SetFloat(shaderProperty, fadeIn.Evaluate(1));
        }
    }

    private void OnTriggerExit(Collider c)
    {
        Player player = c.gameObject.GetComponent<Player>();
        if (player != null)
        {
            player.transform.SetParent(GameManager.Instance.SurroundingRoot);
        }
    }
}