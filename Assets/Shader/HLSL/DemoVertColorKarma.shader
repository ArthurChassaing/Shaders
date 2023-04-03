Shader "Learning/Unlit/VertexColor"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"
			
			struct vertexInput
            {
                float4 vertex : POSITION;
			    float4 vertexColor : COLOR;
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 vertexColor : COLOR;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.vertexColor = v.vertexColor;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return i.vertexColor;
            }
            
            ENDHLSL
        }
    }
}
