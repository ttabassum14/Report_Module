package com.primebank.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.primebank.dao.UserDAO;
import com.primebank.model.User;

@WebServlet("/manageUser")
public class ViewUsersServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<User> users = null;
        try {
            users = userDAO.getAllUsers();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("userList", users);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }

}
