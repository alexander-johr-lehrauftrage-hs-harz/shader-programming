using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor.AI;

public class NewBehaviourScript : MonoBehaviour
{

    float floatZahl = 0;
    double doubleZahl = 0;

    void Start()
    {
        
    }

    void Update()
    {
        

        for (int i = 0; i < 10000; i++)
        {
            floatZahl++;
            doubleZahl++;
        }

        print(string.Format("float: {0} double: {1}", floatZahl, doubleZahl));
    }
}
