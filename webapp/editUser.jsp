<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<%
    User user = (User) request.getAttribute("user");
    String loggedInUser = (String) session.getAttribute("username"); // Get username from session
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #eef2f3; /* Light grey/blue background */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }

        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .edit-profile-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px; /* Adjusted max-width for the form */
            text-align: center;
            border: 1px solid #e0e0e0;
        }

        h2 {
            color: #004d40;
            margin-bottom: 25px;
            font-variant: small-caps;
            font-size: 32px;
            text-align: center;
        }

        h3 {
            color: #555;
            margin-bottom: 30px;
            font-size: 18px;
            font-weight: 400;
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
        .edit-form input[type="password"],
        .edit-form input[type="date"] {
            width: calc(100% - 20px); /* Account for padding */
            padding: 12px 10px;
            margin-bottom: 20px;
            border: 1px solid #dcdcdc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .edit-form input[type="text"]:focus,
        .edit-form input[type="password"]:focus,
        .edit-form input[type="date"]:focus {
            border-color: #00796b;
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2);
            outline: none;
        }

        .edit-form button[type="submit"] {
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
            margin-top: 10px;
        }

        .edit-form button[type="submit"]:hover {
            background-color: #00695c;
            transform: translateY(-2px);
        }

        .edit-form button[type="submit"]:active {
            transform: translateY(0);
        }

        .message-area {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
        }

        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ef9a9a;
        }
    </style>
</head>
<body>

    <div class="header">
        <img alt="Prime Bank" src="img/pbl.png">
        <a href="javascript:history.back()" class="back-button">Back to Dashboard</a>
    </div>

    <div class="main-content">
        <div class="edit-profile-container">
            <h2>Edit User Profile</h2>
            <h3>Currently editing profile for **<%= user.getUsername() %>**</h3>

            <form action="updateUser" method="post" class="edit-form">
                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                
                <label for="contact">Contact Number:</label>
                <input type="text" id="contact" name="contact" value="<%= user.getContact() %>" required aria-label="Enter contact number"><br>
                
                <label for="password">New Password (leave blank to keep current):</label>
                <input type="password" id="password" name="password" value="" aria-label="Enter new password"><br>
                
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" value="<%= user.getDob() %>" required aria-label="Select date of birth"><br>
                
                <button type="submit">Update Profile</button>
            </form>

            <%
                String updateSuccess = request.getParameter("updateSuccess");
                String updateError = request.getParameter("updateError");
            %>

            <% if ("true".equals(updateSuccess)) { %>
                <div class="message-area success-message">Profile updated successfully!</div>
            <% } %>
            <% if ("true".equals(updateError)) { %>
                <div class="message-area error-message">Error updating profile. Please try again.</div>
            <% } %>
        </div>
    </div>

</body>
</html>