using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TorusGenerator : SimpleMeshGenerator  
{
    [Range(3, 30)]
    public int TorusSides = 3;
    [Range(1f, 3f)]
    public float TorusRadius = 2f;
    [Range(0.2f, 1f)]
    public float TorusHeight = 0.5f;

    public bool RecomputeTorus = false;

    void Start()
    {
        MakeTorus();
    }

    private void Update()
    {
        if (RecomputeTorus)
        {
            RecomputeTorus = false;
            MakeTorus();
        }
    }

    void MakeTorus()
    {
        //BuildMesh("Torus", vertices.ToArray(), indices.ToArray());
    }
}
