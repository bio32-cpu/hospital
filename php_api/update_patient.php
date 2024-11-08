<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idpatient = $data['idpatient'];
$name = $data['name'] ?? '';
$address = $data['address'] ?? '';
$age = $data['age'] ?? 0;
$phonenumber = $data['phonenumber'] ?? '';
$sex = $data['sex'] ?? 'MALE';

$sql = "UPDATE patient SET address='$address', age=$age, name='$name', phonenumber='$phonenumber', sex='$sex' WHERE idpatient=$idpatient";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Patient updated successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error updating patient: " . $conn->error));
}

$conn->close();

