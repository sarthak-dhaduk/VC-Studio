<%@ Page Title="contact" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="VC_Studio_Client.contact" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-12">
        <div class="card">

            <div class="card-body text-start d-flex justify-content-center">
                <!-- Remove the extra <form> -->

                <div class="p-3 w-50 h-25">
                    <div class="text-container text-start w-100">
                        <h2 style="color: #FFFFFF;">Get in Touch <span class="gradient-text">with Us!</span>
                        </h2>
                        <span class="mt-2 text-start" style="color: #9B9C9E;">We’d love to hear from you! Whether you have questions, feedback, or suggestions, feel free to reach out.
                    </span>
                    </div>
                    <div class="row g-3 mt-3">
                        <div class="col-md-6 custom-input-field">
                            <asp:Label CssClass="form-label text-secondary" AssociatedControlID="FullName" Text="Full Name" runat="server"></asp:Label>
                            <asp:TextBox ID="FullName" CssClass="form-control" Placeholder="Enter full name" runat="server" Required="true" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6 custom-input-field">
                            <asp:Label CssClass="form-label text-secondary" AssociatedControlID="Email" Text="Email Id" runat="server"></asp:Label>
                            <asp:TextBox ID="Email" CssClass="form-control" Placeholder="Enter your registered email" TextMode="Email" runat="server" Required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6 custom-input-field">
                            <asp:Label CssClass="form-label text-secondary" AssociatedControlID="Mobile" Text="Mobile No." runat="server"></asp:Label>
                            <asp:TextBox ID="Mobile" CssClass="form-control" Placeholder="Mobile No." TextMode="Phone" runat="server" Required="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label CssClass="form-label text-secondary" AssociatedControlID="Subject" Text="Subject" runat="server"></asp:Label>
                            <asp:DropDownList ID="Subject" CssClass="form-select custom-select-button w-100" runat="server">
                                <asp:ListItem Text="Select" Value="" />
                                <asp:ListItem Text="General Inquiry" Value="General Inquiry" />
                                <asp:ListItem Text="Feature Request" Value="Feature Request" />
                                <asp:ListItem Text="Feedback" Value="Feedback" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12 custom-input-field">
                            <asp:Label CssClass="form-label text-secondary" AssociatedControlID="Message" Text="Message" runat="server"></asp:Label>
                            <asp:TextBox ID="Message" CssClass="form-control w-50" TextMode="MultiLine" Rows="4" Placeholder="Type your message here..." runat="server" Required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center text-center mt-4">
                        <asp:LinkButton runat="server" ID="s" OnClick="SendEmail"
                            class="btn-sm gradient-button" Style="background-color: #7DEA4D; color: #0C1132; border-color: #7DEA4D; height: 3rem; border-radius: 12px;">
                            Send Message
    <svg width="34" class="ms-2" height="32" viewBox="0 0 34 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect width="34" height="32" rx="12" fill="#1C1C1E" />
        <path
            d="M14.2308 18.2692L23.7337 8.76642M9.98664 11.9981L21.6349 8.11532C23.3344 7.54883 24.9512 9.16564 24.3847 10.8651L20.5019 22.5134C19.8895 24.3507 17.3613 24.5304 16.4952 22.7981L14.5548 18.9174C14.3445 18.4967 14.0033 18.1555 13.5826 17.9452L9.70188 16.0048C7.96962 15.1387 8.14929 12.6105 9.98664 11.9981Z"
            stroke="#7DEA4D" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
    </svg>
                        </asp:LinkButton>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="AfterSection" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="footer" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const dropdownItems = document.querySelectorAll('.dropdown-item-contact');

            dropdownItems.forEach(item => {
                item.addEventListener('click', function () {
                    const selectedValue = item.getAttribute('data-value');
                    const button = document.querySelector('.custom-select-button');
                    button.textContent = selectedValue;
                });
            });
        });

    </script>
    <!-- ======= Footer ======= -->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center gradient-button"><i
        class="bi bi-arrow-up-short"></i></a>
</asp:Content>
