package com.primebank.servlet;

import com.primebank.dao.UserDAO;
import com.primebank.model.User;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/editUser")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("id"));
        try {
            User user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("editUser.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "User not found for editing.");
                response.sendRedirect("manageUsers?message=userNotFound"); // Redirect back
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error retrieving user for edit: " + e.getMessage());
            response.sendRedirect("manageUsers?message=dbErrorEdit");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String dobString = request.getParameter("dob");
        String contact = request.getParameter("contact");

        Date dob = null;
        if (dobString != null && !dobString.isEmpty()) {
            try {
                dob = Date.valueOf(dobString);
            } catch (IllegalArgumentException e) {
                request.setAttribute("user", new User(username, email, "", role, null, contact)); // Send back partially filled user
                request.setAttribute("errorMessage", "Invalid Date of Birth format.");
                request.getRequestDispatcher("editUser.jsp").forward(request, response);
                return;
            }
        }

        User userToUpdate = new User(username, email, "", role, dob, contact); // Password is not updated via this form

        try {
            boolean updated = userDAO.updateUser(userToUpdate);
            if (updated) {
                response.sendRedirect("manageUsers?message=updated");
            } else {
                request.setAttribute("user", userToUpdate);
                request.setAttribute("errorMessage", "Failed to update user. Please try again.");
                request.getRequestDispatcher("editUser.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate entry")) {
                 if (e.getMessage().contains("username")) {
                    request.setAttribute("errorMessage", "Username already exists. Please choose a different one.");
                } else if (e.getMessage().contains("email")) {
                    request.setAttribute("errorMessage", "Email address already registered.");
                } else {
                    request.setAttribute("errorMessage", "A user with this detail already exists.");
                }
            } else {
                request.setAttribute("errorMessage", "Database error during update: " + e.getMessage());
            }
            request.setAttribute("user", userToUpdate); // Send user back to pre-populate form
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}