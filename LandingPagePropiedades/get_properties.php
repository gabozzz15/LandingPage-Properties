<?php
header('Content-Type: application/json');
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Función para logging en archivo
function debug_log($data) {
    $logFile = 'debug.log';
    $logData = date('Y-m-d H:i:s') . ' - ';
    
    if (is_array($data) || is_object($data)) {
        $logData .= print_r($data, true);
    } else {
        $logData .= $data;
    }
    
    file_put_contents($logFile, $logData . "\n", FILE_APPEND);
}

try {
    $conn = new PDO("mysql:host=localhost;dbname=inmobiliaria_landing_db", "root", "");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Construir la consulta base
    $query = "SELECT * FROM propiedades WHERE estado = 'disponible'";
    $params = array();

    debug_log($_GET);

    // Aplicar filtros si existen
    if (!empty($_GET['tipo'])) {
        $query .= " AND tipo = :tipo";
        $params[':tipo'] = $_GET['tipo'];
    }

    if (!empty($_GET['operacion'])) {
        $query .= " AND operacion = :operacion";
        $params[':operacion'] = $_GET['operacion'];
    }

    if (!empty($_GET['precio_min'])) {
        $query .= " AND precio >= :precio_min";
        $params[':precio_min'] = floatval($_GET['precio_min']);
    }

    if (!empty($_GET['precio_max'])) {
        $query .= " AND precio <= :precio_max";
        $params[':precio_max'] = floatval($_GET['precio_max']);
    }

    // Filtros para amenidades
    $amenities = [
        'estudio', 'sala_tv', 'cuarto_servicio', 'sala_juntas', 'bodega',
        'cisterna', 'alberca', 'jacuzzi', 'gimnasio', 'salon_eventos',
        'garage', 'rampas', 'asador', 'aire_acondicionado', 'ventiladores'
    ];

    foreach ($amenities as $amenity) {
        if (isset($_GET[$amenity]) && $_GET[$amenity] === '1') {
            $query .= " AND $amenity = '1'";
        }
    }

    // Búsqueda por dirección
    if (!empty($_GET['direccion'])) {
        $query .= " AND direccion LIKE :direccion";
        $params[':direccion'] = '%' . $_GET['direccion'] . '%';
    }

    debug_log("Query: " . $query);
    debug_log("Params: " . print_r($params, true));

    $stmt = $conn->prepare($query);
    $stmt->execute($params);
    $properties = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Procesar las imágenes adicionales
    foreach ($properties as &$property) {
        if (!empty($property['imagenes_adicionales'])) {
            $property['imagenes_adicionales'] = explode(',', $property['imagenes_adicionales']);
        } else {
            $property['imagenes_adicionales'] = [];
        }
    }

    echo json_encode([
        'success' => true,
        'data' => $properties,
        'debug' => [
            'query' => $query,
            'params' => $params,
            'filter_count' => count($params)
        ]
    ]);
} catch(PDOException $e) {
    debug_log("Error: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
        'debug' => [
            'query' => $query ?? null,
            'params' => $params ?? null
        ]
    ]);
}
?>
