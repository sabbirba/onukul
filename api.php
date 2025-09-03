<?php
header('Content-Type: application/json');
require 'db.php';
$db   = 'onukul';
$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

switch($action) {
    case 'users':
        if($method === 'GET'){
            $stmt = $pdo->query("SELECT user_id as id, CONCAT(first_name, ' ', last_name) as name, nid, age, type as usertype, district FROM user");
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
            
            $stmt = $pdo->prepare("INSERT INTO user (first_name, last_name, nid, age, type, district, password, registration_date, email, phone) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE(), ?, ?)");
            
            // Split name into first and last name
            $nameParts = explode(' ', $data['name'], 2);
            $firstName = $nameParts[0];
            $lastName = count($nameParts) > 1 ? $nameParts[1] : '';
            
            // Generate a default email and phone if not provided
            $email = $data['email'] ?? $data['nid'] . '@example.com';
            $phone = $data['phone'] ?? '0000000000';
            $district = ($data['usertype'] === 'volunteer') ? $data['district'] : null;
            
            $stmt->execute([
                $firstName, 
                $lastName, 
                $data['nid'], 
                $data['age'], 
                $data['usertype'], 
                $district,
                $data['password'],  // Store as plain text for now
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
        if($method==='GET'){
            $stmt = $pdo->query("
                SELECT p.id, p.name, p.description, 
                GROUP_CONCAT(CONCAT(pi.item_name, ',', pi.quantity, ',', pi.unit) SEPARATOR ';') as items_str
                FROM packages p 
                LEFT JOIN package_items pi ON p.id = pi.package_id 
                GROUP BY p.id
            ");
            $packages = [];
            while($row = $stmt->fetch()) {
                $items = [];
                if($row['items_str']) {
                    foreach(explode(';', $row['items_str']) as $itemStr) {
                        list($name, $quantity, $unit) = explode(',', $itemStr);
                        $items[] = ['name' => $name, 'quantity' => (int)$quantity, 'unit' => $unit];
                    }
                }
                $packages[] = [
                    'id' => $row['id'],
                    'name' => $row['name'],
                    'description' => $row['description'],
                    'items' => $items
                ];
            }
            echo json_encode($packages);
        }
        break;

    case 'aidRequests':
        if($method==='GET'){
            $stmt = $pdo->query("
                SELECT ar.request_id as id, ar.request_date as createdAt, ar.request_status as status, 
                ar.package_id as packageId, ar.reason, ar.user_id as userId,
                CONCAT(u.first_name, ' ', u.last_name) as userName, u.user_id as userId
                FROM aid_request ar 
                JOIN user u ON ar.user_id = u.user_id
            ");
            echo json_encode($stmt->fetchAll());
        }
        break;

    case 'donations':
        if($method==='GET'){
            $stmt = $pdo->query("
                SELECT d.donation_id as id, d.donation_date as date, d.amount_given as amount, 
                d.item_given as item, d.donated_by as donorId,
                CONCAT(u.first_name, ' ', u.last_name) as donor
                FROM donation d 
                JOIN user u ON d.donated_by = u.user_id
            ");
            echo json_encode($stmt->fetchAll());
        }
        break;

    default:
        echo json_encode(['error'=>'Invalid action']);
        break;
}
?>