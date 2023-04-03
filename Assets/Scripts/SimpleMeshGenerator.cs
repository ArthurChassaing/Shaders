using UnityEngine;

public class SimpleMeshGenerator : MonoBehaviour
{
    public Material _MeshMaterial;

    void Start()
    {
        MakeTriangle();
        MakeQuad(); 
        MakeDoubleQuad();
    }

    void MakeTriangle()
    {
        Vector3[] vertices = new Vector3[]
        {
            new Vector3 (0.0f, 0.0f, 0.0f),
            new Vector3 (0.0f, 1.0f, 0.0f),
            new Vector3 (1.0f, 0.0f, 0.0f)
        };

        int[] indices = new int[] { 0, 1, 2 };

        BuildMesh("Triangle", vertices, indices);
    }

    void MakeQuad()
    {
        Vector3[] vertices = new Vector3[]
        {
            new Vector3 (2.0f, 0.0f, 0.0f),
            new Vector3 (2.0f, 1.0f, 0.0f),
            new Vector3 (3.0f, 1.0f, 0.0f),
            new Vector3 (3.0f, 0.0f, 0.0f)
        };

        int[] indices = new int[] { 0, 1, 2, 0, 2, 3 };

        BuildMesh("Quad", vertices, indices);
    }

    void MakeDoubleQuad()
    {
        Vector3[] vertices = new Vector3[]
        {
            new Vector3 (0.0f, 2.0f, 0.0f),
            new Vector3 (0.0f, 3.0f, 0.0f),
            new Vector3 (1.0f, 3.0f, 0.0f),
            new Vector3 (1.0f, 2.0f, 0.0f),
            new Vector3 (2.0f, 2.0f, 0.0f),
            new Vector3 (2.0f, 3.0f, 0.0f),
            new Vector3 (3.0f, 3.0f, 0.0f),
            new Vector3 (3.0f, 2.0f, 0.0f)
        };

        int[] indices = new int[] { 0, 1, 2, 0, 2, 3, 4, 5, 6, 4, 6, 7 };

        BuildMesh("DoubleQuad", vertices, indices);
    }

    protected void BuildMesh(string gameObjectName, Vector3[] vertices, int[] indices, Vector2[] uvs = null)
    {
        // Search in the scene if there is a GameObject called "gameObjectName". If yes, we destroy it.
        GameObject oldOne = GameObject.Find(gameObjectName);
        if (oldOne != null)
            DestroyImmediate(oldOne);

        // Create a GameObject
        GameObject primitive = new GameObject(gameObjectName);

        // Add the components...
        MeshRenderer meshRenderer = primitive.AddComponent<MeshRenderer>();
        MeshFilter meshFilter = primitive.AddComponent<MeshFilter>();

        // ... and set the mesh buffers. 
        meshFilter.mesh.vertices = vertices;
        meshFilter.mesh.triangles = indices;
        meshFilter.mesh.uv = uvs;

        // Apply the material.
        meshRenderer.material = _MeshMaterial != null ? _MeshMaterial : new Material(Shader.Find("Universal Render Pipeline/Unlit"));
    }
}
