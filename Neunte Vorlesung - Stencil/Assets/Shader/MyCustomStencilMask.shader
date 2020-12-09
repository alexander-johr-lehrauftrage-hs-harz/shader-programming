Shader "Custom/MyCustomStencilMask"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _StencilRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 6
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Sencil Operation", Float) = 0

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        ColorMask 0
        ZWrite off


        Stencil{
            Ref[_StencilRef]
            Comp[_StencilComp]
            Pass[_StencilOp]
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
