// Shaderlab Code
Shader "ShaderBFO/First Course/MyFirstShader"
{
    Properties
    {
        //_Color ("Meine Farbe", Color) = (1,1,0,0.0) // 0-1 0.000001   0 - 255 (8 bit) 0 - 512 (9-bit) 0-1024 (10-bit)
    }
    SubShader
    {
        // Shader Code
        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows

        struct Input
        {
            float2 uv_MainTex;
        };

        //fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //fixed4 c = _Color;
            //double zahl; // 0

            // (float1, float2, float3, float4)
            float4 farbe = float4(1, 0, 1, 0);

            // (0,0,0,0) = (1)
            o.Albedo.r = farbe.r;
            //o.Albedo = farbe.x;

            //o.Albedo = farbe.ba;
            //o.Albedo = farbe.yz;

            //o.Albedo = half4(0, 0, 0, 0);
            //o.Albedo = fixed4(0, 0, 0, 0);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
