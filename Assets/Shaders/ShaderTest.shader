Shader "Learning/Unlit/MyFirstShader"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _MainColor ("Color", Color) = (1,1,1,1)
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

			float4 _MainColor;
			
			//Data stored in each vertex
			struct vertexInput
            {
                float4 vertex : POSITION;
			    float4 vertexColor : COLOR;
			    
            };

			//vertex to fragment, data Calculated in vertex shader and passed to fragment shader
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
                //return float4(1,0,0,0);
                return i.vertexColor;
            }
            
            ENDHLSL
        }
    }
}
