using DG.Tweening;
using UnityEngine;

public class MoveStep : MonoBehaviour
{
    public float TransitDuration;
    public Ease MoveEase = Ease.Linear;
    public Ease RotateEase = Ease.Linear;
    public bool NeedShakePosition;
    public Ease ShakePosEase = Ease.Linear;
    public float ShakePos_Duration;
    public float ShakePos_Strength;
    public int ShakePos_Vibration;
    public bool NeedShakeRotation;
    public Ease ShakeRotateEase = Ease.Linear;
    public float ShakeRotate_Duration;
    public float ShakeRotate_Strength;
    public int ShakeRotate_Vibration;
}