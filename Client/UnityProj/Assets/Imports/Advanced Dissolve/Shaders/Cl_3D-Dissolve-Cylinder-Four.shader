// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Cl/3D-Dissolve-Cylinder-Four"
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
		[HideInInspector]_Mask_WorldPos_1("Mask_WorldPos_1", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Normal_1("Mask_Normal_1", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Height_1("Mask_Height_1", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_Raidus_2("Mask_Raidus_2", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_2("Mask_WorldPos_2", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Normal_2("Mask_Normal_2", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Height_2("Mask_Height_2", Range( 0 , 10)) = 0
		[HideInInspector]_Mask_Raidus_3("Mask_Raidus_3", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_3("Mask_WorldPos_3", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Normal_3("Mask_Normal_3", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Height_3("Mask_Height_3", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_Raidus_4("Mask_Raidus_4", Range( 0 , 10)) = 4
		[HideInInspector]_Mask_WorldPos_4("Mask_WorldPos_4", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Normal_4("Mask_Normal_4", Vector) = (0,0,0,0)
		[HideInInspector]_Mask_Height_4("Mask_Height_4", Range( 0 , 10)) = 4
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
		uniform float3 _Mask_WorldPos_2;
		uniform float3 _Mask_Normal_2;
		uniform float _Mask_Height_2;
		uniform float3 _Mask_WorldPos_3;
		uniform float3 _Mask_Normal_3;
		uniform float _Mask_Height_3;
		uniform float3 _Mask_WorldPos_4;
		uniform float3 _Mask_Normal_4;
		uniform float _Mask_Height_4;
		uniform float _Mask_Raidus_1;
		uniform float _Mask_Raidus_2;
		uniform float _Mask_Raidus_3;
		uniform float _Mask_Raidus_4;
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
			float4 temp_output_20_0_g16 = appendResult7_g8;
			float2 temp_output_27_0_g16 = ( (temp_output_20_0_g16).xy / (temp_output_20_0_g16).w );
			float2 appendResult19_g16 = (float2((temp_output_27_0_g16).x , ( ( _ScreenParams.y / _ScreenParams.x ) * (temp_output_27_0_g16).y )));
			float4 tex2DNode5_g16 = tex2D( _DissolveMap1, ( ( ( ( appendResult19_g16 * distance( float4( _WorldSpaceCameraPos , 0.0 ) , mul( unity_ObjectToWorld, float4(0,0,0,1) ) ) ) * _DissolveMap1_ST.xy ) + _DissolveMap1_ST.zw ) + ( (_DissolveMap1_Scroll).xy * _Time.x ) ) );
			float3 ase_worldPos = i.worldPos;
			float3 SelfWorldPos101_g16 = ase_worldPos;
			float3 temp_output_90_0_g16 = _Mask_WorldPos_1;
			float temp_output_100_0_g16 = _Mask_Height_1;
			float3 temp_output_105_0_g16 = ( ( temp_output_90_0_g16 + ( _Mask_Normal_1 * temp_output_100_0_g16 ) ) - temp_output_90_0_g16 );
			float dotResult128_g16 = dot( ( SelfWorldPos101_g16 - temp_output_90_0_g16 ) , temp_output_105_0_g16 );
			float3 temp_output_95_0_g16 = _Mask_WorldPos_2;
			float temp_output_110_0_g16 = _Mask_Height_2;
			float3 temp_output_132_0_g16 = ( ( temp_output_95_0_g16 + ( _Mask_Normal_2 * temp_output_110_0_g16 ) ) - temp_output_95_0_g16 );
			float dotResult103_g16 = dot( ( SelfWorldPos101_g16 - temp_output_95_0_g16 ) , temp_output_132_0_g16 );
			float3 temp_output_131_0_g16 = _Mask_WorldPos_3;
			float temp_output_136_0_g16 = _Mask_Height_3;
			float3 temp_output_135_0_g16 = ( ( temp_output_131_0_g16 + ( _Mask_Normal_3 * temp_output_136_0_g16 ) ) - temp_output_131_0_g16 );
			float dotResult96_g16 = dot( ( SelfWorldPos101_g16 - temp_output_131_0_g16 ) , temp_output_135_0_g16 );
			float3 temp_output_152_0_g16 = _Mask_WorldPos_4;
			float temp_output_170_0_g16 = _Mask_Height_4;
			float3 temp_output_146_0_g16 = ( ( temp_output_152_0_g16 + ( _Mask_Normal_4 * temp_output_170_0_g16 ) ) - temp_output_152_0_g16 );
			float dotResult165_g16 = dot( ( SelfWorldPos101_g16 - temp_output_152_0_g16 ) , temp_output_146_0_g16 );
			float4 appendResult171_g16 = (float4(distance( SelfWorldPos101_g16 , ( temp_output_90_0_g16 + ( max( 0.0 , min( 1.0 , ( dotResult128_g16 / ( temp_output_100_0_g16 * temp_output_100_0_g16 ) ) ) ) * temp_output_105_0_g16 ) ) ) , distance( SelfWorldPos101_g16 , ( temp_output_95_0_g16 + ( max( 0.0 , min( 1.0 , ( dotResult103_g16 / ( temp_output_110_0_g16 * temp_output_110_0_g16 ) ) ) ) * temp_output_132_0_g16 ) ) ) , distance( SelfWorldPos101_g16 , ( temp_output_131_0_g16 + ( max( 0.0 , min( 1.0 , ( dotResult96_g16 / ( temp_output_136_0_g16 * temp_output_136_0_g16 ) ) ) ) * temp_output_135_0_g16 ) ) ) , distance( SelfWorldPos101_g16 , ( temp_output_152_0_g16 + ( max( 0.0 , min( 1.0 , ( dotResult165_g16 / ( temp_output_170_0_g16 * temp_output_170_0_g16 ) ) ) ) * temp_output_146_0_g16 ) ) )));
			float4 appendResult180_g16 = (float4(_Mask_Raidus_1 , _Mask_Raidus_2 , _Mask_Raidus_3 , _Mask_Raidus_4));
			float4 temp_cast_2 = (1.0).xxxx;
			float4 temp_cast_3 = (1.0).xxxx;
			float4 temp_output_185_0_g16 = saturate( max( float4( 0,0,0,0 ) , ( appendResult171_g16 - ( appendResult180_g16 - ( ( ( tex2DNode5_g16.a - 0.5 ) * 2.0 * _DissolveNosieStrength ) *  ( appendResult180_g16 - 0.0 > 1.0 ? temp_cast_2 : appendResult180_g16 - 0.0 <= 1.0 && appendResult180_g16 + 0.0 >= 1.0 ? temp_cast_3 : appendResult180_g16 )  ) ) ) ) );
			float2 temp_output_187_0_g16 = ( (temp_output_185_0_g16).xz * (temp_output_185_0_g16).yw );
			float temp_output_189_0_g16 = ( (temp_output_187_0_g16).x * (temp_output_187_0_g16).y );
			float ifLocalVar174_g16 = 0;
			if( temp_output_189_0_g16 > 0.0 )
				ifLocalVar174_g16 = temp_output_189_0_g16;
			else if( temp_output_189_0_g16 < 0.0 )
				ifLocalVar174_g16 = -1.0;
			float4 appendResult40_g16 = (float4(tex2DNode5_g16.r , tex2DNode5_g16.g , tex2DNode5_g16.b , ifLocalVar174_g16));
			float temp_output_36_0 = (appendResult40_g16).w;
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
7;29;1906;1004;5386.142;588.7877;2.084885;True;False
Node;AmplifyShaderEditor.Vector2Node;7;-4387.867,-2.805116;Float;False;Property;_DissolveMap1_Scroll;DissolveMap1_Scroll;4;0;Create;True;0;0;False;0;0,0;0.25,0.25;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;107;-4133.335,-269.0099;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;108;-4115.137,-300.21;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;109;-3647.132,-302.7967;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;110;-3630.232,-330.0966;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3914.5,-607.2644;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;10;-4389.142,-487.3274;Float;True;Property;_DissolveMap1;DissolveMap1;3;0;Create;True;0;0;False;0;None;f4a7e7699981b2848956ec162fbe8c60;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;133;-4383.076,1136.87;Float;False;301.2341;485.1826;Comment;4;119;125;122;128;Cylinder_Three;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;134;-3864.821,1573.802;Float;False;301.2341;485.1826;Comment;4;120;129;126;123;Cylinder_Four;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;132;-4797.708,596.4245;Float;False;301.2341;485.1826;Comment;4;127;121;124;117;Cylinder_Two;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;131;-5058.986,33.83508;Float;False;301.2341;485.1826;Comment;4;93;34;94;31;Cylinder_One;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;17;-3909.115,-319.5293;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;32;-3957.231,-126.8429;Float;False;Property;_DissolveNosieStrength;DissolveNosieStrength;5;0;Create;True;0;0;False;0;1;0.149;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;39;-3584.308,-486.0281;Float;False;DissolveVertex2Fragment;-1;;8;a9090879a2d3945498c54571bbc2bd0a;0;3;35;SAMPLER2D;0,0;False;24;FLOAT2;0,0;False;34;FLOAT2;0.25,0.25;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-4765.926,996.8329;Float;False;Property;_Mask_Height_2;Mask_Height_2;15;1;[HideInInspector];Create;True;0;0;False;0;0;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;119;-4362.861,1177.821;Float;False;Property;_Mask_Raidus_3;Mask_Raidus_3;16;1;[HideInInspector];Create;True;0;0;False;0;4;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;121;-4701.094,861.2848;Float;False;Property;_Mask_Normal_2;Mask_Normal_2;14;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;31;-5015.064,83.83486;Float;False;Property;_Mask_Raidus_1;Mask_Raidus_1;8;1;[HideInInspector];Create;True;0;0;False;0;4;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;124;-4744.808,709.9103;Float;False;Property;_Mask_WorldPos_2;Mask_WorldPos_2;13;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;-14.54976,7.98,-2.957724;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;117;-4774.218,641.0283;Float;False;Property;_Mask_Raidus_2;Mask_Raidus_2;12;1;[HideInInspector];Create;True;0;0;False;0;4;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3835.814,1615.812;Float;False;Property;_Mask_Raidus_4;Mask_Raidus_4;20;1;[HideInInspector];Create;True;0;0;False;0;4;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;34;-4995.337,155.4596;Float;False;Property;_Mask_WorldPos_1;Mask_WorldPos_1;9;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;-11.97976,9.16,-6.447724;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;93;-5031.633,431.1285;Float;False;Property;_Mask_Height_1;Mask_Height_1;11;1;[HideInInspector];Create;True;0;0;False;0;4;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3842.848,1981.585;Float;False;Property;_Mask_Height_4;Mask_Height_4;23;1;[HideInInspector];Create;True;0;0;False;0;4;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;123;-3776.913,1829.97;Float;False;Property;_Mask_Normal_4;Mask_Normal_4;22;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;94;-4957.84,294.6489;Float;False;Property;_Mask_Normal_1;Mask_Normal_1;10;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;128;-4366.909,1545.683;Float;False;Property;_Mask_Height_3;Mask_Height_3;19;1;[HideInInspector];Create;True;0;0;False;0;4;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;126;-3811.073,1691.629;Float;False;Property;_Mask_WorldPos_4;Mask_WorldPos_4;21;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;-18.42976,9.16,-9.877725;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;122;-4294.596,1401.297;Float;False;Property;_Mask_Normal_3;Mask_Normal_3;18;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;125;-4343.247,1258.721;Float;False;Property;_Mask_WorldPos_3;Mask_WorldPos_3;17;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;-14.54976,9.16,-9.877725;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;136;-3229.694,568.2756;Float;False;Cylinder_DissolveAlpha_Four;-1;;16;218658630baa4bc41bba75ce71b71d5e;0;21;153;FLOAT3;0,0,0;False;20;FLOAT4;0,0,0,0;False;12;SAMPLER2D;0,0;False;36;FLOAT;0;False;4;FLOAT2;0.25,0.25;False;179;FLOAT;4;False;90;FLOAT3;0,0,0;False;99;FLOAT3;0,0,0;False;100;FLOAT;0;False;176;FLOAT;4;False;95;FLOAT3;0,0,0;False;122;FLOAT3;0,0,0;False;110;FLOAT;0;False;177;FLOAT;4;False;131;FLOAT3;0,0,0;False;134;FLOAT3;0,0,0;False;136;FLOAT;0;False;178;FLOAT;4;False;152;FLOAT3;0,0,0;False;150;FLOAT3;0,0,0;False;170;FLOAT;0;False;1;FLOAT4;41
Node;AmplifyShaderEditor.ComponentMaskNode;36;-2523.854,377.3704;Float;True;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2268.056,486.8404;Float;False;Property;_DissolveEdgeWidth;DissolveEdgeWidth;7;0;Create;True;0;0;False;0;0.21;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;81;-1965.215,488.1408;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;-2196.197,380.992;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;75;-1770.016,388.5245;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-2339.977,-436.4243;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;ca1a5e504324857499d1fdeb25489439;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ToggleSwitchNode;48;-1898.064,152.8976;Float;False;Property;_InvertAlpha;InvertAlpha;25;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-2069.597,-262.2349;Float;True;Property;_1;1;1;0;Create;True;0;0;False;0;None;1c7385984e1ebfb4680047d21fe2d444;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;89;-1517.025,235.1981;Float;True;5;0;FLOAT;0;False;1;FLOAT;-0.1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;91;-1210.641,389.7736;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-1239.195,635.6427;Float;False;Property;_DissolveEdgeColor;DissolveEdgeColor;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.1712802,0.603511,0.7279412,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1418.45,-79.00726;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-1975.897,-469.0591;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-851.6494,512.6629;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-361.455,-546.8661;Float;False;Property;_MaskClipAlpha;MaskClipAlpha;0;0;Create;True;0;0;False;0;0.01;0.01;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1654.786,-463.7963;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;78;-1018.883,-170.7594;Float;False;Property;_ClipM;ClipM;24;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureTransformNode;18;-3910.277,-482.8732;Float;False;-1;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-378.5306,-455.6042;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Cl/3D-Dissolve-Cylinder-Four;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.01;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;49;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;107;0;7;0
WireConnection;108;0;107;0
WireConnection;109;0;108;0
WireConnection;110;0;109;0
WireConnection;39;35;10;0
WireConnection;39;24;16;0
WireConnection;39;34;110;0
WireConnection;136;153;17;0
WireConnection;136;20;39;0
WireConnection;136;12;10;0
WireConnection;136;36;32;0
WireConnection;136;4;7;0
WireConnection;136;179;31;0
WireConnection;136;90;34;0
WireConnection;136;99;94;0
WireConnection;136;100;93;0
WireConnection;136;176;117;0
WireConnection;136;95;124;0
WireConnection;136;122;121;0
WireConnection;136;110;127;0
WireConnection;136;177;119;0
WireConnection;136;131;125;0
WireConnection;136;134;122;0
WireConnection;136;136;128;0
WireConnection;136;178;120;0
WireConnection;136;152;126;0
WireConnection;136;150;123;0
WireConnection;136;170;129;0
WireConnection;36;0;136;41
WireConnection;81;0;56;0
WireConnection;47;0;36;0
WireConnection;75;0;47;0
WireConnection;75;1;81;0
WireConnection;48;0;36;0
WireConnection;48;1;47;0
WireConnection;2;0;61;0
WireConnection;2;1;16;0
WireConnection;89;0;75;0
WireConnection;91;0;89;0
WireConnection;46;0;2;4
WireConnection;46;1;48;0
WireConnection;72;0;91;0
WireConnection;72;1;52;0
WireConnection;38;0;1;0
WireConnection;38;1;2;0
WireConnection;78;0;2;4
WireConnection;78;1;46;0
WireConnection;18;0;10;0
WireConnection;0;0;38;0
WireConnection;0;2;72;0
WireConnection;0;10;78;0
ASEEND*/
//CHKSM=552A654EC69A56E905E74645CBBF33BDFCE6D286