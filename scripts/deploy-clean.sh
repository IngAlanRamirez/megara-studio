#!/bin/bash

# Script de despliegue con limpieza completa de gh-pages
# Uso: ./scripts/deploy-clean.sh

set -e  # Salir si hay algún error

echo "🚀 Iniciando despliegue con limpieza completa..."

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

# Verificar que el CSS se generó correctamente
print_status "Verificando generación de CSS..."
if [ -d "dist/_astro" ] && [ -n "$(find dist/_astro -name '*.css' -type f)" ]; then
    css_file=$(find dist/_astro -name "*.css" -type f | head -1)
    css_size=$(du -h "$css_file" | cut -f1)
    print_success "CSS generado correctamente: $css_file ($css_size)"
else
    print_error "No se encontró archivo CSS en dist/_astro"
    exit 1
fi

# Verificar que el HTML incluye el CSS
if grep -q "link.*stylesheet.*_astro" dist/index.html; then
    print_success "CSS incluido correctamente en index.html"
else
    print_error "CSS no incluido en index.html"
    exit 1
fi

# Copiar archivo .nojekyll si existe
if [ -f ".nojekyll" ]; then
    print_status "Copiando archivo .nojekyll..."
    cp .nojekyll dist/
    print_success "Archivo .nojekyll copiado correctamente"
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

# LIMPIEZA COMPLETA: Eliminar rama gh-pages local y remota
print_status "Realizando limpieza completa de gh-pages..."

# Eliminar rama gh-pages local si existe
if git show-ref --verify --quiet refs/heads/gh-pages; then
    print_status "Eliminando rama gh-pages local..."
    git branch -D gh-pages
    print_success "Rama gh-pages local eliminada"
fi

# Eliminar rama gh-pages remota si existe
if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    print_status "Eliminando rama gh-pages remota..."
    git push origin --delete gh-pages
    print_success "Rama gh-pages remota eliminada"
fi

# Crear nueva rama gh-pages limpia
print_status "Creando nueva rama gh-pages limpia..."
git checkout --orphan gh-pages

# Limpiar todo el contenido
print_status "Limpiando contenido de la nueva rama..."
git rm -rf . || true

# Copiar solo los archivos del build
print_status "Copiando archivos del build..."
cp -r dist/* .

# Verificar que el archivo CSS está presente
if [ -f "_astro/agendar.DYN55g0-.css" ]; then
    print_success "Archivo CSS copiado correctamente"
    print_status "Contenido del directorio raíz:"
    ls -la
    print_status "Contenido del directorio _astro:"
    ls -la _astro/
else
    print_error "Archivo CSS no encontrado después de la copia"
    ls -la _astro/ || echo "Directorio _astro no existe"
    exit 1
fi

# Agregar todos los archivos
git add .

# Commit inicial
git commit -m "Initial gh-pages deployment - $(date '+%Y-%m-%d %H:%M:%S')"

# Push a GitHub
print_status "Subiendo nueva rama gh-pages a GitHub..."
git push origin gh-pages
print_success "Nueva rama gh-pages subida a GitHub"

# Volver a la rama original
git checkout "$current_branch"

print_success "🎉 ¡Despliegue con limpieza completa completado exitosamente!"
print_status "Tu sitio estará disponible en: https://ingalanramirez.github.io/megara-studio"
print_status "Puede tomar unos minutos para que los cambios se reflejen."
print_status "Para verificar que el CSS funciona:"
echo "  curl -I https://ingalanramirez.github.io/megara-studio/_astro/agendar.DYN55g0-.css"
print_status "Para verificar el sitio completo:"
echo "  curl -I https://ingalanramirez.github.io/megara-studio/" 