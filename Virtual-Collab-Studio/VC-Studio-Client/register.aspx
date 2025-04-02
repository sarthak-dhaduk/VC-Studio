<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="VC_Studio_Client.register" %>

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

    <title>VC-Studio</title>
</head>
<body>
    <div class="container-xl d-flex align-items-center justify-content-between p-3">
        <img src="assets/icons/icon2.svg" alt="Sign Up Icon" width="30" height="30">
        <span class="gradient-text fw-bolder">Sign Up</span>
    </div>
    <div class="container vh-100 d-flex align-items-center justify-content-center">
        <div class="form-container p-4 w-100">
            <h2 class="form-title text-left ">Let's code <span class="gradient-text">together!</span></h2>
            <p class="text-left paragraph">Sign up to unlock a dynamic compiler and start coding
                <br />
                together in real-time with your team.</p>
            <form id="registerForm" runat="server">
                <div class="row g-3 mb-3">
                    <div class="col-md-6 col-12 custom-input-field">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox ID="txtUsername" runat="server" class="form-control" placeholder="Enter your username"></asp:TextBox>
                        <asp:Label ID="lblUsernameError" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    <div class="col-md-6 col-12 custom-input-field">
                        <label class="form-label">Email ID</label>
                        <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Enter your email"></asp:TextBox>
                        <asp:Label ID="lblEmailError" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6 col-12 custom-input-field">
                        <label class="form-label">Mobile No.</label>
                        <asp:TextBox ID="txtContactNumber" runat="server" class="form-control" placeholder="Enter your contact number"></asp:TextBox>
                        <asp:Label ID="lblContactError" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    <div class="col-md-6 col-12 custom-input-field">
                        <label class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                        <asp:Label ID="lblPasswordError" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6 col-12 custom-input-field">
                        <label class="form-label">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" class="form-control" TextMode="Password" placeholder="Confirm password"></asp:TextBox>
                        <asp:Label ID="lblConfirmPasswordError" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>


                <div class="form-check d-flex mb-3 align-items-center">
                    <asp:CheckBox ID="chkCustom" runat="server" CssClass="hidden-checkbox" Text=" " />
                    <label class="form-check-label" for="chkCustom">
                        I agree with <a href="#" class="terms-link">Terms and conditions</a>
                    </label>
                    <asp:Label ID="lblTermsError" runat="server" ForeColor="Red"></asp:Label>
                </div>

                <button type="submit" id="btnRegister" runat="server" onserverclick="btnRegister_Click" class="btn btn-create w-100">Create free account</button>
            </form>

            <footer class="text-center mt-4">
                Virtual Collab Studio © 2025
            </footer>
        </div>
    </div>

</body>
</html>
