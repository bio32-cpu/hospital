<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra nếu các trường cần thiết tồn tại
if (!isset($data['idmedicine']) || !isset($data['name']) || !isset($data['expirationdate']) || !isset($data['price']) || !isset($data['quantity'])) {
    echo json_encode(array("success" => false, "message" => "Dữ liệu không hợp lệ"));
    exit;
}

$idmedicine = $data['idmedicine'];
$name = $data['name'];
$expirationdate = $data['expirationdate'];
$price = $data['price'];
$quantity = $data['quantity'];

$sql = "UPDATE medicine SET name='$name', expirationdate='$expirationdate', price=$price, quantity=$quantity WHERE idmedicine=$idmedicine";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Cập nhật thuốc thành công"));
} else {
    echo json_encode(array("success" => false, "message" => "Lỗi khi cập nhật thuốc: " . $conn->error));
}

$conn->close();

