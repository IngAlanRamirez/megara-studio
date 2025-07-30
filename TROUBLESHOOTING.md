# 🔧 Solución de Problemas - Megara Studio

Este documento te ayuda a resolver problemas comunes que pueden surgir durante el desarrollo y despliegue del sitio.

## 🖼️ Problemas con Imágenes

### **Error: "Failed to load resource: 404 (Not Found)"**

**Síntomas:**

- Las imágenes no se cargan en el navegador
- Errores 404 en la consola del navegador
- Espacios en blanco donde deberían estar las imágenes
- Errores de "Request URLs for public/ assets must also include your base"

**Solución:**

1. **Verificar configuración de Astro:**

   ```bash
   npm run check-config
   ```

2. **Verificar que el servidor esté corriendo:**

   ```bash
   npm run dev
   ```

3. **Verificar que las imágenes existan:**

   ```bash
   npm run check-images
   ```

4. **Verificar la estructura de directorios:**

   ```
   public/
   ├── assets/
   │   ├── logo/
   │   │   └── megara_studio.jpeg
   │   └── slider/
   │       ├── meditate-5353620_640.jpg
   │       ├── yoga-6128116_640.jpg
   │       ├── massage-6520411_640.jpg
   │       ├── cacao-3995994_640.jpg
   │       ├── tarot-3764407_640.jpg
   │       ├── beautiful-8178741_640.jpg
   │       └── statue-7329573_640.jpg
   ```

5. **Verificar rutas en el código:**

   - Las rutas deben comenzar con `/assets/`
   - Ejemplo: `/assets/logo/megara_studio.jpeg`
   - En desarrollo: `/assets/...`
   - En producción: `/megara-studio/assets/...`

6. **Limpiar caché del navegador:**

   - Presiona `Ctrl+F5` (Windows) o `Cmd+Shift+R` (Mac)
   - O abre las herramientas de desarrollador y desactiva el caché

7. **Reiniciar el servidor de desarrollo:**

   ```bash
   # Detener el servidor (Ctrl+C)
   npm run dev
   ```

8. **Si el problema persiste:**

   ```bash
   # Limpiar caché de Astro
   npm run astro clear

   # Reinstalar dependencias
   rm -rf node_modules package-lock.json
   npm install

   # Reiniciar servidor
   npm run dev
   ```

### **Imágenes no se muestran en producción**

**Síntomas:**

- Las imágenes funcionan en desarrollo pero no en producción
- Errores 404 en GitHub Pages

**Solución:**

1. **Verificar configuración de Astro:**

   ```javascript
   // astro.config.mjs
   export default defineConfig({
     base: "/megara-studio", // Para GitHub Pages
     // ...
   });
   ```

2. **Verificar que las imágenes estén en el build:**

   ```bash
   npm run build
   ls -la dist/assets/
   ```

3. **Verificar rutas en el código:**
   - Las rutas deben ser relativas al directorio `public`
   - No usar rutas absolutas del sistema

## 🚀 Problemas de Despliegue

### **Error: "Build failed"**

**Síntomas:**

- El comando `npm run build` falla
- Errores de TypeScript o compilación

**Solución:**

1. **Verificar dependencias:**

   ```bash
   npm install
   ```

2. **Verificar errores de TypeScript:**

   ```bash
   npm run astro check
   ```

3. **Limpiar caché:**
   ```bash
   rm -rf node_modules/.cache
   rm -rf dist/
   npm install
   npm run build
   ```

### **Error: "transport invoke timed out after 60000ms"**

**Síntomas:**

- El servidor de desarrollo se queda colgado
- Timeout al cargar archivos
- Errores de Vite al procesar módulos

**Solución:**

1. **Detener todos los procesos de Astro:**

   ```bash
   pkill -f "astro dev"
   ```

2. **Limpiar completamente el proyecto:**

   ```bash
   rm -rf node_modules package-lock.json dist/ .astro/ .vite/
   ```

3. **Reinstalar dependencias:**

   ```bash
   npm install
   ```

4. **Verificar configuración:**

   ```bash
   npm run astro check
   ```

5. **Reiniciar servidor:**

   ```bash
   npm run dev
   ```

6. **Si el problema persiste:**

   ```bash
   # Verificar que estés en la rama correcta
   git branch
   git checkout develop

   # Limpiar caché del navegador
   # Presiona Ctrl+F5 (Windows) o Cmd+Shift+R (Mac)
   ```

### **Error: "Git push failed"**

**Síntomas:**

- El script de despliegue falla al hacer push
- Errores de autenticación

**Solución:**

1. **Verificar autenticación de Git:**

   ```bash
   git config --list | grep user
   ```

2. **Configurar credenciales:**

   ```bash
   git config --global user.name "Tu Nombre"
   git config --global user.email "tu@email.com"
   ```

3. **Verificar permisos del repositorio:**
   - Asegúrate de tener permisos de escritura en el repositorio
   - Verifica que el token de acceso sea válido

### **Sitio no se actualiza después del despliegue**

**Síntomas:**

- Los cambios no aparecen en el sitio en vivo
- El sitio muestra contenido antiguo

**Solución:**

1. **Verificar que el despliegue fue exitoso:**

   ```bash
   npm run check-deploy
   ```

2. **Verificar la rama gh-pages:**

   - Ve a tu repositorio en GitHub
   - Verifica que la rama `gh-pages` tenga los cambios más recientes

3. **Esperar la propagación:**

   - GitHub Pages puede tardar hasta 10 minutos en actualizar
   - Limpia el caché del navegador

4. **Verificar configuración de GitHub Pages:**
   - Settings > Pages
   - Source: Deploy from a branch
   - Branch: gh-pages

## 🎨 Problemas de Estilos

### **Estilos no se aplican**

**Síntomas:**

- El sitio se ve sin estilos
- Solo se muestra HTML básico

**Solución:**

1. **Verificar que Tailwind CSS esté instalado:**

   ```bash
   npm list @astrojs/tailwind
   ```

2. **Verificar configuración de Tailwind:**

   ```javascript
   // astro.config.mjs
   import tailwind from "@astrojs/tailwind";

   export default defineConfig({
     integrations: [tailwind()],
   });
   ```

3. **Verificar archivo de estilos:**
   ```css
   /* src/styles/global.css */
   @tailwind base;
   @tailwind components;
   @tailwind utilities;
   ```

### **Colores no coinciden**

**Síntomas:**

- Los colores no son los esperados
- El tema no se aplica correctamente

**Solución:**

1. **Verificar configuración de colores:**

   ```javascript
   // tailwind.config.js
   module.exports = {
     theme: {
       extend: {
         colors: {
           primary: {
             light: "#9CAF88",
             DEFAULT: "#7A8C6B",
             dark: "#5A6B4A",
           },
           // ...
         },
       },
     },
   };
   ```

2. **Verificar clases CSS:**
   - Asegúrate de usar las clases correctas
   - Verifica que no haya conflictos de CSS

## 📱 Problemas de Responsive

### **Sitio no se ve bien en móviles**

**Síntomas:**

- El diseño se rompe en pantallas pequeñas
- Elementos se superponen

**Solución:**

1. **Verificar meta viewport:**

   ```html
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   ```

2. **Verificar clases responsive:**

   ```html
   <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3"></div>
   ```

3. **Probar en diferentes dispositivos:**
   - Usa las herramientas de desarrollador del navegador
   - Prueba en dispositivos reales

## 🔍 Problemas de SEO

### **Meta tags no aparecen**

**Síntomas:**

- Los meta tags no se generan correctamente
- SEO no funciona como esperado

**Solución:**

1. **Verificar configuración de SEO:**

   ```javascript
   // src/config/seo.ts
   export const seoConfig = {
     title: "Megara Studio",
     description: "...",
     // ...
   };
   ```

2. **Verificar uso en componentes:**
   ```astro
   ---
   import { seoConfig } from "../config/seo";
   ---
   <title>{seoConfig.title}</title>
   <meta name="description" content={seoConfig.description} />
   ```

## 🛠️ Comandos Útiles

### **Diagnóstico General:**

```bash
# Verificar todo el proyecto
npm run check-deploy

# Verificar configuración de Astro
npm run check-config

# Verificar imágenes
npm run check-images

# Verificar build
npm run build

# Verificar TypeScript
npm run astro check
```

### **Limpieza:**

```bash
# Limpiar node_modules
rm -rf node_modules package-lock.json
npm install

# Limpiar build
rm -rf dist/

# Limpiar caché completo
rm -rf node_modules/.cache dist/ .astro/ .vite/

# Detener procesos de Astro
pkill -f "astro dev"
```

### **Desarrollo:**

```bash
# Iniciar servidor de desarrollo
npm run dev

# Preview del build
npm run build
npm run preview

# Desplegar
npm run deploy
```

## 📞 Obtener Ayuda

Si los problemas persisten:

1. **Revisa los logs** del servidor de desarrollo
2. **Verifica la consola del navegador** (F12)
3. **Consulta la documentación** de [Astro](https://docs.astro.build)
4. **Revisa los archivos de configuración** del proyecto

---

**¡Con estos pasos deberías poder resolver la mayoría de problemas! 🚀**
