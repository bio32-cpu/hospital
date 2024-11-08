<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$id = isset($_GET['id']) ? intval($_GET['id']) : null;

if ($id) {
    $query = "DELETE FROM onleave WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Record deleted successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to delete record']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid parameters']);
}

$conn->close();
