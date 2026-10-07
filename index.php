<?php
session_start();
header("Location: ".(!empty($_SESSION['user_id']) ? "dashboard.php" : "auth/login.php"));
exit;
?>