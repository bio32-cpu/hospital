<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$conclusion = $data['conclusion'] ?? '';
$conjecture = $data['conjecture'] ?? '';
$examined = $data['examined'] ? 1 : 0;
$idDoctor = $data['iddoctor'] ?? '';
$idMedicine = $data['idmedicine'];
$idNuser = $data['idnuser'] ?? '';
$idPatient = $data['idpatient'];
$price = $data['price'];

$sql = "INSERT INTO medicalrecord (conclusion, conjecture, examined, iddoctor, idmedicine, idnuser, idpatient, price) 
        VALUES ('$conclusion', '$conjecture', $examined, '$idDoctor', $idMedicine, '$idNuser', $idPatient, $price)";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Medical record added successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error adding medical record: " . $conn->error));
}

$conn->close();

