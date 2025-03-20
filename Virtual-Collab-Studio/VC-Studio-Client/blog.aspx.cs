using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
                BindBlogs();
            }
        }

        private void BindBlogs()
        {
            string searchQuery = Request.QueryString["search"];
            string query;

            // If search query is provided, check if it starts with '@'
            if (!string.IsNullOrEmpty(searchQuery))
            {
                // If the search starts with '@', filter by Email
                if (searchQuery.StartsWith("@"))
                {
                    query = "SELECT * FROM Blogs WHERE Email LIKE @SearchQuery";
                    // Remove the '@' symbol and use the rest of the email for the query
                    searchQuery = searchQuery.Substring(1);
                }
                else
                {
                    // Otherwise, search by Title
                    query = "SELECT * FROM Blogs WHERE Title LIKE @SearchQuery";
                }
            }
            else
            {
                // No search query, fetch all blogs
                query = "SELECT * FROM Blogs";
            }

            DataTable dtBlogs = GetData(query, searchQuery);

            if (dtBlogs.Rows.Count > 0)
            {
                rptBlogs.DataSource = dtBlogs;
                rptBlogs.DataBind();
            }
            else
            {
                rptBlogs.DataSource = null;
                rptBlogs.DataBind();
            }
        }
        [System.Web.Services.WebMethod]
        public static List<string> GetSuggestions(string query)
        {
            List<string> suggestions = new List<string>();
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT Title FROM Blogs WHERE Title LIKE @Query OR Description LIKE @Query";
                using (SqlCommand cmd = new SqlCommand(sqlQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Query", "%" + query + "%");
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            suggestions.Add(reader["Title"].ToString());
                        }
                    }
                }
            }

            return suggestions;
        }

        private DataTable GetData(string query, string searchQuery = null)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add the search parameter if the search query exists
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                    }

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        private DataTable GetReviewsForBlog(string blogId)
        {
            string query = "SELECT r.RatingValue, u.Username " +
                           "FROM Ratings r " +
                           "INNER JOIN Users u ON r.Email = u.Email " +
                           "WHERE r.BlogID = @BlogID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BlogID", blogId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dtReviews = new DataTable();
                        sda.Fill(dtReviews);
                        return dtReviews;
                    }
                }
            }
        }

        protected void SubmitRating(object sender, EventArgs e)
        {
            string email = Session["Email"]?.ToString();
            string ratingValueStr = Request.Form["ratingValue"];
            string blogId = Request.Form["userblogId"];

            // Validate the rating value
            if (string.IsNullOrEmpty(ratingValueStr) || !int.TryParse(ratingValueStr, out int ratingValue) || ratingValue < 1 || ratingValue > 5)
            {
                Response.Write("<script>alert('Please provide a valid rating between 1 and 5.');</script>");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();

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
                                using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                                {
                                    updateCommand.Parameters.AddWithValue("@BlogID", blogId);
                                    updateCommand.Parameters.AddWithValue("@Email", email);
                                    updateCommand.Parameters.AddWithValue("@RatingValue", ratingValue);

                                    updateCommand.ExecuteNonQuery();
                                }

                                Response.Write("<script>alert('Your rating has been updated successfully.');</script>");
                            }
                            else
                            {
                                using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                                {
                                    string ratingId = Guid.NewGuid().ToString();

                                    insertCommand.Parameters.AddWithValue("@RatingID", ratingId);
                                    insertCommand.Parameters.AddWithValue("@BlogID", blogId);
                                    insertCommand.Parameters.AddWithValue("@Email", email);
                                    insertCommand.Parameters.AddWithValue("@RatingValue", ratingValue);

                                    insertCommand.ExecuteNonQuery();
                                }

                                Response.Write("<script>alert('Your rating has been submitted successfully.');</script>");
                            }
                        }
                    }

            BindBlogs();
        }
        protected string GetStars(object ratingValue)
        {
            int rating = Convert.ToInt32(ratingValue);
            string stars = "";

            for (int i = 0; i < rating; i++)
            {
                stars += "<span style='color: gold;'>&#9733;</span>";
            }

            for (int i = rating; i < 5; i++)
            {
                stars += "<span style='color: gray;'>&#9734;</span>";
            }

            return stars;
        }

        private double GetAverageRating(string blogId)
        {
            string query = "SELECT AVG(RatingValue) FROM Ratings WHERE BlogID = @BlogID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BlogID", blogId);
                    conn.Open();
                    var result = cmd.ExecuteScalar();

                    if (result != DBNull.Value)
                    {
                        return Convert.ToDouble(result);
                    }
                    else
                    {
                        return 0;
                    }
                }
            }
        }


        protected void rptBlogs_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string blogId = DataBinder.Eval(e.Item.DataItem, "BlogId").ToString();

                double averageRating = GetAverageRating(blogId);

                Label lblRating = (Label)e.Item.FindControl("lblRating");
                if (lblRating != null)
                {
                    lblRating.Text = averageRating.ToString("0.0");
                }

                Repeater rptReviews = (Repeater)e.Item.FindControl("rptReviews");

                DataTable dtReviews = GetReviewsForBlog(blogId);

                if (dtReviews.Rows.Count > 0)
                {
                    rptReviews.DataSource = dtReviews;
                    rptReviews.DataBind();
                }
                else
                {
                    rptReviews.DataSource = null;
                    rptReviews.DataBind();
                }
            }
        }



    }
}