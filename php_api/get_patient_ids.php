<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");

include 'config.php';


$sql = "SELECT idpatient FROM patient";
$result = $conn->query($sql);

$ids = [];
while ($row = $result->fetch_assoc()) {
    $ids[] = $row['idpatient'];
}

echo json_encode($ids);
$conn->close();
