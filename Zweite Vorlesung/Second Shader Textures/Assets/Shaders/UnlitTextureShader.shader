Shader "Unlit/UnlitTextureShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            
            #pragma fragment frag

            #pragma vertex vert // Definition: Wie heißt mein Vertex Shader

            // PotentiellenShaderProgrammParameter
            // Welche Parameter bekommt das Vertex Shader Programm
            // von der GPU zur Verfügung gestellt
            // (Weniger bedeutet, geringere Arbeitsspeicherauslastung VRAM)
            // Struct (ähnlich wie eine Klasse)
            // (Prefab für Parameter)
            struct appdata
            {
                float4 color : COLOR;
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            // PotentiellenFragmentProgrammParameterDieInterpoliertWerden
            // Welche Parameter bekommt das Fragment (Pixel) Shader Programm
            // von der GPU zur Verfügung gestellt
            // (Weniger bedeutet, geringere Arbeitsspeicherauslastung VRAM)
            // Struct (ähnlich wie eine Klasse)
            // (Prefab für Parameter)
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 diff : COLOR0;
            };


            v2f vert(appdata v) // Objekt
            {
                v2f f;

                f.vertex = UnityObjectToClipPos(v.vertex);
                f.uv = v.uv;
                f.diff = fixed4(1, 1, 0, 0);
                return f;
            }


            

            sampler2D _MainTex;
            float4 _MainTex_ST;


            fixed4 frag (v2f f) : SV_Target
            {

                float twoPi = 6.28318530718;
                float pi = 3.14159265359;
                float halfPi = 1.57079632679;

                float x = (f.uv.x - 0.5) * 2; // x (-1 ... 0 ... 1)
                float y = (f.uv.y - 0.5) * 2; // y (-1 ... 0 ... 1)

                //fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
                           // ( 0 ... 0.5 ... 1)
                f.diff = frac((atan2(y,x) / pi));
                //f.diff.g = frac((atan2(y, x) / twoPi) + _Time.y);
                //f.diff.b = frac((atan2(y, x) / twoPi) + _Time.z);


                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                return f.diff;
            }
            ENDCG
        }
    }
}
