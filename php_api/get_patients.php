<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include 'config.php';

$sql = "SELECT idpatient, address, age, name, phonenumber, sex FROM patient";
$result = $conn->query($sql);

$patients = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $patients[] = array(
            "idpatient" => (int)$row["idpatient"],
            "address" => $row["address"] ?? '',
            "age" => (int)$row["age"] ?? 0,
            "name" => $row["name"] ?? '',
            "phonenumber" => $row["phonenumber"] ?? '',
            "sex" => $row["sex"] ?? 'MALE',
        );
    }
    echo json_encode(array("success" => true, "data" => $patients));
} else {
    echo json_encode(array("success" => false, "message" => "No patients found"));
}

$conn->close();

