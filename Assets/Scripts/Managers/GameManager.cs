using UnityEngine;

public class GameManager : MonoSingleton<GameManager>
{
    internal int PuzzleLayer;

    void Awake()
    {
        RenderSettings.fog = true;
        PuzzleLayer = 1 << LayerMask.NameToLayer("Puzzle");
        AudioManager.Instance.BGMFadeIn("bgm/WhisperOfHope");
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
    public Camera StartSceneCamera;
    public Raft Raft;
    public Player Player;
    public StartSceneCameraCarrier StartSceneCameraCarrier;

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
        None = 100,
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
        None = 100,
        StartScene = 0,
        CaveStage1_BeforePuzzle = 1,
        CaveStage1_WhenPuzzle = 2,
        CaveStage1_AfterPuzzle = 3,
        CaveStage2_Narrow = 4,
        CaveStage2_OpenPlaceBeforeWaterfall = 5,
        CaveStage2_AfterWaterfall = 6,
        CaveStage2_Before3DPlatformJump = 7,
        CaveStage2_When3DPlatformJump = 8,
        CaveStage2_After3DPlatformJumpNarrow = 9,
        PlatformStage3_CameOutFromCave = 10,
        PlatformStage3_UnlockFirstPuzzle = 11,
        PlatformStage3_UnlockSecondPuzzle = 12,
        PlatformStage3_SolvingLastPuzzle = 13,
        PlatformStage3_RevivingTree = 14,
        PlatformStage3_TreeRevived = 15,
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

                Player.Controller.MyController.enabled = true;
                Player.Controller.MyMouseLooker.enabled = true;
                Player.Controller.SetAllowJump();
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
                        break;
                    }
                    case TravelProcess.CaveStage1_BeforePuzzle:
                    {
                        StartSceneCameraCarrier.gameObject.SetActive(false);
                        Raft.gameObject.SetActive(true);

                        Player.AutoMove.AutoMoveStart();
                        Raft.AutoMove.AutoMoveStart();
                        Player.Controller.SetColliderRadiusOnRaft();
                        Player.Controller.AllowJump = false;
                        Player.Controller.MyController.enabled = false;
                        Player.Controller.MyMouseLooker.enabled = false;
                        break;
                    }
                    case TravelProcess.CaveStage1_WhenPuzzle:
                    {
                        Raft.AutoMove.IsMoving = false;
                        break;
                    }
                    case TravelProcess.CaveStage1_AfterPuzzle:
                    {
                        Raft.AutoMove.IsMoving = true;
                        Player.Controller.SetAllowJump();
                        Player.Controller.SetColliderRadiusOnLand();
                        break;
                    }
                    case TravelProcess.CaveStage2_Narrow:
                    {
                        break;
                    }
                    case TravelProcess.CaveStage2_OpenPlaceBeforeWaterfall:
                    {
                        break;
                    }
                }
            }

            curTravelProcess = value;
        }
    }
}