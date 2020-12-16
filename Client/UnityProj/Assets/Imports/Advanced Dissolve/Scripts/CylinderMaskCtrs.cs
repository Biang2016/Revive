//******************************************************
//
//	文件名 (File Name) 	: 		CylinderMaskCtrs.cs
//	
//	脚本创建者(Author) 	:		Ejoy_小林

//	创建时间 (CreatTime):		#CreateTime#
//******************************************************

/*
 * *
 * 可考虑使用MaterialPropertyBlock 进行优化
*/

using System.Collections.Generic;
using UnityEngine;
public class CylinderMaskCtrs : MonoBehaviour
{

    public Transform[] masks = new Transform[4];
    public Material[] mats;
    public bool isMatPropBlock = false;
    private const string _shaderPath = "Cl/3D-Dissolve-Cylinder-Four";
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
                if (renderer[i].sharedMaterial.shader == Shader.Find(_shaderPath) && !tempMats.Contains(renderer[i].sharedMaterial))
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
        // if (capsuleCollider == null) return;
        if (masks.Length < 0 || mats.Length < 0) return;

        if (mats.Length > 0)
        {
            for (int i = 0; i < mats.Length; i++)
            {
                for (int j = 0; j < masks.Length; j++)
                {
                    CapsuleCollider capsuleCollider = masks[j].GetComponent<CapsuleCollider>();
                    if (capsuleCollider != null)
                    {
                        mats[i].SetFloat("_Mask_Raidus_" + (j + 1), capsuleCollider.radius * masks[j].localScale.z);
                        mats[i].SetVector("_Mask_WorldPos_" + (j + 1), masks[j].position);
                        mats[i].SetVector("_Mask_Normal_" + (j + 1), masks[j].forward);
                        mats[i].SetFloat("_Mask_Height_" + (j + 1), capsuleCollider.height * masks[j].localScale.y);
                    }
                    else
                    {
                        Debug.LogError(masks[j].name + "对象没有 CapsuleCollider 组件 不参与shader运算！");
                    }
                }
            }
        }
    }
}
