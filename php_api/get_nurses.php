<?php
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM nuser";
$result = $conn->query($sql);

$nurses = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $nurses[] = $row;
    }
}

echo json_encode($nurses);

$conn->close();

