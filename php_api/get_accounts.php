<?php
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

