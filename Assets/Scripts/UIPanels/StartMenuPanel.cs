using System.Collections;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

public class StartMenuPanel : BaseUIForm
{
    [SerializeField] private Image StopAnyInteraction;
    [SerializeField] private Image WhiteScreenImage;
    [SerializeField] private Animator StartMenuAnim;
    void Awake()
    {
        UIType.IsClearStack = true;
        UIType.IsClickElsewhereClose = false;
        UIType.IsESCClose = false;
        UIType.UIForm_LucencyType = UIFormLucencyTypes.ImPenetrable;
        UIType.UIForms_ShowMode = UIFormShowModes.Normal;
        UIType.UIForms_Type = UIFormTypes.Normal;
    }

    void Start()
    {
    }

    void Update()
    {
    }

    public void OnHoverRevive()
    {
        WorldTreeRevivingManager.Instance.SetAnimSpeedOfStartScene(0.4f);
    }

    public void OnLeaveRevive()
    {
        WorldTreeRevivingManager.Instance.SetAnimSpeedOfStartScene(0.2f);
    }

    public void OnHoverQuit()
    {
        WorldTreeRevivingManager.Instance.SetAnimSpeedOfStartScene(0.1f);
    }

    public void OnLeaveQuit()
    {
        WorldTreeRevivingManager.Instance.SetAnimSpeedOfStartScene(0.2f);
    }

    public void OnStartButtonClick()
    {
        AudioManager.Instance.SoundPlay("sfx/tombstone_sound");
        StartCoroutine(Co_StartButtonClick());
    }

    IEnumerator Co_StartButtonClick()
    {
        StopAnyInteraction.enabled = true;
        yield return new WaitForSeconds(0.3f);
        WorldTreeRevivingManager.Instance.Cur_TreeState = WorldTreeRevivingManager.TreeStates.Died;
        AudioManager.Instance.SoundPlay("sfx/ColdWind");
        yield return new WaitForSeconds(2f);
        StartMenuAnim.SetTrigger("FlyAway");
        yield return new WaitForSeconds(2f);
        WhiteScreenImage.DOFade(1f, 0.3f);
        yield return new WaitForSeconds(0.3f);
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_DropDown;
        WhiteScreenImage.DOFade(0f, 0.3f);
    }

    public void OnQuitButtonClick()
    {
        AudioManager.Instance.SoundPlay("sfx/tombstone_sound");
        Application.Quit();
    }
}