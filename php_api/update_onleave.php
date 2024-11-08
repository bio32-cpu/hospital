<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? null;
$idPerson = $data['idperson'] ?? null;
$startDate = $data['startdate'] ?? null;
$endDate = $data['enddate'] ?? null;

if ($id && $idPerson && $startDate) {
    $query = "UPDATE onleave SET idperson = ?, startdate = ?, enddate = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sssi", $idPerson, $startDate, $endDate, $id);

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
