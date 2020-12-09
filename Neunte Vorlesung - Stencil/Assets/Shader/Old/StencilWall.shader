Shader "Custom/StencilWall"
{
    Properties
    {
 
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
 
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
 
        ColorMask 0
        ZWrite off

        Stencil{
            Ref 1
            Comp always
            Pass replace
        }

        CGPROGRAM
         #pragma surface surf Standard fullforwardshadows

 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
 
 
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
 
 
        }
        ENDCG
    }
    FallBack "Diffuse"
}
