<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        /*
         * Body Styles
         * Sets the overall page aesthetics: font, background color, layout, and text color.
         */
        body {
            font-family: 'Roboto', sans-serif; /* Modern, clean font */
            background-color: #eef2f3; /* Light grey/blue background for a professional feel */
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh; /* Ensures the body takes at least the full viewport height */
            color: #333; /* Default text color */
            position: relative; /* Needed for positioning the top-right buttons */
        }

        /* --- Sidebar Styles --- */
        .sidebar {
            width: 260px; /* Slightly wider sidebar */
            background-color: rgba(0, 128, 0, 0.3); /* Semi-transparent green background */
            color: #fff;
            padding-top: 20px; /* Adjust top padding for logo placement */
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            display: flex;
            flex-direction: column; /* Arrange items vertically */
            position: fixed; /* Keep sidebar fixed on scroll */
            height: 100vh; /* Full viewport height */
            overflow-y: auto; /* Enable scrolling for long content */
            z-index: 1000; /* Ensure sidebar is on top of other content */
        }

        .sidebar .logo-section {
            padding: 10px 10px 20px; /* Padding around logo */
            text-align: center;
        }

        .sidebar .logo-section img {
            height: 160px; /* Adjust height of the main bank logo */
            max-width: auto;
        }

        /* Sidebar Menu Styles */
        .sidebar-menu {
            list-style: none; /* Remove default list bullets */
            padding: 0;
            margin: 0;
            flex-grow: 1; /* Allows menu to take available space */
        }

        .sidebar-menu .menu-item {
            margin-bottom: 5px; /* Space between main menu items */
        }

        .sidebar-menu .menu-item a {
            display: block; /* Make the whole area clickable */
            padding: 12px 20px;
            color: #fff;
            text-decoration: none;
            font-size: 18px;
            font-weight: 500;
            transition: background-color 0.3s ease; /* Smooth hover effect */
            border-left: 5px solid transparent; /* For active/hover highlight */
        }

        .sidebar-menu .menu-item a:hover {
            background-color: rgba(255, 255, 255, 0.15); /* Lighter background on hover */
            border-left-color: #00796b; /* Highlight border on hover */
        }

        /* Styles for submenu */
        .sidebar-menu .submenu {
            list-style: none;
            padding: 0;
            margin: 0;
            background-color: rgba(0, 0, 0, 0.1); /* Slightly darker background for submenu */
        }

        .sidebar-menu .submenu .submenu-item a {
            padding: 10px 20px 10px 40px; /* Indent submenu items */
            font-size: 16px;
            color: #e0e0e0; /* Lighter color for submenu text */
            font-weight: 400;
            border-left: 5px solid transparent;
        }

        .sidebar-menu .submenu .submenu-item a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            border-left-color: #00796b;
        }

        /*
         * Main Content Area
         * This container holds the main elements of the page (header, dashboard content) and manages layout.
         */
        .main-content {
            margin-left: 260px; /* Offset by sidebar width */
            flex-grow: 1; /* Allows content to take up available space */
            padding: 20px;
            padding-top: 170px; /* Space for the top-right buttons */
            box-sizing: border-box; /* Include padding in width/height */
            /* Background Image Properties for main-content */
            background-image: url('img/card.png'); /* Placeholder image */
            background-size: cover; /* Cover the entire content area */
            background-repeat: no-repeat; /* Do not repeat the image */
            background-position: center center; /* Center the image within the main-content */
            /* Removed background-attachment: fixed; as it might make it too static for a moving element */
        }
        

        /*
         * Main Heading (H1)
         * Styles for the prominent "Dashboard" title.
         */
        h1 {
            font-size: 38px;
            font-variant: small-caps; /* Gives a distinct, capitalized look */
            color: #004d40; /* Dark teal, matching the bank's theme */
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px; /* Adds a bit of space between letters for readability */
        }

        /* Dashboard content area styles */
        .dashboard-widgets {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Responsive grid columns */
            gap: 20px; /* Space between grid items */
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px; /* Space below widgets */
        }

        .widget-card {
            background-color: #f9f9f9;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .widget-card h3 {
            color: #00796b;
            margin-bottom: 10px;
            font-size: 22px;
        }

        .widget-card p {
            color: #555;
            font-size: 16px;
        }


        /* Styles for the new top-right buttons */
        .top-right-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 1001; /* Ensure buttons are above other content */
            display: flex;
            gap: 10px; /* Space between buttons */
        }

        .top-right-buttons .action-button {
            background-color: #00796b; /* Teal color for the button */
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600; /* Slightly bolder text */
            text-decoration: none; /* Remove underline for links */
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .top-right-buttons .action-button:hover {
            background-color: #00695c; /* Slightly darker teal on hover */
            transform: translateY(-2px); /* Slight lift on hover */
        }

        .top-right-buttons .action-button:active {
            transform: translateY(0); /* Returns to original position on click */
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo-section">
            <img alt="Prime Bank" src="img/prime-bank.png"> <!-- Placeholder image for PBL logo -->
        </div>
        <ul class="sidebar-menu">
            <li class="menu-item">
                <a href="#user-management">User Management</a>
                <ul class="submenu">
                    <li class="submenu-item"><a href="registration.jsp">Register User</a></li>
                    <li class="submenu-item"><a href="manageUser">Manage User</a></li>
                </ul>
            </li>
            <li class="menu-item">
                <a href="#reports">Reports</a>
                <ul class="submenu">
                    <li class="submenu-item"><a href="creditCardReportList.jsp">Credit Card Report</a></li>
                    <li class="submenu-item"><a href="debitCardReportList.jsp">Debit Card Report</a></li>
                    <li class="submenu-item"><a href="prepaidCardReportList.jsp">Prepaid Card Report</a></li>
                </ul>
            </li>
            <!-- Add more main menu items here if needed -->
        </ul>
    </div>

    <!-- New container for back and logout buttons -->
    <div class="top-right-buttons">
        <a href="login.jsp" class="action-button">Back</a>
        <a href="logout" class="action-button">Logout</a>
    </div>

    <div class="main-content">
    
       <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            String userRole = (String) session.getAttribute("userRole");

            if (username == null) {
                response.sendRedirect("login.jsp"); // Redirect to login if not authenticated
                return;
            }
        %>
        
        
        <h1>Welcome to Prime Bank Report Module Dashboard</h1>

    </div>

</body>
</html>
