Shader "Learning/Unlit/Fresnel"
{
    Properties
    {   
		// Fresnel Exponent : float entre 0.1 & 20
        _exponent ("Fresnel Exponent", Range(0.1, 20)) = 1.0
        // 2 couleurs : une BaseColor (celle du mesh) et une pour l'effet outline du fresnel
        _baseColor ("Base Color", Color) = (1,1,1,1)
        _fresnelColor ("Fresnel Color", Color) = (1,1,1,1) 
    }
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"
			
            float _exponent;
			float4 _baseColor;
			float4 _fresnelColor;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                float3 position : TEXCOORD1;
                // + 
                // Transférer la position & la normale en WORLD SPACE
            };

            v2f vert (vertexInput v)
            {
                v2f o;
               
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
               
                // TO DO 
                // position en float4 => w = 1
                // direction en float4 => w = 0
                // matrice: unity_ObjectToWorld
                float3 dir = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 0)).xyz;
                float3 pos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)).xyz;
                
                o.normal = normalize(dir);
                o.position = pos;
                // la normale en worldspace de la struct v2f doit être normalisée
                
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                // TO DO: Une ligne à coder après chaque commentaire
                // Calculer le vecteur FragmentToCamera puis le normaliser
                float3 fragmentToCamera = normalize(_WorldSpaceCameraPos - i.position);
                // Normaliser de nouveau la normale de la struct v2f
                i.normal = normalize(i.normal);
                // Calcul du produit scalaire entre le vecteur PixelToCamera (View vector) & la normale
	            float NdotV = dot(fragmentToCamera, i.normal);
                // Visualiser le résultat de NdotV  => ligne temporaire, juste pour comprendre l'effet à cette étape
                //return NdotV;
                
                // "Ajuster" le résultat obtenu
                
                // Utiliser la fonction pow(valueToRaise, FresnelExponent)
                float fresnel = pow(NdotV, _exponent);
	            
                // lerp entre BaseColor, FresnelColor et le rim calculé ci-dessus.
                return lerp(_baseColor, _fresnelColor, fresnel);
	            //return float4(0.9, 0.3, 0.2, 1.0);
            }
            ENDHLSL
        }
    }
}
