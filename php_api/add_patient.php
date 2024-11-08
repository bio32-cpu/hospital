<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$name = $data['name'] ?? '';
$address = $data['address'] ?? '';
$age = $data['age'] ?? 0;
$phonenumber = $data['phonenumber'] ?? '';
$sex = $data['sex'] ?? 'MALE';

$sql = "INSERT INTO patient (address, age, name, phonenumber, sex) VALUES ('$address', $age, '$name', '$phonenumber', '$sex')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Patient added successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error adding patient: " . $conn->error));
}

$conn->close();

