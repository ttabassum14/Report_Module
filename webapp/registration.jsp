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
            display: flex;
            flex-direction: column;
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
         * This container holds the main elements of the page (header, login form) and centers them.
         */
        .main-content {
            margin-left: 260px;
            flex-grow: 1; /* Allows content to take up available space, pushing footer down if present */
            display: flex;
            flex-direction: column;
            /* Changed for right alignment */
            align-items: center; /* Aligns content center */
            justify-content: center; /* Centers content vertically */
            padding: 20px;
            padding-top: 90px;
            /* Background Image Properties for main-content */
            background-image: url('img/card.png'); /* Placeholder image */
            background-size: cover; /* Cover the entire content area */
            background-repeat: no-repeat; /* Do not repeat the image */
            background-position: center center; /* Center the image within the main-content */
            /* Removed background-attachment: fixed; as it might make it too static for a moving element */
        }
        

        /*
         * Main Heading (H1)
         * Styles for the prominent "Report Module" title.
         */
        h1 {
            font-size: 38px;
            font-variant: small-caps; /* Gives a distinct, capitalized look */
            color: #004d40; /* Dark teal, matching the bank's theme */
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px; /* Adds a bit of space between letters for readability */
        }

        /*
         * Login Container
         * Styles for the main box containing the login form.
         */
        .login-container {
            background-color: #fff; /* White background for the form box */
            padding: 20px 30px;
            border-radius: 10px; /* Slightly more rounded corners for a softer look */
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.55); /* More subtle, deeper shadow for depth */
            width: 100%;
            max-width: 600px; /* Slightly wider for better form element spacing */
            text-align: center;
            border: 1px solid #e0e0e0; /* Subtle border for definition */
        }

        /*
         * Small Logo within Login Container
         * Styles for the bank logo displayed inside the login box.
         */
        .login-container .small-logo {
            height: 50px; /* Size for the smaller logo inside the login box */
            margin-bottom: 2px;
        }

        /*
         * Login Heading (H2)
         * Styles for the "User Login" title within the login container.
         */
        h2 {
            color: #004d40; /* Matching bank theme color */
            margin-bottom: 15px;
            font-variant: small-caps;
            font-size: 28px;
        }

        /*
         * Login Form Label
         * Styles for the text labels above input fields.
         */
        .login-form label {
            display: block; /* Ensures the label takes its own line */
            text-align: left; /* Aligns label text to the left */
            margin-bottom: 8px;
            color: #555;
            font-weight: 500; /* Medium weight for clarity */
            font-size: 15px;
        }

        /*
         * Login Form Input Fields (Text and Password)
         * Styles for the username and password input boxes.
         */
        .login-form input[type="text"],
        .login-form input[type="password"],
        .login-form input[type="email"],
        .login-form input[type="date"]{ /* Added email input type */
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
        .login-form input[type="text"]:focus,
        .login-form input[type="password"]:focus,
        .login-form input[type="email"]:focus,
        .login-form input[type="date"]:focus { /* Added email input type */
            border-color: #00796b; /* Highlight border on focus */
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2); /* Subtle glow effect */
            outline: none; /* Removes the default browser outline */
        }
        
        .login-form select {
            width: calc(100% - 20px); /* Same width as other inputs */
            padding: 12px 10px;
            margin-bottom: 20px;
            border: 1px solid #bab6b6;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .login-form select:focus {
            border-color: #00796b;
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2);
            outline: none;
        }
        

        /*
         * Login Form Submit Button
         * Styles for the "Log In" button.
         */
        .login-form input[type="submit"] {
            background-color: #00796b; /* Teal color for the button */
            color: white;
            padding: 14px 25px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer; /* Indicates it's clickable */
            font-size: 18px;
            font-weight: 700; /* Bold text for prominence */
            transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth hover and active effects */
        }

        /*
         * Submit Button Hover State
         * Styles applied when the mouse cursor is over the button.
         */
        .login-form input[type="submit"]:hover {
            background-color: #00695c; /* Slightly darker teal on hover */
            transform: translateY(-2px); /* Slight lift on hover for visual feedback */
        }

        /*
         * Submit Button Active State
         * Styles applied when the button is being clicked.
         */
        .login-form input[type="submit"]:active {
            transform: translateY(0); /* Returns to original position, creating a "press" effect */
        }

        /* Styles for the custom message box (not used on registration page, but kept for consistency if needed) */
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
            display: none; /* Hidden by default */
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
        
        /* Style for error message display */
        .error-message {
            color: #d32f2f; /* Red color for error */
            font-weight: 500;
            margin-top: 10px;
            margin-bottom: 15px;
            text-align: center;
        }
        
        .error-message-inline {
            color: #d32f2f;
            font-size: 13px;
            font-weight: 500;
            margin-left: 10px;
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
        <h1>User Registration</h1>
        <div class="login-container">
            <img alt="Prime Bank Logo" src="img/pbl.png" class="small-logo">
            <h2>New User Registration</h2>
            
            <%
                    // Display error message if present
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                    <p class="error-message"><%= errorMessage %></p>
                <%
                    }
                %>
            
            <form action="register" method="post" class="login-form">
                <label for="username">Username <span id="usernameError" class="error-message-inline"></span></label>
                <input type="text" id="username" required maxlength="15" name="username" required aria-label="Enter your desired username"><br>
                
                <label for="role">Select role</label>
                <select id="role" name="role">
                <option value="user">User</option>
                <option value="admin">Admin</option>
                </select>


                <label for="email">Email Address <span id="emailError" class="error-message-inline"></span></label>
                <input type="email" id="email" name="email" required maxlength="40" required aria-label="Enter your email address"><br>
                <div id="emailError" class="error-message" style="display: none;"></div>

                <label for="password">Password <span id="passwordError" class="error-message-inline"></span></label>
                <input type="password" id="password" name="password" required maxlength="12" required aria-label="Enter your password"><br>
                <div id="passwordError" class="error-message" style="display: none;"></div>

                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" required maxlength="12" name="confirmPassword" required aria-label="Confirm your password"><br>
                
                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" required aria-label="Enter your date of birth"><br>

                <label for="contact">Contact Number <span id="contactError" class="error-message-inline"></span></label>
                <input type="text" id="contact" name="contact" required maxlength="11" required aria-label="Enter your contact number"><br>
                
                
                <input type="submit" value="Register">
            </form>
            
            <div id="messageBox" class="message-box">
                <p id="messageText"></p>
                <button onclick="closeMessageBox()">OK</button>
            </div>
        </div>
    </div>
    <script>
    function showError(errorId, message) {
        const errorSpan = document.getElementById(errorId);
        errorSpan.innerText = message;
        errorSpan.style.display = 'inline';
    }

    function clearError(errorId) {
        const errorSpan = document.getElementById(errorId);
        errorSpan.innerText = '';
        errorSpan.style.display = 'none';
    }

    function validateMaxLength(id, maxLength, errorId) {
        const input = document.getElementById(id);
        const errorSpan = document.getElementById(errorId);

        input.addEventListener('input', function () {
            if (input.value.length > maxLength) {
                showError(errorId, `Max ${maxLength} characters allowed`);
            } else {
                clearError(errorId);
            }
        });
    }
    
    window.addEventListener('DOMContentLoaded', function () {
        // Real-time max length checks
        validateMaxLength("username", 14, "usernameError");
        validateMaxLength("email", 39, "emailLengthError");
        validateMaxLength("password", 11, "passwordLengthError");
        validateMaxLength("contact", 10, "contactError");

        // Email format validation
        const emailInput = document.getElementById('email');
        const emailErrorDiv = document.getElementById('emailError');
        emailInput.addEventListener('input', function () {
            const email = emailInput.value.trim();
            if (!email.includes('@') || !email.endsWith('.com')) {
                showError('emailError', 'Email must contain "@" and end with ".com".');
            } else {
                clearError('emailError');
            }
        });

        // Password match validation
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordErrorDiv = document.getElementById('passwordError');

        confirmPasswordInput.addEventListener('input', function () {
            if (passwordInput.value !== confirmPasswordInput.value) {
                showError('passwordError', "Passwords do not match.");
            } else {
                clearError('passwordError');
            }
        });

        // Contact number validation (digits only + max length)
        const contactInput = document.getElementById('contact');
        const contactError = document.getElementById('contactError');

        contactInput.addEventListener('input', function () {
            // Remove non-digit characters
            const digitsOnly = this.value.replace(/[^0-9]/g, '');
            if (this.value !== digitsOnly) {
                showError('contactError', 'Only digits are allowed.');
            } else if (this.value.length > 15) {
                showError('contactError', 'Contact number cannot exceed 15 digits.');
            } else {
                clearError('contactError');
            }
            this.value = digitsOnly;
        });

        // Form submit final validation
        document.querySelector('.login-form').addEventListener('submit', function(event) {
            let isValid = true;

            // Re-check email format
            const email = emailInput.value.trim();
            if (!email.includes('@') || !email.endsWith('.com')) {
                showError('emailError', 'Email must contain "@" and end with ".com".');
                isValid = false;
            }

            // Re-check password match
            if (passwordInput.value !== confirmPasswordInput.value) {
                showError('passwordError', "Passwords do not match.");
                isValid = false;
            }

            // Re-check contact number digits only + max length
            const contactVal = contactInput.value;
            if (!/^\d*$/.test(contactVal)) {
                showError('contactError', 'Only digits are allowed.');
                isValid = false;
            } else if (contactVal.length > 15) {
                showError('contactError', 'Contact number cannot exceed 15 digits.');
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault(); // Stop form submission
            }
        });

        // Success message from backend JSP param
        <% if ("true".equals(request.getParameter("registrationSuccess"))) { %>
            showMessageBox("Registration successful!");
        <% } %>
    });
</script>

</body>
</html>
