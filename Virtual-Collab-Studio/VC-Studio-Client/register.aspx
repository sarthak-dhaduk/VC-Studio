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
        <p class="text-left paragraph">Sign up to unlock a dynamic compiler and start coding <br/> together in real-time with your team.</p>
        <form>
            <div class="row g-3 mb-3">
                <div class="col-md-6 col-12 input-field">
                    <label class="form-label" for="firstName">Full Name</label>
                    <input type="text" id="firstName" class="custom-input" placeholder="First name" required>
                </div>
                <div class="col-md-6 col-12 input-field">
                    <label class="form-label" for="email">Email ID</label>
                    <input type="email" id="email" class="custom-input" placeholder="Email ID" required>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6 col-12 input-field">
                    <label class="form-label" for="mobile">Mobile No.</label>
                    <input type="tel" id="mobile" class="custom-input" placeholder="Mobile No." required>
                </div>
                <div class="col-md-6 col-12 input-field">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" class="custom-input" placeholder="Password" required>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6 col-12 input-field">
                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" class="custom-input" placeholder="Confirm password" required>
                </div>
            </div>

            <div class="form-check mb-3 d-flex align-items-center">
                <input class="form-check-input" type="checkbox" id="terms" required>
                <label class="form-check-label" for="terms">
                    I agree with <a href="#" class="terms-link">Terms and conditions</a>
                </label>
            </div>

            <button type="submit" class="btn btn-create w-100">Create free account</button>
        </form>

        <footer class="text-center mt-4">
            Virtual Collab Studio © 2025
        </footer>
    </div>
</div>

</body>
</html>

