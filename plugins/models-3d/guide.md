Workstream draws 3D models (glTF, GLB, OBJ, STL) inside any markdown document of this project, paths relative
to the document. One model, shown inline with orbit and animation: `![Animated fox](../assets/Fox.glb)`.

To compare models (generators, versions), a `compare3d` block (YAML) puts them side by side with linked cameras
and shading modes (PBR, solid, wireframe, normals, albedo, roughness, metal):

```compare3d
title: Helmet, two generators
input: refs/helmet.png   # reference image (optional)
mode: pbr                # opening mode (optional)
models:
  - file: out/meshy.glb
    label: Meshy 4
    note: 30 s, 20 k triangles
  - file: out/tripo.glb
    label: Tripo 2
    rotation: 90         # export facing the wrong way (degrees, optional)
```

The project's Dashboard also has a "3D models" tab listing every model found in the project.
