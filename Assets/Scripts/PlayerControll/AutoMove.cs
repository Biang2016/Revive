using System.Collections;
using DG.Tweening;
using UnityEngine;

public class AutoMove : MonoBehaviour
{
    [SerializeField] private Transform EyeCameraFrame;
    internal MoveStep[] MoveSteps;
    [SerializeField] private Transform MoveStepContainer;

    void Start()
    {
        MoveSteps = new MoveStep[MoveStepContainer.childCount];
        for (int i = 0; i < MoveStepContainer.childCount; i++)
        {
            MoveSteps[i] = MoveStepContainer.GetChild(i).GetComponent<MoveStep>();
        }

        StartCoroutine(Co_StartMove());
    }

    IEnumerator Co_StartMove()
    {
        transform.rotation = MoveSteps[0].transform.rotation;
        transform.position = MoveSteps[0].transform.position;
        yield return new WaitForSeconds(MoveSteps[0].TransitDuration);
        for (int i = 1; i < MoveSteps.Length; i++)
        {
            MoveStep ms = MoveSteps[i];
            if (ms == null)
            {
                break;
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
        }
    }
}