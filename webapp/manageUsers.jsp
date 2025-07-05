<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.primebank.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        /* Your existing CSS styles */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #eef2f3;
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh;
            color: #333;
        }
        .sidebar {
            width: 260px;
            background-color: rgba(0, 128, 0, 0.3);
            color: #fff;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }
        .sidebar .logo-section {
            padding: 10px 10px 20px;
            text-align: center;
        }
        .sidebar .logo-section img {
            height: 160px;
            max-width: auto;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }
        .sidebar-menu .menu-item {
            margin-bottom: 5px;
        }
        .sidebar-menu .menu-item a {
            display: block;
            padding: 12px 20px;
            color: #fff;
            text-decoration: none;
            font-size: 18px;
            font-weight: 500;
            transition: background-color 0.3s ease;
            border-left: 5px solid transparent;
        }
        .sidebar-menu .menu-item a:hover {
            background-color: rgba(255, 255, 255, 0.15);
            border-left-color: #00796b;
        }
        .sidebar-menu .submenu {
            list-style: none;
            padding: 0;
            margin: 0;
            background-color: rgba(0, 0, 0, 0.1);
        }
        .sidebar-menu .submenu .submenu-item a {
            padding: 10px 20px 10px 40px;
            font-size: 16px;
            color: #e0e0e0;
            font-weight: 400;
            border-left: 5px solid transparent;
        }
        .sidebar-menu .submenu .submenu-item a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            border-left-color: #00796b;
        }
        .main-content {
            margin-left: 260px;
            flex-grow: 1;
            padding: 20px;
            padding-top: 90px;
            /* Background Image Properties for main-content */
            background-image: url('img/card.png'); /* Placeholder image */
            background-size: cover; /* Cover the entire content area */
            background-repeat: no-repeat; /* Do not repeat the image */
            background-position: center center; /* Center the image within the main-content */
            /* Removed background-attachment: fixed; as it might make it too static for a moving element */
        }

        .top-right-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 1001;
            display: flex;
            gap: 10px;
        }
        .action-button {
            background-color: #00796b;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .action-button:hover {
            background-color: #00695c;
            transform: translateY(-2px);
        }
        .action-button:active {
            transform: translateY(0);
        }
        h1 {
            font-size: 38px;
            font-variant: small-caps;
            color: #004d40;
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            max-width: 1000px; /* Wider container for table */
            margin: 0 auto; /* Center the container */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #004d40;
            font-weight: 700;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .action-links a {
            color: #00796b;
            text-decoration: none;
            margin-right: 15px;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .action-links a:hover {
            color: #004d40;
            text-decoration: underline;
        }
        .message-box {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            padding: 25px;
            z-index: 1001;
            display: none;
            max-width: 350px;
            text-align: center;
        }
        .message-box p {
            margin-bottom: 20px;
            font-size: 18px;
            color: #333;
        }
        .message-box button {
            background-color: #00796b;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .message-box button:hover {
            background-color: #00695c;
        }
        .export-button-container {
            text-align: right;
            margin-bottom: 20px;
        }
        .export-button-container .action-button {
            background-color: #2196F3; /* Blue for export */
        }
        .export-button-container .action-button:hover {
            background-color: #1976D2;
        }
        .error-message {
            color: #d32f2f;
            font-weight: 500;
            margin-top: 10px;
            margin-bottom: 15px;
            text-align: center;
        }
        .success-message {
            color: #388e3c;
            font-weight: 500;
            margin-top: 10px;
            margin-bottom: 15px;
            text-align: center;
        }
        /* New CSS for Search Form */
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            justify-content: flex-end; /* Align to the right */
            align-items: center;
        }
        .search-form input[type="text"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            width: 250px; /* Adjust width as needed */
        }
        .search-form button {
            background-color: #00796b;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .search-form button:hover {
            background-color: #00695c;
        }
    </style>
    <script>
        function confirmDelete(userId) {
            showMessageBox("Are you sure you want to delete this user?", function() {
                // If confirmed, redirect to the delete action URL
                window.location.href = 'manageUser?action=delete&id=' + userId; // Changed to manageUser
            }, true); // Pass true to show confirm button
            return false; // Prevent default link action
        }

        function showMessageBox(message, callback, isConfirm = false) {
            const messageBox = document.getElementById('messageBox');
            const messageText = document.getElementById('messageText');
            const okButton = document.getElementById('okButton');
            const cancelButton = document.getElementById('cancelButton');

            messageText.innerText = message;
            okButton.onclick = function() {
                closeMessageBox();
                if (callback) callback();
            };

            if (isConfirm) {
                cancelButton.style.display = 'inline-block';
                cancelButton.onclick = function() {
                    closeMessageBox();
                };
                okButton.innerText = 'Yes';
            } else {
                cancelButton.style.display = 'none';
                okButton.innerText = 'OK';
            }

            messageBox.style.display = 'block';
        }

        function closeMessageBox() {
            document.getElementById('messageBox').style.display = 'none';
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const messageType = urlParams.get('message');
            const errorMessage = urlParams.get('error');

            if (messageType === 'deleted') {
                showMessageBox("User deleted successfully!");
            } else if (messageType === 'failedDelete') {
                showMessageBox("Failed to delete user. Please try again.");
            } else if (messageType === 'updated') {
                 showMessageBox("User updated successfully!");
            } else if (messageType === 'userNotFound') {
                 showMessageBox("User not found for editing.");
            } else if (messageType === 'dbErrorEdit') {
                 showMessageBox("Database error when trying to edit user.");
            }

            if (errorMessage === 'unauthorized') {
                showMessageBox("You are not authorized to view this page. Please log in as an administrator.");
            }
        };
    </script>
</head>
<body>

    <div class="sidebar">
        <div class="logo-section">
            <img alt="Prime Bank" src="img/prime-bank.png">
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
            </ul>
    </div>

    <div class="top-right-buttons">
        <a href="dashboard.jsp" class="action-button">Back to Dashboard</a>
        <a href="logout" class="action-button">Logout</a>
    </div>

    <div class="main-content">
        <h1>Manage Users</h1>

        <div class="container">
            <div class="export-button-container">
                <a href="exportUsers<%= request.getParameter("searchTerm") != null ? "?searchTerm=" + request.getParameter("searchTerm") : "" %>" class="action-button">Export to CSV</a>
            </div>

            <%
                // Check if user is logged in and is admin
                String userRole = (String) session.getAttribute("userRole");
                if (session == null || userRole == null || !"admin".equals(userRole)) {
                    response.sendRedirect("dashboard.jsp?error=unauthorized");
                    return; // Stop further processing of the JSP
                } else {
                }

                String displayErrorMessage = (String) request.getAttribute("errorMessage");
                String displaySuccessMessage = (String) request.getAttribute("successMessage");

                if (displayErrorMessage != null) {
            %>
                <p class="error-message"><%= displayErrorMessage %></p>
            <%
                }
                if (displaySuccessMessage != null) {
            %>
                <p class="success-message"><%= displaySuccessMessage %></p>
            <%
                }
            %>

            <form action="manageUsers" method="GET" class="search-form">
                <input type="text" name="searchTerm" placeholder="Search by Username or User ID" value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>">
                <button type="submit">Search</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Date of Birth</th>
                        <th>Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<User> userList = (List<User>) request.getAttribute("userList");

                        if (userList != null && !userList.isEmpty()) {
                            for (User user : userList) {
                    %>
                        <tr>
                            <td><%= user.getId() %></td>
                            <td><%= user.getUsername() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getRole() %></td>
                            <td><%= user.getDob() != null ? user.getDob().toString() : "N/A" %></td>
                            <td><%= user.getContact() != null ? user.getContact() : "N/A" %></td>
                            <td class="action-links">
                                <a href="editUser?id=<%= user.getId() %>">Edit</a> |
                                <a href="#" onclick="return confirmDelete(<%= user.getId() %>)">Delete</a>
                            </td>
                        </tr>
                    <%
                                }
                            } else {
                    %>
                        <tr>
                            <td colspan="7">No users found. <%= request.getParameter("searchTerm") != null && !request.getParameter("searchTerm").isEmpty() ? "for '" + request.getParameter("searchTerm") + "'" : "" %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div id="messageBox" class="message-box">
        <p id="messageText"></p>
        <button id="okButton">OK</button>
        <button id="cancelButton" style="display:none; background-color: #f44336; margin-left: 10px;">Cancel</button>
    </div>
    
    <script>
    function confirmDelete(userId) {
        showMessageBox("Are you sure you want to delete this user?", function() {
             window.location.href = 'manageUsers?action=delete&id=' + userId;
        }, true);
        return false;
    }

    function showMessageBox(message, callback, isConfirm = false) {
        const messageBox = document.getElementById('messageBox');
        const messageText = document.getElementById('messageText');
        const okButton = document.getElementById('okButton');
        const cancelButton = document.getElementById('cancelButton');

        messageText.innerText = message;
        okButton.onclick = function () {
            closeMessageBox();
            if (callback) callback();
        };

        if (isConfirm) {
            cancelButton.style.display = 'inline-block';
            cancelButton.onclick = function () {
                closeMessageBox();
            };
            okButton.innerText = 'Yes';
        } else {
            cancelButton.style.display = 'none';
            okButton.innerText = 'OK';
        }

        messageBox.style.display = 'block';
    }

    function closeMessageBox() {
        document.getElementById('messageBox').style.display = 'none';
    }

    window.onload = function () {
        const urlParams = new URLSearchParams(window.location.search);
        const messageType = urlParams.get('message');
        const errorMessage = urlParams.get('error');

        if (messageType === 'deleted') {
            showMessageBox("User deleted successfully!");
        } else if (messageType === 'failedDelete') {
            showMessageBox("Failed to delete user. Please try again.");
        } else if (messageType === 'updated') {
            showMessageBox("User updated successfully!");
        } else if (messageType === 'userNotFound') {
            showMessageBox("User not found for editing.");
        } else if (messageType === 'dbErrorEdit') {
            showMessageBox("Database error when trying to edit user.");
        }

        if (errorMessage === 'unauthorized') {
            showMessageBox("You are not authorized to view this page. Please log in as an administrator.");
        }
    };
</script>
    

</body>
</html>