Shader "Learning/Unlit/TO RENAME"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        t("BlendLevel", Range(0,1)) = 0.5
    	_color1("Color1", Color) = (1,1,1,1)
    	_color2("Color2", Color) = (1,1,1,1)
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

			float t; // variable globale
			float4 _color1; // variable globale
			float4 _color2; // variable globale
			
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
                return lerp(_color1, _color2, t); // ligne obligatoire // float4(r,g,b,a) = couleur
            }
            
            ENDHLSL
        }
    }
}
