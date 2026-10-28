#include "/lib/ajustes_sombras.glsl"

#ifdef SHADOWS_ENABLED

uniform sampler2D shadowtex0;

uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

uniform vec3 shadowLightPosition;

float compareShadowDepth(
    vec2 coordinates,
    float receiverDepth
) {
    // Fuera del mapa no inventamos una sombra.
    if (
        coordinates.x <= 0.0 ||
        coordinates.x >= 1.0 ||
        coordinates.y <= 0.0 ||
        coordinates.y >= 1.0
    ) {
        return 1.0;
    }

    float storedDepth =
        texture2D(shadowtex0, coordinates).r;

    return step(receiverDepth, storedDepth);
}

float filterShadow(
    vec2 coordinates,
    float receiverDepth
) {
#ifdef SHADOW_SOFTENING
    float accumulated = 0.0;
    float totalWeight = 0.0;

    float sampleSpacing =
        SHADOW_SOFTNESS / float(shadowMapResolution);

    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            float weightX = x == 0 ? 2.0 : 1.0;
            float weightY = y == 0 ? 2.0 : 1.0;
            float weight = weightX * weightY;

            vec2 offset =
                vec2(float(x), float(y))
                * sampleSpacing;

            accumulated += compareShadowDepth(
                coordinates + offset,
                receiverDepth
            ) * weight;

            totalWeight += weight;
        }
    }

    return accumulated / totalWeight;
#else
    return compareShadowDepth(
        coordinates,
        receiverDepth
    );
#endif
}

float getShadowVisibility(
    vec3 playerPosition,
    vec3 worldNormal
) {
    vec3 normal = normalize(worldNormal);

    vec3 lightDirection = normalize(
        mat3(gbufferModelViewInverse)
        * shadowLightPosition
    );

    // Desplazamiento pequeño en unidades del mundo
    // para reducir las sombras sobre la propia superficie.
    vec3 receiverPosition =
        playerPosition + normal * 0.025;

    vec4 shadowViewPosition =
        shadowModelView
        * vec4(receiverPosition, 1.0);

    vec4 shadowClipPosition =
        shadowProjection * shadowViewPosition;

    vec3 shadowCoordinates =
        shadowClipPosition.xyz
        / shadowClipPosition.w;

    shadowCoordinates =
        shadowCoordinates * 0.5 + 0.5;

    if (
        shadowCoordinates.x <= 0.0 ||
        shadowCoordinates.x >= 1.0 ||
        shadowCoordinates.y <= 0.0 ||
        shadowCoordinates.y >= 1.0 ||
        shadowCoordinates.z <= 0.0 ||
        shadowCoordinates.z >= 1.0
    ) {
        return 1.0;
    }

    float facing = max(
        dot(normal, lightDirection),
        0.0
    );

    float depthBias =
        SHADOW_BIAS
        * (1.0 + 2.0 * (1.0 - facing));

    float visibility = filterShadow(
        shadowCoordinates.xy,
        shadowCoordinates.z - depthBias
    );

    // Desvanecer al acercarse al limite de distancia.
    float horizontalDistance =
        length(playerPosition.xz);

    float distanceFade = 1.0 - smoothstep(
        shadowDistance * 0.75,
        shadowDistance,
        horizontalDistance
    );

    // Desvanecer tambien junto a los bordes del mapa.
    vec2 edgePosition =
        abs(shadowCoordinates.xy * 2.0 - 1.0);

    float edgeDistance = max(
        edgePosition.x,
        edgePosition.y
    );

    float edgeFade = 1.0 - smoothstep(
        0.85,
        0.98,
        edgeDistance
    );

    float influence =
        SHADOW_STRENGTH
        * distanceFade
        * edgeFade;

    return mix(1.0, visibility, influence);
}

#endif