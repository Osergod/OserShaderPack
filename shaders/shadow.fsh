#version 120

#include "/lib/ajustes_sombras.glsl"

uniform sampler2D gtexture;
uniform int renderStage;

varying vec2 texcoord;
varying vec4 vertexColor;

void main() {
#ifndef SHADOWS_ENABLED
    discard;
#endif

#ifndef SHADOW_ENTITIES
    if (renderStage == MC_RENDER_STAGE_ENTITIES) {
        discard;
    }
#endif

#ifndef SHADOW_BLOCK_ENTITIES
    if (renderStage == MC_RENDER_STAGE_BLOCK_ENTITIES) {
        discard;
    }
#endif

    vec4 surface =
        texture2D(gtexture, texcoord) * vertexColor;

    // Respetar los huecos de hojas, plantas
    // y otras texturas recortadas.
    if (surface.a < 0.1) {
        discard;
    }

    gl_FragData[0] = surface;
}