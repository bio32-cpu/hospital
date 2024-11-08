<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idPerson = $data['idperson'] ?? null;
$startDate = $data['startdate'] ?? null;
$endDate = $data['enddate'] ?? null;

if ($idPerson && $startDate) {
    $query = "INSERT INTO onleave (idperson, startdate, enddate) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sss", $idPerson, $startDate, $endDate);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Record added successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to add record']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid parameters']);
}

$conn->close();
