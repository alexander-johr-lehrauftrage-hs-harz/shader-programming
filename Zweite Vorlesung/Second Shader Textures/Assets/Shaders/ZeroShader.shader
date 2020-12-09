Shader "Custom/ZeroShader"
{
    Properties
    {
    }
    SubShader
    {

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

            o.Albedo = float4(0,0,0,0);

        }
        ENDCG
    }
    FallBack "Diffuse"
}
