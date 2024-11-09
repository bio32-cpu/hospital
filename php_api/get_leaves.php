<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

$sql = "SELECT * FROM onleave";
$result = $conn->query($sql);

$onLeaveRecords = array();

if ($result) {
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            // Đảm bảo rằng các trường ngày được định dạng dưới dạng chuỗi để phù hợp với Dart
            $row['id'] = (int) $row['id'];
            
            $row['startdate'] = $row['startdate'] ? date("Y-m-d\TH:i:s", strtotime($row['startdate'])) : null;
            $row['enddate'] = $row['enddate'] ? date("Y-m-d\TH:i:s", strtotime($row['enddate'])) : null;
            
            // Thêm log để kiểm tra dữ liệu nếu cần
            error_log("Fetched record: " . json_encode($row));
            
            $onLeaveRecords[] = $row;
        }
        echo json_encode(array("success" => true, "data" => $onLeaveRecords));
    } else {
        echo json_encode(array("success" => false, "message" => "Không có dữ liệu nghỉ phép"));
    }
} else {
    // Ghi log lỗi truy vấn SQL nếu cần thiết
    error_log("SQL Error: " . $conn->error);
    echo json_encode(array("success" => false, "message" => "Lỗi truy vấn cơ sở dữ liệu: " . $conn->error));
}

$conn->close();
