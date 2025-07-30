import contentData from "../data/content.json";

// Tipos TypeScript para el contenido
export interface ContentData {
  site: {
    name: string;
    tagline: string;
    description: string;
    keywords: string;
  };
  navigation: {
    home: string;
    about: string;
    services: string;
    blog: string;
    contact: string;
    bookSession: string;
  };
  hero: {
    title: string;
    subtitle: string;
    ctaPrimary: string;
    ctaSecondary: string;
    trustIndicators: Array<{
      text: string;
      icon: string;
    }>;
  };
  benefits: {
    title: string;
    subtitle: string;
    items: Array<{
      icon: string;
      title: string;
      description: string;
    }>;
    footerText: string;
  };
  services: {
    title: string;
    subtitle: string;
    items: Array<{
      id: string;
      title: string;
      description: string;
      icon: string;
      duration?: string;
      modality?: string;
    }>;
    cta: {
      title: string;
      description: string;
      buttonText: string;
    };
  };
  trust: {
    title: string;
    subtitle: string;
    credentials: Array<{
      icon: string;
      title: string;
      description: string;
    }>;
    certifications: {
      title: string;
      description: string;
      items: string[];
    };
    cta: {
      text: string;
      buttonText: string;
    };
    footerText: string;
  };
  testimonials: {
    title: string;
    subtitle: string;
    items: Array<{
      id: number;
      name: string;
      country: string;
      avatar: string;
      service: string;
      comment: string;
    }>;
  };
  booking: {
    title: string;
    subtitle: string;
    whyChooseUs: {
      title: string;
      benefits: Array<{
        title: string;
        description: string;
      }>;
    };
    preparation: {
      title: string;
      items: string[];
    };
    whatsapp: {
      text: string;
      buttonText: string;
      message: string;
    };
    calendly: {
      title: string;
      description: string;
      note: string;
    };
    additionalInfo: {
      title: string;
      description: string;
      buttons: Array<{
        text: string;
        type: "primary" | "secondary";
      }>;
    };
  };
  footer: {
    description: string;
    links: {
      services: string;
      about: string;
      testimonials: string;
      contact: string;
      privacy: string;
      terms: string;
    };
    contact: {
      email: string;
      whatsapp: string;
      location: string;
    };
    social: {
      instagram: string;
      facebook: string;
      youtube: string;
    };
  };
  newsletter: {
    title: string;
    subtitle: string;
    placeholder: string;
    buttonText: string;
    disclaimer: string;
    successMessage: string;
    errorMessage: string;
  };
}

// Función para obtener todo el contenido
export function getContent(): ContentData {
  return contentData as ContentData;
}

// Funciones específicas para cada sección
export function getSiteInfo() {
  return contentData.site;
}

export function getNavigation() {
  return contentData.navigation;
}

export function getHeroContent() {
  return contentData.hero;
}

export function getBenefitsContent() {
  return contentData.benefits;
}

export function getServicesContent() {
  return contentData.services;
}

export function getTrustContent() {
  return contentData.trust;
}

export function getTestimonialsContent() {
  return contentData.testimonials;
}

export function getBookingContent() {
  return contentData.booking;
}

export function getFooterContent() {
  return contentData.footer;
}

export function getNewsletterContent() {
  return contentData.newsletter;
}

// Función para obtener un servicio específico por ID
export function getServiceById(id: string) {
  return contentData.services.items.find((service) => service.id === id);
}

// Función para obtener testimonios por servicio
export function getTestimonialsByService(serviceName: string) {
  return contentData.testimonials.items.filter(
    (testimonial) => testimonial.service === serviceName
  );
}

// Función para obtener contenido específico por ruta
export function getContentByRoute(route: string) {
  const routeMap: Record<string, any> = {
    "/": {
      hero: contentData.hero,
      benefits: contentData.benefits,
      services: contentData.services,
      trust: contentData.trust,
      testimonials: contentData.testimonials,
      booking: contentData.booking,
    },
    "/servicios": {
      services: contentData.services,
      testimonials: contentData.testimonials,
    },
    "/sobre-megara": {
      trust: contentData.trust,
      testimonials: contentData.testimonials,
    },
    "/agendar": {
      booking: contentData.booking,
      trust: contentData.trust,
    },
    "/contacto": {
      contact: contentData.footer.contact,
    },
  };

  return routeMap[route] || {};
}
