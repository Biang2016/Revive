using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

public class PlayingPanel : BaseUIForm
{
    void Awake()
    {
        UIType.IsClearStack = true;
        UIType.IsClickElsewhereClose = false;
        UIType.IsESCClose = false;
        UIType.UIForm_LucencyType = UIFormLucencyTypes.Translucence;
        UIType.UIForms_ShowMode = UIFormShowModes.Normal;
        UIType.UIForms_Type = UIFormTypes.Normal;

        TimerText.enabled = false;
#if UNITY_EDITOR
        TimerText.enabled = true;
#endif
        HintImage.enabled = false;
        PatternAImage.enabled = false;
        PatternCImage.enabled = false;
        RestartImage.gameObject.SetActive(false);

        HintSpriteDict = new Dictionary<Hints, Sprite>
        {
            {Hints.None, null},
            {Hints.Start, Sprite_HintStart},
            {Hints.PuzzleAMove, Sprite_HintPuzzleAMove},
            {Hints.CanJump, Sprite_HintCanJump},
            {Hints.DeadRoadTombStone, Sprite_HintDeadRoadTombStone},
            {Hints.WaterfallTombStone, Sprite_HintWaterfallTombStone},
            {Hints._3DPlatformerTombStone, Sprite_Hint3DPlatformerTombStone},
            {Hints._3DPlatformerFailure, Sprite_Hint3DPlatformerFailure},
            {Hints.After3DPlatformerFailure, Sprite_HintAfter3DPlatformerTombStone},
            {Hints.ReviveFailure, Sprite_HintReviveFailure},
            {Hints.FinalFly, Sprite_HintFinalFly},
            {Hints.FinalDive, Sprite_HintFinalDive},
            {Hints.PlatformLeft, Sprite_HintPlatformLeft},
            {Hints.PlatformRight, Sprite_HintPlatformRight},
        };
    }

    [SerializeField] private Animator HintImageAnim;
    [SerializeField] private Image HintImage;
    [SerializeField] private Image PatternAImage;
    [SerializeField] private Image PatternCImage;
    [SerializeField] private Image RestartImage;
    [SerializeField] private Animator RestartImageAnim;

    [SerializeField] private Sprite Sprite_HintStart;
    [SerializeField] private Sprite Sprite_HintPuzzleAMove;
    [SerializeField] private Sprite Sprite_HintCanJump;
    [SerializeField] private Sprite Sprite_HintDeadRoadTombStone;
    [SerializeField] private Sprite Sprite_HintWaterfallTombStone;
    [SerializeField] private Sprite Sprite_Hint3DPlatformerTombStone;
    [SerializeField] private Sprite Sprite_Hint3DPlatformerFailure;
    [SerializeField] private Sprite Sprite_HintAfter3DPlatformerTombStone;
    [SerializeField] private Sprite Sprite_HintReviveFailure;
    [SerializeField] private Sprite Sprite_HintPlatformLeft;
    [SerializeField] private Sprite Sprite_HintPlatformRight;
    [SerializeField] private Sprite Sprite_HintFinalFly;
    [SerializeField] private Sprite Sprite_HintFinalDive;

    [SerializeField] private Sprite Sprite_PatterPuzzleA;
    [SerializeField] private Sprite Sprite_PatterPuzzleC;

    public void ShowHint(Hints hint)
    {
        if (hint == Hints.None)
        {
            HintImage.enabled = false;
        }
        else
        {
            AudioManager.Instance.SoundPlay("sfx/sound_newHint", 0.7f);
            HintImage.enabled = true;
            HintImage.sprite = HintSpriteDict[hint];
            HintImageAnim.SetTrigger("Show");
        }
    }

    public enum Hints
    {
        None = 0,
        Start = 1,
        PuzzleAMove = 2,
        CanJump = 3,
        DeadRoadTombStone = 4,
        WaterfallTombStone = 5,
        _3DPlatformerTombStone = 6,
        _3DPlatformerFailure = 7,
        After3DPlatformerFailure = 13,
        ReviveFailure = 8,
        FinalFly = 9,
        FinalDive = 10,
        PlatformLeft = 11,
        PlatformRight = 12,
    }

    private Dictionary<Hints, Sprite> HintSpriteDict;

    public void ShowPuzzleAPattern()
    {
        PatternAImage.enabled = true;
    }

    public void HidePuzzleAPattern()
    {
        PatternAImage.enabled = false;
    }

    public void ShowPuzzleCPattern()
    {
        PatternCImage.enabled = true;
    }

    public void HidePuzzleCPattern()
    {
        PatternCImage.enabled = false;
    }

    public void ShowRestartImage()
    {
        RestartImage.gameObject.SetActive(true);
        RestartImageAnim.SetTrigger("Show");
    }

    [SerializeField] private Text TimerText;
    public bool IsFinalMusicStart = false;
    private float TimerTick = 0f;

    void Update()
    {
#if UNITY_EDITOR
        if (IsFinalMusicStart)
        {
            TimerTick += Time.deltaTime;
            TimerText.text = Math.Round(TimerTick, 1).ToString() + "s";
        }
        else
        {
            TimerTick = 0;
            TimerText.text = "";
        }
#endif
    }

    [SerializeField] private Image BlackScree;

    public void ShowBlackScreen()
    {
        BlackScree.DOFade(1, 0.3f);
    }

    public void HideBlackScreen()
    {
        StartCoroutine(Co_HideBlackScreen());
    }

    IEnumerator Co_HideBlackScreen()
    {
        BlackScree.DOFade(0.5f, 2f);
        yield return new WaitForSeconds(2f);
        BlackScree.DOFade(0.75f, 0.5f);
        yield return new WaitForSeconds(0.5f);
        BlackScree.DOFade(0.0f, 0.5f);
        yield return new WaitForSeconds(0.5f);
    }
}