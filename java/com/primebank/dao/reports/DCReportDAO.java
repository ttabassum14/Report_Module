package com.primebank.dao.reports;

import com.primebank.util.DBConnection; // Assuming this provides connection pooling

import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;


public class DCReportDAO {

    
    public List<Map<String, Object>> getReportData(String reportType, LocalDate startDate, LocalDate endDate) throws SQLException {
        List<Map<String, Object>> reportData = new ArrayList<>();
        String sqlQuery = getSqlQueryByType(reportType);

        if (sqlQuery == null) {
            // logger.warn("Attempted to retrieve data for invalid report type: {}", reportType); // Uncomment if using SLF4j
            throw new IllegalArgumentException("Invalid report type: " + reportType);
        }

        try (Connection conn = DBConnection.getConnection(); // Get connection from pool
             PreparedStatement pstmt = conn.prepareStatement(sqlQuery)) {

            // All reports now use date range parameters
            pstmt.setDate(1, Date.valueOf(startDate));
            pstmt.setDate(2, Date.valueOf(endDate));

            try (ResultSet rs = pstmt.executeQuery()) {
                ResultSetMetaData meta = rs.getMetaData();
                int columnCount = meta.getColumnCount();

                while (rs.next()) {
                    // Using LinkedHashMap to preserve column order as per SQL query
                    Map<String, Object> row = new LinkedHashMap<>();
                    for (int i = 1; i <= columnCount; i++) {
                        row.put(meta.getColumnLabel(i), rs.getObject(i));
                    }
                    reportData.add(row);
                }
            }
        } catch (SQLException e) {
            // logger.error("SQL Error fetching report data for type: " + reportType +
            //              ", Start Date: " + startDate + ", End Date: " + endDate, e); // Uncomment if using SLF4j
            throw e; // Re-throw the exception for higher layers to handle
        } catch (Exception e) {
            // logger.error("An unexpected error occurred while fetching report data for type: " + reportType, e); // Uncomment if using SLF4j
            throw new SQLException("An unexpected error occurred: " + e.getMessage(), e); // Wrap other exceptions
        }

        return reportData;
    }

    private String getSqlQueryByType(String reportType) {
        switch (reportType) {
            case "transaction":
                return "SELECT t.Trxn_code, t.issuer_bank, t.aquirer_bank, t.card_number, " +
                        "cl.client_name AS customer_name, cl.client_code, t.account_number, t.trxn_amount, " +
                        "t.Trxn_date, t.Trxn_description, cl.phone_number " +
                        "FROM Trxn t " +
                        "JOIN Card c ON t.card_number = c.card_number " +
                        "JOIN Client cl ON c.client_code = cl.client_code " +
                        "WHERE t.Trxn_code = 'purchase' AND c.card_type = 'debit' AND t.Trxn_date BETWEEN ? AND ?";
            case "fees":
                return "SELECT t.Trxn_code, t.card_number, cl.client_name AS customer_name, cl.client_code, " +
                        "t.account_number, t.trxn_amount AS fee_amount, t.Trxn_date, t.Trxn_description, cl.phone_number " +
                        "FROM Trxn t " +
                        "JOIN Card c ON t.card_number = c.card_number " +
                        "JOIN Client cl ON c.client_code = cl.client_code " +
                        "WHERE t.Trxn_code = 'fee' AND c.card_type = 'debit' AND t.Trxn_date BETWEEN ? AND ?";
            case "mis":
                return "SELECT c.issue_date, c.card_number, c.card_type, cl.client_name AS customer_name, cl.client_code, " +
                        "cl.birthdate, c.account_number, cl.phone_number, c.branch_name, cl.home_address, cl.home_city, cl.home_country, cl.gender " +
                        "FROM Card c " +
                        "JOIN Client cl ON c.client_code = cl.client_code " +
                        "WHERE c.card_type = 'debit' AND c.issue_date BETWEEN ? AND ?";
            case "tin":
                return "SELECT cl.TIN, cl.NID, c.card_number, c.card_type, cl.client_name AS customer_name, cl.client_code, " +
                        "cl.birthdate, c.account_number, cl.phone_number, cl.home_address, cl.home_city, cl.home_country, cl.gender " +
                        "FROM Card c " +
                        "JOIN Client cl ON c.client_code = cl.client_code " +
                        "WHERE c.card_type = 'debit' AND c.issue_date BETWEEN ? AND ?";
            default:
                return null;
        }
    }
}