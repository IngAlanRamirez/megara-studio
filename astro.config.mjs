// @ts-check
import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

// https://astro.build/config
export default defineConfig({
  site: "https://megara-studio.com",
  // Solo usar base en producción, no en desarrollo
  base: process.env.NODE_ENV === "production" ? "/megara-studio" : "",
  integrations: [
    tailwind(),
    sitemap({
      changefreq: "weekly",
      priority: 0.7,
      lastmod: new Date(),
    }),
  ],
  // Configuración para desarrollo local
  devOptions: {
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
