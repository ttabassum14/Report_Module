package com.primebank.model;

import java.sql.Date; // Use java.sql.Date for database DATE type

public class User {
    private int id;
    private String username;
    private String email;
    private String password; // Store hashed password here
    private String role;
    private Date dob; // Using java.sql.Date for database compatibility
    private String contact;

    // Constructors
    public User() {
    }

    public User(String username, String email, String password, String role, Date dob, String contact) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
        this.dob = dob;
        this.contact = contact;
    }


    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }
    

    @Override
    public String toString() {
        return "User{" +
               "id=" + id +
               ", username='" + username + '\'' +
               ", email='" + email + '\'' +
               ", role='" + role + '\'' +
               ", dob=" + dob +
               ", contact='" + contact + '\'' +
               '}';
    }
}