# OserShaderPack



# Shader para Minecraft

Shader personalizable para Minecraft Java 1.21.1 con OptiFine HD U J1.

El proyecto busca un aspecto cálido y contrastado, con iluminación, colores y efectos configurables.

## Funciones actuales

### Sol y Luna

- Tamaño y giro independientes.
- Colores automáticos según la hora.
- Colores RGB personalizables y modo de color fijo.
- Brillo visible independiente de la iluminación del terreno.
- Conservación de las fases lunares.
- Halos difuminados con intensidad y extensión configurables.

### Iluminación

- Iluminación solar y lunar del terreno.
- Intensidad y colores configurables.
- Luz ambiental y luz indirecta del cielo diferenciadas entre día y noche.
- Influencia configurable de la lluvia y las fases lunares.
- Contribución de la iluminación de bloques mediante el mapa de luz de Minecraft.

### Sombras

- Sombras solares y lunares.
- Resolución, distancia, intensidad y suavizado configurables.
- Opciones para entidades y bloques especiales que proyectan sombras.
- Ajuste adicional de contraste sin reducir directamente la luz de antorchas.
- Resolución predeterminada de 2048 y distancia de 48 bloques.

### Imagen y efectos

- Saturación, contraste y balance cálido y frío.
- Exposición manual y ajuste fino de brillo.
- Viñeta, grano, aberración cromática y enfoque.
- Efectos de lente desactivados por defecto y configurables por separado.

### Configuración

- Menús organizados y nombres en español.
- Descripciones de ayuda y unidades en los controles.
- Perfiles de rendimiento, equilibrado y calidad para las sombras.
- Valores predeterminados elegidos para el estilo del proyecto.

## Organización

- `gbuffers_skytextured`: representación del Sol y la Luna.
- `gbuffers_terrain`: iluminación y recepción de sombras del terreno.
- `shadow`: generación del mapa de sombras.
- `composite`: halos.
- `final`: ajustes de imagen, efectos de lente y salida final.
- `lib`: opciones y cálculos compartidos.
- `lang/es_es.lang`: nombres y ayudas de los controles.
- `shaders.properties`: configuración, perfiles y menús.

## Estado

Proyecto en desarrollo, con pruebas manuales dentro de Minecraft y centrado principalmente en el Overworld.

Bloque A completado: organización de menús, perfiles, ajustes generales de color, exposición, brillo y efectos de lente.

Las sombras actuales corresponden al Sol y la Luna, no a las antorchas ni a otras luces locales. La integración de la iluminación propia no es todavía uniforme en todos los elementos del juego.
