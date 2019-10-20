//******************************************************
//
//	文件名 (File Name) 	: 		Sphere_DissolveInfo.cs
//	
//	脚本创建者(Author) 	:		Ejoy_小林
	
//	创建时间 (CreatTime):		#CreateTime#
//******************************************************


using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sphere_DissolveInfo : MonoBehaviour 
{
	public Material[] mats;
	private string shaderPath ="Cl/3D-Dissolve-Sphere-One";
	void Start () 
	{
		List<Material> tempMats = new List<Material>();
		Renderer[] renderer =(Renderer[])Resources.FindObjectsOfTypeAll(typeof(Renderer));
		if(renderer!=null)
		{
			for(int i=0;i<renderer.Length;i++)
			{
				if(renderer[i]==null||renderer[i].sharedMaterial==null)
				continue;
				if(renderer[i].sharedMaterial.shader==Shader.Find(shaderPath) &&!tempMats.Contains(renderer[i].sharedMaterial))
				tempMats.Add(renderer[i].sharedMaterial);
			}
		}

		if(tempMats.Count>0)
			mats = tempMats.ToArray();
	}
	
	void Update () 
	{
		SetMatProperty();
	}

	public void SetMatProperty()
	{
		if(mats.Length>0)
		{
			for(int i=0;i<mats.Length;i++)
			{
                mats[i].SetFloat("_Mask_Raidus_1" , this.transform.localScale.x * 0.5f);
                mats[i].SetVector("_Mask_WorldPos_1" , this.transform.position);
            }
		}
	}
}
