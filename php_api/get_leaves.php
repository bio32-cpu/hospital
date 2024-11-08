<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$query = "SELECT * FROM onleave";
$result = $conn->query($query);

$onLeaveRecords = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $onLeaveRecords[] = $row;
    }
}

echo json_encode($onLeaveRecords);
$conn->close();
