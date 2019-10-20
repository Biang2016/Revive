// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Cl/3D-Dissolve-Sphere-Four"
{
	Properties
	{
		_MaskClipAlpha("MaskClipAlpha", Range( 0.001 , 1)) = 0.01
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_DissolveMap1("DissolveMap1", 2D) = "white" {}
		_DissolveMap1_Scroll("DissolveMap1_Scroll", Vector) = (0,0,0,0)
		_DissolveNosieStrength("DissolveNosieStrength", Range( 0 , 1)) = 4
		_DissolveEdgeWidth("DissolveEdgeWidth", Range( -0.1 , 0.5)) = -0.1
		[HDR]_DissolveEdgeColor("DissolveEdgeColor", Color) = (1,1,1,0)
		_DissolveEdgeColorInstenty("DissolveEdgeColorInstenty", Range( 0 , 1)) = 0.1
		[Toggle]_ClipM("ClipM", Float) = 1
		[Toggle]_InvertAlpha("InvertAlpha", Float) = 0
		[HideInInspector]_Mask_Raidus_1("Mask_Raidus_1", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_1("Mask_WorldPos_1", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Raidus_2("Mask_Raidus_2", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_2("Mask_WorldPos_2", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Raidus_3("Mask_Raidus_3", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_3("Mask_WorldPos_3", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Raidus_4("Mask_Raidus_4", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_4("Mask_WorldPos_4", Vector) = (0,0,0,0)
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
		uniform float3 _Mask_WorldPos_2;
		uniform float3 _Mask_WorldPos_3;
		uniform float3 _Mask_WorldPos_4;
		uniform float _Mask_Raidus_1;
		uniform float _Mask_Raidus_2;
		uniform float _Mask_Raidus_3;
		uniform float _Mask_Raidus_4;
		uniform float _DissolveNosieStrength;
		uniform float _DissolveEdgeWidth;
		uniform float _DissolveEdgeColorInstenty;
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
			float4 temp_output_2_0_g4 = appendResult7_g8;
			float2 temp_output_6_0_g4 = ( (temp_output_2_0_g4).xy / (temp_output_2_0_g4).w );
			float2 appendResult12_g4 = (float2((temp_output_6_0_g4).x , ( ( _ScreenParams.y / _ScreenParams.x ) * (temp_output_6_0_g4).y )));
			float4 tex2DNode31_g4 = tex2D( _DissolveMap1, ( ( ( ( appendResult12_g4 * distance( float4( _WorldSpaceCameraPos , 0.0 ) , mul( unity_ObjectToWorld, float4(0,0,0,1) ) ) ) * _DissolveMap1_ST.xy ) + _DissolveMap1_ST.zw ) + ( (_DissolveMap1_Scroll).xy * _Time.x ) ) );
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_3_0_g4 = ase_worldPos;
			float3 temp_output_61_0_g4 = _Mask_WorldPos_1;
			float4 appendResult69_g4 = (float4(distance( temp_output_3_0_g4 , temp_output_61_0_g4 ) , distance( temp_output_3_0_g4 , _Mask_WorldPos_2 ) , distance( temp_output_3_0_g4 , _Mask_WorldPos_3 ) , distance( temp_output_3_0_g4 , _Mask_WorldPos_4 )));
			float temp_output_56_0_g4 = _Mask_Raidus_1;
			float4 appendResult60_g4 = (float4(temp_output_56_0_g4 , _Mask_Raidus_2 , _Mask_Raidus_3 , _Mask_Raidus_4));
			float temp_output_38_0_g4 = ( ( tex2DNode31_g4.a - 0.5 ) * 2.0 * _DissolveNosieStrength );
			float4 temp_cast_2 = (temp_output_38_0_g4).xxxx;
			float4 temp_output_71_0_g4 = saturate( max( float4( 0,0,0,0 ) , ( appendResult69_g4 - ( appendResult60_g4 - temp_cast_2 ) ) ) );
			float2 temp_output_78_0_g4 = ( (temp_output_71_0_g4).xz * (temp_output_71_0_g4).yw );
			float temp_output_81_0_g4 = ( (temp_output_78_0_g4).x * (temp_output_78_0_g4).y );
			float ifLocalVar82_g4 = 0;
			if( temp_output_81_0_g4 > 0.0 )
				ifLocalVar82_g4 = temp_output_81_0_g4;
			else if( temp_output_81_0_g4 < 0.0 )
				ifLocalVar82_g4 = -1.0;
			float4 appendResult45_g4 = (float4(tex2DNode31_g4.r , tex2DNode31_g4.g , tex2DNode31_g4.b , ifLocalVar82_g4));
			float temp_output_36_0 = (appendResult45_g4).w;
			float temp_output_47_0 = ( 1.0 - temp_output_36_0 );
			o.Emission = ( saturate( (0.0 + (( temp_output_47_0 - ( 1.0 - _DissolveEdgeWidth ) ) - -0.1) * (1.0 - 0.0) / (0.0 - -0.1)) ) * ( _DissolveEdgeColorInstenty * _DissolveEdgeColor ) ).rgb;
			o.Alpha = 1;
			float temp_output_112_0 = ( temp_output_47_0 * _DissolveEdgeWidth );
			clip( lerp(tex2DNode2.a,( tex2DNode2.a * lerp(temp_output_36_0,temp_output_112_0,_InvertAlpha) ),_ClipM) - _MaskClipAlpha );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
7;29;1906;1004;4014.76;-0.3322754;1.080536;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;10;-4075.204,-111.2536;Float;True;Property;_DissolveMap1;DissolveMap1;3;0;Create;True;0;0;False;0;None;f4a7e7699981b2848956ec162fbe8c60;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3600.558,-231.1908;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;7;-3597.829,-4.431802;Float;False;Property;_DissolveMap1_Scroll;DissolveMap1_Scroll;4;0;Create;True;0;0;False;0;0,0;0.25,0.25;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;106;-3664.896,671.5645;Float;False;Property;_Mask_Raidus_2;Mask_Raidus_2;13;1;[HideInInspector];Create;True;0;0;False;0;4;1.391051;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;34;-3614.511,510.97;Float;False;Property;_Mask_WorldPos_1;Mask_WorldPos_1;12;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;21.63,11.8,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;31;-3672.867,432.9399;Float;False;Property;_Mask_Raidus_1;Mask_Raidus_1;11;1;[HideInInspector];Create;True;0;0;False;0;4;4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;110;-3625.551,992.5218;Float;False;Property;_Mask_WorldPos_3;Mask_WorldPos_3;16;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;18.92,5.79,-6.95;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;107;-3659.13,903.8485;Float;False;Property;_Mask_Raidus_3;Mask_Raidus_3;15;1;[HideInInspector];Create;True;0;0;False;0;4;2.252633;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;109;-3632.498,748.0499;Float;False;Property;_Mask_WorldPos_2;Mask_WorldPos_2;14;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;18,6.54,1.41;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;108;-3653.115,1183.754;Float;False;Property;_Mask_Raidus_4;Mask_Raidus_4;17;1;[HideInInspector];Create;True;0;0;False;0;4;1.807532;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-3674.902,344.7028;Float;False;Property;_DissolveNosieStrength;DissolveNosieStrength;5;0;Create;True;0;0;False;0;4;0.34;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;17;-3641.386,167.075;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;39;-3270.366,-109.9543;Float;False;DissolveVertex2Fragment;-1;;8;a9090879a2d3945498c54571bbc2bd0a;0;3;35;SAMPLER2D;0,0;False;24;FLOAT2;0,0;False;34;FLOAT2;0.25,0.25;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;111;-3609.37,1279.091;Float;False;Property;_Mask_WorldPos_4;Mask_WorldPos_4;18;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;21.63,9.99,-6.74;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;120;-2852.151,375.3733;Float;False;Sphere_DissolveAlpha_Four;-1;;4;a9458928bac17aa409989bf113f68fff;0;13;27;SAMPLER2D;0,0;False;29;FLOAT2;0.25,0.25;False;2;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;3;FLOAT3;0,0,0;False;56;FLOAT;0;False;61;FLOAT3;0,0,0;False;57;FLOAT;0;False;62;FLOAT3;0,0,0;False;58;FLOAT;0;False;63;FLOAT3;0,0,0;False;59;FLOAT;0;False;64;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;36;-2491.854,165.3704;Float;True;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2544.056,565.8404;Float;False;Property;_DissolveEdgeWidth;DissolveEdgeWidth;6;0;Create;True;0;0;False;0;-0.1;0.059;-0.1;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;81;-2088.215,568.1408;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;-2248.197,283.992;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-2093.414,284.6133;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;75;-1853.016,545.5245;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;95;-1948.064,102.8976;Float;False;289;188;Comment;1;48;是否翻转相交区域;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-2339.977,-436.4243;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;ca1a5e504324857499d1fdeb25489439;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ColorNode;52;-1461.512,899.7571;Float;False;Property;_DissolveEdgeColor;DissolveEdgeColor;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.406948,1.266539,0.1344875,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;48;-1898.064,152.8976;Float;False;Property;_InvertAlpha;InvertAlpha;10;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1499.225,804.1256;Float;False;Property;_DissolveEdgeColorInstenty;DissolveEdgeColorInstenty;8;0;Create;True;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-2069.597,-262.2349;Float;True;Property;_1;1;1;0;Create;True;0;0;False;0;None;1c7385984e1ebfb4680047d21fe2d444;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;89;-1555.778,551.8583;Float;True;5;0;FLOAT;0;False;1;FLOAT;-0.1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1418.45,-79.00726;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;91;-1196.793,545.5605;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-1975.897,-469.0591;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-1024.937,879.1499;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;94;-1068.883,-220.7594;Float;False;278;188;Comment;1;78;是否剔除相交区域;1,1,1,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;78;-1018.883,-170.7594;Float;False;Property;_ClipM;ClipM;9;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-361.455,-546.8661;Float;False;Property;_MaskClipAlpha;MaskClipAlpha;0;0;Create;True;0;0;False;0;0.01;0.01;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1654.786,-463.7963;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-763.7939,544.4758;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureTransformNode;18;-3596.335,-106.7994;Float;False;-1;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.RelayNode;113;-1865.282,300.7089;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-378.5306,-455.6042;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Cl/3D-Dissolve-Sphere-Four;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.01;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;49;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;35;10;0
WireConnection;39;24;16;0
WireConnection;39;34;7;0
WireConnection;120;27;10;0
WireConnection;120;29;7;0
WireConnection;120;2;39;0
WireConnection;120;40;32;0
WireConnection;120;3;17;0
WireConnection;120;56;31;0
WireConnection;120;61;34;0
WireConnection;120;57;106;0
WireConnection;120;62;109;0
WireConnection;120;58;107;0
WireConnection;120;63;110;0
WireConnection;120;59;108;0
WireConnection;120;64;111;0
WireConnection;36;0;120;0
WireConnection;81;0;56;0
WireConnection;47;0;36;0
WireConnection;112;0;47;0
WireConnection;112;1;56;0
WireConnection;75;0;47;0
WireConnection;75;1;81;0
WireConnection;48;0;36;0
WireConnection;48;1;112;0
WireConnection;2;0;61;0
WireConnection;2;1;16;0
WireConnection;89;0;75;0
WireConnection;46;0;2;4
WireConnection;46;1;48;0
WireConnection;91;0;89;0
WireConnection;72;0;97;0
WireConnection;72;1;52;0
WireConnection;78;0;2;4
WireConnection;78;1;46;0
WireConnection;38;0;1;0
WireConnection;38;1;2;0
WireConnection;98;0;91;0
WireConnection;98;1;72;0
WireConnection;18;0;10;0
WireConnection;113;0;112;0
WireConnection;0;0;38;0
WireConnection;0;2;98;0
WireConnection;0;10;78;0
ASEEND*/
//CHKSM=01B968FA0BA281F4AE0AB4B0AC116C238BF1CED3