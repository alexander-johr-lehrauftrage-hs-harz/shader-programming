Shader "Custom/TexturesShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)    // fixed4, half4, float4
        _Textur("Textur", 2D) = "white" {}     // sampler2D

        _u("Textur Start X", Range(0,1)) = 0.0 // fixed, half, float
        _v("Textur Start Y", Range(0,1)) = 0.0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        fixed4 _Color;
        sampler2D _Textur;
        fixed _u;
        fixed _v;
        // fixed4x4

        struct Input
        {
            float2 uv_Textur;
        };

        

        void surf (Input input, inout SurfaceOutputStandard o)
        {


            //float winkel =atan2(input.uv_Textur.x, input.uv_Textur.y);

			//float winkel = frac(atan2(input.uv_Textur.x - 0.5, input.uv_Textur.y - 0.5) / (3.14159 / 2) + _Time.x);
			//float winkel = frac(atan2(input.uv_Textur.x - 0.5, input.uv_Textur.y - 0.5) / 6.2832 + _Time.x);


            float2 myUv = float2( input.uv_Textur.x / 4 + _u // x
                                  , input.uv_Textur.y / 4 + _v);   // y

            //fixed4 c = // tex2D (_Textur, myUv) *
            //           winkel;

 
            
            //o.Albedo.r = (input.uv_Textur.x - 0.5) * 2;
            //o.Albedo.g = (input.uv_Textur.y - 0.5) * 2;

            //o.Albedo.r =   atan2((input.uv_Textur.y - 0.5) * 2, (input.uv_Textur.x - 0.5) * 2) / (3.14159 /2);
            //o.Albedo.g = -atan2((input.uv_Textur.y - 0.5) * 2, (input.uv_Textur.x - 0.5) * 2) / (3.14159 / 2);

            o.Albedo.r = frac(atan2((input.uv_Textur.y - 0.5) * 2, (input.uv_Textur.x - 0.5) * 2) / (3.14159 * 2) + _Time.x);
            o.Albedo.g = frac(atan2((input.uv_Textur.y - 0.5) * 2, (input.uv_Textur.x - 0.5) * 2) / (3.14159 * 2) + _Time.y);
            o.Albedo.b = frac(atan2((input.uv_Textur.y - 0.5) * 2, (input.uv_Textur.x - 0.5) * 2) / (3.14159 * 2) + _Time.z);

            //o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
