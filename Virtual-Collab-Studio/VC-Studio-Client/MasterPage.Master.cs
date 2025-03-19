using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace VC_Studio_Client
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Email"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }


            LoadWorkspaces();
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("login.aspx");
        }
        protected void createRoom_Click(object sender, EventArgs e)
        {
            string roomId = roomIdInput.Text.Trim();
            string email = Session["Email"]?.ToString();
            string languages = postLanguage.Value;
            string code = postCode.Value;

            Session["ActiveRoomID"] = roomId.ToString();

            if (string.IsNullOrEmpty(roomId) || string.IsNullOrEmpty(email))
            {
                System.Diagnostics.Debug.WriteLine($"Room ID: {roomId}, Email: {email}");
                Response.Write("<script>alert('Room ID or Email is missing. Please try again.');</script>");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string checkRoomQuery = "SELECT COUNT(*) FROM Workspaces WHERE WorkspaceID = @WorkspaceID";
                SqlCommand checkRoomCmd = new SqlCommand(checkRoomQuery, conn);
                checkRoomCmd.Parameters.AddWithValue("@WorkspaceID", roomId);
                int roomCount = Convert.ToInt32(checkRoomCmd.ExecuteScalar());

                if (roomCount > 0)
                {
                    Response.Write("<script>alert('This Room ID already exists. Please choose a different Room ID.');</script>");
                    return;
                }

                string checkUserQuery = "SELECT COUNT(*) FROM Workspaces WHERE Email = @Email";
                SqlCommand checkUserCmd = new SqlCommand(checkUserQuery, conn);
                checkUserCmd.Parameters.AddWithValue("@Email", email);
                int workspaceCount = Convert.ToInt32(checkUserCmd.ExecuteScalar());

                if (workspaceCount >= 5)
                {
                    Response.Write("<script>alert('You have reached the maximum limit of 5 workspaces.');</script>");
                    return;
                }

                string insertQuery = @"
            INSERT INTO Workspaces (WorkspaceID, Email, ProgrammingLanguage, CodeSnippet) 
            VALUES (@WorkspaceID, @Email, @ProgrammingLanguage, @CodeSnippet)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@WorkspaceID", roomId);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@ProgrammingLanguage", languages);
                insertCmd.Parameters.AddWithValue("@CodeSnippet", code);
                historyCode.Value = code;
                historyLanguage.Value = languages;
                historyId.Value = roomId;
                insertCmd.ExecuteNonQuery();
            }
            LoadWorkspaces();

            if (this.Page is index indexPage)
            {
                indexPage.LoadSaveWorkspacesButton(roomId); // Call the method to show the button
            }
        }
        public static string GenerateRandomId(int length = 8)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            char[] result = new char[length];

            for (int i = 0; i < length; i++)
            {
                result[i] = chars[random.Next(chars.Length)];
            }

            return new string(result);
        }
        protected void postCode_Click(object sender, EventArgs e)
        {
            string randomId = GenerateRandomId();

            string email = (string)Session["Email"];
            string title = txtInputTitle.Text;
            string description = postDescription.Text;
            string language = postLanguage.Value;
            string code = postCode.Value;

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            string query = "INSERT INTO [dbo].[Blogs] (BlogID, Email, Title, Description, ProgrammingLanguage, CodeSnippet) " +
                           "VALUES (@BlogID, @Email, @Title, @Description, @ProgrammingLanguage, @CodeSnippet)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@BlogID", randomId);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ProgrammingLanguage", language);
                        cmd.Parameters.AddWithValue("@CodeSnippet", (object)code ?? DBNull.Value);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Response.Write("Blog post inserted successfully.");
                        }
                        else
                        {
                            Response.Write("An error occurred while inserting the blog post.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);
                }
            }
            txtInputTitle.Text = "";
            postDescription.Text = "";
        }
        private void LoadWorkspaces()
        {
            workspaceList.Controls.Clear();
            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;
            string query = "SELECT WorkspaceID FROM Workspaces WHERE Email = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Email", Session["Email"]?.ToString());

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string workspaceID = reader["WorkspaceID"].ToString();

                                if (roomIdInput.Text == workspaceID)
                                {
                                    HtmlGenericControl li = new HtmlGenericControl("li");
                                    li.Attributes["class"] = "nav-item";

                                    LinkButton linkButton = new LinkButton
                                    {
                                        ID = "historyWorkSpace_" + workspaceID,
                                        CssClass = "nav-link text-light d-flex align-items-center historyWorkSpace",
                                        CausesValidation = false,
                                        CommandArgument = workspaceID,
                                        OnClientClick = $"return historyCreateRoom_Click('{workspaceID}');"
                                    };

                                    string svgHtml = @"<svg class='icon-shadow-green' width='18' height='18' viewBox='0 0 18 18' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                            <rect x='1.5' y='1.5' width='15' height='15' rx='3' stroke='#B6F09C' stroke-width='1.5' stroke-linecap='round'/>
                                          </svg>";
                                    linkButton.Text = svgHtml + $"<span class='ms-2' id='dbGetWorkspace'>{workspaceID}</span>";

                                    linkButton.Click += new EventHandler(LinkButton_Click);

                                    li.Controls.Add(linkButton);

                                    workspaceList.Controls.Add(li);
                                }
                                else
                                {
                                    HtmlGenericControl li = new HtmlGenericControl("li");
                                    li.Attributes["class"] = "nav-item";
                                    LinkButton linkButton = new LinkButton
                                    {
                                        ID = "historyWorkSpace_" + workspaceID,
                                        CssClass = "nav-link text-light d-flex align-items-center historyWorkSpace collapsed",
                                        CausesValidation = false,
                                        CommandArgument = workspaceID,
                                        OnClientClick = $"return historyCreateRoom_Click('{workspaceID}');"
                                    };

                                    string svgHtml = @"<svg class='icon-shadow-green' width='18' height='18' viewBox='0 0 18 18' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                            <rect x='1.5' y='1.5' width='15' height='15' rx='3' stroke='#B6F09C' stroke-width='1.5' stroke-linecap='round'/>
                                          </svg>";
                                    linkButton.Text = svgHtml + $"<span class='ms-2' id='dbGetWorkspace'>{workspaceID}</span>";

                                    linkButton.Click += new EventHandler(LinkButton_Click);

                                    li.Controls.Add(linkButton);

                                    workspaceList.Controls.Add(li);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }
        protected void LinkButton_Click(object sender, EventArgs e)
        {
            LinkButton clickedButton = (LinkButton)sender;
            string workspaceID = clickedButton.CommandArgument;
            Session["ActiveRoomID"] = workspaceID;

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"
         SELECT CodeSnippet, ProgrammingLanguage, WorkspaceID 
         FROM Workspaces 
         WHERE WorkspaceID = @WorkspaceID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@WorkspaceID", workspaceID);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string codeSnippet = reader["CodeSnippet"]?.ToString() ?? string.Empty;
                                string programmingLanguage = reader["ProgrammingLanguage"]?.ToString() ?? string.Empty;
                                string WorkspaceID = reader["WorkspaceID"]?.ToString() ?? string.Empty;

                                historyCode.Value = codeSnippet;
                                historyLanguage.Value = programmingLanguage;
                                historyId.Value = WorkspaceID;

                                if (this.Page is index indexPage)
                                {
                                    indexPage.LoadSaveWorkspacesButton(workspaceID);
                                }
                            }
                            else
                            {
                                Response.Write("<script>alert('Workspace not found.');</script>");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                }
            }
        }
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                string userId = Session["UserId"].ToString();
                string username = txtFirstName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string mobile = txtMobile.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Connection string
                string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

                // Fetch current values from the database
                string currentUsername = "";
                string currentEmail = "";
                string currentMobile = "";
                string currentPassword = "";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string selectQuery = "SELECT Username, Email, ContactNumber, Password FROM Users WHERE UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                currentUsername = reader["Username"].ToString();
                                currentEmail = reader["Email"].ToString();
                                currentMobile = reader["ContactNumber"].ToString();
                                currentPassword = reader["Password"].ToString();
                            }
                        }
                        conn.Close();
                    }
                }

                // Build the update query dynamically based on changes
                List<string> setClauses = new List<string>();
                List<SqlParameter> parameters = new List<SqlParameter>();

                // Check if Username is different
                if (!string.IsNullOrEmpty(username) && username != currentUsername)
                {
                    setClauses.Add("Username = @Username");
                    parameters.Add(new SqlParameter("@Username", username));
                }

                // Check if Email is different
                if (!string.IsNullOrEmpty(email) && email != currentEmail)
                {
                    setClauses.Add("Email = @Email");
                    parameters.Add(new SqlParameter("@Email", email));
                }

                // Check if Mobile is different
                if (!string.IsNullOrEmpty(mobile) && mobile != currentMobile)
                {
                    setClauses.Add("ContactNumber = @Mobile");
                    parameters.Add(new SqlParameter("@Mobile", mobile));
                }

                // Check if Password is different
                if (!string.IsNullOrEmpty(password) && password != currentPassword)
                {
                    setClauses.Add("Password = @Password");
                    parameters.Add(new SqlParameter("@Password", password));
                }

                // If no fields are changed, exit
                if (setClauses.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "NoChangeAlert", "alert('No changes detected.');", true);
                    return;
                }

                // Construct the update query
                string updateQuery = "UPDATE Users SET " + string.Join(", ", setClauses) + " WHERE UserID = @UserID";
                parameters.Add(new SqlParameter("@UserID", userId));

                // Execute the update query
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddRange(parameters.ToArray());

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert", "alert('Data updated successfully!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any errors
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert", $"alert('An error occurred: {ex.Message}');", true);
            }
        }
    }
}