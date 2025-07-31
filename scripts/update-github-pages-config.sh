#!/bin/bash

# Script para actualizar la configuración de GitHub Pages para usar GitHub Actions
# Uso: ./scripts/update-github-pages-config.sh

set -e

echo "🔧 Actualizando configuración de GitHub Pages para usar GitHub Actions..."

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

# Verificar que gh CLI está instalado
if ! command -v gh &> /dev/null; then
    print_error "GitHub CLI (gh) no está instalado."
    exit 1
fi

# Verificar que el usuario está autenticado
if ! gh auth status &> /dev/null; then
    print_error "No estás autenticado con GitHub CLI."
    print_status "Por favor autentícate:"
    echo "  gh auth login"
    exit 1
fi

# Obtener el nombre del repositorio
repo_name=$(gh repo view --json name -q .name)
repo_owner=$(gh repo view --json owner -q .owner.login)

print_status "Actualizando configuración para: $repo_owner/$repo_name"

# Verificar configuración actual
print_status "Verificando configuración actual..."
current_config=$(gh api repos/$repo_owner/$repo_name/pages)

if echo "$current_config" | jq -e '.source.type' > /dev/null; then
    source_type=$(echo "$current_config" | jq -r '.source.type')
    if [ "$source_type" = "workflow" ]; then
        print_success "✅ GitHub Pages ya está configurado para usar GitHub Actions"
        exit 0
    else
        print_status "GitHub Pages está configurado para usar: $source_type"
    fi
fi

# Actualizar configuración para usar GitHub Actions
print_status "Actualizando configuración para usar GitHub Actions..."

# Primero, deshabilitar GitHub Pages
print_status "Deshabilitando configuración actual..."
gh api repos/$repo_owner/$repo_name/pages --method DELETE --silent

# Esperar un momento
sleep 2

# Habilitar GitHub Pages con GitHub Actions
print_status "Habilitando GitHub Pages con GitHub Actions..."
gh api repos/$repo_owner/$repo_name/pages \
  --method POST \
  --field source.type=workflow \
  --field source.branch=main \
  --field source.path=/ \
  --silent

print_success "GitHub Pages configurado para usar GitHub Actions"

# Verificar la nueva configuración
print_status "Verificando nueva configuración..."
sleep 5

new_config=$(gh api repos/$repo_owner/$repo_name/pages)

if echo "$new_config" | jq -e '.source.type' > /dev/null; then
    source_type=$(echo "$new_config" | jq -r '.source.type')
    if [ "$source_type" = "workflow" ]; then
        print_success "✅ GitHub Pages configurado correctamente para usar GitHub Actions"
    else
        print_warning "⚠️ GitHub Pages no está configurado para usar GitHub Actions"
        print_status "Configuración actual: $source_type"
    fi
else
    print_error "❌ No se pudo verificar la configuración de GitHub Pages"
fi

# Mostrar información adicional
print_status "Información adicional:"
echo "  - Repositorio: $repo_owner/$repo_name"
echo "  - URL del sitio: https://$repo_owner.github.io/$repo_name"
echo "  - Rama de despliegue: main, develop"
echo "  - Método de despliegue: GitHub Actions"

print_success "🎉 Configuración de GitHub Pages actualizada!"
print_status "El próximo push a main o develop activará el despliegue automático." 