<?php
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM onleave";
$result = $conn->query($sql);

$leaves = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $leaves[] = $row;
    }
}

echo json_encode($leaves);

$conn->close();

