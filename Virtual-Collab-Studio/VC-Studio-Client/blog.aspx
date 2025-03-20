<%@ Page Title="blog" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="blog.aspx.cs" Inherits="VC_Studio_Client.blog" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="assets/css/blogcodeeditor.css" rel="stylesheet" />

    <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>
    <asp:Repeater ID="rptBlogs" runat="server" OnItemDataBound="rptBlogs_ItemDataBound">
        <ItemTemplate>
            <div class="col-lg-12 userblogwrapper">
                <asp:HiddenField ID="hfBlogId" runat="server" Value='<%# Eval("BlogId") %>' />
                <input type="hidden" class="userUniqueId" value="<%# Eval("BlogId") %>" />
                <div class="card">
                    <div class="card-header d-flex mx-3 justify-content-between align-items-center"
                        style="background-color: #0D0F10; border-radius: 20px 20px 0px 0px;">
                        <div class="d-flex align-items-center fw-bolder p-3">
                            <div class="d-flex justify-content-center align-items-center text-white rounded-circle me-2 session-based-div"
                                style="width: 40px; height: 40px;">
                                <%# Eval("Email").ToString().Length > 0 ? Eval("Email").ToString().Substring(0, 1).ToUpper() : "U" %>
                            </div>

                            <div>
                                <%# Eval("Email") %>
                            </div>
                        </div>


                        <div class="d-flex align-items-start p-3">
                            <asp:Label ID="lblRating" Style="margin-top: 1px;" runat="server" CssClass="text-white me-2" Text="0.0"></asp:Label>

                            <div class="ms-3">
                                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M8.08094 1.64069C8.42102 0.786437 9.57934 0.786437 9.91943 1.64069L11.4 5.35972C11.5434 5.71985 11.8676 5.96591 12.2397 5.99708L16.0827 6.31896C16.9655 6.39289 17.3234 7.54381 16.6509 8.1457L13.7229 10.7661C13.4393 11.0198 13.3155 11.4179 13.4021 11.7973L14.2967 15.7153C14.5022 16.6152 13.5651 17.3265 12.8093 16.8443L9.51914 14.7447C9.20053 14.5414 8.79983 14.5414 8.48123 14.7447L5.19104 16.8443C4.43529 17.3265 3.4982 16.6152 3.70367 15.7153L4.59822 11.7973C4.68485 11.4179 4.56102 11.0198 4.27749 10.7661L1.34949 8.1457C0.676938 7.54381 1.03488 6.39289 1.91762 6.31896L5.76067 5.99708C6.13281 5.96591 6.45698 5.71985 6.60035 5.35972L8.08094 1.64069Z"
                                        stroke="#686B6E" stroke-width="1.5" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="card-body w-100 h-75">
                        <div class="ms-2">
                            <div class="card-body d-flex flex-wrap align-items-stretch">
                                <!-- Blog Content -->
                                <div class="col-md-6 pe-md-3 d-flex flex-column flex-grow-1">
                                    <div class="code-editor mt-3" style="position: relative; border-radius: 12px;">
                                        <header
                                            style="display: flex; justify-content: space-between; align-items: center; background-color: #191919; border-radius: 12px 12px 0 0;">
                                            <h5 style="margin: 0; color: white;"></h5>
                                            <button class="btn btn-sm" style="color: #686B6E;" onclick="copyToClipboard(this)">
                                                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                                    xmlns="http://www.w3.org/2000/svg">
                                                    <path
                                                        d="M14.5 6H15C16.1046 6 17 6.89543 17 8V15C17 16.1046 16.1046 17 15 17H8C6.89543 17 6 16.1046 6 15V14.5M3 12H10C11.1046 12 12 11.1046 12 10V3C12 1.89543 11.1046 1 10 1H3C1.89543 1 1 1.89543 1 3V10C1 11.1046 1.89543 12 3 12Z"
                                                        stroke="#686B6E" stroke-width="1.5" stroke-linecap="round"
                                                        stroke-linejoin="round" />
                                                </svg>
                                                Copy Code
               
                                            </button>
                                        </header>
                                        <div>
                                            <pre style="display: flex; align-items: flex-start; margin: 0px;">
                                                <div class="lineNumbers" style="text-align: right; margin-right: 10px; color: #FFFF; border-right: 1px solid gray; padding-left: 10px; padding-right: 10px;"></div>
                                                <code  class="codecontent" style="color: #FFFF; overflow: auto; overflow-x:hidden;">
                                                    <%# Eval("CodeSnippet").ToString().Trim().Replace("\r\n\t", "") %>
                                                </code>
                                            </pre>

                                        </div>

                                        <footer
                                            style="background-color: #191919; color: white; border-radius: 0 0 12px 12px; text-align: center; padding: 10px;">
                                        </footer>
                                    </div>
                                </div>

                                <!-- Accordion Section -->
                                <div class="col-md-6 mt-3 d-flex flex-column flex-grow-1">
                                    <!-- Description Accordion -->
                                    <div class="accordion-container" style="flex-grow: 1; display: flex; flex-direction: column;">
                                        <h5 class="text-white mb-0 p-4"><%# Eval("Title") %></h5>
                                        <hr class="my-1" />
                                        <!-- Description Accordion -->
                                        <div class="accordion shiny" id="accordionDescription">
                                            <div class="accordion-item" style="border-radius: 20px;">
                                                <h2 class="accordion-header" id="headingDescription" style="border-radius: 20px;">

                                                    <button class="accordion-button" type="button" style="border-radius: 20px 20px 0px 0px;"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#collapseDescription<%# Container.ItemIndex %>"
                                                        aria-expanded="true" aria-controls="collapseDescription<%# Container.ItemIndex %>">
                                                        <i class="bi bi-chevron-down accordion-icon"></i>
                                                        <span class="ms-2">Description</span>
                                                    </button>

                                                </h2>
                                                <div id="collapseDescription<%# Container.ItemIndex %>"
                                                    class="accordion-collapse collapse show">
                                                    <div class="accordion-body">
                                                        <%# Eval("Description") %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Review Accordion -->
                                        <div class="accordion" id="accordionReview" style="border-radius: 0px 0px 22px 22px;">
                                            <div class="accordion-item" style="border-radius: 0px 0px 22px 22px;">
                                                <h2 class="accordion-header" style="border-radius: 0px 0px 22px 22px;">


                                                    <button class="accordion-button" type="button" style="border-radius: 0px 0px 22px 22px;"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#collapseReview<%# Container.ItemIndex %>"
                                                        aria-expanded="true" aria-controls="collapseReview<%# Container.ItemIndex %>">
                                                        <i class="bi bi-chevron-down accordion-icon"></i>

                                                        <span class="ms-2">Review</span>
                                                    </button>



                                                </h2>
                                                <div id="collapseReview<%# Container.ItemIndex %>"
                                                    class="accordion-collapse collapse show" style="border-radius: 0px 0px 22px 22px;">
                                                    <div class="accordion-body">
                                                        <ul id="reviewsList" class="list-unstyled" runat="server">
                                                            <asp:Repeater ID="rptReviews" runat="server">
                                                                <ItemTemplate>
                                                                    <li class="d-flex align-items-center mb-2 p-3">
                                                                        <div class="d-flex justify-content-center align-items-center text-white rounded-circle me-2 session-based-div"
                                                                            style="width: 40px; height: 40px;">
                                                                            <%# Eval("UserName").ToString().Length > 0 ? Eval("UserName").ToString().Substring(0, 1).ToUpper() : "U" %>
                                                                        </div>
                                                                        <div>
                                                                            <strong><%# Eval("UserName") %></strong>
                                                                            <div id="rating" class="d-flex align-items-start justify-content-center w-100">
                                                                                <%# GetStars(Eval("RatingValue")) %>
                                                                            </div>
                                                                        </div>
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:Repeater>

                                                            <li class="d-flex align-items-center p-3">
                                                                <asp:LinkButton ID="lnkAddReview" runat="server" class="btn d-flex align-items-center text-light"
                                                                    Style="background-color: #0D0F10; border-color: #0D0F10; margin: auto; padding: revert-layer;" CssClass="btn btn-light"
                                                                    CommandName="AddReview" CommandArgument='<%# Eval("BlogId") %>' OnClientClick="return openModal('addreviewmodal', this);">
                                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M10 6V10M10 10V14M10 10H14M10 10H6M19 10C19 14.9706 14.9706 19 10 19C5.02944 19 1 14.9706 1 10C1 5.02944 5.02944 1 10 1C14.9706 1 19 5.02944 19 10Z"
                                                stroke="#686B6E" stroke-width="1.5"
                                                stroke-linecap="round" />
                                        </svg>
                                        <span class="ms-2" style="color: #686B6E; font-size: 14px;"> Add Review</span>
                                    </asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AfterSection" runat="server">
    <div class="modal fade" id="addreviewmodal" tabindex="-1" aria-labelledby="addreviewmodalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addreviewmodalLabel">Rate This Post!</h5>

                    <button type="button" class="btn-close" style="filter: invert(1);" data-bs-dismiss="modal"
                        aria-label="Close">
                    </button>

                </div>
                <div class="modal-body">
                    <input type="hidden" name="userblogId" id="userblogId" />

                    <span style="color: #9B9C9E; font-size: 14px;">Rate this post to provide feedback and guide the community toward valuable content.</span>
                    <div class="input-field mt-2 d-flex flex-column align-items-start">
                        <!-- Label -->
                        <label for="rating" class="mb-2" style="color: #9B9C9E; font-size: 14px;">Set Your Rating</label>

                        <!-- Rating Field (Stars) -->
                        <div id="rating" class="d-flex align-items-center justify-content-center p-2 w-100">
                            <!-- 5 star rating system -->
                            <span class="star" data-value="1">&#9733;</span>
                            <span class="star" data-value="2">&#9733;</span>
                            <span class="star" data-value="3">&#9733;</span>
                            <span class="star" data-value="4">&#9733;</span>
                            <span class="star" data-value="5">&#9733;</span>
                        </div>
                        <input type="hidden" id="ratingValue" name="ratingValue" value="0">

                        <!-- Cancel and Submit Buttons -->
                        <div class="mt-2 d-flex justify-content-center w-100">
                            <button class="btn gradient-button" type="button" style="border-radius: 12px;">
                                Cancel
                            </button>
                            <asp:LinkButton type="button" class="btn btn-sm ms-3 text-center" OnClick="SubmitRating" runat="server"
                                Style="background-color: #7DEA4D; color: #0C1132; border-color: #7DEA4D; height: 3rem; border-radius: 12px;">
                                Submit
                            
                                <svg width="35" height="33" viewBox="0 0 35 33" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="0.5" y="0.5" width="34" height="32" rx="12" fill="#1C1C1E" />
                                    <path
                                        d="M17.3 7.5L20.3593 13.0227L26.3 14.3754L22.25 19.1413L22.8624 25.5L17.3 22.9227L11.7377 25.5L12.35 19.1413L8.30005 14.3754L14.2408 13.0227L17.3 7.5Z"
                                        fill="#7DEA4D" />
                                </svg>


                            </asp:LinkButton>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <style>
        
    </style>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="footer" runat="server">
    <script>
        function copyToClipboard(button) {
            const codeElement = document.querySelector('pre code');
            const codeText = codeElement.textContent;
            navigator.clipboard.writeText(codeText)
                .then(() => {
                    button.textContent = 'Copied'; // Update button text to 'Copied'
                    const svgIcon = button.querySelector('svg');
                    svgIcon.style.display = 'none'; // Hide the SVG icon
                    setTimeout(() => {
                        button.textContent = 'Copy Code'; // Reset button text after 2 seconds
                        svgIcon.style.display = 'block'; // Show the SVG icon again
                    }, 2000); // Reset after 2 seconds
                })
                .catch(err => {
                    console.error('Failed to copy code: ', err);
                });
        }

    </script>
    <!-- ======= Footer ======= -->
    <a href="#" class="back-to-top d-flex align-items-center justify-content-center gradient-button"><i
        class="bi bi-arrow-up-short"></i></a>
</asp:Content>
