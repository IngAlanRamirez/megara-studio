#!/bin/bash

# Script para verificar que todo esté listo para el despliegue
# Uso: ./scripts/check-deploy.sh

set -e

echo "🔍 Verificando preparación para despliegue..."

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

# Verificar que git está instalado
if ! command -v git &> /dev/null; then
    print_error "Git no está instalado. Por favor instala Git primero."
    ((errors++))
else
    print_success "✅ Git está instalado"
fi

# Verificar que node está instalado
if ! command -v node &> /dev/null; then
    print_error "Node.js no está instalado. Por favor instala Node.js primero."
    ((errors++))
else
    node_version=$(node --version)
    print_success "✅ Node.js está instalado: $node_version"
fi

# Verificar que npm está instalado
if ! command -v npm &> /dev/null; then
    print_error "npm no está instalado. Por favor instala npm primero."
    ((errors++))
else
    npm_version=$(npm --version)
    print_success "✅ npm está instalado: $npm_version"
fi

# Verificar dependencias
if [ ! -d "node_modules" ]; then
    print_warning "Las dependencias no están instaladas. Ejecuta 'npm install'"
    ((warnings++))
else
    print_success "✅ Dependencias instaladas"
fi

# Verificar configuración de Astro
if [ ! -f "astro.config.mjs" ]; then
    print_error "No se encontró astro.config.mjs"
    ((errors++))
else
    print_success "✅ Configuración de Astro encontrada"
fi

# Verificar archivo de contenido
if [ ! -f "src/data/content.json" ]; then
    print_error "No se encontró src/data/content.json"
    ((errors++))
else
    print_success "✅ Archivo de contenido encontrado"
fi

# Verificar utilidades de contenido
if [ ! -f "src/utils/content.ts" ]; then
    print_error "No se encontró src/utils/content.ts"
    ((errors++))
else
    print_success "✅ Utilidades de contenido encontradas"
fi

# Verificar que git está inicializado
if [ ! -d ".git" ]; then
    print_error "Git no está inicializado. Ejecuta 'git init'"
    ((errors++))
else
    print_success "✅ Git está inicializado"
fi

# Verificar remoto de git
if ! git remote get-url origin &> /dev/null; then
    print_warning "No hay un remoto 'origin' configurado. Asegúrate de agregar tu repositorio de GitHub"
    ((warnings++))
else
    remote_url=$(git remote get-url origin)
    print_success "✅ Remoto configurado: $remote_url"
fi

# Verificar rama actual
current_branch=$(git branch --show-current)
if [[ "$current_branch" != "main" && "$current_branch" != "master" ]]; then
    print_warning "No estás en la rama main/master. Estás en: $current_branch"
    ((warnings++))
else
    print_success "✅ Estás en la rama correcta: $current_branch"
fi

# Verificar cambios sin commitear
if [ -n "$(git status --porcelain)" ]; then
    print_warning "Hay cambios sin commitear en el repositorio"
    ((warnings++))
else
    print_success "✅ No hay cambios sin commitear"
fi

# Verificar que el script de despliegue existe
if [ ! -f "scripts/deploy.sh" ]; then
    print_error "No se encontró scripts/deploy.sh"
    ((errors++))
else
    print_success "✅ Script de despliegue encontrado"
fi

# Verificar permisos del script
if [ ! -x "scripts/deploy.sh" ]; then
    print_warning "El script de despliegue no es ejecutable. Ejecuta 'chmod +x scripts/deploy.sh'"
    ((warnings++))
else
    print_success "✅ Script de despliegue es ejecutable"
fi

# Verificar que el script de Windows existe
if [ ! -f "scripts/deploy.bat" ]; then
    print_warning "No se encontró scripts/deploy.bat (script para Windows)"
    ((warnings++))
else
    print_success "✅ Script de despliegue para Windows encontrado"
fi

# Intentar hacer un build de prueba
print_status "Probando build del proyecto..."
if NODE_ENV=production npm run build &> /dev/null; then
    print_success "✅ Build exitoso"
    
    # Verificar que se creó el directorio dist
    if [ -d "dist" ]; then
        print_success "✅ Directorio dist creado correctamente"
        
        # Verificar archivos importantes en dist
        if [ -f "dist/index.html" ]; then
            print_success "✅ index.html generado"
        else
            print_error "No se encontró dist/index.html"
            ((errors++))
        fi
        
        # Limpiar build de prueba
        rm -rf dist/
        print_status "Build de prueba limpiado"
    else
        print_error "El directorio dist no se creó"
        ((errors++))
    fi
else
    print_error "Build falló. Revisa los errores en la consola"
    ((errors++))
fi

# Resumen final
echo ""
echo "📊 Resumen de verificación:"
echo "=========================="

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
    print_success "🎉 ¡Todo está listo para el despliegue!"
    echo ""
    echo "Para desplegar, ejecuta:"
    echo "  npm run deploy"
    echo ""
    echo "O manualmente:"
    echo "  ./scripts/deploy.sh"
else
    print_error "❌ Corrige los errores antes de desplegar"
    exit 1
fi 