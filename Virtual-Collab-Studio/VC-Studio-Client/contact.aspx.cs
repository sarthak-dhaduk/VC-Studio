using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace VC_Studio_Client
{
    public partial class contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchUserDetails();
            }
        }

        private void FetchUserDetails()
        {
            string email = Session["Email"]?.ToString(); // Retrieve email from session
            if (string.IsNullOrEmpty(email))
            {
                // Handle case where email is not in session
                Response.Redirect("Login.aspx"); // Redirect to login or another appropriate page
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;
            string query = "SELECT Username, Email, ContactNumber FROM Users WHERE Email = @Email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    try
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                FullName.Text = reader["Username"].ToString();
                                Email.Text = reader["Email"].ToString();
                                Mobile.Text = reader["ContactNumber"].ToString();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log or handle exception as needed
                        Response.Write("<script>alert('An error occurred while fetching user details.');</script>");
                    }
                }
            }

            // Make fields readonly
            FullName.ReadOnly = true;
            Email.ReadOnly = true;
            Mobile.ReadOnly = true;
        }


        protected void SendEmail(object sender, EventArgs e)
        {
            Response.Write("<script>alert('SendEmail method triggered');</script>");
            System.Diagnostics.Debug.WriteLine("SendEmail method triggered");
            string fromEmail = "jkalariya487@rku.ac.in";
            string fromEmailPassword = "Rku@123456";
            string toEmail = "tech.solutions1771@gmail.com";

            try
            {
                string fullName = FullName.Text;
                string emailId = Email.Text;
                string mobileNo = Mobile.Text;
                string subject = Subject.SelectedValue;
                string message = Message.Text;

                string emailBody = $@"
<html>
<head>
    <style>
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }}
        .email-container {{
            max-width: 700px;
            margin: 0 auto;
            background: #ffffff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }}
        .header {{
            background-color: #007bff;
            color: #ffffff;
            text-align: center;
            padding: 20px 10px;
            font-size: 22px;
            font-weight: bold;
        }}
        .content {{
            padding: 20px 30px;
        }}
        .content p {{
            font-size: 16px;
            color: #333333;
            margin: 15px 0;
            line-height: 1.5;
        }}
        .content p strong {{
            color: #007bff;
        }}
        .footer {{
            background-color: #f7f7f7;
            text-align: center;
            padding: 10px 15px;
            font-size: 12px;
            color: #888888;
        }}
    </style>
</head>
<body>
    <div class='email-container'>
        <div class='header'>
            New Contact Form Submission
        </div>
        <div class='content'>
            <p><strong>Full Name:</strong> {fullName}</p>
            <p><strong>Email Id:</strong> {emailId}</p>
            <p><strong>Mobile No.:</strong> {mobileNo}</p>
            <p><strong>Subject:</strong> {subject}</p>
            <p><strong>Message:</strong> {message}</p>
        </div>
        <div class='footer'>
            This email was sent from the contact form on your website.<br>
            &copy; {DateTime.Now.Year} Your Company Name. All rights reserved.
        </div>
    </div>
</body>
</html>";

                // Create and configure the email
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromEmail);
                    mail.To.Add(toEmail);
                    mail.Subject = "New Contact Form Submission";
                    mail.Body = emailBody;
                    mail.IsBodyHtml = true;

                    // Configure SMTP client
                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.Credentials = new NetworkCredential(fromEmail, fromEmailPassword);
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }

                // Store details in the database
                StoreInDatabase(fullName, emailId, mobileNo, subject, message);

                // Show success message to user
                Response.Write("<script>alert('Your message has been sent successfully!');</script>");
            }
            catch (Exception ex)
            {
                // Show error message to user
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }


        private void StoreInDatabase(string fullName, string emailId, string mobileNo, string subject, string message)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO ContactUs (ContactId, FullName, Email, ContactNumber, Subject, MessageContent)
                    VALUES (@ContactId, @FullName, @Email, @ContactNumber, @Subject, @MessageContent)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ContactId", GenerateRandomContactId());
                    command.Parameters.AddWithValue("@FullName", fullName);
                    command.Parameters.AddWithValue("@Email", emailId);
                    command.Parameters.AddWithValue("@ContactNumber", mobileNo);
                    command.Parameters.AddWithValue("@Subject", subject);
                    command.Parameters.AddWithValue("@MessageContent", message);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private int GenerateRandomContactId()
        {
            Random random = new Random();
            return random.Next(10000000, 99999999); // Generates a random 8-digit number
        }
    }
}
