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
<body>
    <div class="container-xl d-flex align-items-center justify-content-between p-3">
        <img src="../assets/icons/icon2.svg" alt="Sign Up Icon" width="30" height="30">
        <span class="gradient-text fw-bolder">Reset</span>
    </div>
    <div class="p-5"></div>
    <div class="container d-flex justify-content-center align-items-center mt-5">
        <div class="w-100" style="max-width: 676px;">
            <div class="text-start mb-5">
                <h2 class="gradient-text">Forgot Password</h2>
                <p style="color:#9B9C9E;">Regain access to your account by resetting your password. Enter your registered email address, and we'll send you a link to reset it.</p>
            </div>
            <form id="form1" runat="server">
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-lg-8 mb-3">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter Email Here..."></asp:TextBox><br />
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" TextMode="MultiLine"></asp:Label><br />
                        </div>
                        <div class="col-12 col-lg-4 mb-3">
                            <asp:Button ID="Button1" runat="server" Text="Send" CssClass="btn btn-custom w-100" OnClick="btnSubmit_Click"/>
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
