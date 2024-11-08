<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

// Lấy dữ liệu từ yêu cầu JSON
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra dữ liệu đầu vào
$name = trim($data['name'] ?? '');
$expirationdate = trim($data['expirationdate'] ?? null);
$price = isset($data['price']) ? (int)$data['price'] : 0;
$quantity = isset($data['quantity']) ? (int)$data['quantity'] : 0;

// Kiểm tra nếu trường tên bị trống
if (empty($name)) {
    echo json_encode(array("success" => false, "message" => "Tên thuốc không được để trống"));
    exit;
}

// Xử lý dữ liệu đầu vào để tránh lỗi SQL Injection
$name = mysqli_real_escape_string($conn, $name);

// Câu lệnh SQL để thêm dữ liệu vào bảng `medicine`
$sql = "INSERT INTO medicine (name, expirationdate, price, quantity) VALUES ('$name', '$expirationdate', $price, $quantity)";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Thuốc đã được thêm thành công"));
} else {
    error_log("Lỗi khi thêm thuốc: " . $conn->error); // Ghi log chi tiết
    echo json_encode(array("success" => false, "message" => "Lỗi khi thêm thuốc: " . $conn->error));
}


// Đóng kết nối
$conn->close();
