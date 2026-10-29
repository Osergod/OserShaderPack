#include "/lib/colores_celestes.glsl"

uniform float sunAngle;

vec3 cycleColor(
    float phase,
    vec3 riseColor,
    vec3 middleColor,
    vec3 setColor
) {
    if (phase < 0.25) {
        float blend = smoothstep(0.0, 0.25, phase);
        return mix(riseColor, middleColor, blend);
    }

    if (phase < 0.5) {
        float blend = smoothstep(0.25, 0.5, phase);
        return mix(middleColor, setColor, blend);
    }

    float blend = smoothstep(0.5, 1.0, phase);
    return mix(setColor, riseColor, blend);
}

vec3 getSunColor() {
#ifdef SUN_AUTO_COLOR
    vec3 dawnColor = vec3(
        SUN_DAWN_R, SUN_DAWN_G, SUN_DAWN_B
    );

    vec3 noonColor = vec3(
        SUN_NOON_R, SUN_NOON_G, SUN_NOON_B
    );

    vec3 duskColor = vec3(
        SUN_DUSK_R, SUN_DUSK_G, SUN_DUSK_B
    );

    return cycleColor(
        fract(sunAngle),
        dawnColor,
        noonColor,
        duskColor
    );
#else
    return vec3(SUN_FIXED_R, SUN_FIXED_G, SUN_FIXED_B);
#endif
}

vec3 getMoonColor() {
#ifdef MOON_AUTO_COLOR
    vec3 riseColor = vec3(
        MOON_RISE_R, MOON_RISE_G, MOON_RISE_B
    );

    vec3 nightColor = vec3(
        MOON_NIGHT_R, MOON_NIGHT_G, MOON_NIGHT_B
    );

    vec3 setColor = vec3(
        MOON_SET_R, MOON_SET_G, MOON_SET_B
    );

    return cycleColor(
        fract(sunAngle + 0.5),
        riseColor,
        nightColor,
        setColor
    );
#else
    return vec3(MOON_FIXED_R, MOON_FIXED_G, MOON_FIXED_B);
#endif
}