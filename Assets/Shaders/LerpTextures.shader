Shader "Lerp Textures"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
		_Tex1("Texture 1", 2D) = "white" {}
        _Tex2("Texture 2", 2D) = "white" {}
        _Lerp("Lerp", Range(0, 1)) = 0.5
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

            float4 _Color;
            sampler2D _Tex1, _Tex2;
            float _Lerp;
			
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
                return lerp(tex2D(_Tex1, i.uv), tex2D(_Tex2, i.uv), _Lerp) * _Color;
            }
            
            ENDHLSL
        }
    }
}
