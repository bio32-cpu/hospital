<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);
$idMedicalRecord = $data['idmedicalrecord'];

$sql = "DELETE FROM medicalrecord WHERE idmedicalrecord = $idMedicalRecord";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Medical record deleted successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error deleting medical record: " . $conn->error));
}

$conn->close();

