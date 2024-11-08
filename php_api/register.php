<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");


header("Content-Type: application/json");
include 'config.php';

$data = json_decode(file_get_contents("php://input"));

if (!$data) {
    echo json_encode(array("success" => false, "message" => "Không nhận được dữ liệu đầu vào"));
    exit();
}

// Lấy giá trị từ JSON và kiểm tra nếu có dữ liệu
$username = isset($data->username) ? $data->username : null;
$password = isset($data->password) ? $data->password : null;
$email = isset($data->email) ? $data->email : null;
$phone = isset($data->phone) ? $data->phone : null;

if (!$username || !$password || !$email || !$phone) {
    echo json_encode(array("success" => false, "message" => "Thiếu dữ liệu cần thiết"));
    exit();
}

// Kiểm tra xem tài khoản đã tồn tại chưa
$checkQuery = "SELECT * FROM account WHERE username = '$username'";
$checkResult = $conn->query($checkQuery);

if ($checkResult->num_rows > 0) {
    echo json_encode(array("success" => false, "message" => "Tên đăng nhập đã tồn tại"));
} else {
    // Thêm tài khoản mới vào bảng `account`
    $query = "INSERT INTO account (username, password, email, phonenumber, quit, role) VALUES ('$username', '$password', '$email', '$phone', 0, 'USER')";

    if ($conn->query($query) === TRUE) {
        echo json_encode(array("success" => true, "message" => "Đăng ký thành công"));
    } else {
        echo json_encode(array("success" => false, "message" => "Lỗi khi thêm tài khoản vào cơ sở dữ liệu"));
    }
}

$conn->close();
