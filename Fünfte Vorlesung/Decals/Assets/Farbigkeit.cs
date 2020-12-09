using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Farbigkeit : MonoBehaviour
{
    [SerializeField] private float farbigkeit = 0;

    [SerializeField] MaterialPropertyBlock decalMaterialPropertyBlock;



    Renderer renderer;

    void Start()
    {
        renderer = gameObject.GetComponent<Renderer>();
        decalMaterialPropertyBlock = new MaterialPropertyBlock();
    }

    void Update()
    {

        renderer.GetPropertyBlock(decalMaterialPropertyBlock);

        decalMaterialPropertyBlock.SetFloat("_Intensity", farbigkeit);

        renderer.SetPropertyBlock(decalMaterialPropertyBlock);

    }
}
