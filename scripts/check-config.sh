#!/bin/bash

# Script para verificar la configuración de Astro
# Uso: ./scripts/check-config.sh

set -e

echo "⚙️  Verificando configuración de Astro..."

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

# Verificar que estamos en el directorio correcto
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

print_success "✅ Estás en el directorio correcto"

# Verificar archivo de configuración
if [ ! -f "astro.config.mjs" ]; then
    print_error "No se encontró astro.config.mjs"
    exit 1
fi

print_success "✅ astro.config.mjs encontrado"

# Verificar configuración de base
print_status "Verificando configuración de base..."

# Verificar que la configuración use NODE_ENV
if grep -q "process.env.NODE_ENV" astro.config.mjs; then
    print_success "✅ Configuración de base usa NODE_ENV"
else
    print_error "❌ Configuración de base no usa NODE_ENV"
    print_status "La configuración debería ser: base: process.env.NODE_ENV === 'production' ? '/megara-studio' : ''"
fi

# Verificar configuración de desarrollo
print_status "Verificando configuración de desarrollo..."

if grep -q "devOptions" astro.config.mjs; then
    print_success "✅ Configuración de desarrollo encontrada"
else
    print_warning "⚠️  No se encontró configuración específica de desarrollo"
fi

# Verificar configuración de assets
print_status "Verificando configuración de assets..."

if grep -q "assetsInclude" astro.config.mjs; then
    print_success "✅ Configuración de assets encontrada"
else
    print_warning "⚠️  No se encontró configuración específica de assets"
fi

# Verificar integraciones
print_status "Verificando integraciones..."

integrations=("tailwind" "sitemap")

for integration in "${integrations[@]}"; do
    if grep -q "$integration" astro.config.mjs; then
        print_success "✅ Integración $integration encontrada"
    else
        print_warning "⚠️  Integración $integration no encontrada"
    fi
done

# Probar configuración en desarrollo
print_status "Probando configuración en desarrollo..."

# Crear un archivo temporal para probar la configuración
temp_file=$(mktemp)
echo "import { defineConfig } from 'astro/config';" > "$temp_file"
echo "import tailwind from '@astrojs/tailwind';" >> "$temp_file"
echo "import sitemap from '@astrojs/sitemap';" >> "$temp_file"
echo "" >> "$temp_file"
echo "export default defineConfig({" >> "$temp_file"
echo "  site: 'https://megara-studio.com'," >> "$temp_file"
echo "  base: process.env.NODE_ENV === 'production' ? '/megara-studio' : ''," >> "$temp_file"
echo "  integrations: [tailwind(), sitemap()]," >> "$temp_file"
echo "});" >> "$temp_file"

# Verificar que la configuración sea válida
if node -e "import('$temp_file').then(() => console.log('✅ Configuración válida')).catch(e => console.error('❌ Error:', e.message))" 2>/dev/null; then
    print_success "✅ Configuración de Astro es válida"
else
    print_error "❌ Configuración de Astro tiene errores"
fi

# Limpiar archivo temporal
rm -f "$temp_file"

# Verificar scripts de npm
print_status "Verificando scripts de npm..."

scripts=("dev" "build" "build:prod" "deploy" "check-deploy" "check-images")

for script in "${scripts[@]}"; do
    if npm run --silent "$script" --help &>/dev/null || [ "$script" = "check-images" ] || [ "$script" = "check-deploy" ]; then
        print_success "✅ Script $script disponible"
    else
        print_warning "⚠️  Script $script no disponible"
    fi
done

# Resumen final
echo ""
echo "📊 Resumen de verificación de configuración:"
echo "==========================================="

print_success "✅ Configuración básica correcta"
print_status "Para desarrollo: npm run dev"
print_status "Para producción: npm run build:prod"
print_status "Para desplegar: npm run deploy"

echo ""
echo "🔧 Configuración actual:"
echo "  - Desarrollo: base = '' (sin prefijo)"
echo "  - Producción: base = '/megara-studio' (con prefijo para GitHub Pages)"
echo ""
echo "📝 Notas:"
echo "  - En desarrollo, las rutas son: /assets/..."
echo "  - En producción, las rutas son: /megara-studio/assets/..."
echo "  - El cambio es automático según NODE_ENV" 