#!/bin/bash

# Script para verificar la configuración de GitHub Pages
# Uso: ./scripts/check-github-pages.sh

set -e

echo "🔍 Verificando configuración de GitHub Pages..."

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

# Verificar que git está instalado
if ! command -v git &> /dev/null; then
    print_error "Git no está instalado. Por favor instala Git primero."
    exit 1
fi

# Verificar que git está inicializado
if [ ! -d ".git" ]; then
    print_error "Git no está inicializado. Ejecuta 'git init'"
    exit 1
fi

# Verificar remoto de git
if ! git remote get-url origin &> /dev/null; then
    print_error "No hay un remoto 'origin' configurado. Asegúrate de agregar tu repositorio de GitHub"
    exit 1
else
    remote_url=$(git remote get-url origin)
    print_success "Remoto configurado: $remote_url"
fi

# Extraer información del repositorio
repo_name=$(basename -s .git "$remote_url")
user_name=$(echo "$remote_url" | sed -n 's/.*github\.com[:/]\([^/]*\)\/.*/\1/p')

print_status "Información del repositorio:"
echo "  - Usuario: $user_name"
echo "  - Repositorio: $repo_name"

# Verificar rama actual
current_branch=$(git branch --show-current)
print_status "Rama actual: $current_branch"

# Verificar si la rama gh-pages existe
if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    print_success "Rama gh-pages existe en el remoto"
else
    print_warning "Rama gh-pages no existe en el remoto"
fi

# Verificar archivo .nojekyll
if [ -f ".nojekyll" ]; then
    print_success "Archivo .nojekyll encontrado"
else
    print_warning "Archivo .nojekyll no encontrado (recomendado para GitHub Pages)"
fi

# Verificar configuración de Astro
if [ -f "astro.config.mjs" ]; then
    print_success "Configuración de Astro encontrada"
    
    # Verificar base path
    base_path=$(grep -o 'base: "[^"]*"' astro.config.mjs | cut -d'"' -f2)
    if [ -n "$base_path" ]; then
        print_status "Base path configurado: $base_path"
        
        # Verificar que el base path coincide con el nombre del repositorio
        expected_base="/$repo_name"
        if [ "$base_path" = "$expected_base" ]; then
            print_success "Base path coincide con el nombre del repositorio"
        else
            print_warning "Base path ($base_path) no coincide con el nombre del repositorio ($expected_base)"
        fi
    else
        print_warning "No se pudo detectar el base path en astro.config.mjs"
    fi
else
    print_error "No se encontró astro.config.mjs"
fi

echo ""
echo "📋 Instrucciones para configurar GitHub Pages:"
echo "=============================================="
echo ""
echo "1. Ve a tu repositorio en GitHub: https://github.com/$user_name/$repo_name"
echo ""
echo "2. Ve a Settings > Pages"
echo ""
echo "3. En 'Source', selecciona 'Deploy from a branch'"
echo ""
echo "4. En 'Branch', selecciona 'gh-pages' y '/ (root)'"
echo ""
echo "5. Haz clic en 'Save'"
echo ""
echo "6. Espera unos minutos para que se active el despliegue"
echo ""
echo "7. Tu sitio estará disponible en: https://$user_name.github.io/$repo_name"
echo ""
echo "🔧 Configuración recomendada:"
echo "============================"
echo ""
echo "- Base path en astro.config.mjs: /$repo_name"
echo "- Rama de despliegue: gh-pages"
echo "- Archivo .nojekyll: presente"
echo "- Build command: NODE_ENV=production npm run build"
echo ""
echo "⚠️  Notas importantes:"
echo "===================="
echo ""
echo "- El primer despliegue puede tomar hasta 10 minutos"
echo "- Los cambios posteriores suelen reflejarse en 2-5 minutos"
echo "- Si el CSS no carga, verifica que el base path esté correcto"
echo "- Asegúrate de que el archivo .nojekyll esté en la raíz del build"
echo ""
echo "🔍 Para verificar el despliegue:"
echo "==============================="
echo ""
echo "1. Ejecuta: npm run deploy"
echo "2. Ve a: https://$user_name.github.io/$repo_name"
echo "3. Inspecciona la consola del navegador para errores"
echo "4. Verifica que los archivos CSS se cargan correctamente"
echo ""

print_success "✅ Verificación completada"
print_status "Sigue las instrucciones arriba para configurar GitHub Pages correctamente" 