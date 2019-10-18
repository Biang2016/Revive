using System.Collections;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Events;

public class AutoMove : MonoBehaviour
{
    [SerializeField] private Transform EyeCameraFrame;
    internal MoveStep[] MoveSteps;
    [SerializeField] private Transform MoveStepContainer;

    void Start()
    {
        if (!Manager.Instance.TravelViewMode)
        {
            MoveSteps = new MoveStep[MoveStepContainer.childCount];
            for (int i = 0; i < MoveStepContainer.childCount; i++)
            {
                MoveSteps[i] = MoveStepContainer.GetChild(i).GetComponent<MoveStep>();
            }

            StartCoroutine(Co_StartMove());
        }
    }

    public bool IsMoving = true;
    private int CurrentStep = 0;

    IEnumerator Co_StartMove()
    {
        transform.rotation = MoveSteps[CurrentStep].transform.rotation;
        transform.position = MoveSteps[CurrentStep].transform.position;
        yield return new WaitForSeconds(MoveSteps[CurrentStep].TransitDuration);
        CurrentStep++;
        while (CurrentStep < MoveSteps.Length)
        {
            while (!IsMoving)
            {
                yield return null;
            }

            yield return Co_ExecuteStep();
            CurrentStep++;
        }

        OnComplete?.Invoke();
    }

    IEnumerator Co_ExecuteStep()
    {
        MoveStep ms = MoveSteps[CurrentStep];
        if (ms == null)
        {
            yield return null;
        }

        if (EyeCameraFrame)
        {
            if (ms.NeedShakePosition)
            {
                EyeCameraFrame.transform.DOShakePosition(ms.ShakePos_Duration, ms.ShakePos_Strength, ms.ShakePos_Vibration, fadeOut: false).SetEase(ms.ShakePosEase);
            }

            if (ms.NeedShakeRotation)
            {
                EyeCameraFrame.transform.DOShakeRotation(ms.ShakeRotate_Duration, ms.ShakeRotate_Strength, ms.ShakeRotate_Vibration, fadeOut: false).SetEase(ms.ShakeRotateEase);
            }
        }

        transform.DORotate(ms.transform.rotation.eulerAngles, ms.TransitDuration).SetEase(ms.RotateEase);
        transform.DOMove(ms.transform.position, ms.TransitDuration).SetEase(ms.MoveEase);
        yield return new WaitForSeconds(ms.TransitDuration);
        ms.NextEvent?.Invoke();
    }

    public UnityEvent OnComplete;
}