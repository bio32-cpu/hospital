<?php
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM doctor";
$result = $conn->query($sql);

$doctors = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $doctors[] = $row;
    }
}

echo json_encode($doctors);

$conn->close();

