using UnityEngine;
using System.Collections;
using UnityEngine.Events;

public class PuzzleCStepStone : MonoBehaviour
{
    [SerializeField] private MeshRenderer MeshRenderer;
    [SerializeField] private Animator Animator;
    [SerializeField] private ParticleSystem ParticleSystem_Default;
    [SerializeField] private ParticleSystem ParticleSystem_Triggered;

    public void Start()
    {
        MeshRenderer.material.color = StartColor;
    }

    private void OnTriggerEnter(Collider c)
    {
        Player p = c.gameObject.GetComponent<Player>();
        if (p != null)
        {
            Animator.SetTrigger("StepOn");
            AudioManager.Instance.SoundPlay("sfx/stonemovemnet");
            StartCoroutine(Co_Sound());
            TriggerEvent?.Invoke();
        }
    }

    IEnumerator Co_Sound()
    {
        yield return new WaitForSeconds(1f);
        AudioManager.Instance.SoundPlay("sfx/puzzle1");
        ParticleSystem_Triggered.Play();
        ParticleSystem_Default.startSpeed *= 2f;
        ParticleSystem_Default.startSize *= 2f;
        for (int i = 0; i < 10; i++)
        {
            MeshRenderer.material.color = Color.Lerp(StartColor, ReviveColor, i / 10f);
            yield return new WaitForSeconds(0.1f);
        }
    }

    [SerializeField] private UnityEvent TriggerEvent;

    [SerializeField] private Color StartColor;
    [SerializeField] private Color ReviveColor;
}