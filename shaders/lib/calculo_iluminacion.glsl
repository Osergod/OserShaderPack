#include "/lib/ajustes_iluminacion.glsl"
#include "/lib/funciones_colores.glsl"

uniform mat4 gbufferModelViewInverse;

uniform vec3 sunPosition;
uniform vec3 moonPosition;

uniform float rainStrength;

uniform int moonPhase;

vec3 getSunLightColor() {
#ifdef LIGHT_FOLLOW_CELESTIAL_COLOR
    vec3 selectedColor = getSunColor();
#else
    vec3 selectedColor = vec3(
        SUN_LIGHT_R,
        SUN_LIGHT_G,
        SUN_LIGHT_B
    );
#endif

    return mix(
        vec3(1.0),
        selectedColor,
        LIGHT_COLOR_SATURATION
    );
}

vec3 getMoonLightColor() {
#ifdef LIGHT_FOLLOW_CELESTIAL_COLOR
    vec3 selectedColor = getMoonColor();
#else
    vec3 selectedColor = vec3(
        MOON_LIGHT_R,
        MOON_LIGHT_G,
        MOON_LIGHT_B
    );
#endif

    return mix(
        vec3(1.0),
        selectedColor,
        LIGHT_COLOR_SATURATION
    );
}

float getMoonLightPhase() {
#ifdef LIGHT_MOON_PHASE
    float illuminatedFraction = 0.5 + 0.5 * cos(
        float(moonPhase) * 0.78539816339
    );

    return clamp(illuminatedFraction, 0.0, 1.0);
#else
    return 1.0;
#endif
}

float getDirectWeatherVisibility() {
#ifdef LIGHT_RAIN_DIMMING
    return 1.0
        - clamp(rainStrength, 0.0, 1.0)
        * LIGHT_RAIN_REDUCTION;
#else
    return 1.0;
#endif
}

vec3 calculateWorldLighting(
    vec3 worldNormal,
    float skyExposure,
    vec3 blockLighting,
    vec2 directShadow
) {
    vec3 normal = normalize(worldNormal);

    vec3 sunDirection = normalize(
        mat3(gbufferModelViewInverse) * sunPosition
    );

    vec3 moonDirection = normalize(
        mat3(gbufferModelViewInverse) * moonPosition
    );

    // En este espacio, el eje Y apunta hacia arriba.
    float dayAmount = smoothstep(
        -0.08,
        0.12,
        sunDirection.y
    );

    float sunVisibility = smoothstep(
        -0.04,
        0.08,
        sunDirection.y
    );

    float moonVisibility = smoothstep(
        -0.04,
        0.08,
        moonDirection.y
    );

    float sunFacing = max(
        dot(normal, sunDirection),
        0.0
    );

    float moonFacing = max(
        dot(normal, moonDirection),
        0.0
    );

    float exterior = clamp(skyExposure, 0.0, 1.0);

    // Aproximacion provisional hasta implementar sombras.
    float directExposure = pow(exterior, 6.0);
    float indirectExposure = pow(exterior, 2.0);

    float weatherVisibility =
        getDirectWeatherVisibility();

    vec3 sunlight =
        getSunLightColor()
        * SUN_LIGHT_INTENSITY
        * sunFacing
        * sunVisibility
        * directExposure
        * weatherVisibility
        * directShadow.x;

    vec3 moonlight =
        getMoonLightColor()
        * MOON_LIGHT_INTENSITY
        * moonFacing
        * moonVisibility
        * directExposure
        * weatherVisibility
        * getMoonLightPhase()
        * directShadow.y;

    float ambientIntensity = mix(
        AMBIENT_NIGHT,
        AMBIENT_DAY,
        dayAmount
    );

    vec3 ambientTint = mix(
        vec3(0.65, 0.75, 1.0),
        vec3(1.0, 0.96, 0.9),
        dayAmount
    );

    vec3 ambient =
        ambientTint * ambientIntensity;

    float skyIntensity = mix(
        SKY_LIGHT_NIGHT,
        SKY_LIGHT_DAY,
        dayAmount
    );

    vec3 skyTint = mix(
        vec3(0.45, 0.6, 1.0),
        vec3(0.65, 0.8, 1.0),
        dayAmount
    );

    vec3 skylight =
        skyTint
        * skyIntensity
        * indirectExposure;

        // Contraste adicional solo donde hay sombra
    // de una luz que esta sobre el horizonte.
    float solarOcclusion =
        (1.0 - directShadow.x)
        * sunVisibility;

    float lunarOcclusion =
        (1.0 - directShadow.y)
        * moonVisibility
        * getMoonLightPhase();

    float shadowOcclusion = clamp(
        max(solarOcclusion, lunarOcclusion),
        0.0,
        1.0
    );

    skylight *=
        1.0
        - SHADOW_INDIRECT_DARKENING
        * shadowOcclusion;

    return ambient
        + skylight
        + sunlight
        + moonlight
        + blockLighting;
}