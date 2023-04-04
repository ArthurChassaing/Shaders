Shader "Blend Textures using distance"
{
    Properties
    {
		_Tex1("Texture 1", 2D) = "white" {}
        _Tex2("Texture 2", 2D) = "white" {}
        _MinDistance("Min Distance", Float) = 0.5
        _MaxDistance("Max Distance", Float) = 1.5
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

            sampler2D _Tex1, _Tex2;
            float _MinDistance, _MaxDistance;
			
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
                float3 worldPos : TEXCOORD1;
            };

            // This function is called for each vertex.
            v2f vert (vertexInput v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // This function is called for each pixel.
            float4 frag(v2f i) : SV_Target
            {
                return lerp(
                    tex2D(_Tex1, i.uv),
                    tex2D(_Tex2, i.uv),
                    clamp((distance(i.worldPos, _WorldSpaceCameraPos) - _MinDistance) / (_MaxDistance - _MinDistance), 0, 1)
                    );
            }
            
            ENDHLSL
        }
    }
}
