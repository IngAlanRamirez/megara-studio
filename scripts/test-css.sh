#!/bin/bash

# Script para verificar que el CSS se está generando correctamente
# Uso: ./scripts/test-css.sh

set -e

echo "🔍 Verificando generación de CSS..."

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

# Limpiar build anterior
print_status "Limpiando build anterior..."
rm -rf dist/
print_success "Build anterior eliminado"

# Construir el proyecto
print_status "Construyendo el proyecto..."
NODE_ENV=production npm run build
print_success "Proyecto construido correctamente"

# Verificar que el directorio dist existe
if [ ! -d "dist" ]; then
    print_error "El directorio dist no se creó"
    exit 1
fi

# Verificar archivos CSS en _astro
print_status "Verificando archivos CSS..."
if [ -d "dist/_astro" ]; then
    css_files=$(find dist/_astro -name "*.css" -type f)
    if [ -n "$css_files" ]; then
        print_success "Archivos CSS encontrados:"
        echo "$css_files" | while read -r file; do
            size=$(du -h "$file" | cut -f1)
            echo "  - $file ($size)"
        done
    else
        print_error "No se encontraron archivos CSS en dist/_astro"
        exit 1
    fi
else
    print_error "El directorio dist/_astro no existe"
    exit 1
fi

# Verificar que el HTML incluye el CSS
print_status "Verificando inclusión de CSS en HTML..."
if [ -f "dist/index.html" ]; then
    css_links=$(grep -c "link.*stylesheet.*_astro" dist/index.html || echo "0")
    if [ "$css_links" -gt 0 ]; then
        print_success "CSS incluido en index.html ($css_links enlaces encontrados)"
        
        # Mostrar las líneas que contienen CSS
        echo "Enlaces CSS encontrados:"
        grep "link.*stylesheet.*_astro" dist/index.html | sed 's/^/  /'
    else
        print_error "No se encontraron enlaces CSS en index.html"
        exit 1
    fi
else
    print_error "No se encontró dist/index.html"
    exit 1
fi

# Verificar contenido del CSS
print_status "Verificando contenido del CSS..."
css_file=$(find dist/_astro -name "*.css" -type f | head -1)
if [ -n "$css_file" ]; then
    css_size=$(du -h "$css_file" | cut -f1)
    css_lines=$(wc -l < "$css_file")
    
    print_success "Archivo CSS principal: $css_file"
    print_success "Tamaño: $css_size"
    print_success "Líneas: $css_lines"
    
    # Verificar que contiene Tailwind
    if grep -q "tailwind" "$css_file"; then
        print_success "CSS contiene clases de Tailwind"
    else
        print_warning "CSS no contiene clases de Tailwind (puede ser normal si está minificado)"
    fi
    
    # Verificar que contiene estilos personalizados
    if grep -q "primary\|secondary\|accent" "$css_file"; then
        print_success "CSS contiene estilos personalizados"
    else
        print_warning "CSS no contiene estilos personalizados (puede ser normal si está minificado)"
    fi
else
    print_error "No se encontró archivo CSS"
    exit 1
fi

# Verificar URLs en el HTML
print_status "Verificando URLs en el HTML..."
base_path="/megara-studio"
if grep -q "$base_path/_astro" dist/index.html; then
    print_success "URLs del CSS incluyen el base path correcto ($base_path)"
else
    print_warning "URLs del CSS no incluyen el base path esperado"
fi

print_success "🎉 Verificación de CSS completada exitosamente!"
print_status "El CSS se está generando e incluyendo correctamente en el build" 