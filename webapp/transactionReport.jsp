<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Report - Prime Bank</title>
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
            padding-top: 90px; /* Space for the top-right buttons */
            box-sizing: border-box; /* Include padding in width/height */
            /* Background Image Properties for main-content */
            background-image: url('img/card.png'); /* Placeholder image */
            background-size: cover; /* Cover the entire content area */
            background-repeat: no-repeat; /* Do not repeat the image */
            background-position: center center; /* Center the image within the main-content */
        }


        /*
         * Main Heading (H1)
         * Styles for the prominent "Report" title.
         */
        h1 {
            font-size: 38px;
            font-variant: small-caps; /* Gives a distinct, capitalized look */
            color: #004d40; /* Dark teal, matching the bank's theme */
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px; /* Adds a bit of space between letters for readability */
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

        /* Report Filter Form Styles */
        .report-filter-form {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Responsive grid for form fields */
            gap: 20px;
            align-items: flex-end; /* Align items to the bottom of their grid area */
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #004d40;
            font-size: 15px;
        }

        .form-group input[type="date"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            color: #333;
            transition: border-color 0.3s ease;
            width: 100%; /* Ensure inputs take full width of their group */
            box-sizing: border-box; /* Include padding in width */
        }

        .form-group input[type="date"]:focus {
            border-color: #00796b;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 121, 107, 0.3);
        }

        .generate-button-container {
            grid-column: 1 / -1; /* Make generate button span all columns */
            display: flex;
            justify-content: center; /* Center the button */
            margin-top: 20px;
        }

        .generate-button-container button {
            background-color: #00796b;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 17px;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.2s ease;
            min-width: 150px; /* Ensure buttons have a minimum width */
        }

        .generate-button-container button:hover {
            background-color: #00695c;
            transform: translateY(-2px);
        }

        .generate-button-container button:active {
            transform: translateY(0);
        }

        /* Report Display Area */
        .report-display-area {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            min-height: 200px; /* Give some initial height */
            display: flex; /* Changed to flex for centering content */
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #777;
            font-size: 18px;
            margin-bottom: 20px; /* Space between report area and export buttons */
            position: relative; /* For absolute positioning of spinner */
        }

        .report-display-area h2 {
            color: #004d40;
            margin-bottom: 20px;
        }

        .report-display-area table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .report-display-area th,
        .report-display-area td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .report-display-area th {
            background-color: #f2f2f2;
            color: #004d40;
            font-weight: 700;
        }

        /* Export Buttons Container */
        .export-buttons-container {
            display: flex;
            justify-content: center; /* Center the buttons */
            gap: 15px;
            margin-top: 20px; /* Space above the buttons */
            padding-bottom: 20px; /* Padding for the bottom of the page */
        }

        .export-buttons-container button {
            background-color: #00796b;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 17px;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.2s ease;
            min-width: 150px;
        }

        .export-buttons-container button:hover {
            background-color: #00695c;
            transform: translateY(-2px);
        }

        .export-buttons-container button:active {
            transform: translateY(0);
        }

        /* Loading Spinner */
        .loading-spinner {
            border: 8px solid #f3f3f3; /* Light grey */
            border-top: 8px solid #00796b; /* Blue */
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            display: none; /* Hidden by default */
            /* Centering the spinner */
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1; /* Ensure it's above other content in the display area */
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Hide elements when loading */
        .report-display-area.loading #initialMessage,
        .report-display-area.loading #reportTableContainer {
            display: none;
        }


        /* Responsive adjustments */
        @media (max-width: 768px) {
            body {
                flex-direction: column; /* Stack sidebar and content */
            }

            .sidebar {
                position: relative; /* Allow sidebar to flow with content */
                width: 100%;
                height: auto;
                padding-top: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .main-content {
                margin-left: 0; /* Remove sidebar offset */
                padding: 15px; /* Adjust padding for smaller screens */
                padding-top: 70px; /* Adjust for top-right buttons */
            }

            h1 {
                font-size: 30px;
                margin-bottom: 20px;
            }

            .top-right-buttons {
                top: 10px;
                right: 10px;
                flex-direction: column; /* Stack buttons vertically */
                gap: 5px;
            }

            .top-right-buttons .action-button {
                padding: 8px 12px;
                font-size: 14px;
            }

            .report-filter-form {
                grid-template-columns: 1fr; /* Single column on small screens */
                padding: 20px;
            }

            .generate-button-container,
            .export-buttons-container {
                flex-direction: column; /* Stack buttons */
                gap: 10px;
            }

            .generate-button-container button,
            .export-buttons-container button {
                width: 100%; /* Full width buttons */
                min-width: unset;
            }
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
        <a href="dashboard.jsp" class="action-button">Back to Dashboard</a>
        <a href="logout" class="action-button">Logout</a>
    </div>

    <div class="main-content">
        <h1 id="reportPageTitle">Transaction Report</h1> <div class="report-filter-form">
            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate">
            </div>
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate">
            </div>
            <div class="generate-button-container">
                <button type="button" id="generateReportBtn">Generate Report</button>
            </div>
        </div>

        <div class="report-display-area" id="reportDisplayArea">
            <div class="loading-spinner" id="loadingSpinner"></div>
            <p id="initialMessage">Please select a date range, then click "Generate Report".</p>
            <div id="reportTableContainer"></div>
        </div>

        <div class="export-buttons-container">
            <button type="button" id="exportCsvBtn" disabled>Export to CSV</button>
            <button type="button" id="exportExcelBtn" disabled>Export to Excel</button>
            <button type="button" id="exportPdfBtn" disabled>Export to PDF</button>
        </div>
    </div>
</body>
</html>