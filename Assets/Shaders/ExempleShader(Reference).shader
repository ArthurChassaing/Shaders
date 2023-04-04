Shader "Learning/Unlit/Reference"
{
    // Properties are variables that can be set in the inspector
    // DO NOT FORGOT TO DECLARE THEM IN THE HLSL PROGRAM!
    Properties
    { 
		_WaveScale("Wave scale", Float) = 0.07
        _ReflDistort("Reflection distort", Range(0,1.5)) = 0.5  // slider
        _TintColor("Tint", Color) = (0.34, 0.85, 0.92, 1) // color
        _WindDir("Wind Direction", Vector) = (1, 0, 0, 1)
        _ShieldMap("Shield Map", 2D) = "white" {} // textures 
        _SwordMap("Sword Map", 2D) = "black" {} 	
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }

		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  // Define the vertex shader. Name of the function: vert (can be changed)
            #pragma fragment frag // Define the fragment shader. Name of the function: frag (can be changed)
            #include "UnityCG.cginc"
			
			// Here are the properties shown in the inspector
            float _WaveScale, _ReflDistort;
            sampler2D _ShieldMap, _Re_SwordMapfractionTex;
            float4 _TintColorRefrColor, _WindDir;
			
			struct vertexInput
            {
                float4 vertex : POSITION;						
            };
            
            // Another exemple with more attributes
            /*
            struct vertexInput {
                float4 vertex : POSITION;
                float4 tangent : TANGENT;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 texcoord2 : TEXCOORD2;
                float4 texcoord3 : TEXCOORD3;
                float4 color : COLOR;
            };
            */
			
            // Donn�es qui vont �tre interpol�es par le Rasterizer et qui seront en input du fragment shader
            // Chaque variable de cette struct doit �tre calcul�e dans le vertex shader !
            struct v2f   // v2f = vertex to fragment     ou p-e appel� vertexOutput
            {
	            float4 vertex : SV_POSITION; // => SV_POSITION signifie que c'est la position en clip space 
            };

            v2f vert(vertexInput v)
            {
	            v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); // ETAPE OBLIGATOIRE DU VS. De l'espace objet � l'espace de clipping (�cran)
	            return o;
            }

            // Etape interm�diaire entre le VS et le FS, la rasterization. 
            // Le GPU va d�terminer les fragments couverts par les polygones, et les donn�es transf�r�es
            // du VS au FS seront interpol�es.

            // FRAGMENT SHADER: calcul la couleur finale du fragment/pixel
            float4 frag(v2f i) : SV_Target
            {
	            return float4(1,0,0,0);
            }
            
            ENDHLSL
        }
    }
}
