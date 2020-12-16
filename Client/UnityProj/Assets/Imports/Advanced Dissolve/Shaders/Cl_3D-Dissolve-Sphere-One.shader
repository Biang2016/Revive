// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Cl/3D-Dissolve-Sphere-One"
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
		uniform float _Mask_Raidus_1;
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
			float4 temp_output_2_0_g10 = appendResult7_g8;
			float2 temp_output_6_0_g10 = ( (temp_output_2_0_g10).xy / (temp_output_2_0_g10).w );
			float2 appendResult12_g10 = (float2((temp_output_6_0_g10).x , ( ( _ScreenParams.y / _ScreenParams.x ) * (temp_output_6_0_g10).y )));
			float4 tex2DNode31_g10 = tex2D( _DissolveMap1, ( ( ( ( appendResult12_g10 * distance( float4( _WorldSpaceCameraPos , 0.0 ) , mul( unity_ObjectToWorld, float4(0,0,0,1) ) ) ) * _DissolveMap1_ST.xy ) + _DissolveMap1_ST.zw ) + ( (_DissolveMap1_Scroll).xy * _Time.x ) ) );
			float3 ase_worldPos = i.worldPos;
			float temp_output_50_0_g10 = max( 0.0 , ( distance( ase_worldPos , _Mask_WorldPos_1 ) - ( _Mask_Raidus_1 - ( ( tex2DNode31_g10.a - 0.5 ) * 2.0 * _DissolveNosieStrength ) ) ) );
			float ifLocalVar53_g10 = 0;
			if( temp_output_50_0_g10 > 0.0 )
				ifLocalVar53_g10 = temp_output_50_0_g10;
			else if( temp_output_50_0_g10 < 0.0 )
				ifLocalVar53_g10 = -1.0;
			float4 appendResult45_g10 = (float4(tex2DNode31_g10.r , tex2DNode31_g10.g , tex2DNode31_g10.b , ifLocalVar53_g10));
			float temp_output_36_0 = (appendResult45_g10).w;
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
7;29;1906;1004;4461.491;352.931;1;True;False
Node;AmplifyShaderEditor.Vector2Node;7;-3597.829,-4.431802;Float;False;Property;_DissolveMap1_Scroll;DissolveMap1_Scroll;4;0;Create;True;0;0;False;0;0,0;0.25,0.25;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3600.558,-231.1908;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;10;-4075.204,-111.2536;Float;True;Property;_DissolveMap1;DissolveMap1;3;0;Create;True;0;0;False;0;None;f4a7e7699981b2848956ec162fbe8c60;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WorldPosInputsNode;17;-3641.386,167.075;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;32;-3674.902,344.7028;Float;False;Property;_DissolveNosieStrength;DissolveNosieStrength;5;0;Create;True;0;0;False;0;4;0.348;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;34;-3614.511,510.97;Float;False;Property;_Mask_WorldPos_1;Mask_WorldPos_1;12;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;-0.2,11.8,9;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;31;-3672.867,432.9399;Float;False;Property;_Mask_Raidus_1;Mask_Raidus_1;11;1;[HideInInspector];Create;True;0;0;False;0;4;4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;39;-3270.366,-109.9543;Float;False;DissolveVertex2Fragment;-1;;8;a9090879a2d3945498c54571bbc2bd0a;0;3;35;SAMPLER2D;0,0;False;24;FLOAT2;0,0;False;34;FLOAT2;0.25,0.25;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;121;-2914.049,121.6153;Float;False;Sphere_DissolveAlpha_One;-1;;10;bce0847aa0a04ae4eb46e19dcb22c3bf;0;7;27;SAMPLER2D;0,0;False;29;FLOAT2;0.25,0.25;False;2;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;3;FLOAT3;0,0,0;False;56;FLOAT;0;False;61;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2544.056,565.8404;Float;False;Property;_DissolveEdgeWidth;DissolveEdgeWidth;6;0;Create;True;0;0;False;0;-0.1;0.159;-0.1;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;36;-2491.854,165.3704;Float;True;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;81;-2088.215,568.1408;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;-2248.197,283.992;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-2093.414,284.6133;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-2339.977,-436.4243;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;ca1a5e504324857499d1fdeb25489439;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;95;-1948.064,102.8976;Float;False;289;188;Comment;1;48;是否翻转相交区域;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;75;-1853.016,545.5245;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-1461.512,899.7571;Float;False;Property;_DissolveEdgeColor;DissolveEdgeColor;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,2.035,2.035,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2069.597,-262.2349;Float;True;Property;_1;1;1;0;Create;True;0;0;False;0;None;1c7385984e1ebfb4680047d21fe2d444;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;97;-1499.225,804.1256;Float;False;Property;_DissolveEdgeColorInstenty;DissolveEdgeColorInstenty;8;0;Create;True;0;0;False;0;0.1;0.417;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;48;-1898.064,152.8976;Float;False;Property;_InvertAlpha;InvertAlpha;10;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;89;-1555.778,551.8583;Float;True;5;0;FLOAT;0;False;1;FLOAT;-0.1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-1024.937,879.1499;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1418.45,-79.00726;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;91;-1196.793,545.5605;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-1975.897,-469.0591;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;94;-1068.883,-220.7594;Float;False;278;188;Comment;1;78;是否剔除相交区域;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-361.455,-546.8661;Float;False;Property;_MaskClipAlpha;MaskClipAlpha;0;0;Create;True;0;0;False;0;0.01;0.01;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;113;-1865.282,300.7089;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1654.786,-463.7963;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-763.7939,544.4758;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;78;-1018.883,-170.7594;Float;False;Property;_ClipM;ClipM;9;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureTransformNode;18;-3596.335,-106.7994;Float;False;-1;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-378.5306,-455.6042;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Cl/3D-Dissolve-Sphere-One;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.01;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;49;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;35;10;0
WireConnection;39;24;16;0
WireConnection;39;34;7;0
WireConnection;121;27;10;0
WireConnection;121;29;7;0
WireConnection;121;2;39;0
WireConnection;121;40;32;0
WireConnection;121;3;17;0
WireConnection;121;56;31;0
WireConnection;121;61;34;0
WireConnection;36;0;121;0
WireConnection;81;0;56;0
WireConnection;47;0;36;0
WireConnection;112;0;47;0
WireConnection;112;1;56;0
WireConnection;75;0;47;0
WireConnection;75;1;81;0
WireConnection;2;0;61;0
WireConnection;2;1;16;0
WireConnection;48;0;36;0
WireConnection;48;1;112;0
WireConnection;89;0;75;0
WireConnection;72;0;97;0
WireConnection;72;1;52;0
WireConnection;46;0;2;4
WireConnection;46;1;48;0
WireConnection;91;0;89;0
WireConnection;113;0;112;0
WireConnection;38;0;1;0
WireConnection;38;1;2;0
WireConnection;98;0;91;0
WireConnection;98;1;72;0
WireConnection;78;0;2;4
WireConnection;78;1;46;0
WireConnection;18;0;10;0
WireConnection;0;0;38;0
WireConnection;0;2;98;0
WireConnection;0;10;78;0
ASEEND*/
//CHKSM=4C92C0F9A751FD5BD625A9EA27EEE19DCF1467A0