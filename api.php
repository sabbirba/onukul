<?php
header('Content-Type: application/json');
require 'db.php';
$db   = 'onukul';
$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

switch($action) {
    case 'users':
        if($method === 'GET'){
            $stmt = $pdo->query("SELECT user_id as id, CONCAT(first_name, ' ', last_name) as name, nid, age, type as usertype FROM user");
            echo json_encode($stmt->fetchAll());
        } elseif($method === 'POST'){
            $data = json_decode(file_get_contents('php://input'), true);
            
            // Check if user already exists
            $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM user WHERE nid = ?");
            $checkStmt->execute([$data['nid']]);
            if ($checkStmt->fetchColumn() > 0) {
                echo json_encode(['error' => 'User with this NID already exists']);
                exit;
            }
            
            $stmt = $pdo->prepare("INSERT INTO user (first_name, last_name, nid, age, type, password, registration_date, email, phone) VALUES (?, ?, ?, ?, ?, ?, CURDATE(), ?, ?)");
            
            // Split name into first and last name
            $nameParts = explode(' ', $data['name'], 2);
            $firstName = $nameParts[0];
            $lastName = count($nameParts) > 1 ? $nameParts[1] : '';
            
            // Generate a default email and phone if not provided
            $email = $data['email'] ?? $data['nid'] . '@example.com';
            $phone = $data['phone'] ?? '0000000000';
            
            $stmt->execute([
                $firstName, 
                $lastName, 
                $data['nid'], 
                $data['age'], 
                $data['usertype'], 
                password_hash($data['password'], PASSWORD_DEFAULT),
                $email,
                $phone
            ]);
            echo json_encode(['status'=>'success', 'id' => $pdo->lastInsertId()]);
        }
        break;

    case 'inventory':
        if($method==='GET'){
            $stmt = $pdo->query("SELECT * FROM aid_item");
            echo json_encode($stmt->fetchAll());
        }
        break;

    case 'packages':
        // Note: You'll need to create a packages table or modify this query
        if($method==='GET'){
            // For now, return empty array as packages table doesn't exist in SQL
            echo json_encode([]);
        }
        break;

    case 'aidRequests':
        if($method==='GET'){
            $stmt = $pdo->query("
                SELECT ar.request_id as id, ar.request_date as createdAt, ar.request_status as status, 
                CONCAT(u.first_name, ' ', u.last_name) as userName, u.user_id as userId
                FROM aid_request ar 
                JOIN user u ON ar.user_id = u.user_id
            ");
            echo json_encode($stmt->fetchAll());
        }
        break;

    default:
        echo json_encode(['error'=>'Invalid action']);
        break;
}
?>