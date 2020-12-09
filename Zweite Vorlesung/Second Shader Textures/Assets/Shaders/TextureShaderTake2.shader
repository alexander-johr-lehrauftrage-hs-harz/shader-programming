Shader "Custom/TextureShaderTake2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)  // fixed4, half4, float4
        _Textur ("Textur", 2D) = "white" {} // sampler2d

        _u ("Textur Start X", Range(0,1)) = 0.0
        _v ("Textur Start Y", Range(0,1)) = 0.0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _Textur;

        struct Input
        {
            float2 uv_Textur;
        };

        half _u;
        half _v;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float twoPi = 6.28318530718;
            float pi = 3.14159265359;
            float halfPi = 1.57079632679;

            float x = (IN.uv_Textur.x - 0.5) * 2; // x (-1 ... 0 ... 1)
            float y = (IN.uv_Textur.y - 0.5) * 2; // y (-1 ... 0 ... 1)

            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
                       // ( 0 ... 0.5 ... 1)
            o.Albedo.r = frac((atan2(y,x) / twoPi)  + _Time.x);
            o.Albedo.g = frac((atan2(y, x) / twoPi) + _Time.y);
            o.Albedo.b = frac((atan2(y, x) / twoPi) + _Time.z);
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
