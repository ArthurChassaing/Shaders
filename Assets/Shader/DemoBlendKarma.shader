Shader "Learning/Unlit/Texture"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _texture("Albedo", 2D) = "white" {}
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

			sampler2D _texture; // variable globale qui contient la texture

			struct vertexInput
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			// Vertex shader
			// exécuté pour chaque vertex à chaque frame
			// Fonction qui calcule la position des vertex dans l'espace de la caméra
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); // ligne obligatoire // UNITY_MATRIX_MVP = matrice de projection
            	o.uv = v.uv;
                return o;
            }

			// Fragment shader
			// exécuté pour chaque pixel à chaque frame
			// Fonction qui calcule la couleur de chaque pixel
            float4 frag(v2f i) : SV_Target
            {
                return tex2D(_texture, i.uv); // ligne obligatoire // tex2D(texture, uv) = couleur
            }
            
            ENDHLSL
        }
    }
}
