<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);
$idpatient = $data['idpatient'];

$sql = "DELETE FROM patient WHERE idpatient=$idpatient";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("success" => true, "message" => "Patient deleted successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error deleting patient: " . $conn->error));
}

$conn->close();

