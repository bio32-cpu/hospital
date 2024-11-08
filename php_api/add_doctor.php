<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");
include 'config.php';

// Lấy dữ liệu từ yêu cầu gửi đến
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra dữ liệu
if (!isset($data['name']) || !isset($data['age']) || !isset($data['email']) || !isset($data['phonenumber']) || !isset($data['sex']) || !isset($data['avatar']) || !isset($data['degree']) || !isset($data['specialized']) || !isset($data['yearsexperience'])) {
    echo json_encode(array("success" => false, "message" => "Dữ liệu không hợp lệ"));
    exit;
}

// Sinh id duy nhất cho idperson
$idperson = uniqid('doc_');
$name = $data['name'];
$age = $data['age'];
$email = $data['email'];
$phonenumber = $data['phonenumber'];
$sex = $data['sex'];
$avatar = $data['avatar'];
$degree = $data['degree'];
$specialized = $data['specialized'];
$yearsexperience = $data['yearsexperience'];

// Thực hiện truy vấn để thêm bác sĩ vào cơ sở dữ liệu
$query = "INSERT INTO doctor (idperson, name, age, email, phonenumber, sex, avatar, degree, specialized, yearsexperience) VALUES ('$idperson', '$name', $age, '$email', '$phonenumber', '$sex', '$avatar', '$degree', '$specialized', $yearsexperience)";

if ($conn->query($query) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Bác sĩ đã được thêm thành công"));
} else {
    echo json_encode(array("success" => false, "message" => "Lỗi khi thêm bác sĩ: " . $conn->error));
}

$conn->close();

