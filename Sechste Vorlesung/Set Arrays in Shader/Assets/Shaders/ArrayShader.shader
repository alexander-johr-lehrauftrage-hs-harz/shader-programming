Shader "Custom/ArrayShader"
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
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
 
        #pragma surface surf Standard fullforwardshadows

 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

 
        fixed4 _Color;

        float3 _VectorArray[1]; 
        int _VectorArrayLen;

        void surf (Input IN, inout SurfaceOutputStandard o)
        { 
            float3 averageVector = float3(0,0,0);
            for (int i = 0; i< _VectorArrayLen; i++) {
                float3 vectorEntry = _VectorArray[i];
                averageVector += vectorEntry;
            }
            //averageVector /= _VectorArrayLen;
 
            o.Albedo = averageVector.rgb;
 
        }
        ENDCG
    }
    FallBack "Diffuse"
}
