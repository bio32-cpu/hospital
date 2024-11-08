<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

// Gán các biến từ dữ liệu JSON, nếu không có sẽ sử dụng giá trị mặc định
$idperson = uniqid("nurse_"); // Tạo một ID duy nhất cho y tá
$name = $data['name'] ?? '';
$age = $data['age'] ?? 0;
$email = $data['email'] ?? '';
$phonenumber = $data['phonenumber'] ?? '';
$sex = $data['sex'] ?? 'MALE';
$avatar = $data['avatar'] ?? '';
$degree = $data['degree'] ?? '';
$price = $data['price'] ?? 0;
$room = $data['room'] ?? '';
$yearsexperience = $data['yearsexperience'] ?? 0;

// Câu lệnh SQL để thêm y tá mới vào cơ sở dữ liệu
$sql = "INSERT INTO nuser (idperson, age, email, name, phonenumber, sex, avatar, degree, price, room, yearsexperience) 
        VALUES ('$idperson', $age, '$email', '$name', '$phonenumber', '$sex', '$avatar', '$degree', $price, '$room', $yearsexperience)";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Nurse added successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error adding nurse: " . $conn->error));
}

$conn->close();
