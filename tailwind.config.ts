import type { Config } from "tailwindcss";

export default {
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#A3C49A", // verde olivo claro
          dark: "#718463",
          light: "#DDEBD6",
        },
        secondary: {
          DEFAULT: "#C6B2D6", // lavanda suave
          dark: "#9E83B1",
          light: "#EFE6F5",
        },
        accent: {
          DEFAULT: "#E9C46A", // amarillo suave
        },
        neutral: {
          DEFAULT: "#F5F5F5",
          dark: "#2F2F2F",
        },
        background: "#FFFDF8",
        surface: "#FFFFFF",
      },
      fontFamily: {
        display: ["Poppins", "sans-serif"], // para títulos
        body: ["Lora", "serif"], // para cuerpo del texto
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
} satisfies Config;
