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

                string svgHtml = @"<svg fill=""none"" height=""24"" viewBox=""0 0 24 24"" width=""24"" xmlns=""http://www.w3.org/2000/svg"">
  <g fill=""#686B6E"">
    <path d=""m15 22.75h-6c-5.43 0-7.75-2.32-7.75-7.75v-6c0-5.43 2.32-7.75 7.75-7.75h6c5.43 0 7.75 2.32 7.75 7.75v6c0 5.43-2.32 7.75-7.75 7.75zm-6-20c-4.61 0-6.25 1.64-6.25 6.25v6c0 4.61 1.64 6.25 6.25 6.25h6c4.61 0 6.25-1.64 6.25-6.25v-6c0-4.61-1.64-6.25-6.25-6.25z""/>
    <path d=""m8.68 15.3299c-.42 0-.81-.1-1.15-.29-.83-.47-1.28-1.4-1.28-2.62v-9.97996c0-.41.34-.75.75-.75s.75.34.75.75v9.97996c0 .65.19 1.13.52 1.31.35.2.89.1 1.48-.25l1.32-.79c.54-.32 1.31-.32 1.85 0l1.32.79c.6.36 1.14.45 1.48.25.33-.19.52-.67.52-1.31v-9.97996c0-.41.34-.75.75-.75s.75.34.75.75v9.97996c0 1.22-.45 2.15-1.28 2.62s-1.92.37-2.99-.27l-1.32-.79c-.06-.04-.25-.04-.31 0l-1.32.79c-.62.37-1.26.56-1.84.56z""/>
    <path d=""m15 22.75h-6c-5.43 0-7.75-2.32-7.75-7.75v-6c0-5.43 2.32-7.75 7.75-7.75h6c5.43 0 7.75 2.32 7.75 7.75v6c0 5.43-2.32 7.75-7.75 7.75zm-6-20c-4.61 0-6.25 1.64-6.25 6.25v6c0 4.61 1.64 6.25 6.25 6.25h6c4.61 0 6.25-1.64 6.25-6.25v-6c0-4.61-1.64-6.25-6.25-6.25z""/>
    <path d=""m8.68 15.3299c-.42 0-.81-.1-1.15-.29-.83-.47-1.28-1.4-1.28-2.62v-9.97996c0-.41.34-.75.75-.75s.75.34.75.75v9.97996c0 .65.19 1.13.52 1.31.35.2.89.1 1.48-.25l1.32-.79c.54-.32 1.31-.32 1.85 0l1.32.79c.6.36 1.14.45 1.48.25.33-.19.52-.67.52-1.31v-9.97996c0-.41.34-.75.75-.75s.75.34.75.75v9.97996c0 1.22-.45 2.15-1.28 2.62s-1.92.37-2.99-.27l-1.32-.79c-.06-.04-.25-.04-.31 0l-1.32.79c-.62.37-1.26.56-1.84.56z""/>
  </g>
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
