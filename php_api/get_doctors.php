<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$sql = "SELECT idperson, age, email, name, phonenumber, sex, avatar, degree, specialized, yearsexperience FROM doctor";
$result = $conn->query($sql);


$doctors = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        
        // Chuẩn hóa dữ liệu đầu ra, kiểm tra và thay thế giá trị NULL
        $doctors[] = array(
            "idperson" => $row["idperson"] ?? '',
            "age" => isset($row["age"]) ? (int)$row["age"] : 0,
            "email" => $row["email"] ?? '',
            "name" => $row["name"] ?? '',
            "phonenumber" => $row["phonenumber"] ?? '',
            "sex" => $row["sex"] ?? 'MALE',
            "avatar" => $row["avatar"] ?? '', // Avatar có thể là đường dẫn rỗng nếu không có
            "degree" => $row["degree"] ?? '',
            "specialized" => $row["specialized"] ?? '',
            "yearsexperience" => isset($row["yearsexperience"]) ? (int)$row["yearsexperience"] : 0 // Đảm bảo giá trị là số nguyên
        );
    }
    echo json_encode(array("success" => true, "data" => $doctors));
} else {
    echo json_encode(array("success" => false, "message" => "Không tìm thấy bác sĩ nào"));
}

$conn->close();
