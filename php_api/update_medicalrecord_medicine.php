<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idMedicalRecord = $data['idmedicalrecord'] ?? null;
$idMedicine = $data['idmedicine'] ?? null;

if ($idMedicalRecord && $idMedicine) {
    $query = "UPDATE medicalrecord_medicine SET idmedicine = ? WHERE idmedicalmecord = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $idMedicine, $idMedicalRecord);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Record updated successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to update record']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid parameters']);
}

$conn->close();
