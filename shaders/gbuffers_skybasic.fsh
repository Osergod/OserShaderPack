#version 120

#include "/lib/calculo_cielo.glsl"

uniform int renderStage;

uniform mat4 gbufferProjectionInverse;

uniform float viewWidth;
uniform float viewHeight;

varying vec4 vertexColor;

/* DRAWBUFFERS:0 */

vec3 getSkyViewDirection() {
    vec2 viewport = max(
        vec2(viewWidth, viewHeight),
        vec2(1.0)
    );

    vec2 uv = gl_FragCoord.xy / viewport;

    vec4 clipPosition = vec4(
        uv * 2.0 - 1.0,
        1.0,
        1.0
    );

    vec4 viewPosition =
        gbufferProjectionInverse * clipPosition;

    return normalize(
        viewPosition.xyz / viewPosition.w
    );
}

void main() {
    vec4 color = vertexColor;

#ifdef SKY_CUSTOM
    // Eliminar la superposicion original de amanecer
    // y atardecer: ya calculamos nuestros colores.
    if (renderStage == MC_RENDER_STAGE_SUNSET) {
        discard;
    }

    if (
        renderStage == MC_RENDER_STAGE_SKY ||
        renderStage == MC_RENDER_STAGE_VOID
    ) {
        vec3 direction = getSkyViewDirection();
        vec3 skyColor = calculateCustomSky(direction);

        color = vec4(skyColor, 1.0);
    }
#endif

    // Las estrellas conservan su tratamiento actual.
    gl_FragData[0] = color;
}