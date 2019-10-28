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
        Reviving_Stage1,
        Reviving_Stage2,
        Reviving_Stage3,
        Reviving_Stage4,
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
                    case TreeStates.Reviving_Stage1:
                    {
                        Animator.speed = 0.2f;
                        Animator.SetTrigger("Revive");
                        break;
                    }
                    case TreeStates.Reviving_Stage2:
                    {
                        break;
                    }
                    case TreeStates.Reviving_Stage3:
                    {
                        break;
                    }
                    case TreeStates.Reviving_Stage4:
                    {
                        break;
                    }
                }
            }

            cur_TreeState = value;
        }
    }

    IEnumerator Co_PuzzleCSolved()
    {
        ///Something effects with the stones
        yield return new WaitForSeconds(2f);
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_RevivingTree;

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