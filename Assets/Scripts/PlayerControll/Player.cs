using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
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

    public void StartCaveStage1Puzzle()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_WhenPuzzle;
    }

    public void StartCaveStage3Puzzle()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_WhenPuzzle;
    }
}