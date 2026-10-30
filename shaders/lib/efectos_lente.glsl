#include "/lib/ajustes_lente.glsl"

uniform float viewWidth;
uniform float viewHeight;

uniform int frameCounter;

vec2 getLensViewport() {
    return max(
        vec2(viewWidth, viewHeight),
        vec2(1.0)
    );
}

vec3 sampleLensTexture(vec2 uv) {
    vec2 halfPixel =
        0.5 / getLensViewport();

    vec2 safeUV = clamp(
        uv,
        halfPixel,
        vec2(1.0) - halfPixel
    );

    return texture2D(colortex0, safeUV).rgb;
}

vec3 applyLensSampling(vec2 uv, vec3 originalColor) {
    vec3 color = originalColor;

#ifdef LENS_CHROMATIC
    vec2 viewport = getLensViewport();
    vec2 pixelSize = 1.0 / viewport;

    vec2 fromCenter =
        (uv - vec2(0.5)) * viewport;

    float distanceFromCenter =
        length(fromCenter);

    vec2 radialDirection =
        fromCenter / max(distanceFromCenter, 0.0001);

    float cornerDistance =
        length(viewport * 0.5);

    float edgeAmount = clamp(
        distanceFromCenter / cornerDistance,
        0.0,
        1.0
    );

    vec2 displacement =
        radialDirection
        * pixelSize
        * LENS_CHROMATIC_STRENGTH
        * edgeAmount
        * edgeAmount;

    color.r = sampleLensTexture(
        uv + displacement
    ).r;

    color.b = sampleLensTexture(
        uv - displacement
    ).b;
#endif

#ifdef LENS_SHARPENING
    vec2 sharpPixel =
        1.0 / getLensViewport();

    vec3 neighborhood =
        sampleLensTexture(
            uv + vec2(sharpPixel.x, 0.0)
        )
        + sampleLensTexture(
            uv - vec2(sharpPixel.x, 0.0)
        )
        + sampleLensTexture(
            uv + vec2(0.0, sharpPixel.y)
        )
        + sampleLensTexture(
            uv - vec2(0.0, sharpPixel.y)
        );

    neighborhood *= 0.25;

    color +=
        (originalColor - neighborhood)
        * LENS_SHARPENING_STRENGTH;
#endif

    return color;
}

float getLensNoise(vec2 position) {
    vec2 p = fract(
        position * vec2(0.1031, 0.11369)
    );

    p += vec2(
        dot(p, p.yx + vec2(19.19))
    );

    return fract(
        (p.x + p.y) * p.x
    );
}

vec3 applyLensFinish(vec2 uv, vec3 color) {
#ifdef LENS_VIGNETTE
    vec2 viewport = getLensViewport();

    vec2 fromCenter =
        (uv - vec2(0.5)) * viewport;

    float normalizedDistance =
        length(fromCenter)
        / length(viewport * 0.5);

    float vignette = smoothstep(
        LENS_VIGNETTE_START,
        1.0,
        normalizedDistance
    );

    color *=
        1.0
        - vignette * LENS_VIGNETTE_STRENGTH;
#endif

#ifdef LENS_GRAIN
    float frame = mod(
        float(frameCounter),
        1024.0
    );

    vec2 animatedPosition =
        gl_FragCoord.xy
        + vec2(frame * 17.0, frame * 29.0);

    float noise =
        getLensNoise(animatedPosition) - 0.5;

    color += vec3(
        noise * LENS_GRAIN_STRENGTH
    );
#endif

    return clamp(color, 0.0, 1.0);
}