<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="VC_Studio_Client.login" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../content/bootstrap.min.css" rel="stylesheet" />
    <script src="../scripts/bootstrap.bundle.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <link rel="icon" href="../assets/icons/icon2.svg" type="image/svg+xml">
    <link href="../assets/css/style.main.css" rel="stylesheet" />
    <script src="../assets/js/script.main.js"></script>

    <title>Login</title>
</head>
<body>
    <div class="container-xl d-flex align-items-center justify-content-between p-3">
     <img src="assets/icons/icon2.svg" alt="Sign Up Icon" width="30" height="30">
     <span class="gradient-text fw-bolder">Reset</span>
 </div>

 <div class="container">
     <h1 class="text-center">Let's get <span class="gradient-text">creative!</span></h1>
     <p class="text-center">Log in to access a powerful online compiler and collaborate with your team in real-time.</p>

     <div class="mb-3">
         <input type="email" class="form-control" placeholder="Email" required>
     </div>
     <div class="mb-3">
         <input type="password" class="form-control" placeholder="Password" required>
     </div>

     <div class="mb-3">
         <a href="#" class="d-block text-center forgot-password">Forgot Password?</a>
     </div>

     <div class="col-12 col-lg-12 mb-3 w-100">
         <button type="submit" class="btn btn-custom forget-password w-100">Log In to Code Together</button>
     </div>

     <p class="text-center">Don't have an account? <a href="#" class="signup-link">Sign Up</a></p>

     <footer class="text-center mt-4">
         Virtual Collab Studio &copy; 2025
     </footer>
 </div>
</body>

</html>
