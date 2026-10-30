#version 120

#include "/lib/ajustes_imagen.glsl"

uniform sampler2D colortex0;

varying vec2 texcoord;

vec3 applyImageContrast(vec3 color) {
    vec3 safeColor = clamp(color, 0.0, 1.0);

    vec3 darkPart = pow(
        safeColor,
        vec3(IMAGE_CONTRAST)
    );

    vec3 brightPart = pow(
        vec3(1.0) - safeColor,
        vec3(IMAGE_CONTRAST)
    );

    return darkPart / max(
        darkPart + brightPart,
        vec3(0.000001)
    );
}

vec3 applyImageColor(vec3 color) {
    // Balance calido o frio.
    vec3 balance = vec3(
        1.0 + IMAGE_WARMTH * 0.12,
        1.0,
        1.0 - IMAGE_WARMTH * 0.12
    );

    color *= balance;

    // Mezcla artistica entre gris y color.
    float gray = dot(
        color,
        vec3(0.2126, 0.7152, 0.0722)
    );

    color = mix(
        vec3(gray),
        color,
        IMAGE_SATURATION
    );

    // Contraste con extremos negro y blanco conservados.
    return applyImageContrast(color);
}

void main() {
    vec4 scene = texture2D(colortex0, texcoord);

#ifdef IMAGE_COLOR_CORRECTION
    scene.rgb = applyImageColor(scene.rgb);
#endif

    gl_FragColor = scene;
}