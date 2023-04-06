Shader "Learning/Unlit/TO RENAME"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _texture("Texture", 2D) = "white" {}
        _noise_map("Noise map", 2D) = "white" {}
    	_disturbed_factor("Disturb Factor", Range(0,0.2)) = 0.1
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
			sampler2D _noise_map;
			float _ratio;
			
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
            	float noise = tex2Dlod(_Noise, float4(input.texCoord, 0)).rgb;
            	o.grabPos.x += cos(noise*_Time.x*_Speed) * _Strength;
				o.grabPos.y += sin(noise*_Time.x*_Speed) * _Strength;
            	return o;
            }

			// Fragment shader
			// exécuté pour chaque pixel à chaque frame
			// Fonction qui calcule la couleur de chaque pixel
            float4 frag(v2f i) : SV_Target
            {
            	float4 c = lerp(_texture, _noise_map, _ratio);
                return c; // ligne obligatoire // float4(r,g,b,a) = couleur
            }
            
            ENDHLSL
        }
    }
}
