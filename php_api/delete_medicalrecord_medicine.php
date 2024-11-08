<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$idMedicalRecord = isset($_GET['idmedicalrecord']) ? intval($_GET['idmedicalrecord']) : null;
$idMedicine = isset($_GET['idmedicine']) ? intval($_GET['idmedicine']) : null;

if ($idMedicalRecord && $idMedicine) {
    $query = "DELETE FROM medicalrecord_medicine WHERE idmedicalmecord = ? AND idmedicine = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $idMedicalRecord, $idMedicine);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Record deleted successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to delete record']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid parameters']);
}

$conn->close();
