#!/bin/bash

# Script para configurar GitHub Pages automáticamente
# Uso: ./scripts/setup-github-pages.sh

set -e

echo "🔧 Configurando GitHub Pages automáticamente..."

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
    print_status "Por favor instala GitHub CLI:"
    echo "  macOS: brew install gh"
    echo "  Ubuntu: sudo apt install gh"
    echo "  Windows: winget install GitHub.cli"
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

print_status "Configurando GitHub Pages para: $repo_owner/$repo_name"

# Configurar GitHub Pages para usar GitHub Actions
print_status "Configurando GitHub Pages para usar GitHub Actions..."

# Crear el archivo de configuración de GitHub Pages
cat > .github/workflows/pages.yml << EOF
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4
      
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Build with Astro
      run: |
        NODE_ENV=production npm run build
        echo "Build completed successfully"
        
    - name: Verify CSS generation
      run: |
        echo "Checking if CSS was generated..."
        if [ -d "dist/_astro" ] && [ -n "\$(find dist/_astro -name '*.css' -type f)" ]; then
          css_file=\$(find dist/_astro -name "*.css" -type f | head -1)
          css_size=\$(du -h "\$css_file" | cut -f1)
          echo "✅ CSS generated successfully: \$css_file (\$css_size)"
        else
          echo "❌ CSS not found in dist/_astro"
          exit 1
        fi
        
    - name: Verify HTML includes CSS
      run: |
        echo "Checking if HTML includes CSS link..."
        if grep -q "link.*stylesheet.*_astro" dist/index.html; then
          echo "✅ CSS link found in index.html"
        else
          echo "❌ CSS link not found in index.html"
          exit 1
        fi
        
    - name: List build contents
      run: |
        echo "Build contents:"
        ls -la dist/
        echo "CSS files:"
        find dist/_astro -name "*.css" -type f -exec ls -la {} \;
        
    - name: Upload artifact
      uses: actions/upload-pages-artifact@v3
      with:
        path: dist/

  deploy:
    environment:
      name: github-pages
      url: \${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/develop'
    
    steps:
    - name: Deploy to GitHub Pages
      id: deployment
      uses: actions/deploy-pages@v4
EOF

print_success "Archivo de workflow creado: .github/workflows/pages.yml"

# Configurar GitHub Pages usando la API de GitHub
print_status "Configurando GitHub Pages..."

# Habilitar GitHub Pages
gh api repos/$repo_owner/$repo_name/pages \
  --method POST \
  --field source.type=workflow \
  --field source.branch=main \
  --field source.path=/ \
  --silent

print_success "GitHub Pages configurado para usar GitHub Actions"

# Verificar la configuración
print_status "Verificando configuración..."

pages_config=$(gh api repos/$repo_owner/$repo_name/pages --silent)

if echo "$pages_config" | jq -e '.source.type' > /dev/null; then
    source_type=$(echo "$pages_config" | jq -r '.source.type')
    if [ "$source_type" = "workflow" ]; then
        print_success "✅ GitHub Pages configurado correctamente para usar GitHub Actions"
    else
        print_warning "⚠️ GitHub Pages no está configurado para usar GitHub Actions"
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

print_success "🎉 Configuración de GitHub Pages completada!"
print_status "El próximo push a main o develop activará el despliegue automático." 