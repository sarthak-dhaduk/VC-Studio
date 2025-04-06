<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reset-password.aspx.cs" Inherits="VC_Studio_Client.reset_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../content/bootstrap.min.css" rel="stylesheet" />
    <script src="../scripts/bootstrap.bundle.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <link rel="icon" href="../assets/icons/icon2.svg" type="image/svg+xml">
    <link href="../assets/css/style.main.css" rel="stylesheet" />
    <script src="../assets/js/script.main.js"></script>

    <title>Reset Password</title>
</head>
<body>
    <div class="container-xl d-flex align-items-center justify-content-between p-3">
        <img src="../assets/icons/icon2.svg" alt="Sign Up Icon" width="30" height="30">
        <span class="gradient-text fw-bolder">Forgot Password</span>
    </div>

    <div class="container">
        <h1 class="text-center">Forgot Password - <span class="gradient-text">Create a New Password</span></h1>
        <p class="text-center">Please enter your new password below to reset your account password. Ensure your new password meets the security requirements.</p>
        <form id="form1" runat="server">
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label fw-bolder">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter your new password"></asp:TextBox><br />
            </div>
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label fw-bolder">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Re-enter your new password"></asp:TextBox><br />
            </div>
            <div class="col-12 col-lg-12 mb-3 w-100">
                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-custom forget-password w-100" Text="Reset Password" OnClick="btnReset_Click" />
            </div>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label><br />
        </form>

        <footer class="text-center mt-4">
            Virtual Collab Studio &copy; 2025
        </footer>
    </div>
</body>
</html>
