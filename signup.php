<?php
session_start();

$servername = "<RDS_ENDPOINT>";
$username = "<RDS_USERNAME>";
$password = "<RDS_PASSWORD>";
$dbname = "homeshopping";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("연결 실패: " . $conn->connect_error);
}

$signupUsername = $_POST['username'];
$signupUserid = $_POST['userid'];
$signupPassword = $_POST['password'];

$sql = "SELECT * FROM users WHERE username='$signupUsername'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<script>alert('이미 존재하는 회원입니다!'); window.location.href='signup.html';</script>";
} else {
    $sql = "INSERT INTO users (username, userid, password) VALUES ('$signupUsername', '$signupUserid', '$signupPassword')";
    if ($conn->query($sql) === TRUE) {
        echo "<script>alert('회원가입 성공!'); window.location.href='index.php';</script>";
    } else {
        echo "오류: " . $conn->error;
    }
}

$conn->close();
?>