Shader "Custom/RimShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 200


        Pass{
            ZWrite on
            ColorMask 0
        }


        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;

        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

 
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // 1 , 0.75, 0.50, 0.75, 1
            float rim =  1- dot(IN.viewDir, o.Normal);
             

            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color * pow(rim, 1);
            o.Albedo = c.rgb;
  
            o.Alpha = pow(rim, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
