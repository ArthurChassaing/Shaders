Shader "Learning/Unlit/shader1"
{
	Properties
	{
		// NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
		_Color0("C0", Color) = (0.34, 0.85, 0.92, 1) // color
		_Color1("C1", Color) = (0.34, 0.85, 0.92, 1) // color
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

			float4 _Color0,_Color1;
			float _LerpAlpha;

			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert(vertexInput v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{

				return lerp(_Color0,_Color1,_LerpAlpha);
			}

			ENDHLSL
		}
	}
}
