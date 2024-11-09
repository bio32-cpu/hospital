<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include 'config.php';

// Đọc dữ liệu JSON từ yêu cầu
$data = json_decode(file_get_contents("php://input"), true); // Thêm 'true' để đảm bảo $data là mảng

if (!$data) {
    echo json_encode(array("success" => false, "message" => "Không nhận được dữ liệu đầu vào"));
    exit();
}

// Kiểm tra và gán giá trị từ JSON
$idPerson = isset($data['idperson']) ? $conn->real_escape_string($data['idperson']) : null;
$startDate = isset($data['startdate']) ? $conn->real_escape_string($data['startdate']) : null;
$endDate = isset($data['enddate']) ? $conn->real_escape_string($data['enddate']) : null;

// In ra các biến để kiểm tra dữ liệu đã nhận đúng chưa
error_log("idPerson: " . $idPerson);
error_log("startDate: " . $startDate);
error_log("endDate: " . $endDate);

if ($idPerson && $startDate) {
    $query = "INSERT INTO onleave (idperson, startdate, enddate) VALUES ('$idPerson', '$startDate', '$endDate')";
    if ($conn->query($query) === TRUE) {
        echo json_encode(array("success" => true, "message" => "Thêm nghỉ phép thành công"));
    } else {
        error_log("SQL Error: " . $conn->error); // Ghi log lỗi SQL chi tiết
        echo json_encode(array("success" => false, "message" => "Lỗi khi thêm nghỉ phép: " . $conn->error));
    }
} else {
    echo json_encode(array("success" => false, "message" => "ID nhân viên hoặc ngày bắt đầu không được để trống"));
}

$conn->close();
