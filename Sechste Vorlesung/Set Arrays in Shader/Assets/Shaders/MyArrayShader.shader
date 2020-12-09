Shader "Custom/MyArrayShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        float2 _VectorArray[10];
        int _VectorArrayLen;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {            
            float d = 0;
            for (int i = 0; i < _VectorArrayLen; i++) {

                float dist = 1 - distance(float2(IN.uv_MainTex.x, IN.uv_MainTex.y), _VectorArray[i]);

                d += pow(clamp(dist - 0.0, 0, 1), 20);
            } 

            o.Albedo = float3(1,0,0) * (1-d) + float3(0,0,1) * d;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
