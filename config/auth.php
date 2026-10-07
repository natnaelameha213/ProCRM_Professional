<?php
if(session_status()===PHP_SESSION_NONE) session_start();
require_once __DIR__.'/database.php';
function require_login(){if(empty($_SESSION['user_id'])){header('Location: /ProCRM_Professional/auth/login.php');exit;}}
function require_admin(){require_login();if(($_SESSION['role']??'')!=='admin'){http_response_code(403);die('Access denied');}}
function e($v){return htmlspecialchars((string)$v,ENT_QUOTES,'UTF-8');}
?>