<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

$idMedicalRecord = $data['idmedicalmecord'] ?? null;
$idMedicineOld = $data['idmedicine_old'] ?? null;
$idMedicineNew = $data['idmedicine_new'] ?? null;

if ($idMedicalRecord && $idMedicineOld && $idMedicineNew) {
    $query = "UPDATE `medicalrecord_medicine` SET `idmedicine` = '$idMedicineNew' WHERE `idmedicalmecord` = '$idMedicalRecord' AND `idmedicine` = '$idMedicineOld'";
    if ($conn->query($query) === TRUE) {
        echo json_encode(["success" => true, "message" => "Cập nhật thuốc thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin bắt buộc"]);
}
$conn->close();
?>
