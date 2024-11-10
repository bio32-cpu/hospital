<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

require 'config.php';

try {
    $input = json_decode(file_get_contents("php://input"), true);

    if (isset($input['idMedicalRecord']) && isset($input['idMedicine'])) {
        // Kiểm tra xem các giá trị có phải là số nguyên không
        if (is_numeric($input['idMedicalRecord']) && is_numeric($input['idMedicine'])) {
            $idMedicalRecord = (int)$conn->real_escape_string($input['idMedicalRecord']);
            $idMedicine = (int)$conn->real_escape_string($input['idMedicine']);

            // Câu lệnh SQL để chèn dữ liệu
            $sql = "INSERT INTO medicalrecord_medicine (idmedicalrecord, idmedicine) VALUES ('$idMedicalRecord', '$idMedicine')";

            if ($conn->query($sql) === TRUE) {
                echo json_encode(["success" => true, "message" => "Đơn thuốc đã được thêm thành công"]);
            } else {
                throw new Exception("Lỗi khi thêm dữ liệu: " . $conn->error);
            }
        } else {
            throw new Exception("Dữ liệu đầu vào phải là số nguyên hợp lệ");
        }
    } else {
        throw new Exception("Dữ liệu đầu vào không hợp lệ");
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "error" => $e->getMessage()]);
}

$conn->close();
?>
