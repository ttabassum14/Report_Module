package com.primebank.servlet;

import com.primebank.dao.UserDAO;
import com.primebank.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Date; // Import java.sql.Date
import java.sql.SQLException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }
        
        String username = request.getParameter("username");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dobString = request.getParameter("dob");
        String contact = request.getParameter("contact");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Convert DOB string to java.sql.Date
        Date dob = null;
        if (dobString != null && !dobString.isEmpty()) {
            try {
                dob = Date.valueOf(dobString); // Converts "YYYY-MM-DD" string to java.sql.Date
            } catch (IllegalArgumentException e) {
                request.setAttribute("errorMessage", "Invalid Date of Birth format.");
                request.getRequestDispatcher("registration.jsp").forward(request, response);
                return;
            }
        }

        // Create a User object
        User newUser = new User(username, email, hashedPassword, role, dob, contact);

        UserDAO userDAO = new UserDAO();

        try {
            boolean registered = userDAO.registerUser(newUser);

            if (registered) {
                // Registration successful, redirect to login page with a success message
                response.sendRedirect("registration.jsp?registrationSuccess=true");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("registration.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Handle specific SQL exceptions, e.g., duplicate entry
            if (e.getMessage().contains("Duplicate entry")) {
                if (e.getMessage().contains("username")) {
                    request.setAttribute("errorMessage", "Username already exists. Please choose a different one.");
                } else if (e.getMessage().contains("email")) {
                    request.setAttribute("errorMessage", "Email address already registered.");
                } else {
                    request.setAttribute("errorMessage", "A user with this detail already exists.");
                }
            } else {
                request.setAttribute("errorMessage", "Database error during registration: " + e.getMessage());
            }
            e.printStackTrace(); // Log the full stack trace for debugging
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
    }
}