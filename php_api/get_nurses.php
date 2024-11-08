<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$sql = "SELECT idperson, age, email, name, phonenumber, sex, avatar, degree, price, room, yearsexperience FROM nuser";
$result = $conn->query($sql);

$nurses = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        
        $nurses[] = array(
            "idperson" => $row["idperson"],
            "age" => isset($row["age"]) ? (int)$row["age"] : 0,
            "email" => $row["email"] ?? '',
            "name" => $row["name"] ?? '',
            "phonenumber" => $row["phonenumber"] ?? '',
            "sex" => $row["sex"] ?? 'MALE',
            "avatar" => $row["avatar"] ?? '',
            "degree" => $row["degree"] ?? '',
            "price" => isset($row["price"]) ? (int)$row["price"] : 0,
            "room" => $row["room"] ?? '',
            "yearsexperience" => isset($row["yearsexperience"]) ? (int)$row["yearsexperience"] : 0
        );
    }
    echo json_encode(array("success" => true, "data" => $nurses));
} else {
    echo json_encode(array("success" => false, "message" => "Không tìm thấy y tá nào"));
}

$conn->close();
