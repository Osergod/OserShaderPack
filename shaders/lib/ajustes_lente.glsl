// ========================================
// VINETA
// ========================================

//#define LENS_VIGNETTE // Oscurece suavemente los bordes de la imagen

#define LENS_VIGNETTE_STRENGTH 0.12 // Intensidad del oscurecimiento de los bordes [0.0 0.05 0.1 0.12 0.15 0.2 0.3 0.4 0.6]

#define LENS_VIGNETTE_START 0.35 // Distancia relativa desde el centro a partir de la que empieza la vineta [0.0 0.2 0.35 0.5 0.65 0.8]

// ========================================
// GRANO
// ========================================

//#define LENS_GRAIN // Añade un grano monocromatico animado

#define LENS_GRAIN_STRENGTH 0.01 // Intensidad del grano. Los valores altos hacen mas visible el ruido [0.0 0.005 0.01 0.015 0.02 0.03 0.05]

// ========================================
// ABERRACION CROMATICA
// ========================================

//#define LENS_CHROMATIC // Separa ligeramente los canales de color hacia los bordes de la imagen

#define LENS_CHROMATIC_STRENGTH 0.75 // Separacion maxima de los canales respecto al verde, en pixeles [0.0 0.25 0.5 0.75 1.0 1.5 2.0 3.0 4.0]

// ========================================
// ENFOQUE
// ========================================

//#define LENS_SHARPENING // Refuerza ligeramente los detalles mediante un filtro de enfoque

#define LENS_SHARPENING_STRENGTH 0.15 // Intensidad del enfoque. Los valores altos pueden producir contornos artificiales [0.0 0.05 0.1 0.15 0.2 0.3 0.5 0.75 1.0]