export interface SliderImage {
  src: string;
  alt: string;
  title?: string;
}

export const heroSliderImages: SliderImage[] = [
  {
    src: "assets/logo/megara_studio.jpeg",
    alt: "Megara Studio - Terapias de sanación holística",
    title: "Megara Studio",
  },
  {
    src: "assets/slider/meditate-5353620_640.jpg",
    alt: "Meditación y mindfulness para la paz interior",
    title: "Meditación",
  },
  {
    src: "assets/slider/yoga-6128116_640.jpg",
    alt: "Yoga y terapias de movimiento para el bienestar",
    title: "Yoga Terapéutico",
  },
  {
    src: "assets/slider/massage-6520411_640.jpg",
    alt: "Masajes terapéuticos para la relajación profunda",
    title: "Masajes Terapéuticos",
  },
  {
    src: "assets/slider/cacao-3995994_640.jpg",
    alt: "Ceremonias de cacao para la sanación emocional",
    title: "Ceremonias de Cacao",
  },
  {
    src: "assets/slider/tarot-3764407_640.jpg",
    alt: "Lectura de tarot para la guía espiritual",
    title: "Lectura de Tarot",
  },
  {
    src: "assets/slider/beautiful-8178741_640.jpg",
    alt: "Terapias de belleza y bienestar holístico",
    title: "Bienestar Holístico",
  },
  {
    src: "assets/slider/statue-7329573_640.jpg",
    alt: "Sanación espiritual y energética",
    title: "Sanación Espiritual",
  },
];

// Configuración por defecto del slider
export const sliderConfig = {
  autoplay: true,
  autoplaySpeed: 5000,
  showDots: true,
  showArrows: true,
};
