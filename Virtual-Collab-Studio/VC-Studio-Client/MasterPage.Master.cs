using System;
using System.Collections.Generic;
using System.Configuration;
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
            // Generate a random ID (assuming you already have the GenerateRandomId function)
            string randomId = GenerateRandomId();

            // Retrieve session and form data
            string email = (string)Session["Email"];
            string title = txtInputTitle.Text;
            string description = postDescription.Text;
            string language = postLanguage.Value;
            string code = postCode.Value;

            // Define the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            // Create the SQL query to insert data
            string query = "INSERT INTO [dbo].[Blogs] (BlogID, Email, Title, Description, ProgrammingLanguage, CodeSnippet) " +
                           "VALUES (@BlogID, @Email, @Title, @Description, @ProgrammingLanguage, @CodeSnippet)";

            // Using SqlConnection to connect to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    // Open the database connection
                    conn.Open();

                    // Create SqlCommand to execute the query
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to prevent SQL injection
                        cmd.Parameters.AddWithValue("@BlogID", randomId);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ProgrammingLanguage", language);
                        cmd.Parameters.AddWithValue("@CodeSnippet", (object)code ?? DBNull.Value);  // Handle null value for code snippet

                        // Execute the insert command
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Data inserted successfully
                            // Response.Write("Blog post inserted successfully.");

                        }
                        else
                        {
                            // Data insertion failed
                            Response.Write("An error occurred while inserting the blog post.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle any errors
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
                                // Fetch WorkspaceID
                                string workspaceID = reader["WorkspaceID"].ToString();

                                if (roomIdInput.Text == workspaceID)
                                {
                                    HtmlGenericControl li = new HtmlGenericControl("li");
                                    li.Attributes["class"] = "nav-item";

                                    // Create <asp:LinkButton> element
                                    LinkButton linkButton = new LinkButton
                                    {
                                        ID = "historyWorkSpace_" + workspaceID,
                                        CssClass = "nav-link text-light d-flex align-items-center historyWorkSpace",
                                        CausesValidation = false,
                                        CommandArgument = workspaceID, // Pass WorkspaceID to the server-side OnClick handler
                                        OnClientClick = $"return historyCreateRoom_Click('{workspaceID}');" // Pass WorkspaceID to client-side function
                                    };

                                    // Add SVG icon to LinkButton
                                    string svgHtml = @"<svg class='icon-shadow-green' width='18' height='18' viewBox='0 0 18 18' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                            <rect x='1.5' y='1.5' width='15' height='15' rx='3' stroke='#B6F09C' stroke-width='1.5' stroke-linecap='round'/>
                                          </svg>";
                                    linkButton.Text = svgHtml + $"<span class='ms-2' id='dbGetWorkspace'>{workspaceID}</span>";

                                    // Add server-side click event handler
                                    linkButton.Click += new EventHandler(LinkButton_Click);

                                    // Add LinkButton to <li>
                                    li.Controls.Add(linkButton);

                                    // Add <li> to the placeholder in the .aspx file
                                    workspaceList.Controls.Add(li);
                                }
                                else
                                {
                                    HtmlGenericControl li = new HtmlGenericControl("li");
                                    li.Attributes["class"] = "nav-item";

                                    // Create <asp:LinkButton> element
                                    LinkButton linkButton = new LinkButton
                                    {
                                        ID = "historyWorkSpace_" + workspaceID,
                                        CssClass = "nav-link text-light d-flex align-items-center historyWorkSpace collapsed",
                                        CausesValidation = false,
                                        CommandArgument = workspaceID, // Pass WorkspaceID to the server-side OnClick handler
                                        OnClientClick = $"return historyCreateRoom_Click('{workspaceID}');" // Pass WorkspaceID to client-side function
                                    };

                                    // Add SVG icon to LinkButton
                                    string svgHtml = @"<svg class='icon-shadow-green' width='18' height='18' viewBox='0 0 18 18' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                            <rect x='1.5' y='1.5' width='15' height='15' rx='3' stroke='#B6F09C' stroke-width='1.5' stroke-linecap='round'/>
                                          </svg>";
                                    linkButton.Text = svgHtml + $"<span class='ms-2' id='dbGetWorkspace'>{workspaceID}</span>";

                                    // Add server-side click event handler
                                    linkButton.Click += new EventHandler(LinkButton_Click);

                                    // Add LinkButton to <li>
                                    li.Controls.Add(linkButton);

                                    // Add <li> to the placeholder in the .aspx file
                                    workspaceList.Controls.Add(li);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log or handle the exception
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }

        // Server-side event handler
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

                    // Query to fetch CodeSnippet and ProgrammingLanguage for the given WorkspaceID
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
                                // Fetch CodeSnippet and ProgrammingLanguage
                                string codeSnippet = reader["CodeSnippet"]?.ToString() ?? string.Empty;
                                string programmingLanguage = reader["ProgrammingLanguage"]?.ToString() ?? string.Empty;
                                string WorkspaceID = reader["WorkspaceID"]?.ToString() ?? string.Empty;

                                // Assign values to hidden fields
                                historyCode.Value = codeSnippet;
                                historyLanguage.Value = programmingLanguage;
                                historyId.Value = WorkspaceID;

                                if (this.Page is index indexPage)
                                {
                                    indexPage.LoadSaveWorkspacesButton(workspaceID); // Show button after click
                                }
                            }
                            else
                            {
                                // Handle case where WorkspaceID is not found
                                Response.Write("<script>alert('Workspace not found.');</script>");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                }
            }
        }

    }
}