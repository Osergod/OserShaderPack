#version 120

#include "/lib/recurso.glsl"

uniform int renderStage;

uniform vec3 sunPosition;
uniform vec3 moonPosition;

varying vec2 texcoord;
varying vec4 vertexColor;

void main() {
    // Trabajamos en coordenadas de vista.
    vec4 viewPosition = gl_ModelViewMatrix * gl_Vertex;

    bool isSun = renderStage == MC_RENDER_STAGE_SUN;
    bool isMoon = renderStage == MC_RENDER_STAGE_MOON;

    if (isSun || isMoon) {
        float size = isSun ? SUN_SIZE : MOON_SIZE;

        vec3 celestialPosition = isSun
            ? sunPosition
            : moonPosition;

        // Eje que apunta desde la camara hacia el astro.
        vec3 axis = normalize(celestialPosition);

        // Separar la posicion en una componente axial
        // y otra perpendicular al eje.
        vec3 axial = axis * dot(viewPosition.xyz, axis);
        vec3 radial = viewPosition.xyz - axial;

        // Giro configurable e independiente para cada astro.
        float rotationDegrees = isSun ? SUN_ROTATION : MOON_ROTATION;
        float angle = radians(rotationDegrees);

        float c = cos(angle);
        float s = sin(angle);

        vec3 rotatedRadial =
            radial * c
            + cross(axis, radial) * s;

        // Escalar solo alrededor del centro del astro.
        viewPosition.xyz = axial + rotatedRadial * size;
    }

    gl_Position = gl_ProjectionMatrix * viewPosition;

    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    vertexColor = gl_Color;
}