<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

require 'config.php'; // Đảm bảo tệp kết nối đúng

try {
    $sql = "SELECT * FROM medicalrecord_medicine";
    $result = $conn->query($sql);

    if (!$result) {
        throw new Exception("Lỗi truy vấn cơ sở dữ liệu: " . $conn->error);
    }

    $medicalRecords = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $medicalRecords[] = $row;
        }
    }

    echo json_encode($medicalRecords);
} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}

$conn->close();
?>
