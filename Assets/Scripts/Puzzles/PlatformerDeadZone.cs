﻿using UnityEngine;

public class PlatformerDeadZone : MonoBehaviour
{
    [SerializeField] private Transform RebornPivot;

    private void OnTriggerEnter(Collider c)
    {
        Player player = c.gameObject.GetComponent<Player>();
        if (player != null)
        {
            player.Controller.MyController.enabled = false;
            player.Controller.enabled = false;

            player.transform.SetParent(GameManager.Instance.SurroundingRoot);
            player.transform.position = RebornPivot.position;
            player.transform.rotation = RebornPivot.rotation;

            GameManager.Instance.Platformer3D.ResetAll();
            GameManager.Instance.Platformer3D.ShowFirst();
            player.Controller.MyController.enabled = true;
            player.Controller.enabled = true;
        }
    }
}