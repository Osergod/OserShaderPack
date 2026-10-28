// ========================================
// INTENSIDAD DE LA ILUMINACION DIRECTA
// ========================================

#define SUN_LIGHT_INTENSITY 1.2 // Intensidad con la que el Sol ilumina las superficies. Independiente del brillo visible del astro [0.0 0.1 0.2 0.4 0.6 0.8 1.0 1.2 1.5 1.8 2.0 2.5 3.0]

#define MOON_LIGHT_INTENSITY 0.08 // Intensidad con la que la Luna ilumina las superficies. Independiente de su brillo visible [0.0 0.02 0.04 0.06 0.08 0.1 0.15 0.2 0.3 0.5 0.75 1.0 1.5 2.0 3.0]

// ========================================
// COLOR DE LA ILUMINACION
// ========================================

#define LIGHT_FOLLOW_CELESTIAL_COLOR // La iluminacion sigue los colores del Sol y la Luna. Desactivalo para usar colores de luz independientes

#define LIGHT_COLOR_SATURATION 0.35 // Cantidad del color elegido que conserva la luz. 0.0 produce luz blanca y 1.0 aplica el color completo [0.0 0.1 0.2 0.35 0.5 0.65 0.8 1.0]

// COLOR INDEPENDIENTE DE LA LUZ SOLAR

#define SUN_LIGHT_R 1.0 // Componente roja de la luz solar independiente [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define SUN_LIGHT_G 0.9 // Componente verde de la luz solar independiente [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define SUN_LIGHT_B 0.8 // Componente azul de la luz solar independiente [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

// COLOR INDEPENDIENTE DE LA LUZ LUNAR

#define MOON_LIGHT_R 0.7 // Componente roja de la luz lunar independiente [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define MOON_LIGHT_G 0.8 // Componente verde de la luz lunar independiente [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define MOON_LIGHT_B 1.0 // Componente azul de la luz lunar independiente [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

// ========================================
// LUZ AMBIENTAL
// ========================================

#define AMBIENT_DAY 0.025 // Claridad minima durante el dia, incluso en zonas sin exposicion directa al cielo [0.0 0.002 0.005 0.01 0.015 0.025 0.04 0.06 0.1 0.15 0.2]

#define AMBIENT_NIGHT 0.006 // Claridad minima durante la noche, incluso en zonas sin exposicion directa al cielo [0.0 0.002 0.004 0.006 0.01 0.015 0.025 0.04 0.06 0.1]

// ========================================
// LUZ INDIRECTA DEL CIELO
// ========================================

#define SKY_LIGHT_DAY 0.18 // Claridad indirecta del cielo durante el dia. Afecta principalmente a superficies expuestas al exterior [0.0 0.025 0.05 0.1 0.15 0.18 0.25 0.35 0.5 0.75 1.0]

#define SKY_LIGHT_NIGHT 0.015 // Claridad indirecta del cielo durante la noche [0.0 0.002 0.005 0.01 0.015 0.025 0.04 0.06 0.1 0.15 0.25]

// ========================================
// FASES LUNARES Y LLUVIA
// ========================================

#define LIGHT_MOON_PHASE // La fase lunar modifica la intensidad de la luz directa de la Luna

#define LIGHT_RAIN_DIMMING // La lluvia reduce la intensidad de la iluminacion directa del Sol y la Luna

#define LIGHT_RAIN_REDUCTION 0.65 // Reduccion de la luz directa con lluvia maxima. 0.0 no la reduce y 1.0 la elimina [0.0 0.1 0.2 0.35 0.5 0.65 0.8 0.9 1.0]

// ========================================
// CONTRASTE EN LAS ZONAS CON SOMBRA
// ========================================

#define SHADOW_INDIRECT_DARKENING 0.15 // Reduccion artistica de la luz indirecta del cielo en zonas con sombra. No reduce la luz ambiental minima ni la de antorchas [0.0 0.05 0.1 0.15 0.2 0.25 0.3]