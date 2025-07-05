<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /*
         * Body Styles
         * Sets the overall page aesthetics: font, background color, layout (flexbox), and text color.
         */
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #eef2f3; /* Light grey/blue background */
            color: #333;
            display: flex; /* Use flexbox for overall layout */
            min-height: 100vh; /* Ensure body takes full viewport height */
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
        
        /* Dropdown button for sidebar navigation */
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
            transition: transform 0.3s ease; /* Smooth rotation for arrow */
        }

        .sidebar .dropdown-btn.active .arrow {
            transform: rotate(90deg); /* Rotate arrow when active */
        }

        /* Container for dropdown menu items */
        .dropdown-container {
            display: none; /* Hidden by default */
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

        /* --- Main Content Area adjustments --- */
        .content-wrapper { /* This wraps the header and the main content */
            margin-left: 260px; /* Push content to the right, matching sidebar width */
            flex-grow: 1; /* Allows it to take remaining space */
            padding: 20px; /* General padding for the content area */
            padding-top: 0; /* Reset top padding as header has its own */
            width: calc(100% - 260px); /* Adjust width for content */
        }
        
        /* Header for the main content area */
        .header {
            width: 100%;
            background-color: #004d40; /* Dark teal background for the header */
            padding: 10px 20px;
            display: flex;
            justify-content: flex-end; /* Align buttons to the right */
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            box-sizing: border-box; /* Include padding in width */
        }

        .header-buttons {
            display: flex;
            gap: 15px; /* Space between the two buttons */
        }

        /* Styles for header buttons (Back to Dashboard, Log Out) */
        .header-buttons .back-button,
        .header-buttons .logout-button {
            background-color: #00796b; /* Lighter teal for buttons */
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none; /* For anchor tags acting as buttons */
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: inline-block; /* Required for padding and alignment for anchor */
            line-height: 1; /* Aligns text vertically in anchor */
        }

        .header-buttons .back-button:hover,
        .header-buttons .logout-button:hover {
            background-color: #00695c; /* Darker teal on hover */
            transform: translateY(-2px);
        }

        .header-buttons .back-button:active,
        .header-buttons .logout-button:active {
            transform: translateY(0); /* Press effect */
        }

        /* Main heading for the page */
        h2 {
            font-size: 38px;
            font-variant: small-caps;
            color: #004d40; /* Dark Teal */
            text-align: center;
            margin-top: 40px;
            margin-bottom: 30px;
            letter-spacing: 1px;
        }

        /* Container for the user table and messages */
        .container {
            max-width: 90%;
            margin: 0 auto 40px auto; /* Added margin-bottom for spacing */
            padding: 30px; /* Increased padding */
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* Subtle shadow for depth */
        }

        /* Table styles for displaying user data */
        table {
            border-collapse: collapse; /* Removes space between table cells */
            width: 100%;
            margin-top: 30px;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden; /* Ensures rounded corners clip content */
        }

        th, td {
            padding: 15px;
            border: 1px solid #e0e0e0; /* Light border for cells */
            text-align: left;
            font-size: 15px;
        }

        th {
            background-color: #e0f2f1; /* Light teal for header row */
            font-weight: 700;
            color: #004d40;
            text-transform: uppercase;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9; /* Subtle zebra striping for readability */
        }

        tr:hover {
            background-color: #e8f5e9; /* Light green on row hover */
        }

        /* Styles for action buttons within the table */
        .action-buttons button {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease, transform 0.2s ease; /* Added transform */
            color: white;
            font-weight: 500;
        }

        .action-buttons button:hover {
            transform: translateY(-1px); /* Subtle lift on hover */
        }

        .action-buttons .edit-button {
            background-color: #00796b; /* Teal for edit button */
        }

        .action-buttons .edit-button:hover {
            background-color: #00695c;
        }

        .action-buttons .delete-button {
            background-color: #e57373; /* Soft red for delete button */
            margin-left: 5px; 
        }

        .action-buttons .delete-button:hover {
            background-color: #ef5350;
        }

        /* Styles for messages (success/error) */
        .message-area {
            text-align: center;
            margin-top: 20px;
            padding: 12px 15px; /* Adjusted padding */
            border-radius: 5px;
            font-size: 16px;
        }

        .success-message {
            background-color: #e8f5e9; /* Light green background */
            color: #2e7d32; /* Darker green text */
            font-weight: bold;
            border: 1px solid #a5d6a7;
        }

        .error-message {
            background-color: #ffebee; /* Light red background */
            color: #c62828; /* Darker red text */
            font-weight: bold;
            border: 1px solid #ef9a9a;
        }
        
        /* Styles for export options */
        .export-options {
            text-align: center;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .export-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: #00796b; /* Teal button */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            margin: 0 10px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-weight: 500;
        }

        .export-button:hover {
            background-color: #00695c;
            transform: translateY(-1px);
        }

        /* Message when no users are found */
        .no-users-message {
            text-align: center;
            margin-top: 50px;
            font-size: 18px;
            color: #555;
            padding: 20px;
            background-color: #f0f4f7;
            border-radius: 8px;
            border: 1px dashed #cce0e6;
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

    <div class="content-wrapper"> 
        <div class="header">
            <div class="header-buttons">
                <a href="dashboard.jsp" class="back-button">Back to Dashboard</a>
                <form action="logout" method="post" style="display:inline-block;">
                    <button type="submit" class="logout-button">Log Out</button>
                </form>
            </div>
        </div>
        
        <h2>Manage Users</h2>
        
        <div class="container">
            <div class="export-options">
                <a href="exportUsersPdf" class="export-button"><i class="fas fa-file-pdf"></i> Export to PDF</a>
                <a href="exportUsersExcel" class="export-button"><i class="fas fa-file-excel"></i> Export to Excel</a>
            </div>

            <%
                // Retrieve messages from request parameters
                String updateSuccess = request.getParameter("updateSuccess");
                String deleteSuccess = request.getParameter("deleteSuccess");
                String deleteError = request.getParameter("deleteError");
            %>

            <% if ("true".equals(updateSuccess)) { %>
                <div class="message-area success-message">Successfully updated user details!</div>
            <% } %>

            <% if ("true".equals(deleteSuccess)) { %>
                <div class="message-area success-message">User successfully deleted!</div>
            <% } %>

            <% if ("true".equals(deleteError)) { %>
                <div class="message-area error-message">Error deleting user. Please try again.</div>
            <% } %>

            <%
                // Retrieve the list of users from request attributes
                List<User> userList = (List<User>) request.getAttribute("userList");
                // Check if the user list is not empty
                if (userList != null && !userList.isEmpty()) {
            %>

            <table>
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Contact</th>
                        <th>Date of Birth</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Iterate through the user list and display each user
                        for (User user : userList) { 
                    %>
                    <tr>
                        <td><%= user.getUsername() %></td>
                        <td><%= user.getContact() %></td>
                        <td><%= user.getDob() %></td>
                        <td class="action-buttons">
                            <form action="editUser" method="get" style="display:inline;">
                                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                                <button type="submit" class="edit-button">Edit</button>
                            </form>
                            <form action="deleteUser" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                                <button type="submit" class="delete-button">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <% } else { %>
                <p class="no-users-message">No user records found in the system. Consider adding new users.</p>
            <% } %>
        </div>
    </div>

    <script>
        /**
         * Function to confirm user deletion.
         * Displays a confirmation dialog before proceeding with deletion.
         * @returns {boolean} True if the user confirms, false otherwise.
         */
        function confirmDelete() {
            return confirm("Are you sure you want to delete this user permanently? This action cannot be undone.");
        }

        /**
         * Sidebar dropdown functionality.
         * Adds click event listeners to dropdown buttons to toggle their respective menus.
         */
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownBtns = document.querySelectorAll('.dropdown-btn');

            dropdownBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    // Toggle the 'active' class to rotate the arrow icon
                    this.classList.toggle('active');
                    // Get the next sibling element (the dropdown container)
                    const dropdownContent = this.nextElementSibling;
                    // Toggle the display of the dropdown content
                    if (dropdownContent.style.display === 'block') {
                        dropdownContent.style.display = 'none';
                    } else {
                        dropdownContent.style.display = 'block';
                    }
                });
            });
        });
    </script>

</body>
</html>