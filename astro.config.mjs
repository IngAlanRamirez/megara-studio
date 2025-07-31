// @ts-check
import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

// Determinar el base path según el entorno
const isProduction = process.env.NODE_ENV === "production";
const basePath = isProduction ? "/megara-studio" : "";

console.log("🔧 Configuración de Astro:");
console.log("  - NODE_ENV:", process.env.NODE_ENV);
console.log("  - Base path:", basePath);

// https://astro.build/config
export default defineConfig({
  site: "https://ingalanramirez.github.io",
  base: basePath,
  integrations: [
    tailwind(),
    sitemap({
      changefreq: "weekly",
      priority: 0.7,
      lastmod: new Date(),
    }),
  ],
  // Configuración para desarrollo local
  server: {
    port: 4321,
    host: true,
  },
  // Configuración para assets
  vite: {
    assetsInclude: [
      "**/*.jpg",
      "**/*.jpeg",
      "**/*.png",
      "**/*.gif",
      "**/*.svg",
    ],
  },
});
