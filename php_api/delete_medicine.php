<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra nếu ID thuốc tồn tại
if (!isset($data['idmedicine'])) {
    echo json_encode(array("success" => false, "message" => "Dữ liệu không hợp lệ"));
    exit;
}

$idmedicine = $data['idmedicine'];

$sql = "DELETE FROM medicine WHERE idmedicine=$idmedicine";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Xóa thuốc thành công"));
} else {
    echo json_encode(array("success" => false, "message" => "Lỗi khi xóa thuốc: " . $conn->error));
}

$conn->close();

