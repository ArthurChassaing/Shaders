Shader "Learning/Unlit/PositifNegatif"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
    	_color1("Color1", Color) = (1,1,1,1)
    	_color2("Color1", Color) = (1,1,1,1)
    }
    
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

			float4 _color1;
			float4 _color2;
			
			struct vertexInput
            {
                float4 vertex : POSITION;					
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
            	float3 world_pos : TEXCOORD0;
            };
			
			// Vertex shader
			// exécuté pour chaque vertex à chaque frame
			// Fonction qui calcule la position des vertex dans l'espace de la caméra
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); // ligne obligatoire // UNITY_MATRIX_MVP = matrice de projection
            	o.world_pos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

			// Fragment shader
			// exécuté pour chaque pixel à chaque frame
			// Fonction qui calcule la couleur de chaque pixel
            float4 frag(v2f i) : SV_Target
            {
            	return i.world_pos.x < 0 ? _color1 : _color2;
            }
            
            ENDHLSL
        }
    }
}
