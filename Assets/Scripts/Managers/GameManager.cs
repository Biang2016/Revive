using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityStandardAssets.ImageEffects;

public class GameManager : MonoSingleton<GameManager>
{
    internal int PuzzleLayer;
    internal int TerrainLayer;
    internal int PlayerLayer;
    public float AutoMoveSpeedUpFactor = 1.0f;

    void Awake()
    {
        RenderSettings.fog = true;
        PuzzleLayer = 1 << LayerMask.NameToLayer("Puzzle");
        TerrainLayer = 1 << LayerMask.NameToLayer("Terrain");
        PlayerLayer = 1 << LayerMask.NameToLayer("Player");
    }

    void Update()
    {
#if UNITY_EDITOR
        if (Input.GetKeyUp(KeyCode.O))
        {
            RenderSettings.fog = !RenderSettings.fog;
        }

        if (Input.GetKeyUp(KeyCode.K))
        {
            Player.Controller.MyMouseLooker.enabled = !Player.Controller.MyMouseLooker.enabled;
            StartSceneCameraCarrier.Controller.MyMouseLooker.enabled = !StartSceneCameraCarrier.Controller.MyMouseLooker.enabled;
        }

        if (Input.GetKeyUp(KeyCode.P))
        {
            Player.Controller.SuperManMode = !Player.Controller.SuperManMode;
            StartSceneCameraCarrier.Controller.SuperManMode = !StartSceneCameraCarrier.Controller.SuperManMode;
        }
#endif

        if (Input.GetKeyUp(KeyCode.Space) && CurTravelProcess == TravelProcess.PlatformStage3_TreeRevived)
        {
            if (!Player.Controller.SuperManMode)
            {
                Player.Controller.SuperManMode = true;
                Physics.IgnoreLayerCollision(LayerMask.NameToLayer("Player"), LayerMask.NameToLayer("Airwall"), true);
                UIManager.Instance.ShowUIForms<PlayingPanel>().ShowHint(PlayingPanel.Hints.FinalDive);
            }
        }

        if (Input.GetKey(KeyCode.Equals))
        {
            SupermanSpeed *= 1.01f;
        }

        if (Input.GetKey(KeyCode.Minus))
        {
            SupermanSpeed /= 1.01f;
        }

        if (Input.GetAxis("Mouse ScrollWheel") > 0)
        {
            SupermanSpeed *= 1.1f;
        }

        if (Input.GetAxis("Mouse ScrollWheel") < 0)
        {
            SupermanSpeed /= 1.1f;
        }

        if (CurTravelProcess == TravelProcess.None && Input.GetKeyUp(KeyCode.CapsLock))
        {
            if (!CameraRecordingManager.Instance.IsPlayingRecord)
            {
                if (RecordingStartSceneCameraPath)
                {
                    RecordingStartSceneCameraPath = false;
                    CameraRecordingManager.Instance.SaveRecord();
                }
                else
                {
                    AudioManager.Instance.BGMFadeOut(1f);
                    AudioManager.Instance.BGMFadeIn("bgm/bgm_final", 1f, 1f, false);
                    RecordingStartSceneCameraPath = true;
                }
            }
        }

        if (Input.GetKey(KeyCode.R) && CurTravelProcess == TravelProcess.PlatformStage3_TreeRevived)
        {
            SceneManager.LoadScene("MainScene");
        }

        if (Input.GetKey(KeyCode.F10))
        {
            SceneManager.LoadScene("MainScene");
        }
    }

    public bool RecordingStartSceneCameraPath = false;

    public Camera MainCamera;
    public BloomOptimized MainCameraBloom;
    public Animator MainCameraAnimator;
    public Camera StartSceneCamera;
    public Raft Raft;
    public Player Player;
    public StartSceneCameraCarrier StartSceneCameraCarrier;
    public Cave1WaterStone Cave1WaterStone;
    public Transform SurroundingRoot;
    public Platformer3D Platformer3D;
    public Puzzle PuzzleA;
    public Puzzle PuzzleC;
    public GameObject ReviveArea;
    public GameObject ReviveAreaTooEarly;

    public float SupermanSpeed = 20f;

    private void Start()
    {
        CurGameState = GameStates.None;
        CurGameState = StartGameState;
        CurTravelProcess = TravelProcess.None;
        CurTravelProcess = StartTravelProcess;
    }

    public enum GameStates
    {
        None = -1,
        StartScene = 0,
        Traveling = 1,
        Pause = 2,
        GameComplete = 3,
    }

    [SerializeField] private GameStates StartGameState = GameStates.None;
    [SerializeField] private GameStates curGameState = GameStates.None;

    public GameStates CurGameState
    {
        get => curGameState;
        set
        {
            if (value != curGameState)
            {
                switch (value)
                {
                }

                curGameState = value;
            }
        }
    }

    public enum TravelProcess
    {
        None = -1,
        StartScene = 0,
        CaveStage1_DropDown = 1,
        CaveStage1_DropEnterCave = 2,
        CaveStage1_WakeUp = 3,
        CaveStage1_Stand = 4,
        CaveStage1_BeforePuzzle = 5,
        CaveStage1_WhenPuzzle = 6,
        CaveStage1_PuzzleSolveAnimation = 7,
        CaveStage1_AfterPuzzle = 8,
        CaveStage2_Narrow = 9,
        CaveStage2_OpenPlaceBeforeWaterfall = 10,
        CaveStage2_AfterWaterfall = 11,
        CaveStage2_Before3DPlatformJump = 12,
        CaveStage2_When3DPlatformJump = 13,
        CaveStage2_After3DPlatformJumpNarrow = 14,
        PlatformStage3_CameOutFromCave = 15,
        PlatformStage3_SideStepStonesSolved = 16,
        PlatformStage3_EnterSolvingLastPuzzleZone = 17,
        PlatformStage3_SolvingPuzzleC = 18,
        PlatformStage3_RevivingTree = 19,
        PlatformStage3_TreeRevived = 20,
    }

    [SerializeField] private TravelProcess StartTravelProcess = TravelProcess.None;
    [SerializeField] private TravelProcess curTravelProcess = TravelProcess.None;

    public TravelProcess CurTravelProcess
    {
        get => curTravelProcess;
        set
        {
            if (value == TravelProcess.None)
            {
                StartSceneCameraCarrier.Controller.SuperManMode = false;
                StartSceneCameraCarrier.Controller.SuperManMode = true;
                StartSceneCameraCarrier.gameObject.SetActive(true);
                Player.gameObject.SetActive(false);
                UIManager.Instance.ShowUIForms<EditorPanel>();
            }
            else
            {
                UIManager.Instance.CloseUIForm<EditorPanel>();
            }

            if (value != curTravelProcess)
            {
                switch (value)
                {
                    case TravelProcess.None:
                    {
                        WorldTreeRevivingManager.Instance.Cur_TreeState = WorldTreeRevivingManager.TreeStates.StartSceneRotateSlow;
                        break;
                    }
                    case TravelProcess.StartScene:
                    {
                        WorldTreeRevivingManager.Instance.Cur_TreeState = WorldTreeRevivingManager.TreeStates.StartSceneRotateSlow;
                        PuzzleC.HideAllFragmentOfPuzzleC();
                        AudioManager.Instance.BGMFadeIn("bgm/bgm_stage1", 1f, 1, true);
                        UIManager.Instance.ShowUIForms<StartMenuPanel>();
                        CameraRecordingManager.Instance.PlayRecording(CameraRecordingManager.RecordingTypes.StartSceneRecording, false);
                        StartSceneCameraCarrier.gameObject.SetActive(true);
                        Player.gameObject.SetActive(false);
                        StartSceneCameraCarrier.Controller.enabled = false;
                        StartSceneCameraCarrier.Controller.MyController.enabled = false;
                        StartSceneCameraCarrier.Controller.MyMouseLooker.enabled = false;
                        break;
                    }
                    case TravelProcess.CaveStage1_DropDown:
                    {
                        AudioManager.Instance.BGMFadeOut(0.5f);
                        UIManager.Instance.CloseUIForm<StartMenuPanel>();
                        PuzzleC.ShowAllFragmentOfPuzzleC();
                        AudioManager.Instance.SoundPlay("sfx/sound_wind");
                        StartSceneCameraCarrier.gameObject.SetActive(false);
                        Player.gameObject.SetActive(true);

                        Player.AutoMove.AutoMoveStart();
                        Raft.AutoMove.AutoMoveStart();
                        Player.Controller.SetColliderRadiusOnRaft();
                        Player.Controller.MoveSpeed = 3f;
                        Player.Controller.default_MoveSpeed = 3f;
                        Player.Controller.MyMouseLooker.XSensitivity = 2f;
                        Player.Controller.MyMouseLooker.YSensitivity = 2f;

                        Player.Controller.AllowJump = false;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.MyMouseLooker.enabled = false;
                        Player.Controller.CapsuleCollider.enabled = true;
                        break;
                    }
                    case TravelProcess.CaveStage1_DropEnterCave:
                    {
                        AudioManager.Instance.SoundStop("sound_wind");
                        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowBlackScreen();
                        break;
                    }
                    case TravelProcess.CaveStage1_WakeUp:
                    {
                        AudioManager.Instance.SoundPlay("sfx/Cave1Mixed", 1f);
                        UIManager.Instance.ShowUIForms<PlayingPanel>().HideBlackScreen();
                        break;
                    }
                    case TravelProcess.CaveStage1_Stand:
                    {
                        Player.Controller.enabled = true;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.MyMouseLooker.enabled = true;
                        Player.Controller.CapsuleCollider.enabled = true;
                        AudioManager.Instance.BGMFadeIn("bgm/bgm_stage1", 10f, 1f, true);
                        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowHint(PlayingPanel.Hints.Start);
                        break;
                    }
                    case TravelProcess.CaveStage1_BeforePuzzle:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage1_WhenPuzzle:
                    {
                        Player.Controller.MoveSpeed = 3f;
                        Player.Controller.default_MoveSpeed = 3f;
                        Player.Controller.MyMouseLooker.XSensitivity = 0.5f;
                        Player.Controller.MyMouseLooker.YSensitivity = 0.5f;
                        Raft.AutoMove.IsMoving = false;
                        Player.Controller.MyController.enabled = true;
                        Player.Controller.CapsuleCollider.enabled = false;
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().ShowPuzzleAPattern();
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().ShowHint(PlayingPanel.Hints.PuzzleAMove);
                        break;
                    }
                    case TravelProcess.CaveStage1_PuzzleSolveAnimation:
                    {
                        MainCameraAnimator.SetTrigger("PuzzleASolved");
                        AudioManager.Instance.SoundPlay("sfx/puzzle1");
                        StartCoroutine(Co_PuzzleASolved());
                        Cave1WaterStone.PuzzleSolved();
                        Player.Controller.MyMouseLooker.enabled = false;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.CapsuleCollider.enabled = true;
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().HidePuzzleAPattern();
                        break;
                    }
                    case TravelProcess.CaveStage1_AfterPuzzle:
                    {
                        Player.Controller.MyMouseLooker.XSensitivity = 2f;
                        Player.Controller.MyMouseLooker.YSensitivity = 2f;
                        Player.Controller.MyMouseLooker.enabled = true;
                        Raft.AutoMove.IsMoving = true;
                        break;
                    }
                    case TravelProcess.CaveStage2_Narrow:
                    {
                        Input.ResetInputAxes();
                        Player.Controller.MyController.enabled = true;
                        Player.Controller.CapsuleCollider.enabled = false;
                        Player.Controller.MoveSpeed = 10f;
                        Player.Controller.default_MoveSpeed = 10f;
                        Player.Controller.MyMouseLooker.XSensitivity = 2f;
                        Player.Controller.MyMouseLooker.YSensitivity = 2f;

                        Player.Controller.SetAllowJump();
                        Player.Controller.SetColliderRadiusOnLand();

                        Player.transform.SetParent(SurroundingRoot);
                        Raft.AutoMove.IsMoving = false;
                        Raft.gameObject.SetActive(false);
                        AudioManager.Instance.SoundStop("Cave1Mixed");
                        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowHint(PlayingPanel.Hints.CanJump);
                        break;
                    }
                    case TravelProcess.CaveStage2_OpenPlaceBeforeWaterfall:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage2_AfterWaterfall:
                    {
                        AudioManager.Instance.SoundPlay("sfx/WaterDrop");
                        break;
                    }
                    case TravelProcess.CaveStage2_Before3DPlatformJump:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage2_When3DPlatformJump:
                    {
                        AudioManager.Instance.SoundStop("WaterDrop");
                        Platformer3D.ShowFirst();
                        break;
                    }
                    case TravelProcess.CaveStage2_After3DPlatformJumpNarrow:
                    {
                        break;
                    }
                    case TravelProcess.PlatformStage3_CameOutFromCave:
                    {
                        AudioManager.Instance.BGMFadeIn("bgm/bgm_SeeTheTree", 2f, 1f, true);
                        break;
                    }
                    case TravelProcess.PlatformStage3_SideStepStonesSolved:
                    {
                        Player.Controller.MoveSpeed = 10f;
                        Player.Controller.default_MoveSpeed = 10f;
                        Player.Controller.MyMouseLooker.XSensitivity = 2f;
                        Player.Controller.MyMouseLooker.YSensitivity = 2f;
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().HidePuzzleCPattern();
                        break;
                    }
                    case TravelProcess.PlatformStage3_EnterSolvingLastPuzzleZone:
                    {
                        Player.Controller.MoveSpeed = 3f;
                        Player.Controller.default_MoveSpeed = 3f;
                        Player.Controller.MyMouseLooker.XSensitivity = 0.5f;
                        Player.Controller.MyMouseLooker.YSensitivity = 0.5f;
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().ShowPuzzleCPattern();
                        break;
                    }
                    case TravelProcess.PlatformStage3_SolvingPuzzleC:
                    {
                        MainCameraAnimator.SetTrigger("PuzzleASolved");
                        AudioManager.Instance.SoundPlay("sfx/puzzle1");
                        Player.Controller.MyMouseLooker.enabled = false;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.enabled = false;
                        WorldTreeRevivingManager.Instance.Cur_TreeState = WorldTreeRevivingManager.TreeStates.SolvingStonePuzzle;
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().HidePuzzleCPattern();
                        break;
                    }
                    case TravelProcess.PlatformStage3_RevivingTree:
                    {
                        WorldTreeRevivingManager.Instance.Cur_TreeState = WorldTreeRevivingManager.TreeStates.Reviving_Stage;
                        AudioManager.Instance.BGMFadeIn("bgm/bgm_final", 2f, 1f, true);
                        UIManager.Instance.GetBaseUIForm<PlayingPanel>().IsFinalMusicStart = true;
                        Player.MyCamera.enabled = false;
                        StartSceneCameraCarrier.gameObject.SetActive(true);
                        StartSceneCameraCarrier.Controller.MyController.enabled = false;
                        StartSceneCameraCarrier.Controller.MyMouseLooker.enabled = false;
                        Player.Controller.MyMouseLooker.enabled = false;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.enabled = false;
                        CameraRecordingManager.Instance.PlayRecording(CameraRecordingManager.RecordingTypes.Reviving, true, delegate
                        {
                            Player.MyCamera.enabled = true;
                            StartSceneCameraCarrier.gameObject.SetActive(false);
                            StartSceneCameraCarrier.Controller.MyController.enabled = false;
                            StartSceneCameraCarrier.Controller.MyMouseLooker.enabled = false;
                            Player.Controller.MyMouseLooker.enabled = true;
                            Player.Controller.MyController.enabled = true;
                            Player.Controller.enabled = true;
                            ReviveArea.SetActive(false);
                            ReviveAreaTooEarly.SetActive(false);
                            Player.Controller.MoveSpeed = 10f;
                            Player.Controller.default_MoveSpeed = 10f;
                            Player.Controller.MyMouseLooker.XSensitivity = 2f;
                            Player.Controller.MyMouseLooker.YSensitivity = 2f;
                            CurTravelProcess = TravelProcess.PlatformStage3_TreeRevived;
                        });
                        break;
                    }
                    case TravelProcess.PlatformStage3_TreeRevived:
                    {
                        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowHint(PlayingPanel.Hints.FinalFly);
                        StartCoroutine(Co_ShowRestart());
                        break;
                    }
                }
            }

            curTravelProcess = value;
        }
    }

    IEnumerator Co_ShowRestart()
    {
        yield return new WaitForSeconds(5f);
        UIManager.Instance.ShowUIForms<PlayingPanel>().ShowRestartImage();
    }

    public void PuzzleASolved()
    {
        CurTravelProcess = TravelProcess.CaveStage1_PuzzleSolveAnimation;
    }

    IEnumerator Co_PuzzleASolved()
    {
        yield return new WaitForSeconds(2f);
        CurTravelProcess = TravelProcess.CaveStage1_AfterPuzzle;
    }
}