<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idMedicalRecord = $data['idmedicalrecord'];
$conclusion = $data['conclusion'];
$conjecture = $data['conjecture'];
$examined = $data['examined'] ? 1 : 0;
$idDoctor = $data['iddoctor'];
$idMedicine = $data['idmedicine'];
$idNuser = $data['idnuser'];
$idPatient = $data['idpatient'];
$price = $data['price'];

$sql = "UPDATE medicalrecord SET 
        conclusion = '$conclusion', conjecture = '$conjecture', examined = $examined,
        iddoctor = '$idDoctor', idmedicine = $idMedicine, idnuser = '$idNuser', 
        idpatient = $idPatient, price = $price WHERE idmedicalrecord = $idMedicalRecord";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Medical record updated successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error updating medical record: " . $conn->error));
}

$conn->close();

