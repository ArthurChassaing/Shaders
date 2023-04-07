
Shader "Learning/Unlit/Vertices"
{
    Properties
    {
        _Amplitude("Amplitude", Float) = 0.00
    }

        SubShader
    {
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

            float _Amplitude;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 worldSpacePosition : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldSpacePosition : TEXCOORD0;
            };

            v2f vert(vertexInput v)
            {
                v2f o;
                v.vertex.y += sin(_Time.y) * _Amplitude;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.worldSpacePosition = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return float4(1,1,1,1);
            }

            ENDHLSL
        }
    }
}