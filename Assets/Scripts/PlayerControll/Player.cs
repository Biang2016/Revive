﻿using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    public Camera MyCamera;
    public AutoMove AutoMove;
    public Controller Controller;

    void Update()
    {
        if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.CaveStage1_WhenPuzzle)
        {
            RayCastPuzzleSolve();
        }

        if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.None)
        {
            RayCastPuzzleSolve();
        }
    }

    public bool RayCastPuzzleSolve()
    {
        Ray ray = GameManager.Instance.MainCamera.ScreenPointToRay(Input.mousePosition);

        RaycastHit[] hits = Physics.RaycastAll(ray, 500f, GameManager.Instance.PuzzleLayer);
        if (hits.Length != 0)
        {
            HashSet<Puzzle> triedPuzzle = new HashSet<Puzzle>();
            int ppCount = 0;
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

        return false;
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
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage2_Before3DPlatformJump;
    }
}