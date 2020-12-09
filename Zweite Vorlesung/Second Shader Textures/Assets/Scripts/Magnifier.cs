using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Magnifier : MonoBehaviour
{
    public Material magnifierMaterial;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var mousePos = Input.mousePosition;
        magnifierMaterial.SetFloat("_u", mousePos.x  / 1920);
        magnifierMaterial.SetFloat("_v", mousePos.y / 1080);

    }
}
