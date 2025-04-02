using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VC_Studio_Client
{
    public partial class login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Clear any previous error messages
            lblEmailError.Text = "";
            lblPasswordError.Text = "";

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validate email field
            if (string.IsNullOrEmpty(email))
            {
                lblEmailError.Text = "Email is required.";
                return;
            }
            else if (!IsValidEmail(email))
            {
                lblEmailError.Text = "Invalid email format.";
                return;
            }

            // Validate password field
            if (string.IsNullOrEmpty(password))
            {
                lblPasswordError.Text = "Password is required.";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Users WHERE Email = @Email AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string UserId = reader["UserId"].ToString();
                    string Username = reader["Username"].ToString();
                    string ContactNumber = reader["ContactNumber"].ToString();
                    Session["UserId"] = UserId;
                    Session["Username"] = Username;
                    Session["ContactNumber"] = ContactNumber;
                    Session["Email"] = email;
                    Response.Redirect("index.aspx");
                }
                else
                {
                    lblEmailError.Text = "Invalid email or password.";
                }

                conn.Close();
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}
