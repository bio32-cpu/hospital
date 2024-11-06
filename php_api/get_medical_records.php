<?php
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM medicalrecord";
$result = $conn->query($sql);

$medicalRecords = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $medicalRecords[] = $row;
    }
}

echo json_encode($medicalRecords);

$conn->close();

