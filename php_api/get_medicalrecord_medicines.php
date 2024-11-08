<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$query = "SELECT * FROM medicalrecord_medicine";
$result = $conn->query($query);

$medicalRecordMedicines = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $medicalRecordMedicines[] = $row;
    }
}

echo json_encode($medicalRecordMedicines);
$conn->close();
