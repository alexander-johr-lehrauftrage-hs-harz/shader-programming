Shader "Custom/Decal Shader"
{
    Properties
    {
        _DecalColor("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _MainTex2("Albedo (RGB)", 2D) = "white" {}

        _DecalTex("Decal", 2D) = "white" {}
        _Intensity("Intensity", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
         #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _MainTex2;
        sampler2D _DecalTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
            float2 uv_DecalTex;

        };

 
        fixed4 _DecalColor;
        fixed _Intensity;
        
 
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 decalColor = tex2D(_MainTex2, IN.uv_MainTex2);

 
            fixed4 decalValue = 1 - tex2D(_DecalTex, IN.uv_DecalTex).a;
            fixed4 floorColor = tex2D(_MainTex, IN.uv_MainTex);

            decalValue = max(0, decalValue - _Intensity);



            fixed4 c = (1 - decalValue) * floorColor
                     + (decalValue) * decalColor;

               
            o.Albedo = c.rgb;
 
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
