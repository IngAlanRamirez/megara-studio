# Estructura del Proyecto Megara Studio

## 📁 Organización de Carpetas

```
src/
├── components/          # Componentes reutilizables
│   └── ServiceCard.astro
├── layouts/            # Layouts de página
│   └── BaseLayout.astro
├── pages/              # Páginas de la aplicación
│   └── index.astro
├── assets/             # Imágenes, iconos y recursos estáticos
├── data/               # Datos dinámicos (servicios, testimonios, etc.)
│   └── services.ts
└── styles/             # Estilos globales
    └── global.css
```

## 🎨 Componentes

### BaseLayout.astro

Layout base que incluye:

- Head con meta tags y Google Fonts
- Header con navegación
- Footer
- Slot para contenido dinámico

### ServiceCard.astro

Componente para mostrar servicios con:

- Icono del servicio
- Título y descripción
- Duración
- Estilos consistentes con la paleta de colores

## 📊 Datos

### services.ts

Archivo TypeScript con:

- Interface `Service` para tipado
- Array de servicios disponibles
- Datos estructurados para fácil mantenimiento

## 🎯 Uso

### Usando el BaseLayout

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="Título de la página">
  <!-- Contenido aquí -->
</BaseLayout>
```

### Usando componentes

```astro
---
import ServiceCard from '../components/ServiceCard.astro';
import { services } from '../data/services';
---

{services.map(service => <ServiceCard service={service} />)}
```

## 🚀 Próximos Pasos

1. Crear páginas adicionales (servicios, sobre mí, contacto)
2. Agregar más componentes reutilizables
3. Implementar navegación móvil
4. Agregar imágenes y recursos en `/assets`
5. Crear datos para testimonios y otros contenidos dinámicos
