# Slider de Imágenes - Megara Studio

Este componente de slider reemplaza el área del mandala en la sección hero y permite mostrar múltiples imágenes de manera elegante y responsiva.

## Características

- ✅ **Formato rectangular**: Diseño moderno y elegante
- ✅ **Difuminado diagonal**: Efecto sutil de esquina superior izquierda a inferior derecha
- ✅ **Autoplay configurable**: Reproducción automática con velocidad personalizable
- ✅ **Navegación manual**: Flechas y puntos de navegación
- ✅ **Responsive**: Se adapta a diferentes tamaños de pantalla
- ✅ **Accesible**: Incluye atributos ARIA y navegación por teclado
- ✅ **Transiciones suaves**: Animaciones fluidas entre imágenes
- ✅ **Pausa en hover**: Se detiene automáticamente al pasar el mouse
- ✅ **Carga lazy**: Optimización de rendimiento
- ✅ **Efecto hover**: Escala sutil al pasar el mouse

## Uso Básico

```astro
---
import ImageSlider from '../components/ImageSlider.astro';
import { heroSliderImages } from '../data/sliderImages';
---

<ImageSlider images={heroSliderImages} />
```

## Props Disponibles

| Prop            | Tipo                              | Default    | Descripción                                           |
| --------------- | --------------------------------- | ---------- | ----------------------------------------------------- |
| `images`        | `SliderImage[]`                   | `[]`       | Array de imágenes a mostrar                           |
| `autoplay`      | `boolean`                         | `true`     | Activar/desactivar reproducción automática            |
| `autoplaySpeed` | `number`                          | `5000`     | Velocidad en milisegundos entre transiciones          |
| `showDots`      | `boolean`                         | `true`     | Mostrar/ocultar indicadores de puntos                 |
| `showArrows`    | `boolean`                         | `true`     | Mostrar/ocultar flechas de navegación                 |
| `blurIntensity` | `'light' \| 'medium' \| 'strong'` | `'medium'` | Intensidad del difuminado diagonal (solo en variante) |

## Estructura de Imágenes

```typescript
interface SliderImage {
  src: string; // URL de la imagen
  alt: string; // Texto alternativo para accesibilidad
  title?: string; // Título opcional de la imagen
}
```

## Ejemplos de Configuración

### Slider Básico

```astro
<ImageSlider
  images={heroSliderImages}
  autoplay={true}
  autoplaySpeed={5000}
  showDots={true}
  showArrows={true}
/>
```

### Slider Manual (sin autoplay)

```astro
<ImageSlider
  images={heroSliderImages}
  autoplay={false}
  showDots={true}
  showArrows={true}
/>
```

### Slider Solo con Flechas

```astro
<ImageSlider
  images={heroSliderImages}
  autoplay={true}
  showDots={false}
  showArrows={true}
/>
```

### Slider Solo con Puntos

```astro
<ImageSlider
  images={heroSliderImages}
  autoplay={true}
  showDots={true}
  showArrows={false}
/>
```

## Agregar Nuevas Imágenes

1. Coloca las imágenes en `public/assets/slider/`
2. Actualiza el array en `src/data/sliderImages.ts`:

```typescript
export const heroSliderImages: SliderImage[] = [
  {
    src: "/assets/logo/megara_studio.jpeg",
    alt: "Megara Studio - Terapias de sanación",
    title: "Megara Studio",
  },
  {
    src: "/assets/slider/nueva-imagen.jpg",
    alt: "Descripción de la nueva imagen",
    title: "Título de la imagen",
  },
  // ... más imágenes
];
```

## Personalización de Estilos

El slider usa las clases de Tailwind CSS. Puedes personalizar:

- **Tamaño**: Modifica las clases `w-96 h-72 lg:w-[28rem] lg:h-80` (formato rectangular más grande)
- **Forma**: Cambia `rounded-lg` por otras clases de border-radius
- **Difuminado**: Ajusta las clases de gradiente en el overlay
- **Colores**: Actualiza las clases de color en los botones y puntos
- **Animaciones**: Modifica las clases de transición y animación
- **Sombra**: Personaliza el efecto de sombra con `shadow-lg` o `shadow-xl`

## Demo

Visita `/slider-demo` para ver ejemplos del slider en acción.

## Notas Técnicas

- El slider se inicializa automáticamente cuando el DOM está listo
- Las imágenes se cargan de forma lazy para mejor rendimiento
- El autoplay se pausa automáticamente al hacer hover sobre el slider
- Los controles solo aparecen si hay más de una imagen
- El componente es completamente responsivo y accesible
