<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

header("Content-Type: application/json");
include 'config.php';

// Lấy dữ liệu JSON từ yêu cầu
$data = json_decode(file_get_contents("php://input"));

if (!$data) {
    echo json_encode(array("success" => false, "message" => "Không nhận được dữ liệu đầu vào"));
    exit();
}

// Lấy giá trị từ JSON và kiểm tra nếu có dữ liệu
$username = isset($data->username) ? $conn->real_escape_string($data->username) : null;
$password = isset($data->password) ? $conn->real_escape_string($data->password) : null;
$role = isset($data->role) ? $conn->real_escape_string($data->role) : 'PATIENT'; // Mặc định là 'PATIENT'

if (!$username || !$password) {
    echo json_encode(array("success" => false, "message" => "Thiếu dữ liệu cần thiết"));
    exit();
}

// Kiểm tra xem tài khoản đã tồn tại chưa
$checkQuery = "SELECT * FROM account WHERE username = '$username'";
$checkResult = $conn->query($checkQuery);

if ($checkResult->num_rows > 0) {
    echo json_encode(array("success" => false, "message" => "Tên đăng nhập đã tồn tại"));
} else {
    // Không mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
    $query = "INSERT INTO account (username, password, quit, role) VALUES ('$username', '$password', 0, '$role')";

    if ($conn->query($query) === TRUE) {
        echo json_encode(array("success" => true, "message" => "Đăng ký thành công"));
    } else {
        echo json_encode(array("success" => false, "message" => "Lỗi khi thêm tài khoản vào cơ sở dữ liệu"));
    }
}

$conn->close();
?>
