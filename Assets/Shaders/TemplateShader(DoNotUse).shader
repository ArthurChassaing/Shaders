Shader "RENAME ME"
{
    // Properties are variables that can be set in the inspector
    // DO NOT FORGOT TO DECLARE THEM IN THE HLSL PROGRAM!
    Properties
    {   
        // _HlslVariableName("Inspector Display Name", UnityType) = defaultValue;
    }
    
    SubShader
    {
        // Default tags for a shader
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag
            #include "UnityCG.cginc"

            // HlslType _HlslVariableName;
			
            // This struct is used to pass data from the vertex buffer to the vertex shader.
			struct vertexInput
            {
                float4 vertex : POSITION;
            };
			
            // This struct is used to pass data from the vertex shader to the pixel shader.
            struct v2f
            {
                float4 vertex : SV_POSITION;    
            };

            // This function is called for each vertex.
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }

            // This function is called for each pixel.
            float4 frag(v2f i) : SV_Target
            {
                return float4(1,1,1,1); 
            }
            
            ENDHLSL
        }
    }
}
