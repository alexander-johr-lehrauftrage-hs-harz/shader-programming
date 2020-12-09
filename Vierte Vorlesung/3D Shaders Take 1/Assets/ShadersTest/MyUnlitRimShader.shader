Shader "Unlit/MyUnlitRimShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
 
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
                half3 viewDir: POSITION1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;

                o.normal = v.normal;
                o.viewDir = ObjSpaceViewDir(v.vertex);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = v.normal;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float winkel = 1 - dot(normalize(i.viewDir), normalize(i.normal));
                i.color = float4(1,0,0,0);
                i.color.a = pow(winkel, 2);
                return i.color;
            }
            ENDCG
        }
    }
}
