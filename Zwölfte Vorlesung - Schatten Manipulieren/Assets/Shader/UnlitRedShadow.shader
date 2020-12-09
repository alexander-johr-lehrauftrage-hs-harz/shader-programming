Shader "Unlit/UnlitRedShadow"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {        
        Pass
        {
            Tags{"LightMode" = "ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            //#include "Lighting.cginc"
            #include "AutoLight.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                fixed4 diff : COLOR0;
                float4 pos : SV_POSITION;
                SHADOW_COORDS(1)
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half lightWinkel =  max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));



                o.diff = lightWinkel * _LightColor0 + (1 - lightWinkel) * float4(1, 0, 0, 0);

                TRANSFER_SHADOW(o)

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);

                // Schatten stark => shadow 0 ... 0.1
                // Schatten schwach=> shadow 0.9 ... 1

            fixed shadow = SHADOW_ATTENUATION(i);

                // Cocktail:   Anteil A = Lichtfarbe 1 0.8  +  Anteil B = Schattenfarbe 0 0.2   Cocktail summe = 1
                fixed4 cocktailAnteilLicht = i.diff * shadow;
                fixed4 cocktailAnteilSchatten = float4(1, 0, 0, 0) * (1 - shadow);



                col.rgb *= cocktailAnteilLicht + cocktailAnteilSchatten;
                return col;
            }
            ENDCG
        }
        Pass
        {
            Tags { "LightMode" = "ShadowCaster"}

            CGPROGRAM
            
            #pragma vertex vert 
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f{
                V2F_SHADOW_CASTER;
            };

            v2f vert(appdata v) {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);
                return o;
            }

            float4 frag(v2f i) : SV_Target{
                SHADOW_CASTER_FRAGMENT(i);
            }

            ENDCG
        }
    }
}
