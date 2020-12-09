using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickToAddSomething : MonoBehaviour
{
    [SerializeField]
    private Material material;
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        bool mouseButtonDown = Input.GetMouseButtonDown(0);
        if (mouseButtonDown)
        {
            Debug.Log("Click");
            var vectorList = new List<Vector4>();
            var vectorArrayLen = 4;
            for (int i = 0; i < vectorArrayLen; i++)
            {
                vectorList.Add(
                    new Vector4(Random.Range(0f, 1f), Random.Range(0f, 1f), Random.Range(0f, 1f), 1));
            }
            //material.SetInt("_VectorArrayLen", vectorArrayLen++);

            material.SetVectorArray("_VectorArray", vectorList);
        } 

    }
}
