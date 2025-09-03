<?php
// import_sql.php
$host = 'localhost';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    // Connect without specifying database to create it
    $pdo = new PDO($dsn, $user, $pass, $options);
    
    // Read the SQL file
    $sql = file_get_contents('onukul.sql');
    
    // Split into individual statements
    $statements = array_filter(array_map('trim', explode(';', $sql)));
    
    foreach ($statements as $statement) {
        if (!empty($statement)) {
            $pdo->exec($statement);
        }
    }
    
    echo "SQL file imported successfully!";
    
} catch (\PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
