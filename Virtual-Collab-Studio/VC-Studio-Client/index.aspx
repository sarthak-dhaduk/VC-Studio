<%@ Page Title="index" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="VC_Studio_Client.index" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link href="assets/css/indexcodeeditor.css" rel="stylesheet" />
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header d-flex justify-content-center align-items-center"
                style="background-color: #0D0F10; border-radius: 20px 20px 0px 0px;">
                <!-- Add Post Button -->
                <div class="row w-100">
                    <div class="col-8 d-flex justify-content-end align-items-center">
                        <div class="d-flex justify-content-center align-items-center">
                            <asp:Button class="btn d-flex align-items-center text-light" data-bs-toggle="modal"
                                data-bs-target="#addpostmodal"
                                Style="border-color: #0D0F10; border-radius: 16px; appearance: none; outline: none; box-shadow: inset 0 0 10px rgba(255, 255, 255, 0.1); padding: 9px 14px;">
                                <span style="color: #686B6E; font-size: 16px; padding-top: 2.5px;">Add Post</span>
                                <div class="ms-2">
                                    <svg width="18" height="18" viewBox="0 0 20 20" fill="none"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M10 6V10M10 10V14M10 10H14M10 10H6M19 10C19 14.9706 14.9706 19 10 19C5.02944 19 1 14.9706 1 10C1 5.02944 5.02944 1 10 1C14.9706 1 19 5.02944 19 10Z"
                                            stroke="#686B6E" stroke-width="1.5" stroke-linecap="round" />
                                    </svg>
                                </div>
                            </asp:Button>
                            <div class="">
                                <style>
                                    .custom-dropdown {
                                        width: 220px;
                                        border-radius: 16px;
                                        padding: 12px 15px;
                                        background-color: #0D0F10;
                                        border: none;
                                        color: #fff;
                                        font-size: 16px;
                                        font-family: 'Arial', sans-serif;
                                        appearance: none;
                                        outline: none;
                                        box-shadow: inset 0 0 10px rgba(255, 255, 255, 0.1); /* Inner white shadow */
                                        cursor: pointer;
                                        position: relative;
                                    }

                                        /* Style the dropdown options */
                                        .custom-dropdown option {
                                            background-color: #0D0F10; /* Menu color */
                                            color: #fff;
                                            padding: 10px 15px;
                                            font-size: 16px;
                                            text-align: left;
                                            box-shadow: inset 50px 50px 50px rgba(255, 255, 255, 100); /* Simulating inner shadow */
                                            cursor: pointer;
                                        }

                                            /* Hover effect for options */
                                            .custom-dropdown option:hover {
                                                background: linear-gradient(90deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0));
                                                color: #fff;
                                            }

                                    /* Remove the scrollbar for dropdown */
                                    .custom-dropdown {
                                        scrollbar-width: none; /* For Firefox */
                                    }

                                        .custom-dropdown::-webkit-scrollbar {
                                            display: none; /* For Chrome, Safari, and Edge */
                                        }
                                </style>
                                <select id="languageDropdown" class="custom-dropdown ms-3">
                                    <option value="python">Python</option>
                                    <option value="javascript">JavaScript</option>
                                    <option value="csharp">C#</option>
                                    <option value="java">Java</option>
                                    <option value="cpp">C++</option>
                                    <option value="ruby">Ruby</option>
                                    <option value="go">Go</option>
                                    <option value="swift">Swift</option>
                                    <option value="rust">Rust</option>
                                    <option value="kotlin">Kotlin</option>
                                    <option value="php">PHP</option>
                                    <option value="sql">SQL</option>
                                    <option value="bash">Shell</option>
                                    <option value="haskell">Haskell</option>
                                    <option value="scala">Scala</option>
                                    <option value="perl">Perl</option>
                                    <option value="lua">Lua</option>
                                </select>
                            </div>
                            <button class="btn d-flex ms-3 align-items-center text-light run-btn"
                                style="border-color: #0D0F10; border-radius: 16px; appearance: none; outline: none; box-shadow: inset 0 0 10px rgba(255, 255, 255, 0.1); padding: 9px 14px;"
                                id="showRunButton">
                                <span style="color: #686B6E; font-size: 16px; padding-top: 2.5px;">Run</span>
                                <div class="ms-2">
                                    <svg width="18" height="18" viewBox="0 0 20 20" fill="none"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M1 4.07381V15.9262C1 18.208 3.4464 19.6545 5.44576 18.5548L17.8138 11.7524C19.1953 10.9926 19.1953 9.00742 17.8138 8.24757L5.44575 1.44516C3.4464 0.345517 1 1.79201 1 4.07381Z"
                                            stroke="#686B6E" stroke-width="1.5" stroke-linecap="round" />
                                    </svg>
                                </div>
                            </button>
                        </div>
                    </div>
                    <div class="col-4 d-flex justify-content-end">
                        <div class="d-flex justify-content-center align-items-center">
                            <asp:HiddenField ID="activeCode" runat="server" />
                            <asp:HiddenField ID="activeLanguage" runat="server" />
                            <input type="hidden" id="clientSuccess" name="clientSuccess" value="false" />
                            <!-- MasterPage markup -->
                            <div id="insideSave" class="d-flex justify-content-end">
                                <asp:PlaceHolder ID="saveWorkSpaceChanges" runat="server"></asp:PlaceHolder>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-body w-100 h-75">
                <div class="ms-2">

                    <div id="codeEditor"></div>

                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-12 d-none" id="hideThisDiv"
        style="overflow: hidden; max-height: calc(100vh - 100px);">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center" style="background-color: #0D0F10; border-radius: 20px 20px 0px 0px;">
                <ul class="nav nav-tabs nav-tabs-bordered" id="borderedTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="output" data-bs-toggle="tab"
                            data-bs-target="#bordered-home" type="button" role="tab"
                            aria-controls="home" aria-selected="true">
                            Output</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="input" data-bs-toggle="tab"
                            data-bs-target="#bordered-profile" type="button" role="tab"
                            aria-controls="profile" aria-selected="false" tabindex="-1">
                            Input</button>
                    </li>
                </ul>
                <button type="button" style="width: 3rem;" class="btn-close btn-close-white" aria-label="Close"
                    id="closeButton">
                </button>
            </div>

            <div class="card-body" style="min-height: 12rem;">
                <div class="ms-2">
                    <div class="tab-content pt-2" id="borderedTabContent">
                        <div class="tab-pane fade show active" id="bordered-home" role="tabpanel"
                            aria-labelledby="output">
                            <textarea id="outputBox" class="custom-code-editor text-white" readonly placeholder="Output will appear here..."></textarea>
                        </div>
                        <div class="tab-pane fade" id="bordered-profile" role="tabpanel"
                            aria-labelledby="input">
                            <textarea id="stdinBox" class="custom-code-editor text-white" placeholder="Enter input for your code here..."></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="AfterSection" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="footer" runat="server">
    <a href="#" class="back-to-top d-flex align-items-center justify-content-center gradient-button"><i
        class="bi bi-arrow-up-short"></i></a>
</asp:Content>

