package com.primebank.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
		   private static final String JDBC_URL = "jdbc:mysql://localhost:3306/report_module";
		    private static final String JDBC_USER = "root";
		    private static final String JDBC_PASSWORD = "";

		    public static Connection getConnection() {
		        Connection connection = null;
		        try {
		            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver()); 
		            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
		            System.out.println("Successfully connected to MySQL database!");

		        } catch (SQLException e) {
		            System.err.println("Error connecting to MySQL database: " + e.getMessage());
		        }
		        return connection;
		    }

		    public static void main(String[] args) {
		        Connection conn = getConnection();
		        if (conn != null) {
		            try {
		                conn.close(); // Close the connection when done
		                System.out.println("Connection closed.");
		            } catch (SQLException e) {
		                System.err.println("Error closing connection: " + e.getMessage());
		            }
		        }
		    }
	}

