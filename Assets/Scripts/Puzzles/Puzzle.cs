using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Events;

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

    public bool PlayerEnter = false;

    public void CheckPuzzleSolved()
    {
        if (IsSolved) return;
        if (!PlayerEnter) return;

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
        SolveEvent?.Invoke();
    }

    public UnityEvent SolveEvent;

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

    [SerializeField] private List<PuzzlePart> LeftPuzzleParts = new List<PuzzlePart>();
    [SerializeField] private List<PuzzlePart> RightPuzzleParts = new List<PuzzlePart>();

    private bool PuzzleCAllReturn => PuzzleCLeftReturn && PuzzleCRightReturn;
    private bool PuzzleCLeftReturn = false;
    private bool PuzzleCRightReturn = false;

    /// <summary>
    /// Only used in PuzzleC
    /// </summary>
    public void PuzzlePartXYPositionReturn_Left()
    {
        StartCoroutine(Co_Return(LeftPuzzleParts, 3f));
        PuzzleCLeftReturn = true;
    }

    IEnumerator Co_Return(List<PuzzlePart> pps, float duration)
    {
        foreach (PuzzlePart pp in pps)
        {
            pp.transform.DOLocalMoveX(0, duration);
            pp.transform.DOLocalMoveY(0, duration);
        }

        yield return new WaitForSeconds(duration);

        if (PuzzleCAllReturn)
        {
            GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.PlatformStage3_SideStepStonesSolved;
        }
    }

    /// <summary>
    /// Only used in PuzzleC
    /// </summary>
    public void PuzzlePartXYPositionReturn_Right()
    {
        StartCoroutine(Co_Return(RightPuzzleParts, 3f));
        PuzzleCRightReturn = true;
    }
}