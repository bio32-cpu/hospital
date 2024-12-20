<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idMedicalRecord = $data['idmedicalmecord'] ?? null;
$idMedicine = $data['idmedicine'] ?? null;

if ($idMedicalRecord && $idMedicine) {
    $query = "DELETE FROM `medicalrecord_medicine` WHERE `idmedicalmecord` = '$idMedicalRecord' AND `idmedicine` = '$idMedicine'";
    if ($conn->query($query) === TRUE) {
        echo json_encode(["success" => true, "message" => "Xóa thuốc thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin bắt buộc"]);
}
$conn->close();
?>
