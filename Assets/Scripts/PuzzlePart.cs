using System.Collections.Generic;
using UnityEngine;

public class PuzzlePart : MonoBehaviour
{
    internal Puzzle ParrentPuzzle;

    void Start()
    {
        ParrentPuzzle = transform.parent.gameObject.GetComponent<Puzzle>();
    }

    public float SizeRatio = 1.0f;
}