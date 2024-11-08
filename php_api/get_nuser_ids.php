<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

// Sử dụng một truy vấn duy nhất
$sql = "SELECT idperson AS idnuser FROM nuser";
$result = $conn->query($sql);

$nuserIds = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $nuserIds[] = $row['idnuser']; // Sử dụng đúng tên cột được trả về từ truy vấn
    }
}

echo json_encode($nuserIds);
$conn->close();
