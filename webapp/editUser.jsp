<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.primebank.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
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
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: center; /* Center vertically */
            padding: 20px;
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
        .edit-container { /* Renamed from login-container for clarity */
            background-color: #fff;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
            border: 1px solid #e0e0e0;
        }
        .edit-container .small-logo {
            height: 50px;
            margin-bottom: 2px;
        }
        h2 {
            color: #004d40;
            margin-bottom: 15px;
            font-variant: small-caps;
            font-size: 28px;
        }
        .edit-form label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 15px;
        }
        .edit-form input[type="text"],
        .edit-form input[type="email"],
        .edit-form input[type="date"],
        .edit-form select {
            width: calc(100% - 20px);
            padding: 12px 10px;
            margin-bottom: 20px;
            border: 1px solid #bab6b6;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .edit-form input[type="text"]:focus,
        .edit-form input[type="email"]:focus,
        .edit-form input[type="date"]:focus,
        .edit-form select:focus {
            border-color: #00796b;
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2);
            outline: none;
        }
        .edit-form input[type="submit"] {
            background-color: #00796b;
            color: white;
            padding: 14px 25px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 700;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .edit-form input[type="submit"]:hover {
            background-color: #00695c;
            transform: translateY(-2px);
        }
        .edit-form input[type="submit"]:active {
            transform: translateY(0);
        }
        .error-message {
            color: #d32f2f;
            font-weight: 500;
            margin-top: 10px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
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
                    <li class="submenu-item"><a href="#prepaid-card-report">Prepaid Card Report</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="top-right-buttons">
        <a href="manageUsers" class="action-button">Back to User List</a>
        <a href="logout" class="action-button">Logout</a>
    </div>

    <div class="main-content">
        <h1>Edit User</h1>
        <div class="edit-container">
            <img alt="Prime Bank Logo" src="img/pbl.png" class="small-logo">
            <h2>Edit User Details</h2>
            <%
                // Check if user is logged in and is admin
                String userRole = (String) session.getAttribute("userRole");
                if (session == null || userRole == null || !"admin".equals(userRole)) {
                    response.sendRedirect("login.jsp?error=unauthorized");
                    return;
                }

                User user = (User) request.getAttribute("user");
                if (user == null) {
                    // This should ideally not happen if servlet properly forwards
                    response.sendRedirect("manageUsers?message=userNotFound");
                    return;
                }

                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <p class="error-message"><%= errorMessage %></p>
            <%
                }
            %>
            <form action="editUser" method="post" class="edit-form">
                <input type="hidden" name="id" value="<%= user.getId() %>">

                <label for="username">Username</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required aria-label="Enter username"><br>
                
                <label for="role">Select role</label>
                <select id="role" name="role">
                    <option value="user" <%= "user".equals(user.getRole()) ? "selected" : "" %>>User</option>
                    <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                </select><br>

                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required aria-label="Enter email address"><br>

                <%-- Password is NOT edited here. It's recommended to have a separate "Change Password" functionality. --%>
                <%-- <label for="password">Password</label>
                <input type="password" id="password" name="password" aria-label="Enter new password (optional)"><br> --%>

                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" value="<%= user.getDob() != null ? user.getDob().toString() : "" %>" aria-label="Enter date of birth"><br>

                <label for="contact">Contact Number</label>
                <input type="text" id="contact" name="contact" value="<%= user.getContact() != null ? user.getContact() : "" %>" aria-label="Enter contact number"><br>

                <input type="submit" value="Update User">
            </form>
        </div>
    </div>

</body>
</html>