// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Particles/Additive,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:35373,y:32831,varname:node_9361,prsc:2|normal-9167-RGB,emission-4774-OUT,alpha-5221-OUT,refract-8227-OUT;n:type:ShaderForge.SFN_TexCoord,id:7247,x:30275,y:32794,varname:node_7247,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Abs,id:7335,x:32471,y:32805,varname:node_7335,prsc:2|IN-8589-OUT;n:type:ShaderForge.SFN_Slider,id:8953,x:31326,y:33252,ptovrint:False,ptlb:EmissionLineWidth,ptin:_EmissionLineWidth,varname:_EmissionLineWidth,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.739786,max:1;n:type:ShaderForge.SFN_RemapRange,id:4978,x:32147,y:33140,varname:E_WidthRemap,prsc:0,frmn:0,frmx:1,tomn:50,tomx:5|IN-8953-OUT;n:type:ShaderForge.SFN_Clamp01,id:6806,x:32903,y:32805,varname:node_6806,prsc:2|IN-975-OUT;n:type:ShaderForge.SFN_Clamp01,id:5799,x:33461,y:32180,varname:DisMask,prsc:1|IN-8458-OUT;n:type:ShaderForge.SFN_Fresnel,id:2019,x:32927,y:32320,varname:Fresned,prsc:1|EXP-3575-OUT;n:type:ShaderForge.SFN_Slider,id:9105,x:32093,y:32350,ptovrint:False,ptlb:Fresnel,ptin:_Fresnel,varname:_Fresnel,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:5;n:type:ShaderForge.SFN_Exp,id:3575,x:32608,y:32346,varname:node_3575,prsc:2,et:0|IN-9105-OUT;n:type:ShaderForge.SFN_Color,id:9553,x:32756,y:32134,ptovrint:False,ptlb:Fresnel Color,ptin:_FresnelColor,varname:_FresnelColor,prsc:0,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.1544118,c2:0.5451315,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:4732,x:33008,y:32038,varname:node_4732,prsc:2|A-9553-RGB,B-2019-OUT;n:type:ShaderForge.SFN_Tex2d,id:851,x:32515,y:31667,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:8939,x:32320,y:31955,ptovrint:False,ptlb:EmissionTex,ptin:_EmissionTex,varname:_EmissionTex,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1788-UVOUT;n:type:ShaderForge.SFN_Multiply,id:2436,x:33369,y:32400,varname:node_2436,prsc:2|A-8939-RGB,B-5557-RGB,C-6806-OUT;n:type:ShaderForge.SFN_Color,id:5557,x:32618,y:32595,ptovrint:False,ptlb:EmissionColor,ptin:_EmissionColor,varname:_EmissionColor,prsc:0,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:5508,x:34748,y:32153,varname:node_5508,prsc:2|A-851-RGB,B-55-OUT,T-5799-OUT;n:type:ShaderForge.SFN_Add,id:4774,x:35056,y:32486,varname:node_4774,prsc:2|A-5508-OUT,B-2436-OUT;n:type:ShaderForge.SFN_Lerp,id:8448,x:33915,y:32513,varname:Alpha,prsc:1|A-3998-OUT,B-281-OUT,T-5799-OUT;n:type:ShaderForge.SFN_Vector1,id:3998,x:33880,y:32349,varname:Value_1,prsc:0,v1:1;n:type:ShaderForge.SFN_Slider,id:8285,x:30936,y:32928,ptovrint:False,ptlb:Switch,ptin:_Switch,varname:_Switch,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:9167,x:33734,y:32858,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:_NormalMap,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_NormalVector,id:5925,x:33377,y:33288,prsc:2,pt:True;n:type:ShaderForge.SFN_Multiply,id:993,x:33565,y:33280,varname:node_993,prsc:2|A-9167-RGB,B-5925-OUT,C-8422-OUT;n:type:ShaderForge.SFN_ComponentMask,id:3128,x:34170,y:33483,varname:RefractionFinal,prsc:1,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8409-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:7109,x:33797,y:33736,ptovrint:False,ptlb:Refraction,ptin:_Refraction,varname:_Refraction,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True;n:type:ShaderForge.SFN_Slider,id:6224,x:33335,y:33608,ptovrint:False,ptlb:RefractionStrength,ptin:_RefractionStrength,varname:_RefractionStrength,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.06843606,max:1;n:type:ShaderForge.SFN_Vector3,id:5406,x:33823,y:33166,varname:node_5406,prsc:0,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Lerp,id:307,x:33959,y:33306,varname:node_307,prsc:2|A-5406-OUT,B-993-OUT,T-6224-OUT;n:type:ShaderForge.SFN_Multiply,id:8409,x:33864,y:33535,varname:node_8409,prsc:2|A-307-OUT,B-7109-OUT;n:type:ShaderForge.SFN_Vector1,id:8422,x:33307,y:33449,varname:node_8422,prsc:2,v1:0.5;n:type:ShaderForge.SFN_OneMinus,id:975,x:32661,y:32805,varname:node_975,prsc:2|IN-7335-OUT;n:type:ShaderForge.SFN_Multiply,id:5221,x:34234,y:32621,varname:AlphaFinal,prsc:1|A-9553-A,B-8448-OUT,C-925-OUT;n:type:ShaderForge.SFN_Panner,id:1788,x:32026,y:32537,varname:EmissionUV,prsc:0,spu:0,spv:-0.15|UVIN-7247-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:7518,x:32533,y:33549,ptovrint:False,ptlb:DissolveMask,ptin:_DissolveMask,varname:_DissolveMask,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:11868e4144e4ed541a6ae3cd71db9121,ntxv:0,isnm:False|UVIN-703-OUT;n:type:ShaderForge.SFN_Desaturate,id:7652,x:32852,y:33448,varname:Mask,prsc:0|COL-7518-RGB;n:type:ShaderForge.SFN_Add,id:8589,x:33231,y:33044,varname:MaskAdd,prsc:0|A-8339-OUT,B-7652-OUT;n:type:ShaderForge.SFN_Add,id:8458,x:33548,y:32753,varname:node_8458,prsc:2|A-341-OUT,B-8589-OUT;n:type:ShaderForge.SFN_Vector1,id:341,x:33349,y:32767,varname:node_341,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Multiply,id:3298,x:33008,y:31875,varname:node_3298,prsc:2|A-851-RGB,B-5557-RGB,C-5557-A;n:type:ShaderForge.SFN_Slider,id:5024,x:32952,y:31500,ptovrint:False,ptlb:TexColorLerp,ptin:_TexColorLerp,varname:_TexColorLerp,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:6456,x:33557,y:31778,varname:node_6456,prsc:2|A-5557-RGB,B-7672-OUT,T-5024-OUT;n:type:ShaderForge.SFN_Add,id:7672,x:33396,y:31954,varname:node_7672,prsc:2|A-3298-OUT,B-4732-OUT;n:type:ShaderForge.SFN_Add,id:281,x:33087,y:32546,varname:node_281,prsc:2|A-2019-OUT,B-5557-A;n:type:ShaderForge.SFN_Multiply,id:7081,x:31974,y:34286,varname:node_7081,prsc:2|A-7247-V,B-3666-OUT;n:type:ShaderForge.SFN_Vector1,id:3666,x:31735,y:34320,varname:node_3666,prsc:2,v1:100;n:type:ShaderForge.SFN_Append,id:4132,x:32086,y:34033,varname:objUV,prsc:2|A-7247-U,B-7081-OUT;n:type:ShaderForge.SFN_Multiply,id:8503,x:33081,y:34000,varname:node_8503,prsc:2|A-8346-R,B-5856-OUT,C-1940-OUT;n:type:ShaderForge.SFN_Vector1,id:5856,x:33026,y:34147,varname:node_5856,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Time,id:6934,x:31003,y:33885,varname:Time,prsc:2;n:type:ShaderForge.SFN_Slider,id:184,x:30926,y:33774,ptovrint:False,ptlb:NoiseSpeed,ptin:_NoiseSpeed,varname:_NoiseSpeed,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0.4512348,max:1;n:type:ShaderForge.SFN_Multiply,id:5658,x:31600,y:33954,varname:NoiseMove,prsc:2|A-184-OUT,B-6934-T,C-8106-OUT;n:type:ShaderForge.SFN_Add,id:7598,x:33684,y:33868,varname:N1,prsc:1|A-5658-OUT,B-5579-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8346,x:32744,y:33990,varname:Noise_1,prsc:1,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-4132-OUT;n:type:ShaderForge.SFN_Slider,id:3317,x:32452,y:34302,ptovrint:False,ptlb:NoiseSize,ptin:_NoiseSize,varname:_NoiseSize,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:2.572649,max:5;n:type:ShaderForge.SFN_RemapRange,id:1940,x:32777,y:34268,varname:NoiseSizeRemap,prsc:1,frmn:1,frmx:5,tomn:200,tomx:0.05|IN-3317-OUT;n:type:ShaderForge.SFN_Multiply,id:6986,x:33244,y:34170,varname:node_6986,prsc:2|A-5792-OUT,B-1940-OUT;n:type:ShaderForge.SFN_Append,id:5579,x:33446,y:34087,varname:Noise_1_Final,prsc:1|A-8503-OUT,B-6986-OUT;n:type:ShaderForge.SFN_Add,id:3704,x:33373,y:34831,varname:node_3704,prsc:2|A-9815-OUT,B-1828-OUT;n:type:ShaderForge.SFN_Negate,id:7949,x:31735,y:34484,varname:node_7949,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1454,x:32533,y:34578,varname:Noise_2,prsc:1,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-4132-OUT;n:type:ShaderForge.SFN_Multiply,id:1311,x:33098,y:34464,varname:node_1311,prsc:2|A-1940-OUT,B-9662-OUT;n:type:ShaderForge.SFN_Multiply,id:6261,x:33063,y:34597,varname:node_6261,prsc:2|A-1940-OUT,B-1710-OUT,C-1454-R;n:type:ShaderForge.SFN_Vector1,id:1710,x:32767,y:34707,varname:node_1710,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Append,id:9815,x:33280,y:34575,varname:Noise_2_Final,prsc:2|A-6261-OUT,B-1311-OUT;n:type:ShaderForge.SFN_Add,id:2464,x:33695,y:34336,varname:NoiseUV,prsc:2|A-3115-OUT,B-6945-OUT;n:type:ShaderForge.SFN_Noise,id:5003,x:33880,y:34336,varname:NoiseAppend,prsc:2|XY-2464-OUT;n:type:ShaderForge.SFN_Multiply,id:1516,x:34076,y:34594,varname:node_1516,prsc:2|A-5003-OUT,B-136-OUT;n:type:ShaderForge.SFN_Vector1,id:136,x:33837,y:34536,varname:node_136,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Power,id:3180,x:34479,y:34423,varname:node_3180,prsc:2|VAL-1516-OUT,EXP-9901-OUT;n:type:ShaderForge.SFN_Vector1,id:9901,x:34024,y:34203,varname:node_9901,prsc:2,v1:2.5;n:type:ShaderForge.SFN_Color,id:2725,x:33954,y:33914,ptovrint:False,ptlb:NoiseColor,ptin:_NoiseColor,varname:_NoiseColor,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5815,x:34717,y:33937,varname:node_5815,prsc:2|A-2725-RGB,B-3180-OUT,C-3794-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:3794,x:34385,y:34131,ptovrint:False,ptlb:AddNoise,ptin:_AddNoise,varname:_AddNoise,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True;n:type:ShaderForge.SFN_Add,id:55,x:34502,y:32355,varname:node_55,prsc:2|A-6456-OUT,B-5815-OUT,C-6441-OUT;n:type:ShaderForge.SFN_Multiply,id:1828,x:31832,y:34759,varname:node_1828,prsc:2|A-7949-OUT,B-6934-T,C-8106-OUT;n:type:ShaderForge.SFN_Sin,id:4069,x:33075,y:34299,varname:node_4069,prsc:2|IN-1454-G;n:type:ShaderForge.SFN_Abs,id:9662,x:33244,y:34319,varname:node_9662,prsc:2|IN-4069-OUT;n:type:ShaderForge.SFN_Sin,id:5126,x:33053,y:33865,varname:node_5126,prsc:2|IN-8346-G;n:type:ShaderForge.SFN_Abs,id:5792,x:33302,y:33839,varname:node_5792,prsc:2|IN-5126-OUT;n:type:ShaderForge.SFN_Floor,id:3115,x:33786,y:34169,varname:node_3115,prsc:2|IN-7598-OUT;n:type:ShaderForge.SFN_Floor,id:6945,x:33612,y:34647,varname:node_6945,prsc:2|IN-3704-OUT;n:type:ShaderForge.SFN_Vector1,id:8106,x:31177,y:34397,varname:speedMul,prsc:1,v1:10;n:type:ShaderForge.SFN_Abs,id:7511,x:32269,y:35156,varname:node_7511,prsc:2|IN-6279-OUT;n:type:ShaderForge.SFN_Multiply,id:1305,x:32560,y:35197,varname:node_1305,prsc:2|A-7511-OUT,B-22-OUT;n:type:ShaderForge.SFN_Slider,id:3804,x:31618,y:35468,ptovrint:False,ptlb:LineWidth,ptin:_LineWidth,varname:_LineWidth,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:6.336524,max:10;n:type:ShaderForge.SFN_Multiply,id:6651,x:31581,y:35189,varname:Line,prsc:1|A-7247-V,B-7803-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7803,x:31244,y:35179,ptovrint:False,ptlb:LineTiling,ptin:_LineTiling,varname:_LineTiling,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:10;n:type:ShaderForge.SFN_Sin,id:6279,x:31983,y:35169,varname:node_6279,prsc:2|IN-5494-OUT;n:type:ShaderForge.SFN_Slider,id:7110,x:31487,y:35022,ptovrint:False,ptlb:LineSpeed,ptin:_LineSpeed,varname:_LineSpeed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:-2,max:10;n:type:ShaderForge.SFN_Multiply,id:4179,x:31904,y:34979,varname:node_4179,prsc:2|A-6934-T,B-7110-OUT;n:type:ShaderForge.SFN_Add,id:5494,x:32064,y:35007,varname:node_5494,prsc:2|A-4179-OUT,B-6651-OUT;n:type:ShaderForge.SFN_OneMinus,id:5142,x:32821,y:35218,varname:node_5142,prsc:2|IN-1305-OUT;n:type:ShaderForge.SFN_Clamp01,id:6897,x:33409,y:35240,varname:node_6897,prsc:2|IN-5142-OUT;n:type:ShaderForge.SFN_Multiply,id:6441,x:34550,y:35017,varname:AddLineCol,prsc:1|A-2725-RGB,B-196-OUT,C-6897-OUT,D-4992-OUT,E-3180-OUT;n:type:ShaderForge.SFN_Slider,id:196,x:33522,y:35095,ptovrint:False,ptlb:LineBrightness,ptin:_LineBrightness,varname:_LineBrightness,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:2,max:20;n:type:ShaderForge.SFN_ToggleProperty,id:4992,x:33786,y:35621,ptovrint:False,ptlb:AddLine,ptin:_AddLine,varname:_AddLine,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True;n:type:ShaderForge.SFN_RemapRange,id:22,x:32052,y:35439,varname:node_22,prsc:2,frmn:1,frmx:10,tomn:100,tomx:1|IN-3804-OUT;n:type:ShaderForge.SFN_Slider,id:6608,x:31228,y:33448,ptovrint:False,ptlb:EmissionLineSpeed_U,ptin:_EmissionLineSpeed_U,varname:_EmissionLineSpeed_U,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0.04,max:1;n:type:ShaderForge.SFN_Slider,id:8609,x:31576,y:33709,ptovrint:False,ptlb:EmissionLineSpeed_V,ptin:_EmissionLineSpeed_V,varname:_EmissionLineSpeed_V,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:-0.2,max:1;n:type:ShaderForge.SFN_Multiply,id:2093,x:31730,y:33284,varname:node_2093,prsc:2|A-6608-OUT,B-6934-T;n:type:ShaderForge.SFN_Multiply,id:3140,x:31927,y:33645,varname:node_3140,prsc:2|A-6934-T,B-8609-OUT;n:type:ShaderForge.SFN_Add,id:703,x:32195,y:33473,varname:node_703,prsc:2|A-7247-UVOUT,B-7422-OUT;n:type:ShaderForge.SFN_Append,id:7422,x:31995,y:33493,varname:node_7422,prsc:2|A-2093-OUT,B-3140-OUT;n:type:ShaderForge.SFN_Slider,id:925,x:33907,y:32730,ptovrint:False,ptlb:GlobalAlpha,ptin:_GlobalAlpha,varname:_GlobalAlpha,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:8227,x:34429,y:33325,varname:node_8227,prsc:2|A-925-OUT,B-3128-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:1625,x:31775,y:32753,ptovrint:False,ptlb:OppositeDir,ptin:_OppositeDir,varname:_OppositeDir,prsc:1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-5828-OUT,B-316-OUT;n:type:ShaderForge.SFN_ComponentMask,id:5828,x:31023,y:32539,varname:UV_Y,prsc:1,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-7247-UVOUT;n:type:ShaderForge.SFN_OneMinus,id:316,x:31487,y:32747,varname:node_316,prsc:2|IN-5828-OUT;n:type:ShaderForge.SFN_Add,id:7135,x:32013,y:32919,varname:UV_Y_add,prsc:1|A-1625-OUT,B-4690-OUT;n:type:ShaderForge.SFN_Multiply,id:8339,x:32387,y:33071,varname:node_8339,prsc:2|A-7135-OUT,B-4978-OUT;n:type:ShaderForge.SFN_RemapRange,id:4690,x:31310,y:32949,varname:node_4690,prsc:2,frmn:0,frmx:1,tomn:-1.1,tomx:0.6|IN-8285-OUT;proporder:851-9167-8939-5557-8953-1625-6608-8609-9105-9553-7109-6224-5024-3794-2725-184-3317-4992-3804-7803-7110-196-7518-8285-925;pass:END;sub:END;*/

Shader "D_Shader/D_Shader_HolographicProjection" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _EmissionTex ("EmissionTex", 2D) = "white" {}
        [HDR]_EmissionColor ("EmissionColor", Color) = (0.5,0.5,0.5,1)
        _EmissionLineWidth ("EmissionLineWidth", Range(0, 1)) = 0.739786
        [MaterialToggle] _OppositeDir ("OppositeDir", Float ) = 1
        _EmissionLineSpeed_U ("EmissionLineSpeed_U", Range(-1, 1)) = 0.04
        _EmissionLineSpeed_V ("EmissionLineSpeed_V", Range(-1, 1)) = -0.2
        _Fresnel ("Fresnel", Range(0, 5)) = 0
        [HDR]_FresnelColor ("Fresnel Color", Color) = (0.1544118,0.5451315,1,1)
        [MaterialToggle] _Refraction ("Refraction", Float ) = 1
        _RefractionStrength ("RefractionStrength", Range(0, 1)) = 0.06843606
        _TexColorLerp ("TexColorLerp", Range(0, 1)) = 0
        [MaterialToggle] _AddNoise ("AddNoise", Float ) = 1
        _NoiseColor ("NoiseColor", Color) = (0.5,0.5,0.5,1)
        _NoiseSpeed ("NoiseSpeed", Range(-1, 1)) = 0.4512348
        _NoiseSize ("NoiseSize", Range(1, 5)) = 2.572649
        [MaterialToggle] _AddLine ("AddLine", Float ) = 1
        _LineWidth ("LineWidth", Range(1, 10)) = 6.336524
        _LineTiling ("LineTiling", Float ) = 10
        _LineSpeed ("LineSpeed", Range(-10, 10)) = -2
        _LineBrightness ("LineBrightness", Range(1, 20)) = 2
        _DissolveMask ("DissolveMask", 2D) = "white" {}
        _Switch ("Switch", Range(0, 1)) = 1
        _GlobalAlpha ("GlobalAlpha", Range(0, 1)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles metal xboxone ps4 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform fixed _EmissionLineWidth;
            uniform half _Fresnel;
            uniform fixed4 _FresnelColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _EmissionTex; uniform float4 _EmissionTex_ST;
            uniform fixed4 _EmissionColor;
            uniform fixed _Switch;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform fixed _Refraction;
            uniform fixed _RefractionStrength;
            uniform sampler2D _DissolveMask; uniform float4 _DissolveMask_ST;
            uniform fixed _TexColorLerp;
            uniform fixed _NoiseSpeed;
            uniform half _NoiseSize;
            uniform fixed4 _NoiseColor;
            uniform fixed _AddNoise;
            uniform half _LineWidth;
            uniform half _LineTiling;
            uniform float _LineSpeed;
            uniform half _LineBrightness;
            uniform fixed _AddLine;
            uniform fixed _EmissionLineSpeed_U;
            uniform fixed _EmissionLineSpeed_V;
            uniform fixed _GlobalAlpha;
            uniform fixed _OppositeDir;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                float4 projPos : TEXCOORD6;
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                half3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + (_GlobalAlpha*(lerp(fixed3(0,0,1),(_NormalMap_var.rgb*normalDirection*0.5),_RefractionStrength)*_Refraction).rg);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                half4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                half Fresned = pow(1.0-max(0,dot(normalDirection, viewDirection)),exp(_Fresnel));
                float4 Time = _Time;
                half speedMul = 10.0;
                float2 objUV = float2(i.uv1.r,(i.uv1.g*100.0));
                half2 Noise_1 = objUV.rg;
                half NoiseSizeRemap = (_NoiseSize*-49.9875+249.9875);
                half2 Noise_2 = objUV.rg;
                float2 NoiseUV = (floor(((_NoiseSpeed*Time.g*speedMul)+float2((Noise_1.r*1.2*NoiseSizeRemap),(abs(sin(Noise_1.g))*NoiseSizeRemap))))+floor((float2((NoiseSizeRemap*0.5*Noise_2.r),(NoiseSizeRemap*abs(sin(Noise_2.g))))+((-1*_NoiseSpeed)*Time.g*speedMul))));
                float2 NoiseAppend_skew = NoiseUV + 0.2127+NoiseUV.x*0.3713*NoiseUV.y;
                float2 NoiseAppend_rnd = 4.789*sin(489.123*(NoiseAppend_skew));
                float NoiseAppend = frac(NoiseAppend_rnd.x*NoiseAppend_rnd.y*(1+NoiseAppend_skew.x));
                float node_3180 = pow((NoiseAppend*1.2),2.5);
                half UV_Y = i.uv1.g;
                float2 node_703 = (i.uv1+float2((_EmissionLineSpeed_U*Time.g),(Time.g*_EmissionLineSpeed_V)));
                fixed4 _DissolveMask_var = tex2D(_DissolveMask,TRANSFORM_TEX(node_703, _DissolveMask));
                fixed MaskAdd = (((lerp( UV_Y, (1.0 - UV_Y), _OppositeDir )+(_Switch*1.7+-1.1))*(_EmissionLineWidth*-45.0+50.0))+dot(_DissolveMask_var.rgb,float3(0.3,0.59,0.11)));
                half DisMask = saturate((0.25+MaskAdd));
                float4 node_5597 = _Time;
                fixed2 EmissionUV = (i.uv1+node_5597.g*float2(0,-0.15));
                fixed4 _EmissionTex_var = tex2D(_EmissionTex,TRANSFORM_TEX(EmissionUV, _EmissionTex));
                float3 emissive = (lerp(_MainTex_var.rgb,(lerp(_EmissionColor.rgb,((_MainTex_var.rgb*_EmissionColor.rgb*_EmissionColor.a)+(_FresnelColor.rgb*Fresned)),_TexColorLerp)+(_NoiseColor.rgb*node_3180*_AddNoise)+(_NoiseColor.rgb*_LineBrightness*saturate((1.0 - (abs(sin(((Time.g*_LineSpeed)+(i.uv1.g*_LineTiling))))*(_LineWidth*-11.0+111.0))))*_AddLine*node_3180)),DisMask)+(_EmissionTex_var.rgb*_EmissionColor.rgb*saturate((1.0 - abs(MaskAdd)))));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(lerp(sceneColor.rgb, finalColor,(_FresnelColor.a*lerp(1.0,(Fresned+_EmissionColor.a),DisMask)*_GlobalAlpha)),1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Particles/Additive"
    CustomEditor "ShaderForgeMaterialInspector"
}
