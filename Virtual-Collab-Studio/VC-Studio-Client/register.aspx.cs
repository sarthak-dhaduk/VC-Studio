using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VC_Studio_Client
{
    public partial class register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Clear previous error messages
            ClearErrorMessages();

            bool isValid = true;

            // Validate Username
            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {
                lblUsernameError.Text = "Full name is required.";
                isValid = false;
            }

            // Validate Email
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblEmailError.Text = "Email is required.";
                isValid = false;
            }
            else if (!System.Text.RegularExpressions.Regex.IsMatch(txtEmail.Text, @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"))
            {
                lblEmailError.Text = "Please enter a valid email address.";
                isValid = false;
            }

            // Validate Contact Number
            if (string.IsNullOrWhiteSpace(txtContactNumber.Text))
            {
                lblContactError.Text = "Contact number is required.";
                isValid = false;
            }
            else if (!System.Text.RegularExpressions.Regex.IsMatch(txtContactNumber.Text, @"^\d{10}$"))
            {
                lblContactError.Text = "Contact number must be 10 digits.";
                isValid = false;
            }

            // Validate Password
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblPasswordError.Text = "Password is required.";
                isValid = false;
            }

            // Validate Confirm Password
            if (string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                lblConfirmPasswordError.Text = "Confirm password is required.";
                isValid = false;
            }
            else if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblConfirmPasswordError.Text = "Passwords do not match.";
                isValid = false;
            }

            // Validate Terms and Conditions
            if (!chkCustom.Checked)
            {
                lblTermsError.Text = "You must agree to the terms and conditions.";
                isValid = false;
            }

            if (isValid)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;
                string userId = new Random().Next(10000000, 99999999).ToString();
                string username = txtUsername.Text.Trim();
                string email = txtEmail.Text.Trim();
                string contactNumber = txtContactNumber.Text.Trim();
                string password = txtPassword.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Users (UserID, Username, Email, ContactNumber, Password) VALUES (@Id, @Username, @Email, @ContactNumber, @Password)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", userId);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                Response.Redirect("login.aspx");
            }
        }

        private void ClearErrorMessages()
        {
            lblUsernameError.Text = "";
            lblEmailError.Text = "";
            lblContactError.Text = "";
            lblPasswordError.Text = "";
            lblConfirmPasswordError.Text = "";
            lblTermsError.Text = "";
        }
    }
}
