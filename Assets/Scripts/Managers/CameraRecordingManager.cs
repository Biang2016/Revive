using System.Collections;
using System.Collections.Generic;
using System.IO;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Events;

public class CameraRecordingManager : MonoSingleton<CameraRecordingManager>
{
    void Start()
    {
        UIManager.Instance.GetBaseUIForm<EditorPanel>().RecordingIcon.gameObject.SetActive(false);
    }

    public float RecordTimeIntervalTick = 0f;

    private struct RecordFrame
    {
        public Vector3 Pos;
        public Quaternion Rot;
        public Quaternion RotCamera;
    }

    private List<RecordFrame> RecordFrames = new List<RecordFrame>();

    void Update()
    {
        if (GameManager.Instance.CurTravelProcess == GameManager.TravelProcess.None)
        {
            UIManager.Instance.GetBaseUIForm<EditorPanel>().RecordingIcon.gameObject.SetActive(true);
            if (IsPlayingRecord)
            {
                UIManager.Instance.GetBaseUIForm<EditorPanel>().RecordingIcon.color = Color.green;
            }
            else
            {
                UIManager.Instance.GetBaseUIForm<EditorPanel>().RecordingIcon.color = GameManager.Instance.RecordingStartSceneCameraPath ? Color.red : Color.yellow;
            }

            if (GameManager.Instance.RecordingStartSceneCameraPath)
            {
                RecordFrame rf = new RecordFrame();
                rf.Pos = GameManager.Instance.StartSceneCameraCarrier.transform.localPosition;
                rf.Rot = GameManager.Instance.StartSceneCameraCarrier.transform.localRotation;
                rf.RotCamera = GameManager.Instance.StartSceneCamera.transform.localRotation;
                RecordFrames.Add(rf);
            }
        }
    }

    public void SaveRecord()
    {
        StreamWriter sw = new StreamWriter(RecordingPathDictionary[RecordingTypes.RecordingJustNow]);
        foreach (RecordFrame rf in RecordFrames)
        {
            sw.WriteLine($"{rf.Pos.x},{rf.Pos.y},{rf.Pos.z},{rf.Rot.x},{rf.Rot.y},{rf.Rot.z},{rf.Rot.w},{rf.RotCamera.x},{rf.RotCamera.y},{rf.RotCamera.z},{rf.RotCamera.w}");
        }

        sw.Close();

        RecordFrames.Clear();
        RecordTimeIntervalTick = 0;
    }

    private List<RecordFrame> ReadRecordFrames = new List<RecordFrame>();

    public void PlayRecording(RecordingTypes recordingTypes, bool canMoveAfterPlaying, UnityAction onComplete = null)
    {
        GameManager.Instance.StartSceneCameraCarrier.Controller.enabled = false;
        GameManager.Instance.StartSceneCameraCarrier.MouseLooker.enabled = false;

        IsPlayingRecord = true;
        ReadRecordFrames.Clear();
        StreamReader sr = new StreamReader(RecordingPathDictionary[recordingTypes]);
        string line = "";
        while (!string.IsNullOrEmpty(line = sr.ReadLine()))
        {
            string[] vars = line.Split(',');
            RecordFrame rf = new RecordFrame();
            rf.Pos = new Vector3(float.Parse(vars[0]), float.Parse(vars[1]), float.Parse(vars[2]));
            rf.Rot = new Quaternion(float.Parse(vars[3]), float.Parse(vars[4]), float.Parse(vars[5]), float.Parse(vars[6]));
            rf.RotCamera = new Quaternion(float.Parse(vars[7]), float.Parse(vars[8]), float.Parse(vars[9]), float.Parse(vars[10]));
            ReadRecordFrames.Add(rf);
        }

        GameManager.Instance.StartSceneCameraCarrier.transform.DOPause();
        if (CameraMoveCoroutine != null)
        {
            StopCoroutine(CameraMoveCoroutine);
        }

        CameraMoveCoroutine = StartCoroutine(Co_CameraMove(canMoveAfterPlaying, onComplete));
    }

    public enum RecordingTypes
    {
        RecordingJustNow,
        StartSceneRecording,
        LeftStoneMoving,
        RightStoneMoving,
        Reviving,
    }

    public Dictionary<RecordingTypes, string> RecordingPathDictionary = new Dictionary<RecordingTypes, string>
    {
        {RecordingTypes.RecordingJustNow, Application.streamingAssetsPath + "/CameraAnim.txt"},
        {RecordingTypes.StartSceneRecording, Application.streamingAssetsPath + "/CameraAnim_StartSceneRecording.txt"},
        {RecordingTypes.LeftStoneMoving, Application.streamingAssetsPath + "/CameraAnim_LeftStoneMove.txt"},
        {RecordingTypes.RightStoneMoving, Application.streamingAssetsPath + "/CameraAnim_RightStoneMove.txt"},
        {RecordingTypes.Reviving, Application.streamingAssetsPath + "/CameraAnim_Reviving.txt"},
    };

    private Coroutine CameraMoveCoroutine;
    public bool IsPlayingRecord = false;

    IEnumerator Co_CameraMove(bool canMoveAfterPlaying, UnityAction onComplete)
    {
        foreach (RecordFrame rf in ReadRecordFrames)
        {
            GameManager.Instance.StartSceneCameraCarrier.transform.DOLocalMove(rf.Pos, Time.deltaTime);
            GameManager.Instance.StartSceneCameraCarrier.transform.DOLocalRotateQuaternion(rf.Rot, Time.deltaTime);
            GameManager.Instance.StartSceneCamera.transform.DOLocalRotateQuaternion(rf.RotCamera, Time.deltaTime);
            yield return null;
        }

        IsPlayingRecord = false;
        GameManager.Instance.StartSceneCameraCarrier.Controller.enabled = canMoveAfterPlaying;
        GameManager.Instance.StartSceneCameraCarrier.MouseLooker.enabled = canMoveAfterPlaying;
        onComplete?.Invoke();
    }
}