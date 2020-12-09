Shader "Custom/WorldPositionStripedShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SecondTex("Second Tex", 2D) = "white" {}

        _StripeHeight("Stripe Height", Range (0,10) ) = 1
        _StripeIntensity("Stripe Intensity", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _SecondTex;        
        struct Input
        {
            float3 worldPos;
            float2 uv_MainTex;
            float2 uv_SecondTex;
        };
        fixed4 _Color;
        float _StripeHeight;
        half _StripeIntensity;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {   // -0.1 .. -0.05 .. 0 .. 0.05 0.1 


            float y = (IN.worldPos.y + _Time.z) % _StripeHeight;
                        
            float3 tex = tex2D(_MainTex, IN.uv_MainTex);

            float3 tex2 = tex2D(_SecondTex, IN.uv_SecondTex);

            //fixed3 c = y > (_StripeHeight / 2) ?
            //    float3(0, 0, 1)
            //    : float3(1, 0, 1);

            fixed3 c = y > (_StripeHeight / 2) ?
                tex.rgb * _StripeIntensity + float3(0, 0, 1) * (1 - _StripeIntensity)
                : tex2.rgb * _StripeIntensity + float3(1, 0, 1) * (1 - _StripeIntensity);
             
            // e.g. 0.1   c.rgb * 0.1              + tex.rgb * 0.9
            //            c.rgb * 0.5              + tex.rgb * 0.5
            //            c.rgb * 0.7              + tex.rgb * 0.3
            //o.Albedo =    c.rgb * _StripeIntensity + tex.rgb * (1 - _StripeIntensity); // sum = 1

            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
