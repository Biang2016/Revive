using System.Collections;
using DG.Tweening;
using UnityEngine;

public class AutoMove : MonoBehaviour
{
    [SerializeField] private Transform EyeCameraFrame;
    internal MoveStep[] MoveSteps;
    [SerializeField] private Transform MoveStepContainer;
    [SerializeField] private Transform TranslateTrans;
    [SerializeField] private Transform RotateTrans;

    internal void AutoMoveStart()
    {
        MoveSteps = new MoveStep[MoveStepContainer.childCount];
        for (int i = 0; i < MoveStepContainer.childCount; i++)
        {
            MoveSteps[i] = MoveStepContainer.GetChild(i).GetComponent<MoveStep>();
        }

        StartCoroutine(Co_StartMove());
    }

    public bool IsMoving = true;
    private int CurrentStep = 0;

    IEnumerator Co_StartMove()
    {
        RotateTrans.rotation = MoveSteps[CurrentStep].transform.rotation;
        TranslateTrans.position = MoveSteps[CurrentStep].transform.position;
        yield return new WaitForSeconds(MoveSteps[CurrentStep].TransitDuration / GameManager.Instance.AutoMoveSpeedUpFactor);
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
                EyeCameraFrame.transform.DOShakePosition(ms.ShakePos_Duration / GameManager.Instance.AutoMoveSpeedUpFactor, ms.ShakePos_Strength, ms.ShakePos_Vibration, fadeOut: false).SetEase(ms.ShakePosEase);
            }

            if (ms.NeedShakeRotation)
            {
                EyeCameraFrame.transform.DOShakeRotation(ms.ShakeRotate_Duration / GameManager.Instance.AutoMoveSpeedUpFactor, ms.ShakeRotate_Strength, ms.ShakeRotate_Vibration, fadeOut: false).SetEase(ms.ShakeRotateEase);
            }
        }

        RotateTrans.DORotate(ms.transform.rotation.eulerAngles, ms.TransitDuration / GameManager.Instance.AutoMoveSpeedUpFactor).SetEase(ms.RotateEase);
        TranslateTrans.DOMove(ms.transform.position, ms.TransitDuration / GameManager.Instance.AutoMoveSpeedUpFactor).SetEase(ms.MoveEase);
        yield return new WaitForSeconds(ms.TransitDuration / GameManager.Instance.AutoMoveSpeedUpFactor);
        transform.DOPause();
        ms.NextEvent?.Invoke();
    }
}