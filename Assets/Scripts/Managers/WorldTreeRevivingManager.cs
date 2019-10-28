using UnityEngine;
using System.Collections;

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
                        Animator.speed = 0.2f;
                        Animator.SetTrigger("Revive");
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
        yield return new WaitForSeconds(5f);
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_RevivingTree;
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
}