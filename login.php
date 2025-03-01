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

$loginUsername = $_POST['username'];
$loginUserid = $_POST['userid'];
$loginPassword = $_POST['password'];

$sql = "SELECT * FROM users WHERE username='$loginUsername' AND userid='$loginUserid'";
$result = $conn->query($sql);

if ($result->num_rows == 0) {
    echo "<script>alert('아이디가 틀립니다.'); window.location.href='login.html';</script>";
} else {
    $row = $result->fetch_assoc();
    if ($row['password'] != $loginPassword) {
        echo "<script>alert('패스워드가 틀립니다.'); window.location.href='login.html';</script>";
    } else {
        $_SESSION['username'] = $loginUsername;
        echo "<script>alert('로그인 성공!'); window.location.href='index.php';</script>";
    }
}

$conn->close();
?>