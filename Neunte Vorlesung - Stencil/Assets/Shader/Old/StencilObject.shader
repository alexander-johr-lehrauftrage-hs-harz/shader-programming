Shader "Custom/StencilObject"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
 
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Stencil{
            Ref 1
            Comp NotEqual
            Pass keep
        }

        CGPROGRAM
 
        #pragma surface surf Standard fullforwardshadows
 
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
 
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        { 
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
