Shader "Blend Textures using another"
{
    Properties
    {
		_Tex1("Texture 1", 2D) = "white" {}
        _Tex2("Texture 2", 2D) = "white" {}
        _LerpTex("Lerp Texture", 2D) = "white" {}
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
            sampler2D _Tex1, _Tex2, _LerpTex;
			
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
                return lerp(tex2D(_Tex1, i.uv), tex2D(_Tex2, i.uv), tex2D(_LerpTex, i.uv).r);
            }
            
            ENDHLSL
        }
    }
}
