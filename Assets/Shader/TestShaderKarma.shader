Shader "Learning/Unlit/TO RENAME"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _MainColor("Main Color", Color) = (1,1,1,1)
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

			float4 _MainColor;
			
			struct vertexInput
            {
                float4 vertex : POSITION;						
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;    
            };

			// Vertex shader
			// exécuté pour chaque vertex à chaque frame
			// Fonction qui calcule la position des vertex dans l'espace de la caméra
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); // ligne obligatoire // UNITY_MATRIX_MVP = matrice de projection
                return o;
            }

			// Fragment shader
			// exécuté pour chaque pixel à chaque frame
			// Fonction qui calcule la couleur de chaque pixel
            float4 frag(v2f i) : SV_Target
            {
                return float4(0.5,0,0,0); // ligne obligatoire // float4(r,g,b,a) = couleur
            }
            
            ENDHLSL
        }
    }
}
