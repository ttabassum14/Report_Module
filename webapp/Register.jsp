<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration - Prime Bank</title>
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
            display: flex; /* Changed to flex to easily manage sidebar and main content */
            min-height: 100vh; /* Ensures the body takes at least the full viewport height */
            color: #333; /* Default text color */
            overflow-x: hidden; /* Prevent horizontal scrollbar due to fixed elements */
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
            left: 0; /* Anchor sidebar to the left */
            top: 0; /* Anchor sidebar to the top */
        }

        .sidebar .logo-section {
            padding: 10px 5px 30px; /* Padding around logo */
            text-align: center;
        }

        .sidebar .logo-section img {
            height: 160px; /* Adjust height of the main bank logo */
            max-width: auto;
        }
        
        /*
         * Main Content Area
         * This container holds the main elements of the page (header, registration form) and centers them.
         */
        .main-content {
            flex-grow: 1; /* Allows content to take up available space, pushing footer down if present */
            display: flex;
            flex-direction: column;
            align-items: center; /* Centers content horizontally */
            justify-content: center; /* Centers content vertically */
            padding: 20px;
            margin-left: 260px; /* Offset for the fixed sidebar */
            width: calc(100% - 260px); /* Adjust width to account for sidebar */
        }

        /*
         * Registration Container
         * Styles for the main box containing the user registration form.
         */
        .register-container {
            background-color: #fff; /* White background for the form box */
            padding: 30px 40px;
            border-radius: 10px; /* Slightly more rounded corners for a softer look */
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.55); /* More subtle, deeper shadow for depth */
            width: 100%;
            max-width: 500px; /* Slightly wider for better form element spacing */
            text-align: center;
            border: 1px solid #e0e0e0; /* Subtle border for definition */
        }

        /*
         * Small Logo within Registration Container
         * Styles for the bank logo displayed inside the registration box.
         */
        .register-container .small-logo {
           height: 50px; /* Size for the smaller logo inside the registration box */
           margin-bottom: 20px;
        }

        /*
         * Main Heading (H1)
         * Styles for the prominent "Create User ID" title.
         */
        h1 {
            color: #004d40; /* Dark teal, matching the bank's theme */
            margin-bottom: 25px;
            font-variant: small-caps; /* Gives a distinct, capitalized look */
            font-size: 32px; /* Slightly adjusted for registration title */
        }

        /*
         * Registration Form Label
         * Styles for the text labels above input fields.
         */
        .register-form label {
            display: block; /* Ensures the label takes its own line */
            text-align: left; /* Aligns label text to the left */
            margin-bottom: 8px;
            color: #555;
            font-weight: 500; /* Medium weight for clarity */
            font-size: 15px;
        }

        /*
         * Registration Form Input Fields (Text, Date, and Password)
         * Styles for various input boxes like username, date of birth, password, etc.
         */
        .register-form input[type="text"],
        .register-form input[type="date"],
        .register-form input[type="password"] {
            width: calc(100% - 20px); /* Account for padding to maintain full width */
            padding: 12px 10px; /* More padding for better feel and readability */
            margin-bottom: 20px; /* More space between fields */
            border: 1px solid #bab6b6; 
            border-radius: 5px;
            box-sizing: border-box; /* Ensures padding and border are included in the element's total width and height */
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for focus effects */
        }

        /*
         * Input Field Focus State
         * Styles applied when an input field is actively selected.
         */
        .register-form input[type="text"]:focus,
        .register-form input[type="date"]:focus,
        .register-form input[type="password"]:focus {
            border-color: #00796b; /* Highlight border on focus */
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2); /* Subtle glow effect */
            outline: none; /* Removes the default browser outline */
        }

        /*
         * Registration Form Submit Button
         * Styles for the "Register" button.
         */
        .register-form input[type="submit"] {
            background-color: #00796b; /* Darker teal for button */
            color: white;
            padding: 14px 25px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer; /* Indicates it's clickable */
            font-size: 18px;
            font-weight: 700; /* Bold text for prominence */
            transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth hover and active effects */
            margin-top: 10px; /* Space above the button */
        }

        /*
         * Submit Button Hover State
         * Styles applied when the mouse cursor is over the button.
         */
        .register-form input[type="submit"]:hover {
            background-color: #00695c; /* Slightly darker teal on hover */
            transform: translateY(-2px); /* Slight lift on hover for visual feedback */
        }

        /*
         * Submit Button Active State
         * Styles applied when the button is being clicked.
         */
        .register-form input[type="submit"]:active {
            transform: translateY(0); /* Returns to original position, creating a "press" effect */
        }

        /*
         * Message Area for Success/Error Messages
         * Base styles for displaying feedback messages to the user.
         */
        .message-area {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
        }

        /*
         * Success Message Styles
         * Specific styles for successful operation messages.
         */
        .success-message {
            background-color: #e8f5e9; /* Light green background */
            color: #2e7d32; /* Darker green text */
            border: 1px solid #a5d6a7;
        }

        /*
         * Error Message Styles
         * Specific styles for error messages.
         */
        .error-message {
            background-color: #ffebee; /* Light red background */
            color: #c62828; /* Darker red text */
            border: 1px solid #ef9a9a;
        }

        /*
         * Login Link Container
         * Styles for the "Already have an account?" text and login link.
         */
        .login-link-container {
            margin-top: 25px;
            font-size: 15px;
            color: #555;
        }

        /*
         * Login Link Styles
         * Styles for the "Log In" hyperlink.
         */
        .login-link-container a {
            color: #00796b; /* Matching bank theme color for links */
            text-decoration: none; /* Removes default underline */
            font-weight: 500;
            transition: color 0.3s ease; /* Smooth color transition on hover */
        }

        /*
         * Login Link Hover State
         * Styles applied when the mouse cursor is over the login link.
         */
        .login-link-container a:hover {
            color: #004d40; /* Darker teal on hover */
            text-decoration: underline; /* Underline on hover */
        }

        /*
         * Header Styles
         * Styles for the top navigation/branding area of the page.
         */
        .header {
            width: calc(100% - 260px); /* Adjust width to span remaining space */
            padding: 10px 20px;
            display: flex;
            justify-content: flex-end; /* Pushes content to the right */
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            position: fixed; /* Keep header fixed on scroll */
            top: 0; /* Anchor header to the top */
            right: 0; /* Anchor header to the right */
            z-index: 999; /* Ensure header is below sidebar but above main content if needed */
        }

        .header-buttons {
            display: flex;
            gap: 15px; /* Space between buttons */
        }

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
            transform: translateY(0);
        }
    </style>
</head>
<body>     
    <div class="sidebar">    
        <div class="logo-section">
            <img alt="Prime Bank" src="img/pbl.png">
        </div>
    </div>  
    
    <div class="header">
        <div class="header-buttons">
            <a href="dashboard.jsp" class="back-button">Back to Dashboard</a>
            <form action="logout" method="post" style="display:inline-block;">
                <button type="submit" class="logout-button">Log Out</button>
            </form>
        </div>
    </div>
    
    <div class="main-content">          
       <div class="register-container">
            <img alt="Prime Bank Logo" src="img/logo-pbl.png" class="small-logo">
            <h1>Create User ID</h1>
            
            <form action="register" method="post" class="register-form">
                <label for="username">User Name</label>
                <input type="text" id="username" name="username" required aria-label="Enter your desired username">

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required aria-label="Enter your password">
                
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required aria-label="Confirm your password">
                
                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" required aria-label="Enter your date of birth">

                <label for="contact">Contact Number</label>
                <input type="text" id="contact" name="contact" required aria-label="Enter your contact number">

                <input type="submit" value="Register">            
            </form>
        
            <% 
               // Display error message if present in the request attributes
               if (request.getAttribute("error") != null) { 
            %>
                <div class="message-area error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% 
               // Display success message if registration was successful
               String registrationSuccess = request.getParameter("registrationSuccess");
               if ("true".equals(registrationSuccess)) { 
            %>
                <div class="message-area success-message">
                    Registration successful! You can now log in.
                </div>
            <% } %>    
            
            <div class="login-link-container">
                Already have an account? <a href="LogIn.jsp">Log In</a>
            </div>
        </div>
    </div>   
</body>
</html>