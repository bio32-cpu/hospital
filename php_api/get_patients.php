<?php
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM patient";
$result = $conn->query($sql);

$patients = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $patients[] = $row;
    }
}

echo json_encode($patients);

$conn->close();

