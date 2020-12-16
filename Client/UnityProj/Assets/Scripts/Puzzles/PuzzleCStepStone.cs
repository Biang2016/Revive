using System.Collections;
using UnityEngine;
using UnityEngine.Events;

public class PuzzleCStepStone : MonoBehaviour
{
    [SerializeField] private MeshRenderer MeshRenderer;
    [SerializeField] private Animator Animator;
    [SerializeField] private ParticleSystem ParticleSystem_Default;
    [SerializeField] private ParticleSystem ParticleSystem_Triggered;

    private float defaultStartSpeed;
    private float defaultStartSize;

    public void Start()
    {
        MeshRenderer.material.color = StartColor;
        defaultStartSpeed = ParticleSystem_Default.startSpeed;
        defaultStartSize = ParticleSystem_Default.startSize;
    }

    private void OnTriggerEnter(Collider c)
    {
        Player p = c.gameObject.GetComponent<Player>();
        if (p != null)
        {
            CorrespondingStone.DisableSphereCollider();
            Animator.SetTrigger("StepOn");
            AudioManager.Instance.SoundPlay("sfx/stonemovemnet");
            StartCoroutine(Co_Sound());
        }
    }

    IEnumerator Co_Sound()
    {
//        Input.ResetInputAxes();
//        GameManager.Instance.Player.Controller.MyMouseLooker.LookDown();
//        GameManager.Instance.Player.Controller.MyMouseLooker.enabled = false;
//        GameManager.Instance.Player.Controller.MyController.enabled = false;
//        GameManager.Instance.Player.Controller.enabled = false;
        yield return new WaitForSeconds(1.6f);
        ParticleSystem_Triggered.Play();
        ParticleSystem_Default.startSpeed = defaultStartSpeed * 2;
        ParticleSystem_Default.startSize = defaultStartSize * 2;
        for (int i = 0; i < 10; i++)
        {
            MeshRenderer.material.color = Color.Lerp(StartColor, ReviveColor, i / 10f);
            yield return new WaitForSeconds(0.1f);
        }

//        GameManager.Instance.Player.Controller.MyMouseLooker.enabled = true;
//        GameManager.Instance.Player.Controller.MyController.enabled = true;
//        GameManager.Instance.Player.Controller.enabled = true;

        TriggerEvent?.Invoke();
    }

    [SerializeField] private UnityEvent TriggerEvent;

    [SerializeField] private Color StartColor;
    [SerializeField] private Color ReviveColor;
    [SerializeField] private NormalTombStone CorrespondingStone;
}