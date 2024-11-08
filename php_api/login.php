<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");



header("Content-Type: application/json");
include 'config.php';

$data = json_decode(file_get_contents("php://input"));
$username = $data->username;
$password = $data->password;

$sql = "SELECT * FROM account WHERE username = '$username' AND password = '$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo json_encode(array("success" => true));
} else {
    echo json_encode(array("success" => false, "message" => "Sai tên đăng nhập hoặc mật khẩu"));
}

$conn->close();

