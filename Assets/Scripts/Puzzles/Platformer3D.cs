using UnityEngine;

public class Platformer3D : MonoBehaviour
{
    [SerializeField] private PlatformerStone[] PlatformerStones;
    [SerializeField] private BoxCollider DeadZone;

    public int CurrentIndex = -1;

    void Start()
    {
        ResetAll();
    }

    public void ShowFirst()
    {
        PlatformerStones[0].gameObject.SetActive(true);
        PlatformerStones[0].Show();
        DeadZone.enabled = true;
    }

    public void ShowNext(PlatformerStone current)
    {
        for (int i = 0; i < PlatformerStones.Length; i++)
        {
            if (current == PlatformerStones[i])
            {
                if (i <= CurrentIndex)
                {
                    return;
                }
                else
                {
                    if (i < PlatformerStones.Length - 1)
                    {
                        PlatformerStones[i + 1].gameObject.SetActive(true);
                        PlatformerStones[i + 1].Show();
                    }

                    CurrentIndex++;
                }
            }
        }
    }

    public void ResetAll()
    {
        foreach (PlatformerStone ps in PlatformerStones)
        {
            ps.Reset();
            ps.gameObject.SetActive(false);
        }

        CurrentIndex = -1;
    }
}