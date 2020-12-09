Shader "Custom/MySurfVertexShader2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _WaveSpeed("Wave Speed", Range(0,100)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard vertex:vert fullforwardshadows

        sampler2D _MainTex;
        float _WaveSpeed;

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
        };

        void vert(inout appdata v) {

            

           // float curve = exp(-0.5 * pow(v.vertex.x - (push - 10), 2) )
              

            
            
            
            
            
            
            
            
            
            
            float push = (_Time.y * _WaveSpeed) % 20;
            float curve = exp(-0.2 * pow(v.vertex.x - (push - 10), 2)) *
                          cos(2 * 3.14 * (v.vertex.x - (push - 10)));













            //float curve = 2 * exp(-0.2 * pow(v.vertex.x - (push - 10), 2)) * cos(2 * 3.14 * (v.vertex.x - (push - 10)) );


            v.vertex.y = curve;
        }

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = _Color;
            o.Albedo = c.rgb;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}