Shader "Disturb Ball"
{
    // Properties are variables that can be set in the inspector
    // DO NOT FORGOT TO DECLARE THEM IN THE HLSL PROGRAM!
    Properties
    {   
        _DisturbFactor ("Disturb Factor", Float) = 0.5
        _Texture ("Texture", 2D) = "white" {}
        _Speed ("Speed", Range(0, 1)) = 0.5
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
			float _DisturbFactor;
			float _Speed;
			
            // This struct is used to pass data from the vertex buffer to the vertex shader.
			struct vertexInput
            {
                float4 vertex : POSITION;
			    float3 normal : NORMAL;
			    float2 uv : TEXCOORD0;
            };
			
            // This struct is used to pass data from the vertex shader to the pixel shader.
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            // This function is called for each vertex.
            v2f vert (vertexInput v)
            {
                v2f o;
                v.uv.x += _Speed * _Time.y;
                o.uv = v.uv;
                v.vertex.xyz += v.normal * _DisturbFactor * tex2Dlod(_Texture, float4(v.uv, 0, 0)).r;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }

            // This function is called for each pixel.
            float4 frag(v2f i) : SV_Target
            {
                return tex2D(_Texture, i.uv);
            }
            
            ENDHLSL
        }
    }
}
