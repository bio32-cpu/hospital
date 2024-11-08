<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");
include 'config.php';

// Decode the JSON data received in the request
$data = json_decode(file_get_contents("php://input"), true);

// Check if the required data is provided
if (!isset($data['idperson']) || !isset($data['name']) || !isset($data['age']) || !isset($data['email']) || !isset($data['phonenumber']) || !isset($data['sex']) || !isset($data['avatar']) || !isset($data['degree']) || !isset($data['specialized']) || !isset($data['yearsexperience'])) {
    echo json_encode(array("success" => false, "message" => "Dữ liệu không hợp lệ"));
    exit;
}

// Get doctor details from the request
$idperson = $data['idperson'];
$name = $data['name'];
$age = $data['age'];
$email = $data['email'];
$phonenumber = $data['phonenumber'];
$sex = $data['sex'];
$avatar = $data['avatar'];
$degree = $data['degree'];
$specialized = $data['specialized'];
$yearsexperience = $data['yearsexperience'];

// Prepare and execute the update query
$query = "UPDATE doctor SET name = '$name', age = $age, email = '$email', phonenumber = '$phonenumber', sex = '$sex', avatar = '$avatar', degree = '$degree', specialized = '$specialized', yearsexperience = $yearsexperience WHERE idperson = '$idperson'";

if ($conn->query($query) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Bác sĩ đã được cập nhật thành công"));
} else {
    echo json_encode(array("success" => false, "message" => "Lỗi khi cập nhật bác sĩ: " . $conn->error));
}

$conn->close();
