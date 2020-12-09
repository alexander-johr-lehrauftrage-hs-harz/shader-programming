using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VertFragBsp : MonoBehaviour
{
    // (Kommt von außen)
    private class COLORAttribute : Attribute
    {
    }
    class POSITIONAttribute : Attribute
    {
    }
    class TEXCOORD0Attribute : Attribute
    {
    }

    class COLOR0Attribute : Attribute
    {
    }

    class SV_POSITIONAttribute : Attribute
    {
    }

    internal class SV_TargetAttribute : Attribute
    {
    }

    private Vector4 UnityObjectToClipPos(Vector4 vertex)
    {
        throw new NotImplementedException();
    }

    public class appdata
    {
        [COLOR]
        public Vector3 color;
        [POSITION]
        public Vector4 vertex;
        [TEXCOORD0]
        public Vector2 uv;
    };

    v2f vert(appdata v) // Objekt
    {
        v2f f = new v2f();

        f.vertex = UnityObjectToClipPos(v.vertex);
        f.uv = v.uv;
        f.diff = new Vector4(1, 0, 0, 0);
        return f;
    }

    public class v2f
    {
        [TEXCOORD0]
        public Vector2 uv;
        [SV_POSITION]
        public Vector4 vertex;
        [COLOR0]
        public Vector4 diff;
    };

    [SV_Target]
    Color frag(v2f f)
    {
        return f.diff;
    }



}

