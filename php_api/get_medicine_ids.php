<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");

include 'config.php';

$sql = "SELECT idmedicine FROM medicine";
$result = $conn->query($sql);

$medicineIds = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $medicineIds[] = $row;
    }
}

echo json_encode($medicineIds);
$conn->close();

