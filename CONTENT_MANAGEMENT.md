# Sistema de Gestión de Contenido - Megara Studio

Este sistema permite gestionar todo el contenido del sitio web desde un archivo JSON centralizado, facilitando las actualizaciones y mantenimiento del contenido.

## 📁 Estructura de Archivos

```
src/
├── data/
│   ├── content.json          # Contenido principal del sitio
│   └── sliderImages.ts       # Configuración de imágenes del slider
├── utils/
│   └── content.ts            # Utilidades para manejar el contenido
└── components/
    └── *.astro              # Componentes que usan el contenido
```

## 🎯 Cómo Funciona

### 1. **Archivo de Contenido Principal** (`src/data/content.json`)

Este archivo contiene todo el texto del sitio organizado por secciones:

```json
{
  "site": {
    "name": "Megara Studio",
    "tagline": "Consultorio de Sanación Integral"
  },
  "hero": {
    "title": "Sana tu cuerpo, mente y alma...",
    "subtitle": "Terapias de sanación emocional..."
  },
  "services": {
    "title": "Nuestros Servicios de Sanación",
    "items": [...]
  }
}
```

### 2. **Utilidades de Contenido** (`src/utils/content.ts`)

Proporciona funciones para acceder al contenido de forma tipada:

```typescript
import { getHeroContent, getServicesContent } from "../utils/content";

// Obtener contenido específico
const heroContent = getHeroContent();
const servicesContent = getServicesContent();
```

### 3. **Componentes Actualizados**

Los componentes ahora usan el contenido del JSON:

```astro
---
import { getHeroContent } from "../utils/content";

const heroContent = getHeroContent();
---

<h1>{heroContent.title}</h1>
<p>{heroContent.subtitle}</p>
```

## 🔧 Cómo Modificar el Contenido

### **Para Cambiar Textos:**

1. **Abre** `src/data/content.json`
2. **Localiza** la sección que quieres modificar
3. **Edita** el texto directamente
4. **Guarda** el archivo
5. **Los cambios se reflejan automáticamente** en el sitio

### **Ejemplo de Modificación:**

```json
// Antes
"hero": {
  "title": "Sana tu cuerpo, mente y alma desde cualquier lugar del mundo"
}

// Después
"hero": {
  "title": "Transforma tu vida con sanación holística desde cualquier lugar"
}
```

## 📋 Secciones Disponibles

### **1. Información del Sitio**

- `site.name` - Nombre del sitio
- `site.description` - Descripción para SEO
- `site.keywords` - Palabras clave

### **2. Navegación**

- `navigation.home` - Enlace Inicio
- `navigation.services` - Enlace Servicios
- `navigation.bookSession` - Botón CTA principal

### **3. Sección Hero**

- `hero.title` - Título principal
- `hero.subtitle` - Subtítulo
- `hero.ctaPrimary` - Botón principal
- `hero.ctaSecondary` - Botón secundario
- `hero.trustIndicators` - Indicadores de confianza

### **4. Beneficios**

- `benefits.title` - Título de la sección
- `benefits.items` - Lista de beneficios
- `benefits.footerText` - Texto del footer

### **5. Servicios**

- `services.title` - Título de la sección
- `services.items` - Lista de servicios
- `services.cta` - Call to action

### **6. Confianza**

- `trust.title` - Título de la sección
- `trust.credentials` - Credenciales
- `trust.certifications` - Certificaciones

### **7. Testimonios**

- `testimonials.title` - Título de la sección
- `testimonials.items` - Lista de testimonios

### **8. Agenda**

- `booking.title` - Título de la sección
- `booking.whyChooseUs` - Beneficios de elegirnos
- `booking.preparation` - Preparación para sesiones

### **9. Footer**

- `footer.description` - Descripción del footer
- `footer.contact` - Información de contacto
- `footer.social` - Redes sociales

## 🚀 Funciones Útiles

### **Obtener Contenido Específico:**

```typescript
import {
  getHeroContent,
  getServicesContent,
  getTestimonialsContent,
  getBookingContent,
} from "../utils/content";
```

### **Buscar Servicio por ID:**

```typescript
import { getServiceById } from "../utils/content";

const biodescodificacion = getServiceById("biodescodificacion");
```

### **Filtrar Testimonios por Servicio:**

```typescript
import { getTestimonialsByService } from "../utils/content";

const testimoniosReiki = getTestimonialsByService("Reiki");
```

### **Obtener Contenido por Ruta:**

```typescript
import { getContentByRoute } from "../utils/content";

const contenidoHome = getContentByRoute("/");
const contenidoServicios = getContentByRoute("/servicios");
```

## ✨ Ventajas del Sistema

### **✅ Fácil Mantenimiento**

- Todo el contenido en un solo lugar
- Cambios rápidos sin tocar código
- Sin riesgo de romper la funcionalidad

### **✅ Consistencia**

- Tipado TypeScript para evitar errores
- Estructura organizada y clara
- Reutilización de contenido

### **✅ Escalabilidad**

- Fácil agregar nuevas secciones
- Soporte para múltiples idiomas (futuro)
- Integración con CMS (futuro)

### **✅ Colaboración**

- Contenido separado del código
- Fácil para no desarrolladores
- Control de versiones del contenido

## 🔄 Flujo de Trabajo

1. **Desarrollador** crea la estructura JSON
2. **Editor de contenido** modifica el JSON
3. **Sitio web** se actualiza automáticamente
4. **Sin necesidad de tocar código**

## 📝 Mejores Prácticas

### **Al Editar el JSON:**

- Mantén la estructura existente
- Usa comillas dobles para strings
- No elimines propiedades requeridas
- Verifica la sintaxis JSON

### **Al Agregar Nuevo Contenido:**

- Sigue el patrón existente
- Actualiza los tipos TypeScript
- Documenta las nuevas secciones
- Prueba en desarrollo primero

## 🛠️ Próximas Mejoras

- [ ] Interfaz visual para editar contenido
- [ ] Soporte para múltiples idiomas
- [ ] Integración con CMS headless
- [ ] Sistema de versionado de contenido
- [ ] Validación automática de contenido

---

**¡Con este sistema, modificar el contenido del sitio es tan fácil como editar un archivo de texto!**
