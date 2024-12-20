<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// Hiển thị lỗi chi tiết để kiểm tra lỗi trong quá trình phát triển
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require 'config.php'; // Ensure this file sets up the database connection

try {
    $sql = "SELECT idmedicine FROM medicine";
    $result = $conn->query($sql);

    if (!$result) {
        throw new Exception("Error executing query: " . $conn->error);
    }

    $medicineIds = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $medicineIds[] = (int)$row['idmedicine']; // Ensure the value is an integer
        }
    }

    echo json_encode($medicineIds);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Lỗi khi tải dữ liệu: " . $e->getMessage()]);
}

$conn->close();
?>
