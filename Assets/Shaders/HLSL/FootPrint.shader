Shader "Unlit/footprint"
{
    // Properties are variables that can be set in the inspector
    // DO NOT FORGOT TO DECLARE THEM IN THE HLSL PROGRAM!
    Properties
    {   
        // _HlslVariableName("Inspector Display Name", UnityType) = defaultValue
        _MainTex("Texture", 2D) = "white" {}
        _Speed ("Speed", Range(0.1, 5)) = 1
        _Amplitude ("Amplitude", Range(0, 1)) = 0.1
        _Frequency ("Frequency", Range(0, 10)) = 2
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

			sampler2D _MainTex;
			float _Speed;
			float _Amplitude;
			float _Frequency;
			
            // This struct is used to pass data from the vertex buffer to the vertex shader.
			struct vertexInput
            {
                float4 vertex : POSITION;
			    float3 uv : TEXCOORD0;
            };
			
            // This struct is used to pass data from the vertex shader to the pixel shader.
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 uv : TEXCOORD0;
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
                float2 center = float2(0.5,0.5);
                float d = distance(i.uv, center);
                float spread = sin(_Frequency * d * 3.14159 - _Time.y * _Speed) * _Amplitude;

                float falloff = smoothstep(0, 1, d);
                spread *= falloff;

                float2 uvRipple = i.uv + spread * (i.uv - center) ;
                float4 colorRipple = tex2D(_MainTex, uvRipple);
                if (colorRipple.a < 0.05)
                {
                    discard;
                }
                return colorRipple; 
            }
            
            ENDHLSL
        }
    }
}
