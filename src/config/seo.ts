export const siteConfig = {
  name: "Megara Studio",
  description:
    "Consultorio de sanación emocional, física y espiritual. Terapias holísticas para transformar tu vida.",
  url: "https://megara-studio.com",
  ogImage: "/assets/logo/megara_studio.jpeg",
  links: {
    whatsapp: "+573001234567",
    email: "hola@megara-studio.com",
  },
  keywords: [
    "sanación holística",
    "biodescodificación",
    "biomagnetismo",
    "reiki",
    "tarot terapéutico",
    "constelaciones familiares",
    "círculos de mujeres",
    "sanación con cacao",
    "terapia emocional",
    "sanación espiritual",
    "terapias alternativas",
    "bienestar integral",
    "transformación personal",
    "sesiones online",
    "terapeuta holística",
  ],
  services: [
    "Biodescodificación",
    "Biomagnetismo",
    "Tarot Terapéutico",
    "Círculos de Mujeres",
    "Constelaciones Familiares",
    "Reiki",
    "Sanación con Cacao",
  ],
};

export const defaultSEO = {
  titleTemplate: "%s | Megara Studio",
  defaultTitle: "Megara Studio - Consultorio de Sanación Integral",
  description: siteConfig.description,
  canonical: siteConfig.url,
  openGraph: {
    type: "website",
    locale: "es_ES",
    url: siteConfig.url,
    title: siteConfig.name,
    description: siteConfig.description,
    siteName: siteConfig.name,
    images: [
      {
        url: siteConfig.ogImage,
        width: 1200,
        height: 630,
        alt: siteConfig.name,
      },
    ],
  },
  twitter: {
    handle: "@megarastudio",
    site: "@megarastudio",
    cardType: "summary_large_image",
  },
};
