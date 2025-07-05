package com.primebank.servlet;

import com.primebank.dao.UserDAO;
import com.primebank.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manageUsers") // Make sure this matches your JSP's form action
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !"admin".equals(session.getAttribute("userRole"))) {
            // Redirect to login or an unauthorized page if not an admin
            response.sendRedirect("dashboard.jsp?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");
        String searchTerm = request.getParameter("searchTerm"); // Get the search term from the request

        if ("delete".equals(action)) {
            handleDelete(request, response);
        } else {
            // Default action: display all users or search users
            displayUsers(request, response, searchTerm); // Pass the search term
        }
    }

    private void displayUsers(HttpServletRequest request, HttpServletResponse response, String searchTerm)
            throws ServletException, IOException {
        List<User> users = null;
        try {
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                // If a search term is provided, perform a search
                try {
                    int userId = Integer.parseInt(searchTerm.trim());
                    // If searchTerm is an integer, search by ID or username
                    users = userDAO.searchUsersByIdOrUsername(searchTerm.trim(), userId);
                } catch (NumberFormatException e) {
                    // If searchTerm is not an integer, search only by username
                    users = userDAO.searchUsersByIdOrUsername(searchTerm.trim(), -1); // -1 indicates no ID search
                }
            } else {
                // If no search term, get all users
                users = userDAO.getAllUsers();
            }
            request.setAttribute("userList", users);
            request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error retrieving users: " + e.getMessage());
            request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
            e.printStackTrace(); // Log the exception for debugging
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        if (userIdStr == null || userIdStr.isEmpty()) {
            response.sendRedirect("manageUsers?message=failedDelete&error=invalidId");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            boolean deleted = userDAO.deleteUser(userId);
            if (deleted) {
                // Set a success attribute that can be picked up by the JSP or a redirect
                response.sendRedirect("manageUsers?message=deleted");
            } else {
                response.sendRedirect("manageUsers?message=failedDelete");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("manageUsers?message=failedDelete&error=invalidFormat");
        } catch (SQLException e) {
            response.sendRedirect("manageUsers?message=failedDelete&error=dbError");
            e.printStackTrace();
        }
    }
}