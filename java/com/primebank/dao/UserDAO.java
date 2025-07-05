package com.primebank.dao;

import com.primebank.model.User;
import com.primebank.util.DBConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    /**
     * Registers a new user in the database.
     * @param user The User object containing user details.
     * @return true if registration is successful, false otherwise.
     * @throws SQLException if a database access error occurs.
     */
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, role, email, password, dob, contact) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getRole());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPassword()); // Store hashed password
            pstmt.setDate(5, user.getDob());
            pstmt.setString(6, user.getContact());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            throw e; // Re-throw to handle duplicate entry in servlet
        }
    }

    /**
     * Retrieves a user from the database by username.
     * @param username The username to search for.
     * @return A User object if found, null otherwise.
     * @throws SQLException if a database access error occurs.
     */
    public User getUserByUsername(String username) throws SQLException {
        String sql = "SELECT id, username, email, password, role, dob, contact FROM users WHERE username = ?";
        User user = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        }
        return user;
    }

    /**
     * Retrieves a user from the database by ID.
     * @param userId The ID of the user to retrieve.
     * @return A User object if found, null otherwise.
     * @throws SQLException if a database access error occurs.
     */
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT id, username, email, password, role, dob, contact FROM users WHERE id = ?";
        User user = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        }
        return user;
    }

    /**
     * Retrieves a list of all users from the database.
     * @return A List of User objects.
     * @throws SQLException if a database access error occurs.
     */
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, email, password, role, dob, contact, created_at FROM users ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        }
        return users;
    }

    /**
     * Updates an existing user's details in the database.
     * @param user The User object with updated details.
     * @return true if the update is successful, false otherwise.
     * @throws SQLException if a database access error occurs.
     */
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET username = ?, email = ?, role = ?, dob = ?, contact = ? WHERE id = ?";
        // Password is not updated here. If password update is needed, create a separate method.
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getRole());
            pstmt.setDate(4, user.getDob());
            pstmt.setString(5, user.getContact());
            pstmt.setInt(6, user.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * Deletes a user from the database by ID.
     * @param userId The ID of the user to delete.
     * @return true if deletion is successful, false otherwise.
     * @throws SQLException if a database access error occurs.
     */
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    
    public List<User> searchUsersByIdOrUsername(String searchTerm, int id) throws SQLException {
        List<User> users = new ArrayList<>();
        String sql;
        boolean searchById = id != -1;

        if (searchById) {
            sql = "SELECT * FROM users WHERE id = ? OR LOWER(username) LIKE LOWER(?)";
        } else {
            sql = "SELECT * FROM users WHERE LOWER(username) LIKE LOWER(?)";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (searchById) {
                pstmt.setInt(1, id);
                pstmt.setString(2, "%" + searchTerm + "%");
            } else {
                pstmt.setString(1, "%" + searchTerm + "%");
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    users.add(extractUserFromResultSet(rs));
                }
            }
        }

        return users;
    }

    

    /**
     * Helper method to extract User object from ResultSet.
     */
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password")); // Hashed password
        user.setRole(rs.getString("role"));
        user.setDob(rs.getDate("dob"));
        user.setContact(rs.getString("contact"));
        return user;
    }
}