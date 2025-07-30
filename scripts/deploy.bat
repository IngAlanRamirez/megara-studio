@echo off
REM Script de despliegue para GitHub Pages (Windows)
REM Uso: scripts\deploy.bat

echo 🚀 Iniciando despliegue a GitHub Pages...

REM Verificar que estamos en el directorio correcto
if not exist "package.json" (
    echo [ERROR] No se encontró package.json. Asegúrate de estar en el directorio raíz del proyecto.
    pause
    exit /b 1
)

REM Verificar que git está instalado
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git no está instalado. Por favor instala Git primero.
    pause
    exit /b 1
)

REM Verificar que node está instalado
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js no está instalado. Por favor instala Node.js primero.
    pause
    exit /b 1
)

REM Verificar que npm está instalado
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] npm no está instalado. Por favor instala npm primero.
    pause
    exit /b 1
)

echo [INFO] Verificando dependencias...

REM Instalar dependencias si no están instaladas
if not exist "node_modules" (
    echo [INFO] Instalando dependencias...
    npm install
    echo [SUCCESS] Dependencias instaladas correctamente
) else (
    echo [INFO] Dependencias ya están instaladas
)

REM Limpiar build anterior
echo [INFO] Limpiando build anterior...
if exist "dist" rmdir /s /q dist
echo [SUCCESS] Build anterior eliminado

REM Construir el proyecto
echo [INFO] Construyendo el proyecto...
set NODE_ENV=production
npm run build
echo [SUCCESS] Proyecto construido correctamente

REM Verificar que el build se creó correctamente
if not exist "dist" (
    echo [ERROR] El directorio dist no se creó. Verifica que el build fue exitoso.
    pause
    exit /b 1
)

REM Verificar el estado de git
echo [INFO] Verificando estado de Git...

REM Verificar si hay cambios sin commitear
git diff-index --quiet HEAD --
if errorlevel 1 (
    echo [WARNING] Hay cambios sin commitear en el repositorio.
    set /p response="¿Deseas continuar con el despliegue? (y/N): "
    if /i not "%response%"=="y" (
        echo [INFO] Despliegue cancelado por el usuario
        pause
        exit /b 0
    )
)

REM Verificar si estamos en la rama correcta (main o master)
for /f "tokens=*" %%i in ('git branch --show-current') do set current_branch=%%i
if not "%current_branch%"=="main" if not "%current_branch%"=="master" (
    echo [WARNING] No estás en la rama main/master. Estás en: %current_branch%
    set /p response="¿Deseas continuar con el despliegue? (y/N): "
    if /i not "%response%"=="y" (
        echo [INFO] Despliegue cancelado por el usuario
        pause
        exit /b 0
    )
)

REM Crear rama gh-pages si no existe
echo [INFO] Preparando rama gh-pages...

REM Verificar si la rama gh-pages existe
git show-ref --verify --quiet refs/remotes/origin/gh-pages
if errorlevel 1 (
    echo [INFO] Creando rama gh-pages...
    git checkout --orphan gh-pages
    git rm -rf .
    git commit --allow-empty -m "Initial gh-pages commit"
    git push origin gh-pages
    git checkout %current_branch%
) else (
    echo [INFO] Rama gh-pages ya existe
)

REM Crear directorio temporal para el despliegue
echo [INFO] Preparando archivos para despliegue...
set temp_dir=%TEMP%\megara-deploy-%RANDOM%
mkdir "%temp_dir%"
xcopy "dist\*" "%temp_dir%\" /E /I /Y

REM Cambiar a la rama gh-pages
git checkout gh-pages

REM Limpiar archivos existentes (excepto .git)
git rm -rf . 2>nul

REM Copiar archivos del build
xcopy "%temp_dir%\*" "." /E /I /Y

REM Agregar todos los archivos
git add .

REM Commit de los cambios
git diff-index --quiet HEAD --
if errorlevel 1 (
    git commit -m "Deploy to GitHub Pages - %date% %time%"
    echo [SUCCESS] Cambios committeados
) else (
    echo [INFO] No hay cambios que committear
)

REM Push a GitHub
echo [INFO] Subiendo cambios a GitHub...
git push origin gh-pages
echo [SUCCESS] Cambios subidos a GitHub

REM Volver a la rama original
git checkout %current_branch%

REM Limpiar directorio temporal
rmdir /s /q "%temp_dir%"

echo [SUCCESS] 🎉 ¡Despliegue completado exitosamente!
echo [INFO] Tu sitio estará disponible en: https://[tu-usuario].github.io/megara-studio
echo [INFO] Puede tomar unos minutos para que los cambios se reflejen.
echo [INFO] Para configurar GitHub Pages:
echo   1. Ve a Settings ^> Pages en tu repositorio
echo   2. Selecciona 'Deploy from a branch'
echo   3. Selecciona la rama 'gh-pages'
echo   4. Guarda los cambios

pause 