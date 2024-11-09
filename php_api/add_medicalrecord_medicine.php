<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idMedicalRecord = $data['idmedicalmecord'] ?? null;
$idMedicine = $data['idmedicine'] ?? null;

if ($idMedicalRecord && $idMedicine) {
    $query = "INSERT INTO `medicalrecord_medicine` (`idmedicalmecord`, `idmedicine`) VALUES ('$idMedicalRecord', '$idMedicine')";
    if ($conn->query($query) === TRUE) {
        echo json_encode(["success" => true, "message" => "Thêm thuốc thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin bắt buộc"]);
}
$conn->close();
?>
