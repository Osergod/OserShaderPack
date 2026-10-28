#version 120

uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 vertexColor;

/* DRAWBUFFERS:0 */

void main() {
    vec4 color = texture2D(gtexture, texcoord) * vertexColor;

    gl_FragData[0] = color;
}