Shader "Custom/WorldPositionShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        struct Input
        {
            float3 worldPos;
            float2 uv_MainTex;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed3 c = IN.worldPos.y > 0 ? 
                float3(1, 0, 0) 
                : float3(0, 1, 0); //tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
