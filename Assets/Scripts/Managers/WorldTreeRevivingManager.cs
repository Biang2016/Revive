using System.Collections;
using UnityEngine;

public class WorldTreeRevivingManager : MonoSingleton<WorldTreeRevivingManager>
{
    [SerializeField] private Animator Animator;

    public enum TreeStates
    {
        Died,
        StartSceneRotateSlow,
        SolvingStonePuzzle,
        Reviving_Stage
    }

    private TreeStates cur_TreeState;

    public TreeStates Cur_TreeState
    {
        get { return cur_TreeState; }
        set
        {
            if (value != cur_TreeState)
            {
                switch (value)
                {
                    case TreeStates.Died:
                    {
                        Animator.speed = 0.2f;
                        Animator.SetTrigger("Died");
                        break;
                    }
                    case TreeStates.StartSceneRotateSlow:
                    {
                        Animator.speed = 0.05f;
                        break;
                    }
                    case TreeStates.SolvingStonePuzzle:
                    {
                        StartCoroutine(Co_PuzzleCSolved());
                        break;
                    }
                    case TreeStates.Reviving_Stage:
                    {
                        StartCoroutine(Co_AnimDelay());
                        break;
                    }
                }
            }

            cur_TreeState = value;
        }
    }

    public void SetAnimSpeedOfStartScene(float speed)
    {
        Animator.speed = speed;
    }

    IEnumerator Co_PuzzleCSolved()
    {
        AudioManager.Instance.BGMFadeOut(3f);
        yield return new WaitForSeconds(3f);
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_RevivingTree; // Music Start 0s
        GameManager.Instance.PuzzleC.ReturnAllPuzzlePartToFarthestPlaceAndMerge(3f);

        yield return new WaitForSeconds(31f);
        int steps = 10;
        for (int i = 0; i < steps; i++)
        {
            RenderSettings.fogStartDistance += 30f;
            RenderSettings.fogEndDistance += 30f;
            yield return new WaitForSeconds(0.2f);
        }
    }

    IEnumerator Co_AnimDelay()
    {
        // Music Start 0s
        yield return new WaitForSeconds(9f);
        Animator.speed = 0.2f;
        Animator.SetTrigger("Revive");
        yield return new WaitForSeconds(26f); // Music 35s strong beat
        GameManager.Instance.PuzzleC.PuzzleCParticleEffect.Play();
        yield return new WaitForSeconds(12f); // Music 47s strong beat

        GameManager.Instance.PuzzleC.PuzzleCParticleEffect.Stop();
        GameManager.Instance.PuzzleC.PuzzleCParticleEffect2.Play();
        GameManager.Instance.PuzzleC.ChangePuzzleStoneColor(2f);

        yield return new WaitForSeconds(3f); // Music 50s
        int steps = 10;
        for (int i = 0; i < steps; i++)
        {
            MountainMR.sharedMaterials[0].color = Color.Lerp(StartColor, EndColor, (float) i / steps);
            yield return new WaitForSeconds(0.2f);
        }
    }

    [SerializeField] private MeshRenderer MountainMR;
    [SerializeField] private Color StartColor;
    [SerializeField] private Color EndColor;

    void Awake()
    {
        MountainMR.sharedMaterials[0].color = StartColor;
    }
}