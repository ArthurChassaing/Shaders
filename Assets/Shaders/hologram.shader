Shader "Learning/Unlit/hologram"
{
    Properties
    {
        _Albedo0("_Albedo", 2D) = "white" {} // textures 
            _WaveScale("Wave scale", Float) = 0.07
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
    }

        SubShader
    {
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _Albedo0;
            float _WaveScale;
			
			struct vertexInput
            {
                float4 vertex : POSITION;						
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;    
                float3 WolrdSpace : TEXCOORD0;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.WolrdSpace = mul(unity_ObjectToWorld, v.vertex) + _WaveScale * _Time.y;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                if (tex2D(_Albedo0,i.WolrdSpace).r == 0)
                {
                    discard;
                }
                return tex2D(_Albedo0,i.WolrdSpace ) ;
            }
            
            ENDHLSL
        }
    }
}
