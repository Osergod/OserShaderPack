#version 120

uniform mat4 gbufferModelViewInverse;

varying vec2 texcoord;
varying vec2 lightcoord;

varying vec4 vertexColor;
varying vec3 worldNormal;

void main() {
    gl_Position = ftransform();

    texcoord = (
        gl_TextureMatrix[0] * gl_MultiTexCoord0
    ).xy;

    lightcoord = (
        gl_TextureMatrix[1] * gl_MultiTexCoord1
    ).xy;

    vertexColor = gl_Color;

    vec3 viewNormal = gl_NormalMatrix * gl_Normal;

    worldNormal =
        mat3(gbufferModelViewInverse) * viewNormal;
}