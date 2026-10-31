#include "/lib/ajustes_cielo.glsl"

uniform vec3 sunPosition;
uniform vec3 upPosition;

uniform float sunAngle;

vec3 calculateCustomSky(vec3 viewDirection) {
    vec3 direction = normalize(viewDirection);
    vec3 up = normalize(upPosition);
    vec3 sun = normalize(sunPosition);

    float viewHeight = dot(direction, up);
    float sunHeight = dot(sun, up);

    // Mezcla entre el cielo nocturno y el diurno.
    float dayAmount = smoothstep(
        -0.18,
        0.10,
        sunHeight
    );

    vec3 dayTop = vec3(
        SKY_DAY_TOP_R,
        SKY_DAY_TOP_G,
        SKY_DAY_TOP_B
    );

    vec3 dayHorizon = vec3(
        SKY_DAY_HORIZON_R,
        SKY_DAY_HORIZON_G,
        SKY_DAY_HORIZON_B
    );

    vec3 nightTop = vec3(
        SKY_NIGHT_TOP_R,
        SKY_NIGHT_TOP_G,
        SKY_NIGHT_TOP_B
    );

    vec3 nightHorizon = vec3(
        SKY_NIGHT_HORIZON_R,
        SKY_NIGHT_HORIZON_G,
        SKY_NIGHT_HORIZON_B
    );

    float verticalBlend = smoothstep(
        0.0,
        SKY_HORIZON_HEIGHT,
        max(viewHeight, 0.0)
    );

    verticalBlend = pow(
        verticalBlend,
        SKY_GRADIENT_CURVE
    );

    vec3 topColor = mix(
        nightTop,
        dayTop,
        dayAmount
    );

    vec3 horizonColor = mix(
        nightHorizon,
        dayHorizon,
        dayAmount
    );

    vec3 skyColor = mix(
        horizonColor,
        topColor,
        verticalBlend
    );

    // Distinguir amanecer y atardecer.
    // La seleccion cambia cuando la transicion calida
    // no esta visible: mediodia y medianoche.
    float evening =
        step(0.25, sunAngle)
        * (1.0 - step(0.75, sunAngle));

    vec3 twilightTop = mix(
        vec3(
            SKY_DAWN_TOP_R,
            SKY_DAWN_TOP_G,
            SKY_DAWN_TOP_B
        ),
        vec3(
            SKY_DUSK_TOP_R,
            SKY_DUSK_TOP_G,
            SKY_DUSK_TOP_B
        ),
        evening
    );

    vec3 twilightFront = mix(
        vec3(
            SKY_DAWN_FRONT_R,
            SKY_DAWN_FRONT_G,
            SKY_DAWN_FRONT_B
        ),
        vec3(
            SKY_DUSK_FRONT_R,
            SKY_DUSK_FRONT_G,
            SKY_DUSK_FRONT_B
        ),
        evening
    );

    vec3 twilightBack = mix(
        vec3(
            SKY_DAWN_BACK_R,
            SKY_DAWN_BACK_G,
            SKY_DAWN_BACK_B
        ),
        vec3(
            SKY_DUSK_BACK_R,
            SKY_DUSK_BACK_G,
            SKY_DUSK_BACK_B
        ),
        evening
    );

    // Proyectar ambas direcciones sobre el horizonte.
    vec3 horizontalView =
        direction - up * viewHeight;

    vec3 horizontalSun =
        sun - up * sunHeight;

    horizontalView /= max(
        length(horizontalView),
        0.0001
    );

    horizontalSun /= max(
        length(horizontalSun),
        0.0001
    );

    float towardsSun = clamp(
        dot(horizontalView, horizontalSun) * 0.5 + 0.5,
        0.0,
        1.0
    );

    towardsSun = pow(
        towardsSun,
        1.0 / max(SKY_TWILIGHT_WIDTH, 0.05)
    );

    vec3 twilightHorizon = mix(
        twilightBack,
        twilightFront,
        towardsSun
    );

    vec3 twilightColor = mix(
        twilightHorizon,
        twilightTop,
        verticalBlend
    );

    // Activar la paleta calida cerca del horizonte solar.
    float twilightAmount = 1.0 - smoothstep(
        0.01,
        0.25,
        abs(sunHeight)
    );

    float twilightWeight = clamp(
        twilightAmount
        * SKY_TWILIGHT_INTENSITY
        * mix(1.0, 0.65, verticalBlend),
        0.0,
        1.0
    );

    skyColor = mix(
        skyColor,
        twilightColor,
        twilightWeight
    );

    return skyColor * SKY_BRIGHTNESS;
}