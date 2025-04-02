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
    public partial class blog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserRatings();
                int blogId = 1; // Hardcoded BlogID for now
                BindRating(blogId);


            }

        }

        private void BindRating(int blogId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;
            string query = "SELECT AVG(CAST(RatingValue AS FLOAT)) AS AverageRating FROM Ratings WHERE BlogID = @BlogID";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BlogID", blogId);

                    try
                    {
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != DBNull.Value && result != null)
                        {
                            lblRating.Text = Math.Round(Convert.ToDouble(result), 1).ToString(); // Set the average rating
                        }
                        else
                        {
                            lblRating.Text = "0.0"; // Default if no ratings
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log error (optional)
                        lblRating.Text = "Error"; // Display error
                    }
                }
            }
        }

        protected void SubmitRating(object sender, EventArgs e)
        {

            int blogId = 1; // Replace with dynamically retrieved BlogID
            string email = "yash@gmail.com"; // Replace with the logged-in user's email
            string ratingValue = Request.Form["ratingValue"]; // Replace with the actual form value

            if (string.IsNullOrEmpty(ratingValue))
            {
                Response.Write("<script>alert('Rating value is required.');</script>");
                return;
            }

            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\New_Virtual\\Virtual-Collab-Studio\\VC-Studio-Client\\App_Data\\VirtualCollabStudioDB.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if a rating already exists for this BlogID and Email
                string checkQuery = @"
                    SELECT COUNT(*)
                    FROM Ratings
                    WHERE BlogID = @BlogID AND Email = @Email";

                string updateQuery = @"
                    UPDATE Ratings
                    SET RatingValue = @RatingValue
                    WHERE BlogID = @BlogID AND Email = @Email";

                string insertQuery = @"
                    INSERT INTO Ratings (RatingID, BlogID, Email, RatingValue)
                    VALUES (@RatingID, @BlogID, @Email, @RatingValue)";

                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@BlogID", blogId);
                    checkCommand.Parameters.AddWithValue("@Email", email);

                    int count = (int)checkCommand.ExecuteScalar();

                    if (count > 0)
                    {
                        // Update the existing rating
                        using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                        {
                            updateCommand.Parameters.AddWithValue("@BlogID", blogId);
                            updateCommand.Parameters.AddWithValue("@Email", email);
                            updateCommand.Parameters.AddWithValue("@RatingValue", ratingValue);

                            updateCommand.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        // Insert a new rating
                        using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                        {
                            int ratingId = new Random().Next(10000000, 99999999);

                            insertCommand.Parameters.AddWithValue("@RatingID", ratingId);
                            insertCommand.Parameters.AddWithValue("@BlogID", blogId);
                            insertCommand.Parameters.AddWithValue("@Email", email);
                            insertCommand.Parameters.AddWithValue("@RatingValue", ratingValue);

                            insertCommand.ExecuteNonQuery();
                        }
                    }
                }
            }

            Response.Write("<script>alert('Rating submitted successfully.');</script>");
        }
        private void LoadUserRatings()
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\New_Virtual\\Virtual-Collab-Studio\\VC-Studio-Client\\App_Data\\VirtualCollabStudioDB.mdf;Integrated Security=True"; // Update with your DB connection string
            string query = "SELECT Email, RatingValue FROM Ratings";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string email = reader["Email"].ToString();
                        int rating = Convert.ToInt32(reader["RatingValue"]);
                        reviewsList.InnerHtml += GenerateReviewHtml(email, rating);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle errors (e.g., log the exception)
                Console.WriteLine(ex.Message);
            }
        }

        //private void LoadBlogRating()
        //{
        //    string blogId = Request.QueryString["id"]; // Assume the blog ID is passed in the URL
        //    if (string.IsNullOrEmpty(blogId)) return;

        //    // Fetch the average rating from the database for the specific blog
        //    string query = "SELECT AVG(rating) as avgRating FROM Reviews WHERE blogId = @BlogId";
        //    using (SqlConnection conn = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\New_Virtual\\Virtual-Collab-Studio\\VC-Studio-Client\\App_Data\\VirtualCollabStudioDB.mdf;Integrated Security=True"))
        //    {
        //        conn.Open();
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@BlogId", blogId);

        //        var result = cmd.ExecuteScalar();
        //        if (result != DBNull.Value)
        //        {
        //            double averageRating = Convert.ToDouble(result);
        //            // Set the average rating in the UI
        //            lblRating.Text = averageRating.ToString("0.0"); // Display as "4.5"
        //        }
        //        else
        //        {
        //            // If no ratings are available, set a default value
        //            lblRating.Text = "0.0";
        //        }
        //    }
        //}

        private string GenerateReviewHtml(string email, int rating)
        {
            string stars = new string('⭐', rating); // Generate stars based on rating
            string initial = email.Length > 0 ? email[0].ToString().ToUpper() : "?";

            return $@"
                <li class='d-flex align-items-center mb-2 p-3'>
                    <div class='d-flex justify-content-center align-items-center bg-primary text-center text-white rounded-circle me-2' style='width: 48px; height: 48px;'>
                        {initial}
                    </div>
                    <div>
                        <strong>{email}</strong>
                        <p class='mb-0'>{stars}</p>
                    </div>
                </li>";
        }
    }
}