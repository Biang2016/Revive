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

    void Awake()
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
        StartCoroutine(Co_Return(LeftPuzzleParts, 3f, true));
        PuzzleCLeftReturn = true;
    }

    IEnumerator Co_Return(List<PuzzlePart> pps, float duration, bool isLeft)
    {
        GameManager.Instance.Player.MyCamera.enabled = false;
        GameManager.Instance.StartSceneCameraCarrier.gameObject.SetActive(true);
        GameManager.Instance.StartSceneCameraCarrier.Controller.MyController.enabled = false;
        GameManager.Instance.StartSceneCameraCarrier.Controller.MyMouseLooker.enabled = false;
        GameManager.Instance.Player.Controller.MyMouseLooker.enabled = false;
        GameManager.Instance.Player.Controller.MyController.enabled = false;
        GameManager.Instance.Player.Controller.enabled = false;
        CameraRecordingManager.Instance.PlayRecording(isLeft ? CameraRecordingManager.RecordingTypes.LeftStoneMoving : CameraRecordingManager.RecordingTypes.RightStoneMoving, false);

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

        GameManager.Instance.Player.MyCamera.enabled = true;
        GameManager.Instance.StartSceneCameraCarrier.Controller.MyController.enabled = true;
        GameManager.Instance.StartSceneCameraCarrier.Controller.MyMouseLooker.enabled = true;
        GameManager.Instance.StartSceneCameraCarrier.gameObject.SetActive(false);
        GameManager.Instance.Player.Controller.MyMouseLooker.enabled = true;
        GameManager.Instance.Player.Controller.MyController.enabled = true;
        GameManager.Instance.Player.Controller.enabled = true;
    }

    /// <summary>
    /// Only used in PuzzleC
    /// </summary>
    public void PuzzlePartXYPositionReturn_Right()
    {
        StartCoroutine(Co_Return(RightPuzzleParts, 3f, false));
        PuzzleCRightReturn = true;
    }

    /// <summary>
    /// Only used in PuzzleC
    /// </summary>
    public void HideAllFragmentOfPuzzleC()
    {
        foreach (PuzzlePart part in PuzzleParts)
        {
            part.gameObject.SetActive(false);
        }

        PuzzleParts[0].gameObject.SetActive(true);
    }

    /// <summary>
    /// Only used in PuzzleC
    /// </summary>
    public void ShowAllFragmentOfPuzzleC()
    {
        foreach (PuzzlePart part in PuzzleParts)
        {
            part.gameObject.SetActive(true);
        }
    }

    /// <summary>
    /// Only used in PuzzleC
    /// </summary>
    public void ReturnAllPuzzlePartToFarthestPlaceAndMerge(float duration)
    {
        StartCoroutine(Co_MergePuzzle(duration));
    }

    IEnumerator Co_MergePuzzle(float duration)
    {
        int steps = 60;
        for (int i = 0; i < steps; i++)
        {
            foreach (PuzzlePart part in PuzzleParts)
            {
                part.SizeRatio += (PuzzleParts[0].SizeRatio - part.SizeRatio) / (60f - i);
            }

            yield return new WaitForSeconds(duration / steps);
        }
    }
}