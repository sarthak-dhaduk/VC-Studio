using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VC_Studio_Client
{
    public partial class reset_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string userId = Request.QueryString["UserID"];
            string token = Request.QueryString["Token"];

            if (string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please fill in all fields.";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            // Commented token validation for now
            /*if (Cache[userId] == null || Cache[userId].ToString() != token)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red; // Error color
                lblMessage.Text = "Invalid or expired token.";
                return;
            }*/

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string randomUserId = GenerateRandomString();

                string query = "UPDATE Users SET Password = @Password, UserID = @NewUserID WHERE UserID = @OldUserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Password", newPassword);
                cmd.Parameters.AddWithValue("@NewUserID", randomUserId);
                cmd.Parameters.AddWithValue("@OldUserID", userId);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Password has been reset successfully. ";

                    lblMessage.Text += "<a href='login.aspx' class='btn btn-link'>Go to Login</a>";

                    Cache.Remove(userId);
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red; 
                    lblMessage.Text = "Password reset failed. Please try again with a valid token or ensure the token has not expired.";
                }
            }
        }

        public static string GenerateRandomString()
        {
            const string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random rand = new Random();
            char[] stringChars = new char[8]; 

            for (int i = 0; i < 8; i++)
            {
                stringChars[i] = characters[rand.Next(characters.Length)];
            }

            return new string(stringChars);
        }
    }
}