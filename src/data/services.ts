export interface Service {
  id: string;
  title: string;
  description: string;
  icon: string;
  duration: string;
  price?: string;
}

export const services: Service[] = [
  {
    id: "biodescodificacion",
    title: "Biodescodificación",
    description:
      "Descubre el origen emocional de tus síntomas físicos y libera los patrones que limitan tu bienestar",
    icon: "🌱",
    duration: "60-90 minutos",
  },
  {
    id: "biomagnetismo",
    title: "Biomagnetismo",
    description:
      "Equilibra tu campo magnético corporal para restaurar la salud y el balance energético",
    icon: "🧲",
    duration: "60-90 minutos",
  },
  {
    id: "tarot-terapeutico",
    title: "Tarot Terapéutico",
    description:
      "Explora tu inconsciente y encuentra claridad en tu camino de vida a través de la sabiduría ancestral",
    icon: "🔮",
    duration: "60 minutos",
  },
  {
    id: "circulos-mujeres",
    title: "Círculos de Mujeres",
    description:
      "Conecta con tu esencia femenina en un espacio sagrado de sororidad y empoderamiento",
    icon: "🌙",
    duration: "120 minutos",
  },
  {
    id: "constelaciones",
    title: "Constelaciones Familiares",
    description:
      "Sanar las heridas familiares y liberar patrones transgeneracionales que afectan tu presente",
    icon: "⭐",
    duration: "90-120 minutos",
  },
  {
    id: "reiki",
    title: "Reiki",
    description:
      "Recibe la energía universal de sanación para equilibrar tu cuerpo, mente y espíritu",
    icon: "✨",
    duration: "60 minutos",
  },
];
