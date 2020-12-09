Shader "Custom/MyRimShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Range ("Range", Range(0,10)) = 1

    }
    SubShader
    {
        Tags { "RenderType"="Transparent"  "Queue" = "Transparent" }
        LOD 200

        Pass {
            ZWrite on // Bitte schreib in den Z Buffer
            ColorMask 0 // Bitte schreib nicht in den Frame Buffer
        }



        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
             
            float3 viewDir;
        };

        fixed4 _Color;
        float _Range;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            


            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) 
                              * _Color;

            o.Albedo = c.rgb;

            // 0 ... 0.5 ... 1
            float winkel = 1 - dot(normalize(IN.viewDir)
                                  , normalize(o.Normal));
            o.Alpha = pow(winkel, _Range);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
