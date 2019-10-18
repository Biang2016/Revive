using UnityEngine;

public class Manager : MonoSingleton<Manager>
{
    internal int PuzzleLayer;

    private void Start()
    {
        PuzzleLayer = 1 << LayerMask.NameToLayer("Puzzle");
    }

    public Camera MainCamera;
    public AutoMove Raft;
    public AutoMove Player;

    public bool TravelViewMode = false;
}