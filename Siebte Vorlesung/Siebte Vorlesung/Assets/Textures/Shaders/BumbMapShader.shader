Shader "Custom/BumbMapShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NormalTex("Normal Texture", 2D) = "white" {}

        _NormalRange("NormalRange", Range(0,10)) = 0.5
        _BrightnessRange("BrightnessRange", Range(0,1)) = 0.5
 

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
 

        CGPROGRAM
         #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _NormalTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalTex;
        };

        half _NormalRange;
        half _BrightnessRange;
        fixed4 _Color;
        half _NormalX;
        half _NormalY;
        half _NormalZ;
 
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
 
            o.Normal = UnpackNormal( tex2D(_NormalTex, IN.uv_NormalTex)) * _NormalRange;
            o.Normal *= float3(_NormalRange, -1 * _NormalRange, 1);
 
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
