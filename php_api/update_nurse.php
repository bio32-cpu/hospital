<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");
include 'config.php';

// Đọc dữ liệu từ yêu cầu PUT
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra nếu dữ liệu không hợp lệ
if (!isset($data['idperson'])) {
    echo json_encode(array("success" => false, "message" => "Thiếu idperson"));
    exit;
}

// Lấy dữ liệu cần cập nhật
$idperson = $data['idperson'];
$age = isset($data['age']) ? $data['age'] : null;
$email = isset($data['email']) ? $data['email'] : '';
$name = isset($data['name']) ? $data['name'] : '';
$phonenumber = isset($data['phonenumber']) ? $data['phonenumber'] : '';
$sex = isset($data['sex']) ? $data['sex'] : 'MALE';
$avatar = isset($data['avatar']) ? $data['avatar'] : '';
$degree = isset($data['degree']) ? $data['degree'] : '';
$price = isset($data['price']) ? $data['price'] : 0;
$room = isset($data['room']) ? $data['room'] : '';
$yearsexperience = isset($data['yearsexperience']) ? $data['yearsexperience'] : 0;

// Chuẩn bị câu truy vấn SQL để cập nhật thông tin y tá
$query = "UPDATE nuser SET 
            age = '$age', 
            email = '$email', 
            name = '$name', 
            phonenumber = '$phonenumber', 
            sex = '$sex', 
            avatar = '$avatar', 
            degree = '$degree', 
            price = '$price', 
            room = '$room', 
            yearsexperience = '$yearsexperience' 
          WHERE idperson = '$idperson'";

if ($conn->query($query) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Cập nhật y tá thành công"));
} else {
    echo json_encode(array("success" => false, "message" => "Lỗi khi cập nhật y tá: " . $conn->error));
}

$conn->close();
