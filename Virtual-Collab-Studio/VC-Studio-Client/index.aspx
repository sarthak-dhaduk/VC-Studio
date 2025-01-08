<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="VC_Studio_Client.index" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../content/bootstrap.min.css" rel="stylesheet" />
    <script src="../scripts/bootstrap.bundle.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <link rel="icon" href="../assets/icons/icon2.svg" type="image/svg+xml">
    <script src="../assets/js/script.main.js"></script>

    <title>VC-Studio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #131619;
            margin: 0;
            padding: 0;
        }
        /* Initial state - scrollbar hidden */
        ::-webkit-scrollbar {
          width: 4px;
          height: 12px;
          opacity: 0; /* Hidden by default */
          transition: opacity 0.3s ease; /* Smooth transition for visibility */
        }

        ::-webkit-scrollbar-track {
          background: #00ffff00;
          margin-top: 10px;
        }

        ::-webkit-scrollbar-thumb {
          border-radius: 12px;
          background: #555;
        }

        /* When scrolling */
        .scroll-visible ::-webkit-scrollbar {
          opacity: 1; /* Visible while scrolling */
        }

        .sidebar {
            background-color: #0D0F10;
            height: 100vh;
            position: fixed;
            width: 250px;
            transition: all 0.3s;
            overflow-y: auto;
            border-radius: 12px;
            margin: 12px;
        }
        .sidebar.collapsed {
            width: 70px;
        }
        .sidebar-header {
            text-align: center;
            padding: 15px;
            color: white;
            border-bottom: 1px solid #1C1F20;
        }
        .sidebar-header img {
            width: 40px;
            margin-bottom: 10px;
        }
        .menu-item {
            padding: 15px;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s;
        }
        .menu-item:hover {
            background-color: #1C1F20;
        }
        .section-dropdown{
            border-bottom: 1px solid #1C1F20;
        }
        .menu-dropdown .submenu {
            margin-left: 15px;
            display: none;
        }
        .menu-dropdown.open .submenu {
            display: block;
        }
        .join-btn {
            height: 30px;
            margin-top: 12px;
            margin-right: 12px;
        }
        .user-box {
            margin: 15px;
            padding: 10px;
            background-color: #1C1F20;
            border-radius: 10px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .user-box img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }
        .user-info {
            margin-left: 10px;
            flex-grow: 1;
        }
        .toggle-btn {
            display: none;
            font-size: 24px;
            color: white;
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 1000;
            cursor: pointer;
        }
        .main-container {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }
        .main-container.collapsed {
            margin-left: 70px;
        }
        .main-card, .terminal-card {
            background-color: #0D0F10;
            color: white;
            border-radius: 10px;
            padding: 15px;
        }
        .terminal-card {
            display: none;
        }
        .terminal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .terminal-tabs {
            display: flex;
            gap: 10px;
        }
        .terminal-tabs button {
            background: none;
            color: white;
            border: none;
            cursor: pointer;
            padding: 5px 10px;
            border-bottom: 2px solid transparent;
        }
        .terminal-tabs button.active {
            border-bottom: 2px solid #00d1b2;
        }
        @media screen and (max-width: 768px) {
            .sidebar {
                position: absolute;
                transform: translateX(-100%);
                z-index: 1000;
            }
            .sidebar.open {
                transform: translateX(0);
            }
            .toggle-btn {
                display: block;
            }
            .main-container {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <i class="fas fa-bars toggle-btn align-content-end" onclick="toggleSidebar()"></i>
    <div class="sidebar">
        <!-- Sidebar Header -->
        <div class="sidebar-header">
            <img src="../assets/icons/icon2.svg" alt="Website Icon">
            <h5>VC Studio</h5>
            <small>Virtual Collab Studio</small>
        </div>

        <!-- GENERAL Section -->
        <div class="menu-dropdown section-dropdown open">
            <div class="menu-item" onclick="toggleMenu(this)">
                GENERAL
            </div>
            <div class="submenu">
                <a href="blog.aspx" class="menu-item"><i class="fas fa-search"></i> Search</a>
                <a href="blog.aspx" class="menu-item"><i class="fas fa-blog"></i> Blog</a>
                <a href="about.aspx" class="menu-item"><i class="fas fa-info-circle"></i> About</a>
                <a href="contact.aspx" class="menu-item"><i class="fas fa-phone"></i> Contact</a>
            </div>
        </div>

        <!-- MEMBERS Section -->
        <div class="menu-dropdown section-dropdown open">
            <div class="menu-item" onclick="toggleMenu(this)">
                MEMBERS
            </div>
            <div class="submenu">
                <div class="menu-item"><i class="fas fa-user"></i> Sarthak Dhaduk</div>
                <div class="menu-item"><i class="fas fa-user"></i> Yash Lalani</div>
                <div class="menu-item"><i class="fas fa-user"></i> Kalariya Jigar</div>
            </div>
        </div>

        <!-- WORKSPACE Section -->
        <div class="d-flex justify-content-between section-dropdown">
            <div class="menu-dropdown open">
            <div class="menu-item" onclick="toggleMenu(this)">
                <span>WORKSPACE</span>
            </div>
            <div class="submenu">
                <div class="menu-item">
                    121JKM37
                </div>
                <div class="menu-item"><i class="fas fa-history"></i> Created Workspaces</div>
                <div class="menu-item"><i class="fas fa-plus"></i> Create Workspace</div>
            </div>
        </div>
            <button class="btn btn-sm btn-success join-btn" >JOIN</button>
        </div>

        <!-- User Box -->
        <div class="user-box">
            <img src="../assets/icons/icon2.svg" alt="User">
            <div class="user-info">
                <strong>Sarthak Dhaduk</strong>
                <small>Developer</small>
            </div>
            <i class="fas fa-cog"></i>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Main Card -->
        <div class="main-card">
            <div class="d-flex justify-content-between">
                <button class="btn btn-primary">Add Post</button>
                <select class="form-select w-auto">
                    <option>Select Language</option>
                </select>
                <button class="btn btn-success" onclick="toggleTerminal()">Run Code</button>
            </div>
            <div class="mt-4">
                <div class="card">Code Editor Card</div>
            </div>
        </div>

        <!-- Terminal Card -->
        <div class="terminal-card mt-4">
            <div class="terminal-header">
                <div class="terminal-tabs">
                    <button class="active" onclick="switchTab('output')">Output</button>
                    <button onclick="switchTab('input')">Input</button>
                </div>
                <button class="btn btn-danger" onclick="closeTerminal()">X</button>
            </div>
            <div id="output-tab" class="mt-3">Output Content</div>
            <div id="input-tab" class="mt-3" style="display: none;">Input Content</div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('open');
            document.querySelector('.main-container').classList.toggle('collapsed');
        }

        function toggleMenu(element) {
            element.parentElement.classList.toggle('open');
        }

        function toggleTerminal() {
            document.querySelector('.terminal-card').style.display = 'block';
        }

        function closeTerminal() {
            document.querySelector('.terminal-card').style.display = 'none';
        }

        function switchTab(tab) {
            document.getElementById('output-tab').style.display = tab === 'output' ? 'block' : 'none';
            document.getElementById('input-tab').style.display = tab === 'input' ? 'block' : 'none';
            document.querySelectorAll('.terminal-tabs button').forEach(btn => btn.classList.remove('active'));
            document.querySelector(`.terminal-tabs button[onclick="switchTab('${tab}')"]`).classList.add('active');
        }
    </script>
</body>
</html>
