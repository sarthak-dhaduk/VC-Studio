<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgot-password.aspx.cs" Inherits="VC_Studio_Client.forgot_Password" %>

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
    <title>Forgot Password</title>
</head>
<body class="">
           <div class="top-bar px-5">
        <img src="../assets/icons/icon2.svg" alt="Icon">
        <span class="gradient-text">Reset</span>
    </div>
    <div class="p-5"></div>
    <div class="container d-flex justify-content-center align-items-center mt-5">
        <div class="w-100" style="max-width: 676px;">
            <div class="text-start mb-5">
                <h2 class="gradient-text">Forgot Password</h2>
                <p style="color:#9B9C9E;">Regain access to your account by resetting your password. Enter your registered email address, and we'll send you a link to reset it.</p>
            </div>
            <form>
                <div class="container">
    <div class="row">
        <!-- Input Field -->
        <div class="col-12 col-lg-8 mb-3">
            <input type="email" class="form-control" placeholder="Enter Email Here..." required>
        </div>
        <!-- Button -->
        <div class="col-12 col-lg-4 mb-3">
            <button type="submit" class="btn btn-custom w-100">Send</button>
        </div>
    </div>
</div>
            </form>
    <div class="p-4"></div>
            <footer class="text-center mt-4">
                Virtual Collab Studio &copy; 2025
            </footer>
        </div>
    </div>
</body>
</html>
