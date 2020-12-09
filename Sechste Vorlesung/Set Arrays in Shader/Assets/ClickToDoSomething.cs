using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickToDoSomething : MonoBehaviour
{
    [SerializeField]
    private Material material;

    int vectorArrayLen = 1;

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
            Vector4[] vectorArray = new Vector4[10];

            for (int i = 0; i < (vectorArrayLen % 10); i++)
            {
                vectorArray[i] = new Vector2(
                      Random.Range(0f, 1f)
                    , Random.Range(0f, 1f));
            }

            material.SetInt("_VectorArrayLen", vectorArrayLen % 10);
            material.SetVectorArray("_VectorArray", vectorArray);

            vectorArrayLen++;
        }
    }
}
