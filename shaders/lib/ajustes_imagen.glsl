// ========================================
// AJUSTES GENERALES DE COLOR
// ========================================

#define IMAGE_COLOR_CORRECTION // Activa los ajustes generales de saturacion, contraste y balance de color

#define IMAGE_SATURATION 1.05 // Intensidad de los colores. 0.0 produce una imagen gris y 1.0 conserva la saturacion original [0.0 0.5 0.75 0.9 1.0 1.05 1.1 1.2 1.35 1.5 2.0]

#define IMAGE_CONTRAST 1.03 // Contraste general. 1.0 no modifica el contraste. Los valores superiores refuerzan claros y oscuros [0.5 0.75 0.9 0.95 1.0 1.03 1.05 1.1 1.2 1.35 1.5 2.0]

#define IMAGE_WARMTH 0.1 // Balance artistico de color. Los valores negativos enfrían la imagen y los positivos la hacen mas calida. 0.0 es neutro [-1.0 -0.75 -0.5 -0.25 -0.1 0.0 0.1 0.25 0.5 0.75 1.0]

// ========================================
// EXPOSICION Y BRILLO
// ========================================

#define IMAGE_EXPOSURE 0.0 // Exposicion manual en pasos EV. 0.0 no modifica la exposicion. Los valores positivos aclaran y los negativos oscurecen [-2.0 -1.5 -1.0 -0.75 -0.5 -0.25 0.0 0.25 0.5 0.75 1.0 1.5 2.0]

#define IMAGE_BRIGHTNESS 0.0 // Ajuste fino sumado al color final. 0.0 no modifica el brillo. Los valores positivos pueden levantar los negros [-0.1 -0.075 -0.05 -0.025 -0.01 0.0 0.01 0.025 0.05 0.075 0.1]