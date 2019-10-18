using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Puzzle : MonoBehaviour
{
    internal List<PuzzlePart> PuzzleParts;
    internal bool[] PuzzleHits;
    public bool IsSolved = false;

    void Start()
    {
        PuzzleParts = new List<PuzzlePart>();
        for (int i = 0; i < transform.childCount; i++)
        {
            PuzzlePart pp = transform.GetChild(i).GetComponent<PuzzlePart>();
            if (pp) PuzzleParts.Add(pp);
        }

        PuzzleHits = new bool[PuzzleParts.Count];
    }

    public void ResetPuzzle()
    {
        for (int i = 0; i < PuzzleHits.Length; i++)
        {
            PuzzleHits[i] = false;
        }
    }

    public void CheckPuzzleSolved()
    {
        if (IsSolved) return;
        bool solve = true;
        for (int i = 0; i < PuzzleHits.Length; i++)
        {
            solve &= PuzzleHits[i];
        }

        if (solve) SolvePuzzle();
        else
        {
            ResetPuzzle();
        }
    }

    public void SolvePuzzle()
    {
        IsSolved = true;
        Debug.Log("PuzzleSolved+++++++++++++++++++++++++");
        foreach (PuzzlePart pp in PuzzleParts)
        {
            pp.gameObject.SetActive(false);
        }
    }

    #region PuzzleAutoGenerate

    public float DistanceFromViewPoint = 100f;
    public BoxCollider CheckPointBoxCollider;

    void Update()
    {
        RefreshPuzzlePlacePosition();
    }

    public void RefreshPuzzlePlacePosition()
    {
        foreach (PuzzlePart pp in PuzzleParts)
        {
            float distance = DistanceFromViewPoint * pp.SizeRatio;
            pp.transform.localPosition = new Vector3(pp.transform.localPosition.x, pp.transform.localPosition.y, distance);
            pp.transform.localScale = pp.SizeRatio * Vector3.one;
        }

        CheckPointBoxCollider.transform.localPosition = Vector3.zero;
    }

    #endregion
}