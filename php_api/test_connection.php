<?php
$servername = "localhost";
$username = "root"; // Thay đổi nếu bạn đã đặt mật khẩu cho MySQL
$password = "";     // Thay đổi nếu bạn đã đặt mật khẩu cho MySQL
$dbname = "hospital"; // Đảm bảo tên cơ sở dữ liệu chính xác

// Tạo kết nối
$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}
echo "Kết nối thành công với cơ sở dữ liệu MySQL!";
$conn->close();

