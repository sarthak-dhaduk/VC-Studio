using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace VC_Studio_Client
{
    public partial class index : System.Web.UI.Page
    {

        public PlaceHolder SaveWorkSpaceChangesPlaceholder => saveWorkSpaceChanges;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Only call this on the first load to avoid re-adding on every postback
            {
                string roomId = Session["ActiveRoomID"] as string;

                // Load the button if roomId is available in the session
                if (!string.IsNullOrEmpty(roomId))
                {
                    LoadSaveWorkspacesButton(roomId);
                }
            }
            else
            {
                // If it's a postback, we need to recreate the button
                string roomId = Session["ActiveRoomID"] as string;
                if (!string.IsNullOrEmpty(roomId))
                {
                    LoadSaveWorkspacesButton(roomId);
                }
            }
        }

        public void LoadSaveWorkspacesButton(string id)
        {
            try
            {
                string workspaceID = id.Trim();

                LinkButton linkButton2 = new LinkButton
                {
                    ID = "activeWorkSpace_" + workspaceID,
                    CssClass = "btn d-flex ms-3 align-items-center text-light save-btn",
                    CausesValidation = false,
                    CommandArgument = workspaceID,
                    OnClientClick = $"return activeWorkSpace_Click('{workspaceID}');"
                };

                string svgHtml = @"<svg width='18' height='18' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <path d='M1 4.07381V15.9262C1 18.208 3.4464 19.6545 5.44576 18.5548L17.8138 11.7524C19.1953 10.9926 19.1953 9.00742 17.8138 8.24757L5.44575 1.44516C3.4464 0.345517 1 1.79201 1 4.07381Z' 
            stroke='#686B6E' stroke-width='1.5' stroke-linecap='round' />
        </svg>";

                linkButton2.Text = $@"
<span style='color: #686B6E; font-size: 16px; padding-top: 2.5px;'>Save Changes</span>
<div class='ms-2'>{svgHtml}</div>";

                linkButton2.Click += new EventHandler(SaveButton_Click);

                // Clear and add the LinkButton to the placeholder
                saveWorkSpaceChanges.Controls.Clear();
                saveWorkSpaceChanges.Controls.Add(linkButton2);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            LinkButton clickedButton = (LinkButton)sender;
            string workspaceID = clickedButton.CommandArgument;
            string email = Session["Email"]?.ToString();
            string languages = activeLanguage?.Value;
            string code = activeCode?.Value;

            Response.Write($"<script>console.log('SaveButton_Click: {workspaceID}, {email}, {languages}, {code}');</script>");

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(workspaceID))
            {
                System.Diagnostics.Debug.WriteLine("Email or WorkspaceID is null or empty.");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["CollaborativeCodeEditor"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string updateQuery = @"
            UPDATE Workspaces
            SET ProgrammingLanguage = @ProgrammingLanguage,
                CodeSnippet = @CodeSnippet
            WHERE WorkspaceID = @WorkspaceID AND Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProgrammingLanguage", languages ?? string.Empty);
                        cmd.Parameters.AddWithValue("@CodeSnippet", code ?? string.Empty);
                        cmd.Parameters.AddWithValue("@WorkspaceID", workspaceID);
                        cmd.Parameters.AddWithValue("@Email", email);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine(rowsAffected > 0
                            ? "Record updated successfully."
                            : "No matching record to update.");
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error in SaveButton_Click: " + ex.Message);
                }
            }
        }
    }
}
