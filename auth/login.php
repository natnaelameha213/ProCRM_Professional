<?php
session_start();require_once '../config/database.php';$error='';
if($_SERVER['REQUEST_METHOD']==='POST'){
 $s=$pdo->prepare("SELECT * FROM users WHERE email=? AND status='active' LIMIT 1");$s->execute([trim($_POST['email']??'')]);$u=$s->fetch();
 if($u && password_verify($_POST['password']??'',$u['password'])){
  $_SESSION['user_id']=$u['id'];$_SESSION['name']=$u['name'];$_SESSION['role']=$u['role'];
  $pdo->prepare("UPDATE users SET last_login=NOW() WHERE id=?")->execute([$u['id']]);
  header('Location: ../dashboard.php');exit;
 } $error='Invalid email or password.';
} ?>
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>ProCRM Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"><link href="../assets/css/style.css" rel="stylesheet"></head>
<body class="auth-bg"><div class="auth-card"><div class="brand dark">Pro<span>CRM</span></div><h3>Welcome back</h3><p class="text-muted">Sign in to your workspace.</p>
<?php if($error):?><div class="alert alert-danger"><?=htmlspecialchars($error)?></div><?php endif;?>
<form method="post"><input class="form-control mb-3" type="email" name="email" placeholder="Email" required><input class="form-control mb-3" type="password" name="password" placeholder="Password" required><button class="btn btn-primary w-100">Sign in</button></form>
<p class="small text-muted mt-4">Demo: admin@procrm.local / Admin123!</p></div></body></html>