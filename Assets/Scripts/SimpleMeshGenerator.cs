using UnityEngine;

public class SimpleMeshGenerator : MonoBehaviour
{
    public Material _MeshMaterial;

    void Start()
    {
        MakeTriangle();
        //MakeQuad(); 
        //MakeDoubleQuad();
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
        
        Vector2[] uvs = new Vector2[]
        {
            new Vector2(0, 0),
            new Vector2(0, 1),
            new Vector2(1, 0)
        };
        
        Color[] colors = 
        {
            Color.red,
            Color.green,
            Color.blue
        };

        BuildMesh("Triangle", vertices, indices,null,colors);
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
    
    void MakeCube()
    {
        // TO DO: Vertices array of type Vector3
        Vector3[] vertices = new Vector3[8]
        {
            new Vector3(0, 0, 0),
            new Vector3(0, 1, 0),
            new Vector3(1, 0, 0),
            new Vector3(1, 1, 0),
            new Vector3(1, 1, 1),
            new Vector3(1, 0, 1),
            new Vector3(0, 1, 1),
            new Vector3(0, 0, 1),
        };
        
        // TO DO: Indices array of type int
        int[] indices = new int[36]
        {
            0, 1, 2, 
            2, 1, 3, // 1
            3, 2, 5,
            5, 3, 4, // 2
            4, 5, 6,
            6, 5, 7, // 3
            7, 5, 2,
            2, 0, 7, // 4
            7, 0, 1,
            1, 7, 6, // 5
            6, 1, 3,
            3, 6, 4 // 6
        };
        
        // TO DO: appeller la fonction BuildMesh avec les bons paramètres
        BuildMesh("Quad", vertices, indices);
    }

    protected void BuildMesh(string gameObjectName, Vector3[] vertices, int[] indices, Vector2[] uvs = null, Color[] colors = null)
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
        meshFilter.mesh.colors = colors;

        // Apply the material.
        meshRenderer.material = _MeshMaterial != null ? _MeshMaterial : new Material(Shader.Find("Universal Render Pipeline/Unlit"));
    }
}
