<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

// Sử dụng một truy vấn duy nhất
$sql = "SELECT idperson AS iddoctor FROM doctor";
$result = $conn->query($sql);

$doctorIds = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $doctorIds[] = $row['iddoctor']; // Sử dụng đúng tên cột được trả về từ truy vấn
    }
}

echo json_encode($doctorIds);
$conn->close();
