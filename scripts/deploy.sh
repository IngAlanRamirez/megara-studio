#!/bin/bash

# Script de despliegue para GitHub Pages
# Uso: ./scripts/deploy.sh

set -e  # Salir si hay algún error

echo "🚀 Iniciando despliegue a GitHub Pages..."

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

# Verificar que node está instalado
if ! command -v node &> /dev/null; then
    print_error "Node.js no está instalado. Por favor instala Node.js primero."
    exit 1
fi

# Verificar que npm está instalado
if ! command -v npm &> /dev/null; then
    print_error "npm no está instalado. Por favor instala npm primero."
    exit 1
fi

print_status "Verificando dependencias..."

# Instalar dependencias si no están instaladas
if [ ! -d "node_modules" ]; then
    print_status "Instalando dependencias..."
    npm install
    print_success "Dependencias instaladas correctamente"
else
    print_status "Dependencias ya están instaladas"
fi

# Limpiar build anterior
print_status "Limpiando build anterior..."
rm -rf dist/
print_success "Build anterior eliminado"

# Construir el proyecto
print_status "Construyendo el proyecto..."
NODE_ENV=production npm run build
print_success "Proyecto construido correctamente"

# Verificar que el build se creó correctamente
if [ ! -d "dist" ]; then
    print_error "El directorio dist no se creó. Verifica que el build fue exitoso."
    exit 1
fi

# Verificar el estado de git
print_status "Verificando estado de Git..."

# Verificar si hay cambios sin commitear
if [ -n "$(git status --porcelain)" ]; then
    print_warning "Hay cambios sin commitear en el repositorio."
    echo "¿Deseas continuar con el despliegue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_status "Despliegue cancelado por el usuario"
        exit 0
    fi
fi

# Verificar si estamos en la rama correcta (main o master)
current_branch=$(git branch --show-current)
if [[ "$current_branch" != "main" && "$current_branch" != "master" ]]; then
    print_warning "No estás en la rama main/master. Estás en: $current_branch"
    echo "¿Deseas continuar con el despliegue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_status "Despliegue cancelado por el usuario"
        exit 0
    fi
fi

# Crear rama gh-pages si no existe
print_status "Preparando rama gh-pages..."

# Verificar si la rama gh-pages existe
if ! git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    print_status "Creando rama gh-pages..."
    git checkout --orphan gh-pages
    git rm -rf .
    git commit --allow-empty -m "Initial gh-pages commit"
    git push origin gh-pages
    git checkout "$current_branch"
else
    print_status "Rama gh-pages ya existe"
fi

# Crear directorio temporal para el despliegue
print_status "Preparando archivos para despliegue..."
temp_dir=$(mktemp -d)
cp -r dist/* "$temp_dir/"

# Cambiar a la rama gh-pages
git checkout gh-pages

# Limpiar archivos existentes (excepto .git)
git rm -rf . || true

# Copiar archivos del build
cp -r "$temp_dir"/* .

# Agregar todos los archivos
git add .

# Commit de los cambios
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "Deploy to GitHub Pages - $(date '+%Y-%m-%d %H:%M:%S')"
    print_success "Cambios committeados"
else
    print_status "No hay cambios que committear"
fi

# Push a GitHub
print_status "Subiendo cambios a GitHub..."
git push origin gh-pages
print_success "Cambios subidos a GitHub"

# Volver a la rama original
git checkout "$current_branch"

# Limpiar directorio temporal
rm -rf "$temp_dir"

print_success "🎉 ¡Despliegue completado exitosamente!"
print_status "Tu sitio estará disponible en: https://[tu-usuario].github.io/megara-studio"
print_status "Puede tomar unos minutos para que los cambios se reflejen."
print_status "Para configurar GitHub Pages:"
echo "  1. Ve a Settings > Pages en tu repositorio"
echo "  2. Selecciona 'Deploy from a branch'"
echo "  3. Selecciona la rama 'gh-pages'"
echo "  4. Guarda los cambios" 