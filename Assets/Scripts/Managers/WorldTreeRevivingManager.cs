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

    IEnumerator Co_PuzzleCSolved()
    {
        AudioManager.Instance.BGMFadeOut(6f);
        yield return new WaitForSeconds(3f);
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_RevivingTree; // Music Start 0s
        GameManager.Instance.PuzzleC.ReturnAllPuzzlePartToFarthestPlaceAndMerge(3f);

        yield return new WaitForSeconds(15f);
        int steps = 10;
        for (int i = 0; i < steps; i++)
        {
            RenderSettings.fogStartDistance += 30f;
            RenderSettings.fogEndDistance += 30f;
            yield return new WaitForSeconds(0.1f);
        }
    }

    IEnumerator Co_AnimDelay()
    {
        // Music Start 0s
        yield return new WaitForSeconds(9f);
        Animator.speed = 0.2f;
        Animator.SetTrigger("Revive");
        yield return new WaitForSeconds(24f);
        GameManager.Instance.PuzzleC.PuzzleCParticleEffect.Play();
    }
}