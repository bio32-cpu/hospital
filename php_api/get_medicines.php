<?php
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM medicine";
$result = $conn->query($sql);

$medicines = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $medicines[] = $row;
    }
}

echo json_encode($medicines);

$conn->close();

