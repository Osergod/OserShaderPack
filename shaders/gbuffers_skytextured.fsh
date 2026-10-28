#version 120

#include "/lib/funciones_colores.glsl"

uniform sampler2D gtexture;
uniform int renderStage;

varying vec2 texcoord;
varying vec4 vertexColor;

/* DRAWBUFFERS:0 */

void main() {
    vec4 color = texture2D(gtexture, texcoord) * vertexColor;

    if (renderStage == MC_RENDER_STAGE_SUN) {
        color.rgb *= getSunColor() * SUN_BRIGHTNESS;
    } else if (renderStage == MC_RENDER_STAGE_MOON) {
        color.rgb *= getMoonColor() * MOON_BRIGHTNESS;
    }

    gl_FragData[0] = color;
}