<?php
header('Content-Type: application/json');

// Database configuration
$host = 'localhost';
$db   = 'onukul';
$user = 'root';
$pass = 'Onukul@123';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

$response = ['success' => false];

try {
    // Try to connect to the database
    $pdo = new PDO($dsn, $user, $pass, $options);
    $response['success'] = true;
    $response['message'] = 'Database connection successful!';
    
    // Get list of tables
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    $response['tables'] = [];
    foreach ($tables as $table) {
        $countStmt = $pdo->query("SELECT COUNT(*) as count FROM `$table`");
        $count = $countStmt->fetch()['count'];
        $response['tables'][] = ['name' => $table, 'rows' => $count];
    }
    
    // Get sample data from user table if it exists
    if (in_array('user', $tables)) {
        $userStmt = $pdo->query("SELECT * FROM user LIMIT 5");
        $response['sampleData'] = $userStmt->fetchAll();
    } else {
        $response['sampleData'] = [];
    }
    
} catch (PDOException $e) {
    $response['error'] = $e->getMessage();
}

echo json_encode($response);
?>