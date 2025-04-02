using System;
using System.Net;
using System.Net.Mail;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace VC_Studio_Client
{
    public partial class forgot_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Please enter your registered email.";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID FROM users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    string userId = result.ToString();
                    string token = GenerateRandomToken();

                    string protocol = Request.Url.Scheme;
                    string resetLink = $"{protocol}://localhost:44300/reset-password.aspx?UserID={userId}&Token={token}";

                    if (SendResetEmail(email, resetLink))
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "Password reset link has been sent to your email. ";

                        lblMessage.Text += "<a href='https://mail.google.com/' target='_blank'>";
                        lblMessage.Text += " Go to Gmail </a>";
                        lblMessage.Text += "<img src='../assets/icons/mail.svg' alt='Email Icon' width='30' height='30' />";

                        Cache[userId] = token;
                    }
                    else
                    {
                        lblMessage.Text = "Failed to send email. Try again.";
                    }
                }
                else
                {
                    lblMessage.Text = "Email not found.";
                }
            }
        }
        private bool SendResetEmail(string email, string resetLink)
        {
            try
            {
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string fromEmail = "jkalariya487@rku.ac.in";
                string emailPassword = "Jigar.Rku@123456";

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromEmail);
                    mail.To.Add(email);
                    mail.Subject = "Password Reset Request";
                    mail.Body = @"
    <html>
    <head>
        <style>
            a{
            color: #0C1132
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .email-container {
                width: 100%;
                max-width: 600px;
                margin: 20px auto;
                background-color: #ffffff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .email-header {
                background-color: #0066cc;
                padding: 20px;
                text-align: center;
                color: white;
            }
            .email-header img {
                width: 150px;
            }
            .email-body {
                padding: 20px;
                text-align: center;
            }
            .email-body h2 {
                font-size: 22px;
                margin-bottom: 20px;
            }
            .btn-custom {
                background-color: #B6F09C;
                color: #0C1132;
                border: none;
                border-radius: 12px;
                font-weight: bold;
                transition: background-color 0.3s ease-in-out;
                height:25px;
                padding: 12px 30px;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                text-align: center;
            }

            .btn-custom:hover {
                background-color: #A5E89B;
                color: #0C1132;
            }
            .footer {
                text-align: center;
                padding: 20px;
                font-size: 14px;
                background-color: #f4f4f4;
            }
        </style>
    </head>
    <body>
        <div class='email-container'>
            <div class='email-header'>
                <img src='../assets/icons/icon2.svg' alt='Virtual Code Studio Logo'>
            </div>
            <div class='email-body'>
                <h2>Password Reset Request</h2>
                <p>Dear User,</p>
                <p>We received a request to reset the password for your account. If you requested this change, please click the button below to reset your password:</p>
                <a href='" + resetLink + @"' class='btn-custom'>Reset Your Password</a>
                <p>If you didn't request a password reset, you can ignore this email.</p>
            </div>
            <div class='footer'>
                <p>&copy; 2025 Virtual Code Studio - VC Studio</p>
                <p><a href='http://www.virtualcodestudio.com' target='_blank'>Visit Our Website</a></p>
            </div>
        </div>
    </body>
    </html>"; mail.IsBodyHtml = true;

                    using (SmtpClient smtp = new SmtpClient(smtpServer, smtpPort))
                    {
                        smtp.Credentials = new NetworkCredential(fromEmail, emailPassword);
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }
                return true;
            }
            catch
            {
                return false;
            }
        }

        private string GenerateRandomToken()
        {
            Random random = new Random();
            return random.Next(1000000, 9999999).ToString();
        }
    }
}