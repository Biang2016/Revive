// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Cl/3D-Dissolve-Cylinder-One"
{
	Properties
	{
		_MaskClipAlpha("MaskClipAlpha", Range( 0.001 , 1)) = 0.01
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_DissolveMap1("DissolveMap1", 2D) = "white" {}
		_DissolveMap1_Scroll("DissolveMap1_Scroll", Vector) = (0,0,0,0)
		_DissolveNosieStrength("DissolveNosieStrength", Range( 0 , 1)) = 1
		[HDR]_DissolveEdgeColor("DissolveEdgeColor", Color) = (1,1,1,0)
		_DissolveEdgeWidth("DissolveEdgeWidth", Range( 0 , 1)) = 0.21
		[HideInInspector]_Mask_Raidus_1("Mask_Raidus_1", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_Height_1("Mask_Height_1", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_1("Mask_WorldPos_1", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Normal_1("Mask_Normal_1", Vector) = (0,0,0,0)
		[Toggle]_ClipM("ClipM", Float) = 1
		[Toggle]_InvertAlpha("InvertAlpha", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform sampler2D _DissolveMap1;
		uniform float4 _DissolveMap1_ST;
		uniform float2 _DissolveMap1_Scroll;
		uniform float3 _Mask_WorldPos_1;
		uniform float3 _Mask_Normal_1;
		uniform float _Mask_Height_1;
		uniform float _Mask_Raidus_1;
		uniform float _DissolveNosieStrength;
		uniform float _DissolveEdgeWidth;
		uniform float4 _DissolveEdgeColor;
		uniform float _ClipM;
		uniform float _InvertAlpha;
		uniform float _MaskClipAlpha;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 tex2DNode2 = tex2D( _MainTex, i.uv_texcoord );
			o.Albedo = ( _Color * tex2DNode2 ).rgb;
			float2 temp_output_29_0_g8 = ( ( ( i.uv_texcoord * _DissolveMap1_ST.xy ) + _DissolveMap1_ST.zw ) + ( (_DissolveMap1_Scroll).xy * _Time.x ) );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos23_g8 = UnityObjectToClipPos( ase_vertex3Pos );
			float4 computeScreenPos4_g8 = ComputeScreenPos( unityObjectToClipPos23_g8 );
			float4 appendResult7_g8 = (float4((temp_output_29_0_g8).x , (temp_output_29_0_g8).y , (computeScreenPos4_g8).z , (computeScreenPos4_g8).w));
			float4 temp_output_20_0_g10 = appendResult7_g8;
			float2 temp_output_27_0_g10 = ( (temp_output_20_0_g10).xy / (temp_output_20_0_g10).w );
			float2 appendResult19_g10 = (float2((temp_output_27_0_g10).x , ( ( _ScreenParams.y / _ScreenParams.x ) * (temp_output_27_0_g10).y )));
			float4 tex2DNode5_g10 = tex2D( _DissolveMap1, ( ( ( ( appendResult19_g10 * distance( float4( _WorldSpaceCameraPos , 0.0 ) , mul( unity_ObjectToWorld, float4(0,0,0,1) ) ) ) * _DissolveMap1_ST.xy ) + _DissolveMap1_ST.zw ) + ( (_DissolveMap1_Scroll).xy * _Time.x ) ) );
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_37_0_g10 = ase_worldPos;
			float3 temp_output_39_0_g10 = _Mask_WorldPos_1;
			float temp_output_43_0_g10 = _Mask_Height_1;
			float3 temp_output_51_0_g10 = ( ( temp_output_39_0_g10 + ( _Mask_Normal_1 * temp_output_43_0_g10 ) ) - temp_output_39_0_g10 );
			float dotResult57_g10 = dot( ( temp_output_37_0_g10 - temp_output_39_0_g10 ) , temp_output_51_0_g10 );
			float temp_output_38_0_g10 = _Mask_Raidus_1;
			float ifLocalVar60_g10 = 0;
			if( temp_output_38_0_g10 >= 1.0 )
				ifLocalVar60_g10 = 1.0;
			else
				ifLocalVar60_g10 = temp_output_38_0_g10;
			float temp_output_64_0_g10 = max( 0.0 , ( distance( temp_output_37_0_g10 , ( temp_output_39_0_g10 + ( max( 0.0 , min( 1.0 , ( dotResult57_g10 / ( temp_output_43_0_g10 * temp_output_43_0_g10 ) ) ) ) * temp_output_51_0_g10 ) ) ) - ( temp_output_38_0_g10 - ( ( ( tex2DNode5_g10.a - 0.5 ) * 2.0 * _DissolveNosieStrength ) * ifLocalVar60_g10 ) ) ) );
			float ifLocalVar65_g10 = 0;
			if( temp_output_64_0_g10 > 0.0 )
				ifLocalVar65_g10 = temp_output_64_0_g10;
			else if( temp_output_64_0_g10 < 0.0 )
				ifLocalVar65_g10 = -1.0;
			float4 appendResult40_g10 = (float4(tex2DNode5_g10.r , tex2DNode5_g10.g , tex2DNode5_g10.b , ifLocalVar65_g10));
			float temp_output_36_0 = (appendResult40_g10).w;
			float temp_output_47_0 = ( 1.0 - temp_output_36_0 );
			o.Emission = ( saturate( (0.0 + (( temp_output_47_0 - ( 1.0 - _DissolveEdgeWidth ) ) - -0.1) * (1.0 - 0.0) / (0.0 - -0.1)) ) * _DissolveEdgeColor ).rgb;
			o.Alpha = 1;
			clip( lerp(tex2DNode2.a,( tex2DNode2.a * lerp(temp_output_36_0,temp_output_47_0,_InvertAlpha) ),_ClipM) - _MaskClipAlpha );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
7;29;1906;1004;4511.387;74.39365;1;True;False
Node;AmplifyShaderEditor.Vector2Node;7;-4072.329,595.6685;Float;False;Property;_DissolveMap1_Scroll;DissolveMap1_Scroll;4;0;Create;True;0;0;False;0;0,0;0.25,0.25;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;107;-3819.396,107.0638;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;105;-3763.489,897.4771;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;108;-3801.196,75.86378;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;106;-3733.591,915.6772;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;109;-3333.19,73.27708;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3600.558,-231.1908;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;110;-3316.29,45.97715;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;103;-3031.589,916.9771;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;10;-4075.204,-111.2536;Float;True;Property;_DissolveMap1;DissolveMap1;3;0;Create;True;0;0;False;0;None;f4a7e7699981b2848956ec162fbe8c60;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector3Node;34;-3596.056,544.6684;Float;False;Property;_Mask_WorldPos_1;Mask_WorldPos_1;10;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;-11.97976,9.16,12.20284;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;32;-3622.189,338.7308;Float;False;Property;_DissolveNosieStrength;DissolveNosieStrength;5;0;Create;True;0;0;False;0;1;0.14;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;94;-3551.787,406.5698;Float;False;Property;_Mask_Normal_1;Mask_Normal_1;11;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;31;-3629.646,188.6909;Float;False;Property;_Mask_Raidus_1;Mask_Raidus_1;8;1;[HideInInspector];Create;True;0;0;False;0;4;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-3622.704,265.3985;Float;False;Property;_Mask_Height_1;Mask_Height_1;9;1;[HideInInspector];Create;True;0;0;False;0;4;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;17;-3579.573,685.7444;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;39;-3270.366,-109.9543;Float;False;DissolveVertex2Fragment;-1;;8;a9090879a2d3945498c54571bbc2bd0a;0;3;35;SAMPLER2D;0,0;False;24;FLOAT2;0,0;False;34;FLOAT2;0.25,0.25;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;104;-2997.785,906.5767;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;102;-2875.488,190.3677;Float;False;Cylinder_DissolveAlpha_One;-1;;10;6fb7fe4d4abd21d4491acc8c4e8e2a0f;0;9;20;FLOAT4;0,0,0,0;False;12;SAMPLER2D;0,0;False;38;FLOAT;1;False;43;FLOAT;5;False;36;FLOAT;0;False;45;FLOAT3;0,0,0;False;39;FLOAT3;0,0,0;False;37;FLOAT3;0,0,0;False;4;FLOAT2;0.25,0.25;False;1;FLOAT4;41
Node;AmplifyShaderEditor.RangedFloatNode;56;-2268.056,486.8404;Float;False;Property;_DissolveEdgeWidth;DissolveEdgeWidth;7;0;Create;True;0;0;False;0;0.21;0.13;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;36;-2523.854,377.3704;Float;True;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;-2196.197,380.992;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;81;-1965.215,488.1408;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;75;-1770.016,388.5245;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-2339.977,-436.4243;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;ca1a5e504324857499d1fdeb25489439;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;2;-2069.597,-262.2349;Float;True;Property;_1;1;1;0;Create;True;0;0;False;0;None;1c7385984e1ebfb4680047d21fe2d444;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;89;-1517.025,235.1981;Float;True;5;0;FLOAT;0;False;1;FLOAT;-0.1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;48;-1898.064,152.8976;Float;False;Property;_InvertAlpha;InvertAlpha;13;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-1975.897,-469.0591;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;91;-1210.641,389.7736;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-1239.195,635.6427;Float;False;Property;_DissolveEdgeColor;DissolveEdgeColor;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1418.45,-79.00726;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1654.786,-463.7963;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureTransformNode;18;-3596.335,-106.7994;Float;False;-1;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-851.6494,512.6629;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-361.455,-546.8661;Float;False;Property;_MaskClipAlpha;MaskClipAlpha;0;0;Create;True;0;0;False;0;0.01;0.01;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;78;-1018.883,-170.7594;Float;False;Property;_ClipM;ClipM;12;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-378.5306,-455.6042;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Cl/3D-Dissolve-Cylinder-One;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.01;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;49;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;107;0;7;0
WireConnection;105;0;7;0
WireConnection;108;0;107;0
WireConnection;106;0;105;0
WireConnection;109;0;108;0
WireConnection;110;0;109;0
WireConnection;103;0;106;0
WireConnection;39;35;10;0
WireConnection;39;24;16;0
WireConnection;39;34;110;0
WireConnection;104;0;103;0
WireConnection;102;20;39;0
WireConnection;102;12;10;0
WireConnection;102;38;31;0
WireConnection;102;43;93;0
WireConnection;102;36;32;0
WireConnection;102;45;94;0
WireConnection;102;39;34;0
WireConnection;102;37;17;0
WireConnection;102;4;104;0
WireConnection;36;0;102;41
WireConnection;47;0;36;0
WireConnection;81;0;56;0
WireConnection;75;0;47;0
WireConnection;75;1;81;0
WireConnection;2;0;61;0
WireConnection;2;1;16;0
WireConnection;89;0;75;0
WireConnection;48;0;36;0
WireConnection;48;1;47;0
WireConnection;91;0;89;0
WireConnection;46;0;2;4
WireConnection;46;1;48;0
WireConnection;38;0;1;0
WireConnection;38;1;2;0
WireConnection;18;0;10;0
WireConnection;72;0;91;0
WireConnection;72;1;52;0
WireConnection;78;0;2;4
WireConnection;78;1;46;0
WireConnection;0;0;38;0
WireConnection;0;2;72;0
WireConnection;0;10;78;0
ASEEND*/
//CHKSM=C15E77BC081EC05FCEC807BB81C23CDD2D534C44