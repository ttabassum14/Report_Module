package com.primebank.servlet;

import com.primebank.dao.UserDAO;
import com.primebank.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        try {
            User user = userDAO.getUserByUsername(username);

            if (user != null) {
                // Verify the entered password against the hashed password from the User object
                if (BCrypt.checkpw(password, user.getPassword())) {
                    // Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", user.getId());
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("userRole", user.getRole()); // Store the user's role

                    response.sendRedirect("dashboard.jsp"); // Redirect to dashboard
                } else {
                    // Incorrect password
                    request.setAttribute("errorMessage", "Invalid username or password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Username not found
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error during login: " + e.getMessage());
            e.printStackTrace(); // Log the full stack trace for debugging
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}