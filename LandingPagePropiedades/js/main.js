let map;
let markers = [];
let properties = [];

// Inicializar el mapa
function initMap() {
    map = L.map('map').setView([10.4806, -66.9036], 7); // Centro de Venezuela (Caracas)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: ' OpenStreetMap contributors'
    }).addTo(map);
}

// Función para formatear precio
function formatPrice(price, currency) {
    return new Intl.NumberFormat('es-MX', {
        style: 'currency',
        currency: currency || 'MXN'
    }).format(price);
}

// Crear tarjeta de propiedad
function createPropertyCard(property) {
    const amenities = [
        { name: 'estudio', icon: 'fa-book', label: 'Estudio' },
        { name: 'sala_tv', icon: 'fa-tv', label: 'Sala TV' },
        { name: 'cuarto_servicio', icon: 'fa-bed', label: 'Cuarto Servicio' },
        { name: 'sala_juntas', icon: 'fa-users', label: 'Sala Juntas' },
        { name: 'bodega', icon: 'fa-box', label: 'Bodega' },
        { name: 'cisterna', icon: 'fa-water', label: 'Cisterna' },
        { name: 'alberca', icon: 'fa-swimming-pool', label: 'Alberca' },
        { name: 'jacuzzi', icon: 'fa-hot-tub', label: 'Jacuzzi' },
        { name: 'gimnasio', icon: 'fa-dumbbell', label: 'Gimnasio' },
        { name: 'salon_eventos', icon: 'fa-glass-cheers', label: 'Salón Eventos' },
        { name: 'garage', icon: 'fa-car', label: 'Garage' },
        { name: 'rampas', icon: 'fa-wheelchair', label: 'Rampas' },
        { name: 'asador', icon: 'fa-fire', label: 'Asador' },
        { name: 'aire_acondicionado', icon: 'fa-snowflake', label: 'Aire Acondicionado' },
        { name: 'ventiladores', icon: 'fa-fan', label: 'Ventiladores' }
    ];

    const activeAmenities = amenities.filter(amenity => property[amenity.name] === '1');
    
    const amenitiesHtml = activeAmenities.map(amenity => 
        `<span class="amenity-badge"><i class="fas ${amenity.icon} me-1"></i> ${amenity.label}</span>`
    ).join('');

    // Usar la imagen principal de la propiedad o una imagen de placeholder si no existe
    const imageSrc = property.imagen_principal || `https://via.placeholder.com/400x300?text=${encodeURIComponent(property.tipo)}`;

    return `
        <div class="col-md-6 col-lg-4">
            <div class="card property-card">
                <img src="${imageSrc}" class="card-img-top" alt="${property.titulo}">
                <span class="operation-badge operation-${property.operacion}">${property.operacion.toUpperCase()}</span>
                <div class="card-body">
                    <h5 class="card-title">${property.titulo}</h5>
                    <p class="price-tag">${formatPrice(property.precio, property.moneda)}</p>
                    <p class="card-text">${property.descripcion.substring(0, 100)}${property.descripcion.length > 100 ? '...' : ''}</p>
                    <p class="card-text"><small class="text-muted">${property.direccion}</small></p>
                    <div class="property-details">
                        ${property.habitaciones > 0 ? `<span class="detail-badge"><i class="fas fa-bed me-1"></i> ${property.habitaciones} Hab</span>` : ''}
                        ${property.banos > 0 ? `<span class="detail-badge"><i class="fas fa-bath me-1"></i> ${property.banos} Baños</span>` : ''}
                        ${property.superficie_construida > 0 ? `<span class="detail-badge"><i class="fas fa-ruler me-1"></i> ${property.superficie_construida}m²</span>` : ''}
                    </div>
                    <div class="amenities-container">
                        ${amenitiesHtml}
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Actualizar marcadores en el mapa
function updateMapMarkers(properties) {
    // Limpiar marcadores existentes
    markers.forEach(marker => map.removeLayer(marker));
    markers = [];

    // Añadir nuevos marcadores
    properties.forEach(property => {
        const marker = L.marker([property.latitud, property.longitud])
            .bindPopup(`
                <strong>${property.titulo}</strong><br>
                ${formatPrice(property.precio, property.moneda)}<br>
                ${property.direccion}
            `);
        markers.push(marker);
        marker.addTo(map);
    });

    // Ajustar vista si hay marcadores
    if (markers.length > 0) {
        const group = new L.featureGroup(markers);
        map.fitBounds(group.getBounds());
    }
}

// Cargar y mostrar propiedades
function loadProperties(filters = {}) {
    // Eliminar filtros vacíos
    Object.keys(filters).forEach(key => {
        if (filters[key] === '' || filters[key] === null || filters[key] === undefined) {
            delete filters[key];
        }
    });

    console.log('Aplicando filtros:', filters);
    const queryParams = new URLSearchParams(filters);
    const url = `get_properties.php?${queryParams.toString()}`;
    console.log('URL de la petición:', url);

    // Mostrar indicador de carga
    const container = document.getElementById('propertiesContainer');
    container.innerHTML = '<div class="col-12 text-center"><div class="spinner-border" role="status"><span class="visually-hidden">Cargando...</span></div></div>';

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Respuesta completa:', data);

            if (data.success) {
                properties = data.data;
                
                // Log de debugging
                if (data.debug) {
                    console.log('Query SQL:', data.debug.query);
                    console.log('Parámetros:', data.debug.params);
                    console.log('Número de filtros aplicados:', data.debug.filter_count);
                }

                // Mostrar resultados
                if (properties.length === 0) {
                    container.innerHTML = '<div class="col-12"><div class="alert alert-info">No se encontraron propiedades con los filtros seleccionados.</div></div>';
                } else {
                    container.innerHTML = properties.map(createPropertyCard).join('');
                    updateMapMarkers(properties);
                }
            } else {
                console.error('Error en la respuesta:', data.error);
                container.innerHTML = `<div class="col-12"><div class="alert alert-danger">Error al cargar las propiedades: ${data.error}</div></div>`;
            }
        })
        .catch(error => {
            console.error('Error:', error);
            container.innerHTML = `<div class="col-12"><div class="alert alert-danger">Error al cargar las propiedades: ${error.message}</div></div>`;
        });
}

// Recolectar filtros del formulario
function getFilters() {
    const filters = {};
    
    // Filtros básicos
    const tipo = document.getElementById('propertyType').value;
    const operacion = document.getElementById('operationType').value;
    const precioMin = document.getElementById('minPrice').value;
    const precioMax = document.getElementById('maxPrice').value;
    const direccion = document.getElementById('searchAddress').value;

    if (tipo) filters.tipo = tipo;
    if (operacion) filters.operacion = operacion;
    if (precioMin) filters.precio_min = precioMin;
    if (precioMax) filters.precio_max = precioMax;
    if (direccion) filters.direccion = direccion;

    // Amenidades
    const amenities = [
        'estudio', 'sala_tv', 'cuarto_servicio', 'sala_juntas', 'bodega',
        'cisterna', 'alberca', 'jacuzzi', 'gimnasio', 'salon_eventos',
        'garage', 'rampas', 'asador', 'aire_acondicionado', 'ventiladores'
    ];

    amenities.forEach(amenity => {
        const checkbox = document.getElementById(amenity);
        if (checkbox && checkbox.checked) {
            filters[amenity] = '1';
        }
    });

    return filters;
}

// Event Listeners
document.addEventListener('DOMContentLoaded', function() {
    initMap();
    
    // Manejar filtros
    document.getElementById('applyFilters').addEventListener('click', function() {
        const filters = getFilters();
        loadProperties(filters);
    });

    // Cargar propiedades iniciales
    loadProperties();

    // Añadir event listener para el formulario
    document.getElementById('filterForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const filters = getFilters();
        loadProperties(filters);
    });
});
