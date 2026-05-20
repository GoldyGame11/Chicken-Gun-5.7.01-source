Shader "Custom/FCP_Gradient" {
	Properties {
		[Enum(Horizontal,0,Vertical,1,Double,2,HueHorizontal,3,HueVertical,4)] [PerRendererData] _Mode ("Color mode", Float) = 0
		[PerRendererData] _Color1 ("Color 1", Vector) = (1,1,1,1)
		[PerRendererData] _Color2 ("Color 2", Vector) = (1,1,1,1)
		[Enum(HS, 0, HV, 1, SH, 2, SV, 3, VH, 4, VS, 5)] [PerRendererData] _DoubleMode ("Double mode", Float) = 0
		[PerRendererData] _HSV ("Complementing HSV values", Vector) = (0,0,0,1)
		[PerRendererData] _HSV_MIN ("Min Range value for HSV", Vector) = (0,0,0,0)
		[PerRendererData] _HSV_MAX ("Max Range value for HSV", Vector) = (1,1,1,1)
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				return float4(1.0, 1.0, 1.0, 1.0); // RGBA
			}

			ENDHLSL
		}
	}
}