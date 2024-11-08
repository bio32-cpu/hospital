<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST"); // Đổi thành POST thay vì DELETE
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

// Lấy dữ liệu JSON từ yêu cầu POST
$data = json_decode(file_get_contents("php://input"), true);
$idperson = $data['idperson'];

// Kiểm tra và thực hiện xóa nếu có idperson
if ($idperson) {
    $sql = "DELETE FROM nuser WHERE idperson = '$idperson'"; // Đổi tên bảng cho đúng với CSDL của bạn

    if ($conn->query($sql) === TRUE) {
        echo json_encode(array("success" => true, "message" => "Y tá đã được xóa thành công"));
    } else {
        echo json_encode(array("success" => false, "message" => "Lỗi khi xóa y tá: " . $conn->error));
    }
} else {
    echo json_encode(array("success" => false, "message" => "ID y tá không hợp lệ"));
}

$conn->close();
