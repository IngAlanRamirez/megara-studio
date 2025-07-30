# 🚀 Despliegue a GitHub Pages

Este documento explica cómo desplegar el sitio de Megara Studio a GitHub Pages.

## 📋 Prerrequisitos

Antes de desplegar, asegúrate de tener instalado:

- ✅ **Git** - Para control de versiones
- ✅ **Node.js** (v16 o superior) - Para ejecutar Astro
- ✅ **npm** - Para gestionar dependencias
- ✅ **Cuenta de GitHub** - Para alojar el sitio

## 🔧 Configuración Inicial

### 1. **Crear Repositorio en GitHub**

1. Ve a [GitHub](https://github.com) y crea un nuevo repositorio
2. Nombra el repositorio: `megara-studio`
3. Hazlo público (requerido para GitHub Pages gratuito)
4. No inicialices con README (ya tenemos uno)

### 2. **Subir Código a GitHub**

```bash
# Inicializar git (si no está inicializado)
git init

# Agregar el repositorio remoto
git remote add origin https://github.com/[tu-usuario]/megara-studio.git

# Agregar todos los archivos
git add .

# Commit inicial
git commit -m "Initial commit: Megara Studio website"

# Subir a GitHub
git push -u origin main
```

### 3. **Configurar GitHub Pages**

1. Ve a tu repositorio en GitHub
2. Ve a **Settings** > **Pages**
3. En **Source**, selecciona **Deploy from a branch**
4. En **Branch**, selecciona **gh-pages** y **/(root)**
5. Haz clic en **Save**

## 🚀 Despliegue

### **Opción 1: Script Automático (Recomendado)**

#### **Para macOS/Linux:**

```bash
# Despliegue normal
npm run deploy

# Despliegue forzado (ignora cambios sin commitear)
npm run deploy:force
```

#### **Para Windows:**

```bash
# Despliegue normal
npm run deploy:win
```

### **Opción 2: Script Manual**

#### **Para macOS/Linux:**

```bash
# Hacer el script ejecutable (solo la primera vez)
chmod +x scripts/deploy.sh

# Ejecutar el script
./scripts/deploy.sh
```

#### **Para Windows:**

```cmd
# Ejecutar el script
scripts\deploy.bat
```

### **Opción 3: Despliegue Manual**

```bash
# 1. Construir el proyecto
npm run build

# 2. Crear rama gh-pages (solo la primera vez)
git checkout --orphan gh-pages
git rm -rf .
git commit --allow-empty -m "Initial gh-pages commit"
git push origin gh-pages

# 3. Copiar archivos del build
cp -r dist/* .

# 4. Commit y push
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages

# 5. Volver a la rama principal
git checkout main
```

## 🔍 ¿Qué hace el Script de Despliegue?

El script automatizado realiza los siguientes pasos:

1. **✅ Verificaciones**

   - Comprueba que estés en el directorio correcto
   - Verifica que Git, Node.js y npm estén instalados
   - Instala dependencias si es necesario

2. **🏗️ Construcción**

   - Limpia builds anteriores
   - Construye el proyecto con `npm run build`
   - Verifica que el build sea exitoso

3. **📝 Gestión de Git**

   - Verifica el estado del repositorio
   - Crea la rama `gh-pages` si no existe
   - Maneja cambios sin commitear

4. **🚀 Despliegue**

   - Copia archivos del build a la rama `gh-pages`
   - Hace commit de los cambios
   - Sube a GitHub

5. **🧹 Limpieza**
   - Vuelve a la rama original
   - Limpia archivos temporales

## 🌐 URL del Sitio

Una vez desplegado, tu sitio estará disponible en:

```
https://[tu-usuario].github.io/megara-studio
```

**Ejemplo:** Si tu usuario es `johndoe`, la URL será:

```
https://johndoe.github.io/megara-studio
```

## ⏱️ Tiempo de Despliegue

- **Primera vez:** 5-10 minutos
- **Actualizaciones:** 2-5 minutos
- **Disponibilidad:** Puede tomar hasta 10 minutos para que los cambios se reflejen

## 🔄 Actualizar el Sitio

Para actualizar el sitio después de hacer cambios:

1. **Hacer cambios** en el código
2. **Commit y push** a la rama principal:
   ```bash
   git add .
   git commit -m "Actualizar contenido"
   git push origin main
   ```
3. **Ejecutar el script de despliegue:**
   ```bash
   npm run deploy
   ```

## 🛠️ Solución de Problemas

### **Error: "No se encontró package.json"**

- Asegúrate de estar en el directorio raíz del proyecto
- Verifica que el archivo `package.json` existe

### **Error: "Git no está instalado"**

- Instala Git desde [git-scm.com](https://git-scm.com)

### **Error: "Node.js no está instalado"**

- Instala Node.js desde [nodejs.org](https://nodejs.org)

### **Error: "Build falló"**

- Verifica que todas las dependencias estén instaladas: `npm install`
- Revisa los errores en la consola durante el build

### **Error: "Push falló"**

- Verifica que tienes permisos para escribir en el repositorio
- Asegúrate de estar autenticado en Git

### **Sitio no se actualiza**

- Espera 10-15 minutos (GitHub Pages puede tardar)
- Verifica que la rama `gh-pages` se actualizó correctamente
- Revisa la configuración de GitHub Pages

## 📞 Soporte

Si tienes problemas con el despliegue:

1. **Revisa los logs** del script de despliegue
2. **Verifica la configuración** de GitHub Pages
3. **Consulta la documentación** de [GitHub Pages](https://pages.github.com/)
4. **Revisa los errores** en la consola del navegador

## 🎯 Próximos Pasos

Después del despliegue exitoso:

1. **Configurar dominio personalizado** (opcional)
2. **Configurar HTTPS** (automático en GitHub Pages)
3. **Configurar analytics** (Google Analytics, etc.)
4. **Configurar SEO** (sitemap, meta tags, etc.)

---

**¡Tu sitio de Megara Studio estará listo para recibir visitantes! 🌟**
