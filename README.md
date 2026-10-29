# OserShaderPack



# Shader para Minecraft

Shader personalizable para Minecraft Java 1.21.1 con OptiFine HD U J1.

El proyecto busca un aspecto cálido y contrastado, con colores e iluminación configurables.

## Funciones actuales

### Sol y Luna

- Tamaño y giro independientes.
- Colores automáticos según la hora.
- Colores RGB personalizables y modo de color fijo.
- Brillo visible independiente de la iluminación del terreno.
- Conservación de las fases lunares.

### Halos

- Halos difuminados con intensidad y extensión configurables.
- Color sincronizado con cada astro.
- Atenuación según la lluvia, el horizonte y la fase lunar.

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

### Configuración

- Menús y nombres de opciones en español.
- Descripciones de ayuda para los controles.
- Valores predeterminados elegidos para el estilo del proyecto.

## Organización

- `gbuffers_skytextured`: representación del Sol y la Luna.
- `gbuffers_terrain`: iluminación y recepción de sombras del terreno.
- `shadow`: generación del mapa de sombras.
- `composite`: halos.
- `final`: salida de la imagen.
- `lib`: opciones y cálculos compartidos.
- `lang/es_es.lang`: nombres de los controles.
- `shaders.properties`: configuración y menús.

## Estado

Proyecto en desarrollo, con pruebas manuales dentro de Minecraft. La implementación actual se ha trabajado principalmente en el Overworld.

Las sombras actuales corresponden al Sol y la Luna, no a las antorchas ni a otras luces locales.
