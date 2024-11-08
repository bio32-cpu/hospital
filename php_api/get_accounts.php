<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");
include 'config.php';

$sql = "SELECT * FROM account";
$result = $conn->query($sql);

$accounts = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $accounts[] = $row;
    }
}

echo json_encode($accounts);

$conn->close();

