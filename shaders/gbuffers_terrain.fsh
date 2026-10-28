#version 120

#include "/lib/calculo_iluminacion.glsl"

uniform sampler2D gtexture;
uniform sampler2D lightmap;

uniform float alphaTestRef;

varying vec2 texcoord;
varying vec2 lightcoord;

varying vec4 vertexColor;
varying vec3 worldNormal;

/* DRAWBUFFERS:0 */

vec3 toLinear(vec3 color) {
    return pow(
        max(color, vec3(0.0)),
        vec3(2.2)
    );
}

vec3 toDisplay(vec3 color) {
    return pow(
        clamp(color, 0.0, 1.0),
        vec3(1.0 / 2.2)
    );
}

void main() {
    vec4 surface =
        texture2D(gtexture, texcoord) * vertexColor;

    if (surface.a < alphaTestRef) {
        discard;
    }

    // Convertir las coordenadas del mapa de luz
    // a una exposicion aproximada entre 0 y 1.
    vec2 exposure = clamp(
        (lightcoord - vec2(1.0 / 32.0))
        / (30.0 / 32.0),
        0.0,
        1.0
    );

    // Muestrear la luz de bloques con exposicion
    // minima al cielo.
    vec3 blockSample = toLinear(
        texture2D(
            lightmap,
            vec2(lightcoord.x, 1.0 / 32.0)
        ).rgb
    );

    // Restar el nivel base para no sumarlo
    // otra vez como luz de bloques.
    vec3 baselineSample = toLinear(
        texture2D(
            lightmap,
            vec2(1.0 / 32.0, 1.0 / 32.0)
        ).rgb
    );

    vec3 blockLighting = max(
        blockSample - baselineSample,
        vec3(0.0)
    );

    vec3 lighting = calculateWorldLighting(
        worldNormal,
        exposure.y,
        blockLighting
    );

    vec3 linearSurface = toLinear(surface.rgb);
    vec3 litSurface = linearSurface * lighting;

    gl_FragData[0] = vec4(
        toDisplay(litSurface),
        surface.a
    );
}