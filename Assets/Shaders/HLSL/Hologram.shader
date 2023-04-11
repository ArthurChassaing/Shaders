Shader "RENAME ME"
{
    // Properties are variables that can be set in the inspector
    // DO NOT FORGOT TO DECLARE THEM IN THE HLSL PROGRAM!
    Properties
    {   
        _Texture ("Texture", 2D) = "white" {}
        _Speed ("Speed", Float) = 0.1
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

            sampler2D _Texture;
			float _Speed;
			
            // This struct is used to pass data from the vertex buffer to the vertex shader.
			struct vertexInput
            {
                float4 vertex : POSITION;
            };
			
            // This struct is used to pass data from the vertex shader to the pixel shader.
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 _worldSpacePos : TEXCOORD0;
            };

            // This function is called for each vertex.
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o._worldSpacePos = mul(UNITY_MATRIX_MVP, v.vertex).xyz;
                return o;
            }

            // This function is called for each pixel.
            float4 frag(v2f i) : SV_Target
            {
                float4 color = tex2D(_Texture, (i._worldSpacePos.y + _Time.y ) * _Speed);
                if(color.r < 0.5)
                    discard;
                return color; 
            }
            
            ENDHLSL
        }
    }
}
