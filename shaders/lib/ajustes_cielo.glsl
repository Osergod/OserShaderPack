// ========================================
// CONTROLES GENERALES
// ========================================

#define SKY_CUSTOM // Activa el cielo personalizado del shader

#define SKY_BRIGHTNESS 1.0 // Multiplicador del color del cielo. No modifica la iluminacion del terreno [0.25 0.5 0.75 1.0 1.25 1.5 2.0]

#define SKY_HORIZON_HEIGHT 0.55 // Extension vertical de la transicion entre horizonte y parte superior [0.2 0.35 0.45 0.55 0.7 0.85 1.0]

#define SKY_GRADIENT_CURVE 0.8 // Forma del gradiente. Los valores altos conservan el color del horizonte durante mas recorrido [0.5 0.65 0.8 1.0 1.25 1.5 2.0]

#define SKY_TWILIGHT_INTENSITY 1.0 // Intensidad de los colores de amanecer y atardecer. 0.0 elimina esta transicion de color [0.0 0.25 0.5 0.75 1.0 1.25 1.5]

#define SKY_TWILIGHT_WIDTH 0.6 // Amplitud de la zona calida alrededor de la direccion del Sol. Los valores altos la extienden [0.15 0.25 0.4 0.6 0.8 1.0 1.5 2.0]

// ========================================
// DIA: PARTE SUPERIOR
// ========================================

#define SKY_DAY_TOP_R 0.04 // Rojo del cielo superior diurno [0.0 0.02 0.04 0.08 0.1 0.2 0.4 0.6 0.8 1.0]
#define SKY_DAY_TOP_G 0.2 // Verde del cielo superior diurno [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0]
#define SKY_DAY_TOP_B 0.48 // Azul del cielo superior diurno [0.0 0.1 0.2 0.3 0.4 0.48 0.6 0.7 0.8 0.9 1.0]

// DIA: HORIZONTE

#define SKY_DAY_HORIZON_R 0.22 // Rojo del horizonte diurno [0.0 0.1 0.15 0.22 0.3 0.4 0.5 0.6 0.8 1.0]
#define SKY_DAY_HORIZON_G 0.55 // Verde del horizonte diurno [0.0 0.1 0.2 0.3 0.4 0.55 0.65 0.75 0.9 1.0]
#define SKY_DAY_HORIZON_B 0.62 // Azul del horizonte diurno [0.0 0.1 0.2 0.3 0.4 0.5 0.62 0.75 0.9 1.0]

// ========================================
// NOCHE: PARTE SUPERIOR
// ========================================

#define SKY_NIGHT_TOP_R 0.008 // Rojo del cielo superior nocturno [0.0 0.004 0.008 0.012 0.02 0.03 0.05 0.1]
#define SKY_NIGHT_TOP_G 0.012 // Verde del cielo superior nocturno [0.0 0.004 0.008 0.012 0.02 0.03 0.05 0.1]
#define SKY_NIGHT_TOP_B 0.035 // Azul del cielo superior nocturno [0.0 0.01 0.02 0.035 0.05 0.075 0.1 0.15 0.2]

// NOCHE: HORIZONTE

#define SKY_NIGHT_HORIZON_R 0.025 // Rojo del horizonte nocturno [0.0 0.01 0.015 0.025 0.04 0.06 0.1 0.2]
#define SKY_NIGHT_HORIZON_G 0.035 // Verde del horizonte nocturno [0.0 0.01 0.02 0.035 0.05 0.075 0.1 0.2]
#define SKY_NIGHT_HORIZON_B 0.075 // Azul del horizonte nocturno [0.0 0.02 0.04 0.06 0.075 0.1 0.15 0.25]

// ========================================
// AMANECER: PARTE SUPERIOR
// ========================================

#define SKY_DAWN_TOP_R 0.16 // Rojo del cielo superior al amanecer [0.0 0.05 0.1 0.16 0.25 0.4 0.6 0.8 1.0]
#define SKY_DAWN_TOP_G 0.16 // Verde del cielo superior al amanecer [0.0 0.05 0.1 0.16 0.25 0.4 0.6 0.8 1.0]
#define SKY_DAWN_TOP_B 0.32 // Azul del cielo superior al amanecer [0.0 0.1 0.2 0.32 0.4 0.5 0.6 0.8 1.0]

// AMANECER: HACIA EL SOL

#define SKY_DAWN_FRONT_R 1.0 // Rojo del horizonte hacia el Sol al amanecer [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0]
#define SKY_DAWN_FRONT_G 0.48 // Verde del horizonte hacia el Sol al amanecer [0.0 0.1 0.2 0.3 0.4 0.48 0.6 0.8 1.0]
#define SKY_DAWN_FRONT_B 0.2 // Azul del horizonte hacia el Sol al amanecer [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0]

// AMANECER: LADO OPUESTO

#define SKY_DAWN_BACK_R 0.25 // Rojo del horizonte opuesto al Sol al amanecer [0.0 0.1 0.2 0.25 0.35 0.5 0.7 1.0]
#define SKY_DAWN_BACK_G 0.25 // Verde del horizonte opuesto al Sol al amanecer [0.0 0.1 0.2 0.25 0.35 0.5 0.7 1.0]
#define SKY_DAWN_BACK_B 0.45 // Azul del horizonte opuesto al Sol al amanecer [0.0 0.1 0.2 0.3 0.45 0.6 0.8 1.0]

// ========================================
// ATARDECER: PARTE SUPERIOR
// ========================================

#define SKY_DUSK_TOP_R 0.12 // Rojo del cielo superior al atardecer [0.0 0.05 0.08 0.12 0.2 0.3 0.5 0.75 1.0]
#define SKY_DUSK_TOP_G 0.08 // Verde del cielo superior al atardecer [0.0 0.02 0.05 0.08 0.12 0.2 0.4 0.7 1.0]
#define SKY_DUSK_TOP_B 0.28 // Azul del cielo superior al atardecer [0.0 0.1 0.2 0.28 0.4 0.5 0.6 0.8 1.0]

// ATARDECER: HACIA EL SOL

#define SKY_DUSK_FRONT_R 1.0 // Rojo del horizonte hacia el Sol al atardecer [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0]
#define SKY_DUSK_FRONT_G 0.28 // Verde del horizonte hacia el Sol al atardecer [0.0 0.1 0.2 0.28 0.4 0.5 0.6 0.8 1.0]
#define SKY_DUSK_FRONT_B 0.1 // Azul del horizonte hacia el Sol al atardecer [0.0 0.05 0.1 0.2 0.3 0.4 0.6 0.8 1.0]

// ATARDECER: LADO OPUESTO

#define SKY_DUSK_BACK_R 0.38 // Rojo del horizonte opuesto al Sol al atardecer [0.0 0.1 0.2 0.3 0.38 0.5 0.7 1.0]
#define SKY_DUSK_BACK_G 0.16 // Verde del horizonte opuesto al Sol al atardecer [0.0 0.05 0.1 0.16 0.25 0.4 0.6 0.8 1.0]
#define SKY_DUSK_BACK_B 0.4 // Azul del horizonte opuesto al Sol al atardecer [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0]