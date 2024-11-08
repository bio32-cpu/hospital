<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");


include 'config.php';

$sql = "SELECT * FROM medicalrecord";
$result = $conn->query($sql);

$medicalRecords = array();
while($row = $result->fetch_assoc()) {
    $medicalRecords[] = $row;
}

echo json_encode($medicalRecords);
$conn->close();

