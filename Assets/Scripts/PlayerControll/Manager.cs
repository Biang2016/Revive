using UnityEngine;

public class Manager : MonoSingleton<Manager>
{
    internal int PuzzleLayer;

    private void Start()
    {
        RenderSettings.fog = true;
        PuzzleLayer = 1 << LayerMask.NameToLayer("Puzzle");
    }

    void Update()
    {
        if (Input.GetKeyUp(KeyCode.O))
        {
            RenderSettings.fog = !RenderSettings.fog;
        }
    }

    public Camera MainCamera;
    public AutoMove Raft;
    public AutoMove Player;

    public bool TravelViewMode = false;
}