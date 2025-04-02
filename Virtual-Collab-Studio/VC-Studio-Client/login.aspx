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

    <!-- Custom styling for validation errors -->
    <style>
        .validation-error {
            color: red;
            font-size: 0.9rem;
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <form id="formLogin" runat="server">
        <div class="container-xl d-flex align-items-center justify-content-between p-3">
            <img src="assets/icons/icon2.svg" alt="Sign Up Icon" width="30" height="30">
            <span class="gradient-text fw-bolder">Login</span>
        </div>

        <div class="container">
            <h1 class="text-center">Let's get <span class="gradient-text">creative!</span></h1>
            <p class="text-center">Log in to access a powerful online compiler and collaborate with your team in real-time.</p>

            <div class="mb-3">
                <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>
                <asp:Label ID="lblEmailError" runat="server" CssClass="validation-error"></asp:Label>
            </div>
            <div class="mb-3">
                <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                <asp:Label ID="lblPasswordError" runat="server" CssClass="validation-error"></asp:Label>
            </div>

            <div class="mb-3">
                <a href="forgot-password.aspx" class="d-block text-center forgot-password">Forgot Password?</a>
            </div>

            <div class="col-12 col-lg-12 mb-3 w-100">
                <button type="button" id="btnLogin" runat="server" onserverclick="btnLogin_Click" class="btn btn-custom forget-password w-100">
                    Log In to Code Together
                </button>
            </div>

            <p class="text-center">Don't have an account? <a href="register.aspx" class="signup-link">Sign Up</a></p>

            <footer class="text-center mt-4">
                Virtual Collab Studio &copy; 2025
            </footer>
        </div>
    </form>
</body>
</html>
