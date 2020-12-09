Shader "Unlit/ForceFieldShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

        _ForceFieldRadius("Force Field Radius", Float) = 4.0
        _ForceFieldPosition("Force Field Position", Vector) = (0.0, 0.0, 0.0, 0.0)

        [HDR] _ColorA("Color A", Color) = (0.0, 0.0, 0.0, 0.0)
        [HDR] _ColorB("Color B", Color) = (1.0, 1.0, 1.0, 1.0)

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Blend One One
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                fixed4 color : COLOR;

                //float2 uv : TEXCOORD0; // Fehlt im Tutorial

                float4 tc0 : TEXCOORD0;
                float4 tc1 : TEXCOORD1; // Brauchen wir das
            };

            struct v2f
            {   
                // float2 uv : TEXCOORD0; // Fehlt im Tutorial
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;

                float4 tc0 : TEXCOORD0;
                float4 tc1 : TEXCOORD1;

            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _ForceFieldRadius;
            float3 _ForceFieldPosition;

            float4 _ColorA;
            float4 _ColorB;


            float4 ManipulateParticleOffset(float3 particleCenter)
            {
                float distanceToParticle = distance(particleCenter, _ForceFieldPosition);

                bool isParticleInsideForceField = distanceToParticle < _ForceFieldRadius;

                if (isParticleInsideForceField) {
                    float distanceToForceFieldRadius = _ForceFieldRadius - distanceToParticle;

                    float3 fp = (particleCenter - _ForceFieldPosition); // p-f
                    float3 directionToParticle = normalize(fp); // (p-f).n

                    float4 particleOffset;
                        
                    particleOffset.xyz = directionToParticle * distanceToForceFieldRadius;
                    particleOffset.w = distanceToForceFieldRadius / _ForceFieldRadius;

                    return particleOffset;
                }

                return 0;
            }

            v2f vert (appdata v)
            {
                v2f o;
                                        // tc0.z = x
                                        // tc0.w = y
                                        // tc1.x = z
                float3 particleCenter = float3(v.tc0.zw, v.tc1.x); // TODO:  warum 2 Parameter?; zw und x, was tun sie?
                //float3 particleCenter = float3(v.vertex.xyz); // TODO:  warum 2 Parameter?; zw und x, was tun sie?



                float3 vertexOffset = ManipulateParticleOffset(particleCenter);

                v.vertex.xyz += vertexOffset;

                o.vertex = UnityObjectToClipPos(v.vertex);
                
                // Initialisiere die resultierende Farbe aus dem Custom Vertex Stream
                o.color = v.color;

                o.tc0.xy = TRANSFORM_TEX(v.tc0.xy, _MainTex);
                //o.tc0.xy = TRANSFORM_TEX(v.tc0, _MainTex);

                // Initialisiere resultierende Textur Koordinaten

                o.tc0.zw = v.tc0.zw; // TODO: was macht das
                o.tc1 = v.tc1; // TODO: was macht das
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                                            // uv , TODO: Was macht die Änderung
                fixed4 col = tex2D(_MainTex, i.tc0);
                col *= i.color;

                float3 particleCenter = float3(i.tc0.zw, i.tc1.x);
                // 0 ... 0.5 ... 1 0 = auf Kante, 0.5 = genau mittig zwischen Zentrum und Kante. 1 = im Zentrum
                float particleOffsetNormalizedLength = ManipulateParticleOffset(particleCenter).w;

                col = lerp(col * _ColorA, col * _ColorB, particleOffsetNormalizedLength);

                col *= col.a; // TODO: Brauch man das?

                return col;
            }
            ENDCG
        }
    }
}
