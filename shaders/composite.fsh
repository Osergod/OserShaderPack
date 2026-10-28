#version 120

#include "/lib/recurso.glsl"
#include "/lib/funciones_colores.glsl"
#include "/lib/halo_celeste.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;

uniform mat4 gbufferProjectionInverse;

uniform vec3 sunPosition;
uniform vec3 moonPosition;
uniform vec3 upPosition;

uniform float rainStrength;

uniform int moonPhase;
uniform int isEyeInWater;

varying vec2 texcoord;

/* DRAWBUFFERS:0 */

vec3 getViewDirection(vec2 uv) {
    vec4 clipPosition = vec4(
        uv * 2.0 - 1.0,
        1.0,
        1.0
    );

    vec4 viewPosition =
        gbufferProjectionInverse * clipPosition;

    return normalize(viewPosition.xyz / viewPosition.w);
}

float getHalo(
    vec3 viewDirection,
    vec3 celestialDirection,
    float radius,
    float strength
) {
    float alignment = clamp(
        dot(viewDirection, celestialDirection),
        -1.0,
        1.0
    );

    float angularDistance = acos(alignment);

    float safeRadius = max(radius, 0.0001);
    float normalizedDistance = angularDistance / safeRadius;

    // Perfil suave, sin un borde circular duro.
    float glow = exp(
        -2.0 * normalizedDistance * normalizedDistance
    );

    // Evitar contribuciones desde el hemisferio opuesto.
    float frontVisibility = smoothstep(
        0.0,
        0.1,
        alignment
    );

    return glow * strength * frontVisibility;
}

float getHorizonVisibility(
    vec3 celestialDirection,
    vec3 upDirection
) {
    float height = dot(celestialDirection, upDirection);

    // Desvanecer el halo al pasar bajo el horizonte.
    return smoothstep(-0.08, 0.02, height);
}

void main() {
    vec4 scene = texture2D(colortex0, texcoord);
    float depth = texture2D(depthtex0, texcoord).r;

    // Añadir el halo solo en pixeles del fondo celeste.
    // No dibujarlo bajo el agua, lava o nieve en polvo.
    if (depth >= 1.0 && isEyeInWater == 0) {
        vec3 viewDirection = getViewDirection(texcoord);

        vec3 sunDirection = normalize(sunPosition);
        vec3 moonDirection = normalize(moonPosition);
        vec3 upDirection = normalize(upPosition);

        float weatherVisibility =
            1.0 - clamp(rainStrength, 0.0, 1.0);

        float sunVisibility = getHorizonVisibility(
            sunDirection,
            upDirection
        );

        float moonVisibility = getHorizonVisibility(
            moonDirection,
            upDirection
        );

        // Radios visuales de referencia, en radianes.
        // Se ajustan con el tamaño del astro y del halo.
        float sunRadius =
            0.15 * SUN_SIZE * SUN_HALO_SIZE;

        float moonRadius =
            0.10 * MOON_SIZE * MOON_HALO_SIZE;

        float sunHalo = getHalo(
            viewDirection,
            sunDirection,
            sunRadius,
            SUN_HALO_STRENGTH
        );

        float moonHalo = getHalo(
            viewDirection,
            moonDirection,
            moonRadius,
            MOON_HALO_STRENGTH
        );

        // Aproximacion de la fraccion iluminada:
        // fase 0 = llena; fase 4 = nueva.
        float moonIllumination = 0.5 + 0.5 * cos(
            float(moonPhase) * 0.78539816339
        );

        moonIllumination = clamp(
            moonIllumination,
            0.0,
            1.0
        );

        vec3 sunGlow =
            getSunColor()
            * SUN_BRIGHTNESS
            * sunHalo
            * sunVisibility;

        vec3 moonGlow =
            getMoonColor()
            * MOON_BRIGHTNESS
            * moonHalo
            * moonVisibility
            * moonIllumination;

        scene.rgb +=
            (sunGlow + moonGlow) * weatherVisibility;
    }

    gl_FragData[0] = scene;
}