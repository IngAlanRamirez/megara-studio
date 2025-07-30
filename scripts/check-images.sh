#!/bin/bash

# Script para verificar que todas las imágenes sean accesibles
# Uso: ./scripts/check-images.sh

set -e

echo "🖼️  Verificando accesibilidad de imágenes..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con colores
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Contador de errores
errors=0
warnings=0

# Verificar que estamos en el directorio correcto
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

print_success "✅ Estás en el directorio correcto"

# Lista de imágenes que deben existir
declare -a images=(
    "public/assets/logo/megara_studio.jpeg"
    "public/assets/slider/meditate-5353620_640.jpg"
    "public/assets/slider/yoga-6128116_640.jpg"
    "public/assets/slider/massage-6520411_640.jpg"
    "public/assets/slider/cacao-3995994_640.jpg"
    "public/assets/slider/tarot-3764407_640.jpg"
    "public/assets/slider/beautiful-8178741_640.jpg"
    "public/assets/slider/statue-7329573_640.jpg"
)

print_status "Verificando existencia de archivos de imagen..."

# Verificar cada imagen
for image in "${images[@]}"; do
    if [ -f "$image" ]; then
        # Obtener tamaño del archivo
        size=$(ls -lh "$image" | awk '{print $5}')
        print_success "✅ $image ($size)"
    else
        print_error "❌ $image - NO ENCONTRADO"
        ((errors++))
    fi
done

# Verificar permisos de lectura
print_status "Verificando permisos de lectura..."

for image in "${images[@]}"; do
    if [ -f "$image" ]; then
        if [ -r "$image" ]; then
            print_success "✅ Permisos correctos: $image"
        else
            print_error "❌ Sin permisos de lectura: $image"
            ((errors++))
        fi
    fi
done

# Verificar que el servidor de desarrollo esté corriendo
print_status "Verificando servidor de desarrollo..."

# Intentar hacer una petición HTTP a localhost:4321
if command -v curl &> /dev/null; then
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:4321 | grep -q "200"; then
        print_success "✅ Servidor de desarrollo está corriendo en localhost:4321"
        
        # Verificar una imagen específica
        if curl -s -o /dev/null -w "%{http_code}" http://localhost:4321/assets/logo/megara_studio.jpeg | grep -q "200"; then
            print_success "✅ Imagen accesible via HTTP: /assets/logo/megara_studio.jpeg"
        else
            print_warning "⚠️  Imagen no accesible via HTTP: /assets/logo/megara_studio.jpeg"
            ((warnings++))
        fi
    else
        print_warning "⚠️  Servidor de desarrollo no está corriendo en localhost:4321"
        print_status "Para iniciar el servidor, ejecuta: npm run dev"
        ((warnings++))
    fi
else
    print_warning "⚠️  curl no está instalado, no se puede verificar el servidor"
    ((warnings++))
fi

# Verificar rutas en el código
print_status "Verificando rutas en el código..."

# Buscar referencias a imágenes en el código
image_references=$(grep -r "assets/" src/ --include="*.astro" --include="*.ts" --include="*.js" | grep -E "\.(jpg|jpeg|png|gif|svg)" || true)

if [ -n "$image_references" ]; then
    print_status "Referencias encontradas en el código:"
    echo "$image_references" | while read -r line; do
        print_status "  $line"
    done
else
    print_warning "⚠️  No se encontraron referencias a imágenes en el código"
    ((warnings++))
fi

# Verificar configuración de Astro
print_status "Verificando configuración de Astro..."

if [ -f "astro.config.mjs" ]; then
    print_success "✅ astro.config.mjs encontrado"
    
    # Verificar si hay configuración de assets
    if grep -q "assetsInclude" astro.config.mjs; then
        print_success "✅ Configuración de assets encontrada"
    else
        print_warning "⚠️  No se encontró configuración específica de assets"
        ((warnings++))
    fi
else
    print_error "❌ astro.config.mjs no encontrado"
    ((errors++))
fi

# Resumen final
echo ""
echo "📊 Resumen de verificación de imágenes:"
echo "======================================"

if [ $errors -eq 0 ]; then
    print_success "✅ No se encontraron errores críticos"
else
    print_error "❌ Se encontraron $errors errores críticos"
fi

if [ $warnings -eq 0 ]; then
    print_success "✅ No se encontraron advertencias"
else
    print_warning "⚠️  Se encontraron $warnings advertencias"
fi

echo ""

if [ $errors -eq 0 ]; then
    print_success "🎉 ¡Todas las imágenes están listas!"
    echo ""
    echo "Para verificar en el navegador:"
    echo "  1. Asegúrate de que el servidor esté corriendo: npm run dev"
    echo "  2. Abre http://localhost:4321 en tu navegador"
    echo "  3. Abre las herramientas de desarrollador (F12)"
    echo "  4. Ve a la pestaña Network para ver si las imágenes cargan"
else
    print_error "❌ Corrige los errores antes de continuar"
    echo ""
    echo "Sugerencias:"
    echo "  - Verifica que todas las imágenes existan en public/assets/"
    echo "  - Asegúrate de que los permisos sean correctos"
    echo "  - Reinicia el servidor de desarrollo: npm run dev"
    exit 1
fi 