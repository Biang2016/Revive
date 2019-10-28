using System;
using System.Collections.Generic;
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
            {Hints.ReviveFailure, Sprite_HintReviveFailure},
            {Hints.FinalFly, Sprite_HintFinalFly},
        };
    }

    [SerializeField] private Animator HintImageAnim;
    [SerializeField] private Image HintImage;
    [SerializeField] private Image PatternAImage;
    [SerializeField] private Image PatternCImage;
    [SerializeField] private Image RestartImage;

    [SerializeField] private Sprite Sprite_HintStart;
    [SerializeField] private Sprite Sprite_HintPuzzleAMove;
    [SerializeField] private Sprite Sprite_HintCanJump;
    [SerializeField] private Sprite Sprite_HintDeadRoadTombStone;
    [SerializeField] private Sprite Sprite_HintWaterfallTombStone;
    [SerializeField] private Sprite Sprite_Hint3DPlatformerTombStone;
    [SerializeField] private Sprite Sprite_Hint3DPlatformerFailure;
    [SerializeField] private Sprite Sprite_HintReviveFailure;
    [SerializeField] private Sprite Sprite_HintFinalFly;

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
            HintImage.enabled = true;
            HintImage.sprite = HintSpriteDict[hint];
            HintImageAnim.SetTrigger("Show");
        }
    }

    public enum Hints
    {
        None,
        Start,
        PuzzleAMove,
        CanJump,
        DeadRoadTombStone,
        WaterfallTombStone,
        _3DPlatformerTombStone,
        _3DPlatformerFailure,
        ReviveFailure,
        FinalFly
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
    }

    [SerializeField] private Text TimerText;
    public bool IsFinalMusicStart = false;
    private float TimerTick = 0f;

    void Update()
    {
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
    }
}