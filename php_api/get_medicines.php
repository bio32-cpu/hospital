<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include 'config.php';

$sql = "SELECT * FROM medicine";
$result = $conn->query($sql);

$medicines = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Đảm bảo rằng trường expirationdate được định dạng dưới dạng chuỗi để phù hợp với Dart
        $row['idmedicine'] = (int) $row['idmedicine'];
        $row['price'] = (int) $row['price'];
        $row['quantity'] = (int) $row['quantity'];
        $row['expirationdate'] = $row['expirationdate'] ? date("Y-m-d\TH:i:s", strtotime($row['expirationdate'])) : null;
        
        $medicines[] = $row;
    }
    echo json_encode(array("success" => true, "data" => $medicines));
} else {
    echo json_encode(array("success" => false, "message" => "Không có dữ liệu thuốc"));
}

$conn->close();
