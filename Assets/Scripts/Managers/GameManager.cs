using System.Collections;
using System.Collections.Generic;
using System.Media;
using UnityEngine;
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

        if (Input.GetKeyUp(KeyCode.F10))
        {
            if (!RecordingStartSceneCameraPath)
            {
                CameraRecordingManager.Instance.PlayRecording();
            }
        }

        if (Input.GetKeyUp(KeyCode.F11))
        {
            if (!CameraRecordingManager.Instance.IsPlayingRecord)
            {
                RecordingStartSceneCameraPath = true;
            }
        }

        if (Input.GetKeyUp(KeyCode.F12))
        {
            if (!CameraRecordingManager.Instance.IsPlayingRecord)
            {
                RecordingStartSceneCameraPath = false;
                CameraRecordingManager.Instance.SaveRecord();
            }
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
        CaveStage1_DropDown,
        CaveStage1_DropEnterCave,
        CaveStage1_WakeUp,
        CaveStage1_Stand,
        CaveStage1_BeforePuzzle,
        CaveStage1_WhenPuzzle,
        CaveStage1_PuzzleSolveAnimation,
        CaveStage1_AfterPuzzle,
        CaveStage2_Narrow,
        CaveStage2_OpenPlaceBeforeWaterfall,
        CaveStage2_AfterWaterfall,
        CaveStage2_Before3DPlatformJump,
        CaveStage2_When3DPlatformJump,
        CaveStage2_After3DPlatformJumpNarrow,
        PlatformStage3_CameOutFromCave,
        PlatformStage3_UnlockFirstPuzzle,
        PlatformStage3_UnlockSecondPuzzle,
        PlatformStage3_SolvingLastPuzzle,
        PlatformStage3_RevivingTree,
        PlatformStage3_TreeRevived,
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
                Raft.gameObject.SetActive(false);
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
                        break;
                    }
                    case TravelProcess.StartScene:
                    {
                        // start UI
                        break;
                    }
                    case TravelProcess.CaveStage1_DropDown:
                    {
                        StartSceneCameraCarrier.gameObject.SetActive(false);
                        Raft.gameObject.SetActive(true);

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

                        //click UI start button enter this phase
                        // start drop down sound
                        break;
                    }
                    case TravelProcess.CaveStage1_DropEnterCave:
                    {
                        // start black
                        break;
                    }
                    case TravelProcess.CaveStage1_WakeUp:
                    {
                        AudioManager.Instance.SoundPlay("sfx/Cave1Mixed", 1f);
                        break;
                    }
                    case TravelProcess.CaveStage1_Stand:
                    {
                        Player.Controller.enabled = true;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.MyMouseLooker.enabled = true;
                        Player.Controller.CapsuleCollider.enabled = true;
                        AudioManager.Instance.BGMFadeIn("bgm/bgm_stage1", 10f, 1f, true);
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
                        Player.Controller.MyController.enabled = true;
                        Player.Controller.CapsuleCollider.enabled = false;
                        Player.Controller.MoveSpeed = 10f;
                        Player.Controller.default_MoveSpeed = 10f;
                        Player.Controller.MyMouseLooker.XSensitivity = 2f;
                        Player.Controller.MyMouseLooker.YSensitivity = 2f;

                        Player.Controller.SetAllowJump();
                        Player.Controller.SetColliderRadiusOnLand();

                        Player.transform.SetParent(SurroundingRoot);
                        Raft.gameObject.SetActive(false);
                        AudioManager.Instance.SoundStop("sfx/Cave1Mixed");
                        break;
                    }
                    case TravelProcess.CaveStage2_OpenPlaceBeforeWaterfall:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage2_AfterWaterfall:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage2_Before3DPlatformJump:
                    {
                        Platformer3D.ShowFirst();
                        break;
                    }
                    case TravelProcess.CaveStage2_When3DPlatformJump:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage2_After3DPlatformJumpNarrow:
                    {
                        AudioManager.Instance.BGMFadeIn("bgm/WhisperStage2", 3f, 1f);
                        break;
                    }
                }
            }

            curTravelProcess = value;
        }
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