﻿Shader "Unlit/ManipulateVertexPos"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;

                float timeVal = (frac(_Time.y / 5) * 2) - 1;

                v.vertex.y = sin(v.vertex.x + _Time.x * 100) * pow(timeVal, 2) * 2;


                //if (_Time.y % 10 > 0.0 && _Time.y % 10 < 5) {
                //    v.vertex.y = sin(v.vertex.x * _Time.y % 10 + _Time.x * 100);
                //}
                //else {
                //    v.vertex.y = sin(v.vertex.x + _Time.x * 100);
                //}




                
                o.vertex = UnityObjectToClipPos(v.vertex);


                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
 
                fixed4 col = tex2D(_MainTex, i.uv);
 
                return col;
            }
            ENDCG
        }
    }
}
