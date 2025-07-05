<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f4f7f6; /* Light background for the main content area */
            color: #333;
            display: flex; /* Use flexbox for overall layout */
            min-height: 100vh;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: 260px; /* Slightly wider sidebar */
            background-color: rgba(0, 128, 0, 0.3);
            color: #fff;
            padding-top: 20px; /* Adjust top padding for logo placement */
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column; /* Arrange items vertically */
            position: fixed; /* Keep sidebar fixed */
            height: 100vh;
            overflow-y: auto; /* Enable scrolling for long content */
        }

        .sidebar .logo-section {
            padding: 10px 20px 30px; /* Padding around logo */
            text-align: center;
        }

        .sidebar .logo-section img {
            height: 160px; /* Adjust height of the main bank logo */
            max-width: auto;
        }

        .sidebar nav {
            flex-grow: 1; /* Navigation takes remaining space */
        }
        
        .sidebar .dropdown-btn {
            background-color: #004d40; /* Match sidebar background */
            color: #fff;
            padding: 15px 20px; /* More padding for better click area */
            text-align: left;
            border: none;
            width: 100%;
            cursor: pointer;
            font-size: 17px; /* Slightly larger font size */
            outline: none;
            display: flex; /* For icon and text alignment */
            justify-content: space-between; /* Push arrow to the right */
            align-items: center;
            transition: background-color 0.3s ease;
        }

        .sidebar .dropdown-btn:hover,
        .sidebar .dropdown-btn.active {
            background-color: #00695c; /* Darker teal on hover/active */
        }

        .sidebar .dropdown-btn .icon {
            margin-right: 10px; /* Space between icon and text */
            width: 20px; /* Fixed width for icons */
            text-align: center;
        }

        .sidebar .dropdown-btn .arrow {
            transition: transform 0.3s ease;
        }

        .sidebar .dropdown-btn.active .arrow {
            transform: rotate(90deg); /* Rotate arrow when active */
        }

        .dropdown-container {
            display: none;
            background-color: #00332e; /* Even darker teal for dropdown items */
            padding-left: 0; /* Remove default padding */
        }

        .dropdown-container a {
            display: block;
            padding: 10px 20px 10px 55px; /* Indent sub-items, consistent padding */
            color: #e0f2f1; /* Lighter text for sub-items */
            text-decoration: none;
            font-size: 15px;
            transition: background-color 0.3s ease;
        }

        .dropdown-container a:hover {
            background-color: #004d40; /* Highlight on hover */
        }

        /* Main Content Area */
        .main-content-area {
            margin-left: 260px; /* Match sidebar width */
            flex-grow: 1; /* Takes remaining horizontal space */
            padding: 30px; /* Increased padding for content */
            position: relative; /* For positioning logout button */
        }
        
        .main-content-area h2 {
            font-size: 40px;
            font-variant: small-caps;
            color: #004d40; /* Matching sidebar color */
            text-align: center;
            margin-top: 150px; /* Reduced top margin for a cleaner look */
            margin-bottom: 30px;
        }

        .main-content-area p {
            text-align: center;
            font-size: 18px;
            color: #555;
        }

        /* Logout Button */
        .logout-button-container {
            position: absolute;
            top: 45px; 
            right: 30px;
        }

        .logout-button {
            padding: 10px 25px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #ef5350;
        }
    </style>
</head>
<body>

<div class="sidebar">    
    <div class="logo-section">
        <img alt="Prime Bank" src="img/pbl.png">
    </div>
    
    <nav>
        <button class="dropdown-btn">
            <span class="icon"><i class="fas fa-users"></i></span> User <span class="arrow"><i class="fas fa-chevron-right"></i></span>
        </button>
        <div class="dropdown-container">
            <a href="Register.jsp">Add User</a>
            <a href="userList">Manage Users</a>
        </div>

        <button class="dropdown-btn">
            <span class="icon"><i class="fas fa-file-alt"></i></span> Reports <span class="arrow"><i class="fas fa-chevron-right"></i></span>
        </button>
        <div class="dropdown-container">
            <a href="creditCardReportList.jsp">Credit Card Report</a>
            <a href="#">Debit Card Report</a>
            <a href="#">Prepaid Card Report</a>
        </div>
    </nav>
</div>

<div class="main-content-area">
    <div class="logout-button-container">
        <form action="logout" method="post">
            <button type="submit" class="logout-button">Log Out</button>
        </form>
    </div>

    <h2>Dashboard Overview</h2>
    <p>Welcome to your Prime Bank Report Module Dashboard. Select an option from the sidebar to begin managing users or generating reports.</p>
</div>

<script>
    // Dropdown logic
    var dropdowns = document.getElementsByClassName("dropdown-btn");
    for (var i = 0; i < dropdowns.length; i++) {
        dropdowns[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
            } else {
                dropdownContent.style.display = "block";
            }
        });
    }
</script>

</body>
</html>