using System.Collections;
using UnityEngine;

public class StartMenuPanel : BaseUIForm
{
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
    }

    public void OnLeaveRevive()
    {
    }

    public void OnStartButtonClick()
    {
        StartCoroutine(Co_StartButtonClick());
    }

    IEnumerator Co_StartButtonClick()
    {
        GameManager.Instance.CurTravelProcess = GameManager.TravelProcess.CaveStage1_DropDown;
        yield return new WaitForSeconds(1f);
    }

    public void OnQuitButtonClick()
    {
        Application.Quit();
    }
}