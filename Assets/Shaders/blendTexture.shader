Shader "Learning/Unlit/blendTexture"
{
	Properties
	{
		// NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
		_Albedo0("_Albedo", 2D) = "white" {} // textures 
		_Albedo1("_Albedo", 2D) = "white" {} // textures 
		_LerpAlpha("lerp Alpha", range(0,1)) = 0.5

	}

		SubShader
	{
		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert  
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _Albedo0,_Albedo1;
			float _LerpAlpha;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 uv : TEXCOORD0;
			};

			v2f vert(vertexInput v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{

				return lerp(tex2D(_Albedo0,i.uv),tex2D(_Albedo1,i.uv),_LerpAlpha);
			}

			ENDHLSL
		}
	}
}
