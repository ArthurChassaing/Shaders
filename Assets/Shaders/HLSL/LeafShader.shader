Shader "Leaf Shader"
{
    Properties
    {
		_Tex("Texture", 2D) = "white" {}
        _Alpha("First alpha discard", Range(0, 1)) = 1
    }

        SubShader
    {
        // Default tags for a shader
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

        Pass
        {
            Cull Off

            HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _Tex;
            float _Alpha;
			
            // This struct is used to pass data from the vertex buffer to the vertex shader.
			struct vertexInput
            {
                float4 vertex : POSITION;
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
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
                return o;
            }

            // This function is called for each pixel.
            float4 frag(v2f i) : SV_Target
            {
                float4 color = tex2D(_Tex, i.uv);
                if (color.a <= _Alpha)
					discard;
                return color;
            }
            
            ENDHLSL
        }
    }
}
