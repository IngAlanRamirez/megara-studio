# 🌟 Megara Studio - Sitio Web

Sitio web profesional para Megara Studio, consultorio de sanación emocional, física y espiritual.

## 🎯 Características

- ✅ **Diseño Moderno y Espiritual** - Colores suaves y elementos visuales armoniosos
- ✅ **Sistema de Contenido Centralizado** - Todo el contenido en un archivo JSON
- ✅ **Responsive Design** - Optimizado para móviles y escritorio
- ✅ **SEO Optimizado** - Meta tags, sitemap y estructura semántica
- ✅ **Despliegue Automatizado** - Scripts para GitHub Pages
- ✅ **Componentes Reutilizables** - Arquitectura modular y escalable

## 🚀 Despliegue Rápido

### **Verificar Preparación:**

```bash
npm run check-deploy
```

### **Desplegar a GitHub Pages:**

```bash
# macOS/Linux
npm run deploy

# Windows
npm run deploy:win
```

### **Ver Documentación Completa:**

Consulta [DEPLOYMENT.md](./DEPLOYMENT.md) para instrucciones detalladas.

## 🚀 Project Structure

Inside of your Astro project, you'll see the following folders and files:

```text
/
├── public/
├── src/
│   └── pages/
│       └── index.astro
└── package.json
```

Astro looks for `.astro` or `.md` files in the `src/pages/` directory. Each page is exposed as a route based on its file name.

There's nothing special about `src/components/`, but that's where we like to put any Astro/React/Vue/Svelte/Preact components.

Any static assets, like images, can be placed in the `public/` directory.

## 🧞 Comandos Disponibles

Todos los comandos se ejecutan desde la raíz del proyecto:

| Comando                | Acción                                             |
| :--------------------- | :------------------------------------------------- |
| `npm install`          | Instalar dependencias                              |
| `npm run dev`          | Iniciar servidor de desarrollo en `localhost:4321` |
| `npm run build`        | Construir sitio para producción en `./dist/`       |
| `npm run preview`      | Previsualizar build localmente                     |
| `npm run deploy`       | Desplegar a GitHub Pages (macOS/Linux)             |
| `npm run deploy:win`   | Desplegar a GitHub Pages (Windows)                 |
| `npm run check-deploy` | Verificar preparación para despliegue              |
| `npm run check-images` | Verificar accesibilidad de imágenes                |
| `npm run check-config` | Verificar configuración de Astro                   |
| `npm run astro ...`    | Ejecutar comandos CLI de Astro                     |

## 📁 Estructura del Proyecto

```
megara-studio/
├── src/
│   ├── components/          # Componentes reutilizables
│   ├── data/
│   │   └── content.json     # Contenido centralizado
│   ├── utils/
│   │   └── content.ts       # Utilidades de contenido
│   ├── layouts/             # Layouts de página
│   └── pages/               # Páginas del sitio
├── scripts/
│   ├── deploy.sh            # Script de despliegue (macOS/Linux)
│   ├── deploy.bat           # Script de despliegue (Windows)
│   └── check-deploy.sh      # Script de verificación
├── public/                  # Archivos estáticos
└── package.json
```

## 📚 Documentación Adicional

- 📖 [Guía de Despliegue](./DEPLOYMENT.md) - Instrucciones detalladas para GitHub Pages
- 📖 [Gestión de Contenido](./CONTENT_MANAGEMENT.md) - Cómo modificar el contenido del sitio
- 🔧 [Solución de Problemas](./TROUBLESHOOTING.md) - Resolver problemas comunes
- 📖 [Documentación de Astro](https://docs.astro.build) - Framework oficial

## 🛠️ Tecnologías Utilizadas

- **Astro** - Framework web moderno
- **Tailwind CSS** - Framework de CSS utilitario
- **TypeScript** - Tipado estático
- **GitHub Pages** - Hosting gratuito

---

**¡Tu sitio de Megara Studio está listo para el mundo! 🌟**
