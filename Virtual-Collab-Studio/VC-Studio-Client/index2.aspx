<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index2.aspx.cs" Inherits="VC_Studio_Client.index2" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- <link href="../content/bootstrap.min.css" rel="stylesheet" /> -->

    <link
    href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
    rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">

    <link href="assets/css/style.css" rel="stylesheet">

    

    <!-- <script src="../scripts/bootstrap.bundle.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script> -->
    <link rel="icon" href="../assets/icons/icon2.svg" type="image/svg+xml">
    <script src="../assets/js/script.main.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="d-flex vh-100">
    <div class="sidebar-container d-flex flex-column bg-dark vh-100">
      <aside id="sidebar" class="sidebar">
        <ul class="sidebar-nav" id="sidebar-nav">
          <!-- Logo Section -->
          <li class="nav-item text-center mb-4">
            <img src="assets/image/MainLogo.svg" alt="VC Studio Logo" class="img-fluid mb-2" style="max-width: 12rem;" />
          </li><!-- End Logo Section -->

          <!-- General Links -->
          <li class="nav-heading">General</li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="index.html">
              <i class="bi bi-search me-2"></i>
              <span>Search</span>
              <kbd class="ms-auto">⌘ S</kbd>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-file-earmark-text me-2"></i> Blog
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-info-circle me-2"></i> About
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-telephone me-2"></i> Contact
            </a>
          </li>

          <!-- Members Section -->
          <li class="nav-heading">Members</li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-person-circle me-2"></i> Sarthak Dhaduk
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-person-circle me-2"></i> Yash Lalani
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-person-circle me-2"></i> Kalariya Jigar
            </a>
          </li>

          <!-- Workspace Section -->
          <li class="nav-heading d-flex justify-content-between align-items-center">
            Workspace
            <button class="btn btn-sm d-flex align-items-center text-light"
              style="background-color: rgb(33, 37, 41); border: none; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
              <span style="color: rgb(155, 156, 158);">JOIN</span>
            </button>
          </li>



          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center" href="#">
              <i class="bi bi-square" style="color:#B6F09C"></i> 12IJKM37
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
              <i class="bi bi-square" style="color:#B6F09C"></i> 985US4X
            </a>
          </li>
          <li class="nav-item">
            <button class="btn d-flex align-items-center text-light"
              style="background-color: #0D0F10; border-color: #0D0F10;margin: auto;padding: revert-layer;">
              <i class="bi bi-plus-circle me-2" style="color:#686B6E;"></i>
              <span style="color:#686B6E;">Create New Workspace</span>
            </button>
          </li>

          <!-- Footer Section (sticking to bottom) -->
          <li class="mt-auto">
            <div class="nav-link text-light d-flex align-items-center p-2"
              style="height: 60px; margin-top: 3rem; position: relative;">
              <div class="bg-primary text-center text-white rounded-circle me-2" style="width: 40px; height: 40px;">
                J
              </div>
              <div>
                <strong>Jigar Kalariya</strong>
                <small class="text-muted d-block">Dev</small>
              </div>
              <div class="dropdown dropup ms-auto">
                <i class="bi bi-gear" id="settingsDropdown" data-bs-toggle="dropdown" aria-expanded="false"
                  style="cursor: pointer;"></i>
                <ul class="dropdown-menu custom-dropdown">
                  <li class="dropdown-item-wrapper">
                    <a class="dropdown-item d-flex justify-content-between align-items-center" href="#">
                      <span>Profile Settings</span>
                      <i class="bi bi-person"></i> <!-- Icon at the end -->
                    </a>
                  </li>
                  <li class="dropdown-item-wrapper">
                    <a class="dropdown-item d-flex justify-content-between align-items-center" href="#">
                      <span>Logout</span>
                      <i class="bi bi-box-arrow-right"></i> <!-- Icon at the end -->
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </li>



        </ul>
      </aside>
    </div>

    <main id="main" class="main flex-grow-1">
      <!-- <i class="bi bi-list toggle-sidebar-btn"></i> -->
      <section class="section">
        <div class="row align-items-top">

          <div class="col-lg-12">
            <div class="card">
              <div class="card-header d-flex justify-content-center align-items-center"
                style="background-color: #0D0F10;">
                <!-- Add Post Button -->
                <asp:button class="btn d-flex align-items-center text-light" data-bs-toggle="modal"
                  data-bs-target="#addpostmodal" style="background-color: #0D0F10; border-color: #0D0F10;">
                  <span style="color:#686B6E;">Add Post</span>
                  <i class="bi bi-plus-circle ms-2" style="color:#686B6E;"></i>
                </asp:button>

                <!-- Language Selector -->
                <select class="form-select w-auto ms-2 text-light"
                  style="background-color: #0D0F10; border-color: #0D0F10; color:#686B6E;">
                  <option value="python">Python</option>
                  <option value="javascript">JavaScript</option>
                  <option value="java">Java</option>
                  <option value="csharp">C#</option>
                  <option value="ruby">Ruby</option>
                  <option value="php">PHP</option>
                  <i class="bi bi-chevron-down ms-2" style="color:#686B6E;"></i>
                </select>

                <button class="btn d-flex ms-2 align-items-center text-light"
                  style="background-color: #0D0F10; border-color: #0D0F10;">
                  <span style="color:#686B6E;">Run</span>
                  <i class="bi bi-play-circle ms-2" style="color:#686B6E;"></i>
                </button>
              </div>

              <div class="card-body w-100 h-75">

                <div class="ms-2">
                  <textarea class="form-control" placeholder="Enter your code snippet here..."
                    style="background-color: #0D0F10; border-color: #0D0F10; color:#686B6E; min-height: 22.4rem; max-height: 22.4rem; resize: none;">
                  </textarea>
                </div>
              
              </div>
            </div>
          </div>

          <div class="col-lg-12">
            <div class="card">
              <div class="card-header d-flex justify-content-start align-items-center"
                style="background-color: #0D0F10;">
                <ul class="nav nav-tabs nav-tabs-bordered" id="borderedTab" role="tablist">
                  <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="output" data-bs-toggle="tab" data-bs-target="#bordered-home"
                      type="button" role="tab" aria-controls="home" aria-selected="true">Output</button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="input" data-bs-toggle="tab" data-bs-target="#bordered-profile"
                      type="button" role="tab" aria-controls="profile" aria-selected="false"
                      tabindex="-1">Input</button>
                  </li>
                </ul>
              </div>

              <div class="card-body w-100 h-75">
                <div class="ms-2">
                  <div class="ms-2">
                    <div class="tab-content pt-2" id="borderedTabContent">
                      <div class="tab-pane fade show active" id="bordered-home" role="tabpanel"
                        aria-labelledby="output">
                        <p class="text-white font-weight-bold">
                          Hello World!
                        </p>
                      </div>
                      <div class="tab-pane fade" id="bordered-profile" role="tabpanel" aria-labelledby="input">
                        <p class="text-white font-weight-bold">
                          > Hello World!
                        </p>
                      </div>
                    </div>

                  </div>

                </div>
              </div>
            </div>

          </div>

        </div>
      </section>
      <div class="modal fade" id="addpostmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content" style="background-color: #1A1D21;">
            <div class="modal-header" style="border-bottom: none;">
              <h5 class="modal-title" id="exampleModalLabel">Add New Post</h5>
              <button type="button" class="btn-close" style="color: #686B6E;" data-bs-dismiss="modal"
                aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form class="row g-3">
                <div class="col-12">
                  <label for="inputNanme4" class="form-label">Your Name</label>
                  <input type="text" class="form-control" id="inputNanme4">
                </div>
                <div class="col-12">
                  <label for="inputEmail4" class="form-label">Email</label>
                  <input type="email" class="form-control" id="inputEmail4">
                </div>
              </form>
            </div>
            <div class="modal-footer" style="border-top: none;">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary"
                style="background-color: #7DEA4D; border-color: #7DEA4D;">Save</button>
            </div>
          </div>
        </div>
      </div>

    </main>
  </div>
    </form>
  
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/quill/quill.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <script src="assets/js/main.js"></script>
</body>

</html>
