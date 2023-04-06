Shader "Learning/Unlit/TO RENAME"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _texture("Gradient", 2D) = "white" {}
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

			sampler2D _texture;
			
			struct vertexInput
            {
                float4 vertex : POSITION;
			    
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
            	float3 world_space : TEXCOORD0;
            };
			
			// Vertex shader
			// exécuté pour chaque vertex à chaque frame
			// Fonction qui calcule la position des vertex dans l'espace de la caméra
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
            	o.world_space = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

			// Fragment shader
			// exécuté pour chaque pixel à chaque frame
			// Fonction qui calcule la couleur de chaque pixel
            float4 frag(v2f i) : SV_Target
            {
                return tex2D(_texture, i.world_space); // ligne obligatoire // float4(r,g,b,a) = couleur
            }
            
            ENDHLSL
        }
    }
}
