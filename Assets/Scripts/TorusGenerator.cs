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
        Vector3[] vertices = new Vector3[TorusSides * 2];
        int[] indices = new int[TorusSides * 6];
        float angle, x, y;

        for (int i = 0; i < vertices.Length; i += 2)
        {
            angle = i * Mathf.PI / TorusSides;
            x = Mathf.Cos(angle) * TorusRadius;
            y = Mathf.Sin(angle) * TorusRadius;
            vertices[i] = new Vector3(x, y, TorusHeight);
            vertices[i + 1] = new Vector3(x, y, 0);

            indices[i * 3] = i;
            indices[i * 3 + 1] = i + 1;
            indices[i * 3 + 2] = (i + 2) % (TorusSides * 2);
            indices[i * 3 + 3] = i + 1;
            indices[i * 3 + 4] = (i + 3) % (TorusSides * 2);
            indices[i * 3 + 5] = (i + 2) % (TorusSides * 2);
        }

        BuildMesh("Torus", vertices, indices);
    }
}
