package com.primebank.servlet;

import com.primebank.dao.UserDAO;
import com.primebank.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/exportUsers")
public class ExportUsersServlet extends HttpServlet {
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

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"users.csv\"");

        try (PrintWriter writer = response.getWriter()) {
            String searchTerm = request.getParameter("searchTerm");
            List<User> users;

            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                try {
                    int userId = Integer.parseInt(searchTerm.trim());
                    users = userDAO.searchUsersByIdOrUsername(searchTerm.trim(), userId);
                } catch (NumberFormatException e) {
                    users = userDAO.searchUsersByIdOrUsername(searchTerm.trim(), -1);
                }
            } else {
                users = userDAO.getAllUsers();
            }

            // Write CSV Header
            writer.println("ID,Username,Email,Role,DateOfBirth,Contact");

            // Write user data
            for (User user : users) {
                writer.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                        user.getId(),
                        user.getUsername().replace("\"", "\"\""),
                        user.getEmail().replace("\"", "\"\""),
                        user.getRole().replace("\"", "\"\""),
                        (user.getDob() != null ? user.getDob().toString() : ""),
                        (user.getContact() != null ? user.getContact().replace("\"", "\"\"") : ""));
            }
        } catch (SQLException e) {
            response.getWriter().println("Error generating CSV: " + e.getMessage());
            e.printStackTrace();
        }
    }
}