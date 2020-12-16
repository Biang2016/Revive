//******************************************************
//
//	文件名 (File Name) 	: 		SphereMaskCtrs.cs
//	
//	脚本创建者(Author) 	:		Ejoy_小林
	
//	创建时间 (CreatTime):		#CreateTime#
//******************************************************


using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphereMaskCtrs : MonoBehaviour
{
    public Transform[] masks = new Transform[4];
    public Material[] mats;
    private string shaderPath = "Cl/3D-Dissolve-Sphere-Four";
    void Start()
    {
        List<Material> tempMats = new List<Material>();
        Renderer[] renderer = (Renderer[])Resources.FindObjectsOfTypeAll(typeof(Renderer));
        if (renderer != null)
        {
            for (int i = 0; i < renderer.Length; i++)
            {
                if (renderer[i] == null || renderer[i].sharedMaterial == null)
                    continue;
                if (renderer[i].sharedMaterial.shader == Shader.Find(shaderPath) && !tempMats.Contains(renderer[i].sharedMaterial))
                    tempMats.Add(renderer[i].sharedMaterial);
            }
        }

        if (tempMats.Count > 0)
            mats = tempMats.ToArray();
    }

    void Update()
    {
        SetMatProperty();
    }

    public void SetMatProperty()
    {
        if (masks.Length < 0 || mats.Length < 0) return;
        if (mats.Length > 0)
        {
            for (int i = 0; i < mats.Length; i++)
            {
                for (int j = 0; j < masks.Length; j++)
                {
                    mats[i].SetFloat("_Mask_Raidus_" + (j + 1), masks[j].localScale.x * 0.5f);
                    mats[i].SetVector("_Mask_WorldPos_" + (j + 1), masks[j].position);
                }
            }
        }
    }
}
