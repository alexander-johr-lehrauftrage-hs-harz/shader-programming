Shader "Custom/MyDecalShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}
        _AlphaMap("Alpha Map", 2D) = "white" {}
        _DecalTex("Decal Map", 2D) = "white" {}

        [PerRendererData] _Intensity("Intensity", Range(0,2)) = 0.1

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        sampler2D _AlphaMap;
        float4 _AlphaMap_TexelSize;

        sampler2D _DecalTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_AlphaMap;
            float2 uv_DecalTex;
        };



        half _Intensity;
        fixed4 _Color;
         
        float4 myTex2D(sampler2D tex, float2 uv) {
            return tex2D(tex, uv) > _Intensity ? 1 : 0;
        }

        float4 box(sampler2D tex, float2 uv, float4 size)
        {
            float4 c = myTex2D(tex, uv + float2(-size.x, size.y)) + myTex2D(tex, uv + float2(0, size.y)) + myTex2D(tex, uv + float2(size.x, size.y)) +
                myTex2D(tex, uv + float2(-size.x, 0)) + myTex2D(tex, uv + float2(0, 0)) + myTex2D(tex, uv + float2(size.x, 0)) +
                myTex2D(tex, uv + float2(-size.x, -size.y)) + myTex2D(tex, uv + float2(0, -size.y)) + myTex2D(tex, uv + float2(size.x, -size.y));

            return c / 9;
        }



        void surf (Input IN, inout SurfaceOutputStandard o)
        {
 
            float4 alpha = tex2D(_AlphaMap, IN.uv_AlphaMap);

            float decalValue = alpha.r;

            decalValue = box(_AlphaMap, IN.uv_AlphaMap, _AlphaMap_TexelSize);

            float originalValue = 1 - decalValue;

            float4 originalColor = tex2D(_MainTex, IN.uv_MainTex);
            float4 decalColor = tex2D(_DecalTex, IN.uv_DecalTex);

            fixed4 c = originalColor * originalValue + decalColor * decalValue;
            o.Albedo = c.rgb;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}