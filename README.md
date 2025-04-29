# LandingProperties 🏘️

## Descripción del Proyecto

LandingProperties es una aplicación web moderna e interactiva diseñada para mostrar y filtrar propiedades inmobiliarias. La plataforma ofrece una experiencia de usuario intuitiva que permite a los usuarios explorar propiedades mediante un mapa interactivo, filtros avanzados y tarjetas de propiedades detalladas.

[![image.png](https://i.postimg.cc/HLssr8x6/image.png)](https://postimg.cc/CRXVt1b8)
[![image.png](https://i.postimg.cc/D0s79qjw/image.png)](https://postimg.cc/Zvbk3yzG)

## 🌟 Características Principales

- **Mapa Interactivo**: Visualización geográfica de propiedades usando Leaflet
- **Filtros Avanzados**: 
  - Filtrado por tipo de propiedad
  - Filtrado por operación (venta/renta)
  - Rango de precios
  - Filtro por amenidades
- **Tarjetas de Propiedades Detalladas**
- **Responsive Design**: Funciona en dispositivos móviles y de escritorio
- **Búsqueda por Dirección**

## 🛠️ Tecnologías Utilizadas

### Frontend
- HTML5
- CSS3
- JavaScript (ES6+)
- Bootstrap 5
- Font Awesome
- Leaflet.js

### Backend
- PHP
- MySQL

## 📦 Requisitos Previos

- Servidor web (Apache/Nginx)
- PHP 7.4+
- MySQL 5.7+
- Navegador web moderno

## 🚀 Instalación

### Clonar el Repositorio
```bash
git clone https://github.com/gabozzz15/LandingPage-Properties.git
cd LandingPage-Properties
```

### Configuración de Base de Datos
1. Crear base de datos:
```sql
CREATE DATABASE inmobiliaria_landing_db;
```

2. Importar estructura de base de datos:
```bash
mysql -u tu_usuario -p inmobiliaria_landing_db < inmobiliaria_landing_db.sql
```

3. Configurar conexión de base de datos en `get_properties.php`:
```php
$conn = new PDO("mysql:host=localhost;dbname=inmobiliaria_landing_db", "usuario", "contraseña");
```

## 🔧 Configuración

### Estructura de Archivos
```
LandingProperties/
│
├── css/
│   ├── styles.css
│   └── img/
│
├── js/
│   └── main.js
│
├── index.html
├── get_properties.php
└── inmobiliaria_landing_db.sql
```

## 🌐 Despliegue

### Configuración del Servidor
1. Copiar archivos al directorio web
2. Configurar permisos
3. Verificar conexión a base de datos

## 🔍 Funcionalidades Detalladas

### Filtrado de Propiedades
- Filtro por tipo de propiedad (casa, departamento, terreno, etc.)
- Filtro por operación (venta/renta)
- Rango de precios personalizable
- Selección de múltiples amenidades

### Mapa Interactivo
- Ubicación de propiedades en mapa de Venezuela
- Zoom y navegación
- Marcadores con información de propiedades
- Centrado en propiedades seleccionadas

## 📱 Responsive Design
- Diseño adaptable para móviles, tablets y escritorio
- Menús colapsables
- Ajuste de layout según tamaño de pantalla

## 🤝 Contribuciones

### Cómo Contribuir
1. Haz un Fork del repositorio
2. Crea tu rama de características (`git checkout -b feature/AmazingFeature`)
3. Commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 🐛 Reportar Problemas
Reporta problemas o sugerencias en [Issues del Proyecto](https://github.com/gabozzz15/LandingPage-Properties/issues)


## 📄 Licencia

Distribuido bajo Licencia MIT. Consulte `LICENSE` para más información.

## 📞 Contacto

Gabriel Bastardo - gabitobastardo@gmail.com

Link del Proyecto: [https://github.com/gabozzz15/LandingPage-Properties](https://github.com/tu-usuario/LandingProperties)

## 🙏 Agradecimientos
- [Leaflet.js](https://leafletjs.com/)
- [Bootstrap](https://getbootstrap.com)
- [Font Awesome](https://fontawesome.com)
- [OpenStreetMap](https://www.openstreetmap.org/)

---
