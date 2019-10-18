using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    private void Start()
    {
        AudioManager.Instance.BGMFadeIn("bgm/Stream");
    }

    public void StartPuzzleA()
    {
        Manager.Instance.Raft.IsMoving = false;
    }

    void Update()
    {
        RayCastPuzzleSolve();
    }

    public bool RayCastPuzzleSolve()
    {
        Ray ray = Manager.Instance.MainCamera.ScreenPointToRay(Input.mousePosition);

        RaycastHit[] hits = Physics.RaycastAll(ray, 500f, Manager.Instance.PuzzleLayer);
        if (hits.Length != 0)
        {
            HashSet<Puzzle> triedPuzzle = new HashSet<Puzzle>();
            int ppCount = 0;
            foreach (RaycastHit hit in hits)
            {
                PuzzlePart pp = hit.collider.gameObject.GetComponent<PuzzlePart>();
                if (pp != null)
                {
                    pp.ParrentPuzzle.PuzzleHits[pp.ParrentPuzzle.PuzzleParts.IndexOf(pp)] = true;
                    triedPuzzle.Add(pp.ParrentPuzzle);
                    ppCount++;
                }
            }

            Debug.Log("Cast" + ppCount);

            foreach (Puzzle puzzle in triedPuzzle)
            {
                puzzle.CheckPuzzleSolved();
            }
        }

        return false;
    }
}