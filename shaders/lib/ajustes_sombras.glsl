// ========================================
// ACTIVACION
// ========================================

#define SHADOWS_ENABLED // Activa las sombras proyectadas por el Sol y la Luna

// ========================================
// RESOLUCION Y DISTANCIA
// ========================================

const int shadowMapResolution = 2048; // Resolucion del mapa de sombras. Los valores altos aumentan el detalle y el consumo [512 1024 2048 4096]

const float shadowDistance = 48.0; // Distancia de referencia de las sombras alrededor del jugador, en bloques [32.0 48.0 64.0 80.0 96.0 128.0]

// Limitar el terreno renderizado para el mapa de sombras.
const float shadowDistanceRenderMul = 1.0;

// Leer profundidad sin comparacion automatica.
const bool shadowHardwareFiltering = false;
const bool shadowtex0Nearest = true;

// ========================================
// ASPECTO
// ========================================

#define SHADOW_SOFTENING // Suaviza los bordes mediante varias comparaciones de profundidad

#define SHADOW_SOFTNESS 1.25 // Extension del filtro de suavizado, medida en texeles del mapa de sombras [0.5 0.75 1.0 1.25 1.5 2.0 2.5 3.0]

#define SHADOW_STRENGTH 1.0 // Cantidad de luz directa bloqueada por las sombras. No reduce la luz ambiental ni la luz de antorchas [0.0 0.25 0.5 0.75 1.0]

// ========================================
// OBJETOS QUE PROYECTAN SOMBRAS
// ========================================

#define SHADOW_ENTITIES // Permite que las criaturas y otras entidades proyecten sombras

#define SHADOW_BLOCK_ENTITIES // Permite que bloques especiales, como cofres, proyecten sombras

// ========================================
// AJUSTE AVANZADO
// ========================================

#define SHADOW_BIAS 0.001 // Margen de profundidad para evitar manchas sobre las superficies. Un valor excesivo separa las sombras de los objetos [0.0002 0.0005 0.001 0.0015 0.002 0.003 0.005]