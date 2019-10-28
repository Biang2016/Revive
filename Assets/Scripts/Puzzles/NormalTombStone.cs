using UnityEngine;
using UnityEngine.Events;

public class NormalTombStone : MonoBehaviour
{
    [SerializeField] private ParticleSystem PS;

    void OnTriggerEnter(Collider c)
    {
        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowHint(Hint);
        PS.Play();
        AudioManager.Instance.SoundPlay("sfx/tombstone_sound");
    }

    public PlayingPanel.Hints Hint;
}