# Configuración de GitHub Actions para Despliegue Automático

## 🚀 Ventajas de usar GitHub Actions

- **Despliegue automático**: Se ejecuta automáticamente en cada push
- **Entorno limpio**: Cada build se ejecuta en un entorno limpio de Ubuntu
- **Verificaciones automáticas**: Valida que el CSS se genere correctamente
- **Rollback automático**: Si algo falla, no se desplega
- **Logs detallados**: Puedes ver exactamente qué pasó en cada paso
- **Sin problemas de permisos**: GitHub Actions maneja los permisos automáticamente

## 📋 Requisitos previos

1. **GitHub CLI instalado**:
   ```bash
   # macOS
   brew install gh
   
   # Ubuntu
   sudo apt install gh
   
   # Windows
   winget install GitHub.cli
   ```

2. **Autenticación con GitHub**:
   ```bash
   gh auth login
   ```

## 🔧 Configuración automática

### Opción 1: Script automático (Recomendado)

```bash
# Ejecutar el script de configuración
npm run deploy:github-actions
```

Este script:
- Configura GitHub Pages para usar GitHub Actions
- Crea el archivo de workflow
- Verifica la configuración

### Opción 2: Configuración manual

1. **Crear el directorio de workflows**:
   ```bash
   mkdir -p .github/workflows
   ```

2. **Crear el archivo de workflow**:
   El archivo `.github/workflows/deploy.yml` ya está creado

3. **Configurar GitHub Pages**:
   - Ve a tu repositorio → Settings → Pages
   - En "Source", selecciona "GitHub Actions"

## 📁 Archivos creados

### `.github/workflows/deploy.yml`
Workflow principal que:
- Se ejecuta en push a `main` o `develop`
- Instala dependencias
- Construye el proyecto
- Verifica que el CSS se genere
- Despliega a GitHub Pages

### `.github/workflows/verify-deployment.yml`
Workflow de verificación que:
- Se ejecuta después del despliegue
- Verifica que el sitio esté accesible
- Verifica que el CSS esté disponible
- Mide el tiempo de carga

### `scripts/setup-github-pages.sh`
Script de configuración que:
- Configura GitHub Pages automáticamente
- Crea los archivos necesarios
- Verifica la configuración

## 🔄 Flujo de trabajo

1. **Push a main/develop** → Se activa el workflow
2. **Build automático** → Se construye el proyecto
3. **Verificaciones** → Se valida que todo esté correcto
4. **Despliegue** → Se sube a GitHub Pages
5. **Verificación** → Se verifica que el sitio funcione

## 📊 Monitoreo

### Ver logs del workflow:
```bash
# Ver workflows recientes
gh run list

# Ver logs de un workflow específico
gh run view <workflow-id>
```

### Verificar el sitio:
```bash
# Verificar que el sitio esté accesible
curl -I https://ingalanramirez.github.io/megara-studio/

# Verificar que el CSS esté disponible
curl -I https://ingalanramirez.github.io/megara-studio/_astro/agendar.DYN55g0-.css
```

## 🛠️ Comandos útiles

```bash
# Configurar GitHub Actions
npm run deploy:github-actions

# Despliegue manual (si es necesario)
npm run deploy:clean

# Verificar configuración
npm run check-github-pages

# Verificar CSS
npm run check-css
```

## 🔍 Verificaciones incluidas

### En el workflow de build:
- ✅ Instalación de dependencias
- ✅ Build del proyecto
- ✅ Verificación de generación de CSS
- ✅ Verificación de inclusión de CSS en HTML
- ✅ Listado de archivos generados

### En el workflow de verificación:
- ✅ Accesibilidad del sitio
- ✅ Accesibilidad del CSS
- ✅ Estructura del HTML
- ✅ Tiempo de carga

## 🚨 Solución de problemas

### Si el workflow falla:

1. **Verificar logs**:
   ```bash
   gh run list
   gh run view <workflow-id>
   ```

2. **Verificar configuración**:
   ```bash
   npm run check-github-pages
   ```

3. **Verificar CSS localmente**:
   ```bash
   npm run check-css
   ```

### Si el CSS no carga:

1. **Verificar que el workflow se ejecutó**:
   - Ve a Actions en GitHub
   - Verifica que el último workflow fue exitoso

2. **Verificar configuración de GitHub Pages**:
   - Ve a Settings → Pages
   - Asegúrate de que esté configurado para GitHub Actions

3. **Esperar propagación**:
   - GitHub Pages puede tardar hasta 10 minutos

## 🎯 Beneficios esperados

- **CSS siempre disponible**: GitHub Actions garantiza que el CSS se genere y se incluya
- **Despliegue confiable**: Sin problemas de permisos o configuración manual
- **Rollback automático**: Si algo falla, el sitio anterior sigue funcionando
- **Logs detallados**: Puedes ver exactamente qué pasó en cada paso
- **Verificaciones automáticas**: Se valida que todo funcione antes del despliegue

## 📞 Próximos pasos

1. **Ejecutar la configuración**:
   ```bash
   npm run deploy:github-actions
   ```

2. **Hacer un push de prueba**:
   ```bash
   git add .
   git commit -m "Configure GitHub Actions deployment"
   git push origin develop
   ```

3. **Verificar el despliegue**:
   - Ve a Actions en GitHub
   - Verifica que el workflow se ejecute correctamente
   - Verifica que el sitio esté disponible

¡Con GitHub Actions, el CSS debería cargar correctamente y el despliegue será mucho más confiable! 