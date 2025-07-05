<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login - Prime Bank</title>
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
        }

        /* --- Sidebar Styles --- */
        .sidebar {
            width: 260px; /* Slightly wider sidebar */
            color: #fff;
            padding-top: 20px; /* Adjust top padding for logo placement */
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

        /*
         * Main Content Area
         * This container holds the main elements of the page (header, login form) and centers them.
         */
        .main-content {
           position: relative; /* Needed for positioning the overlay */
           flex-grow: 1;
           display: flex;
           flex-direction: column;
           align-items: flex-end;
           justify-content: center;
           padding: 20px;
           padding-right: 60px;
           overflow: hidden; /* Ensure overlay doesn't spill out */
       }

/* Pseudo-element for background image with transparency */
.main-content::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('img/reports.jpg');
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
    opacity: 0.5; /* Adjust transparency level (0 = fully transparent, 1 = fully opaque) */
    z-index: 0;
}

/* Make sure actual content appears above the background */
.main-content > * {
    position: relative;
    z-index: 1;
}

        /*
         * Main Heading (H1)
         * Styles for the prominent "Report Module" title.
         */
        h1 {
            font-size: 48px;
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
            max-width: 450px; /* Slightly wider for better form element spacing */
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
        .login-form input[type="password"] {
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
        .login-form input[type="password"]:focus {
            border-color: #00796b; /* Highlight border on focus */
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2); /* Subtle glow effect */
            outline: none; /* Removes the default browser outline */
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

        /* Styles for the custom message box */
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
            max-width: 380px;
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
        
        /* Style for error message display */
        .error-message {
            color: #d32f2f; /* Red color for error */
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
    </div>

    <div class="main-content">
        <h1>Report Module</h1>
        <div class="login-container">
            <img alt="Prime Bank Logo" src="img/pbl.png" class="small-logo">
            <h2>User Login</h2>
            <form action="login" method="post" class="login-form">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required aria-label="Enter your username"><br>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required aria-label="Enter your password"><br>
                
                <%
                    // Display error message if present
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                    <p class="error-message"><%= errorMessage %></p>
                <%
                    }
                %>
                

                <input type="submit" value="Log In">
            </form>

            <div id="messageBox" class="message-box">
                <p id="messageText"></p>
                <button onclick="closeMessageBox()">OK</button>
            </div>

            <%
               // Get the "logout" parameter from the request
               String logout = request.getParameter("logout");
               
               if ("true".equals(logout)) {
            %>
                <script>
                    function showMessageBox(message) {
                        document.getElementById('messageText').innerText = message;
                        document.getElementById('messageBox').style.display = 'block';
                    }

                    function closeMessageBox() {
                        document.getElementById('messageBox').style.display = 'none';
                    }

                    // Display the message box indicating successful logout
                    showMessageBox("You have been successfully logged out.");
                </script>
            <% }
             %>
        </div>
    </div>

</body>
</html>