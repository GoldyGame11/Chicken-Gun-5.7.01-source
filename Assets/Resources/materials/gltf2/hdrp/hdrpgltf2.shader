Shader "Shader Graphs/HDRPGLTF2" {
	Properties {
		[NoScaleOffset] _MainTex ("_MainTex", 2D) = "white" {}
		_Color ("_Color", Vector) = (1,1,1,1)
		[NoScaleOffset] [Normal] _BumpMap ("_BumpMap", 2D) = "bump" {}
		_Metallic ("_Metallic", Float) = 0
		_Glossiness ("_Glossiness", Float) = 0
		[NoScaleOffset] _MetallicGlossMap ("_MetallicGlossMap", 2D) = "white" {}
		_EmissionColor ("_EmissionColor", Vector) = (0,0,0,0)
		[NoScaleOffset] _EmissionMap ("_EmissionMap", 2D) = "white" {}
		[NoScaleOffset] _OcclusionMap ("_OcclusionMap", 2D) = "white" {}
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.uv = (input.uv.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			float4 _Color;

			struct Fragment_Stage_Input
			{
				float2 uv : TEXCOORD0;
			};

			float4 frag(Fragment_Stage_Input input) : SV_TARGET
			{
				return _MainTex.Sample(sampler_MainTex, input.uv.xy) * _Color;
			}

			ENDHLSL
		}
	}
	Fallback "Hidden/Shader Graph/FallbackError"
	//CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}