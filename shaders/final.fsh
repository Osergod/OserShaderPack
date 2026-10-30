#version 120

#include "/lib/ajustes_imagen.glsl"

uniform sampler2D colortex0;

varying vec2 texcoord;

vec3 applyManualExposure(vec3 color) {
    // Con el valor neutro, conservar exactamente la entrada.
    if (IMAGE_EXPOSURE == 0.0) {
        return color;
    }

    // Aproximacion del color lineal.
    vec3 linearColor = pow(
        max(color, vec3(0.0)),
        vec3(2.2)
    );

    linearColor *= exp2(IMAGE_EXPOSURE);

    // Volver al espacio de visualizacion.
    return pow(
        max(linearColor, vec3(0.0)),
        vec3(1.0 / 2.2)
    );
}

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

    return applyImageContrast(color);
}

void main() {
    vec4 scene = texture2D(colortex0, texcoord);

    // Exposicion antes de la correccion de color.
    scene.rgb = applyManualExposure(scene.rgb);

#ifdef IMAGE_COLOR_CORRECTION
    scene.rgb = applyImageColor(scene.rgb);
#endif

    // Ajuste fino de brillo despues del color.
    scene.rgb = clamp(
        scene.rgb + vec3(IMAGE_BRIGHTNESS),
        0.0,
        1.0
    );

    gl_FragColor = scene;
}