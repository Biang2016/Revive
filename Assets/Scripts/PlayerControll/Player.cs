using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    public Camera MyCamera;
    public AutoMove AutoMove;
    public Controller Controller;

    public bool IsEnterPuzzleCheckPoint = false;

    void Update()
    {
        if (IsEnterPuzzleCheckPoint)
        {
            if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.CaveStage1_WhenPuzzle)
            {
                RayCastPuzzleSolve();
            }

            if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.PlatformStage3_EnterSolvingLastPuzzleZone)
            {
                RayCastPuzzleSolve();
            }

            if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.None)
            {
                RayCastPuzzleSolve();
            }
        }
    }

    public bool RayCastPuzzleSolve()
    {
        Ray ray = GameManager.Instance.MainCamera.ScreenPointToRay(Input.mousePosition);

        RaycastHit[] hits = Physics.RaycastAll(ray, 500f, GameManager.Instance.PuzzleLayer);
        int ppCount = 0;
        if (hits.Length != 0)
        {
            HashSet<Puzzle> triedPuzzle = new HashSet<Puzzle>();
            foreach (RaycastHit hit in hits)
            {
                PuzzlePart pp = hit.collider.gameObject.GetComponent<PuzzlePart>();
                if (pp == null)
                {
                    pp = hit.collider.transform.parent.gameObject.GetComponent<PuzzlePart>();
                }

                if (pp != null)
                {
                    pp.ParrentPuzzle.PuzzleHits[pp.ParrentPuzzle.PuzzleParts.IndexOf(pp)] = true;
                    triedPuzzle.Add(pp.ParrentPuzzle);
                    ppCount++;
                }
            }

            foreach (Puzzle puzzle in triedPuzzle)
            {
                puzzle.CheckPuzzleSolved();
            }
        }

        Debug.Log(ppCount);

        return false;
    }

    public void OnDropIntoCave()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_DropEnterCave;
    }

    public void OnWakeUp()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_WakeUp;
    }

    public void OnStand()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_Stand;
    }

    public void StartCaveStage1Puzzle()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_WhenPuzzle;
    }

    public void StartCaveStage2Narrow()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage2_Narrow;
    }

    public void StartAfterWaterFall()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage2_AfterWaterfall;
    }

    public void OnEnterLastCave()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage2_After3DPlatformJumpNarrow;
    }

    public void OnLeaveLastCave()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_CameOutFromCave;
    }

    public void OnStart3DPlatformer()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage2_When3DPlatformJump;
    }

    public void OnEnterSolvingZone()
    {
        if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.PlatformStage3_SideStepStonesSolved)
        {
            GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_EnterSolvingLastPuzzleZone;
        }
    }

    public void OnLeaveSolvingZone()
    {
        if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.PlatformStage3_EnterSolvingLastPuzzleZone)
        {
            GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_SideStepStonesSolved;
        }
    }

    public void OnEnterSolvingZoneTooEarly()
    {
        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowHint(PlayingPanel.Hints.ReviveFailure);
    }

    public void OnSolvePuzzleC()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_SolvingPuzzleC;
    }
}