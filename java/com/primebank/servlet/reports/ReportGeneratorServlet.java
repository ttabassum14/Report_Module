package com.primebank.servlet.report;

import com.primebank.dao.reports.CCReportDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;


@WebServlet("/generateReportBtn") // Annotation for servlet mapping
public class ReportGeneratorServlet extends HttpServlet {

    // private static final Logger logger = LoggerFactory.getLogger(ReportGeneratorServlet.class); // Uncomment if using SLF4j
    private CCReportDAO ccReportDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        ccReportDAO = new CCReportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        LocalDate startDate = null;
        LocalDate endDate = null;

        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDate.parse(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDate.parse(endDateStr);
            }
        } catch (DateTimeParseException e) {
            // logger.error("Error parsing date parameters: startDate={}, endDate={}", startDateStr, endDateStr, e); // Uncomment if using SLF4j
            request.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM-DD.");
            request.getRequestDispatcher("/error.jsp").forward(request, response); // Forward to an error page
            return;
        }

        if (reportType == null || reportType.isEmpty() || startDate == null || endDate == null) {
            // logger.warn("Missing parameters for report generation. reportType={}, startDate={}, endDate={}", reportType, startDateStr, endDateStr); // Uncomment if using SLF4j
            request.setAttribute("errorMessage", "Please select a report type and provide valid start and end dates.");
            request.getRequestDispatcher("/error.jsp").forward(request, response); // Forward to an error page
            return;
        }

        try {
            List<Map<String, Object>> reportData = ccReportDAO.getReportData(reportType, startDate, endDate);
            request.setAttribute("reportData", reportData);
            request.setAttribute("reportType", reportType);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);

            // Store report data in session for export, or a more robust caching mechanism
            request.getSession().setAttribute("currentReportData", reportData);
            request.getSession().setAttribute("currentReportType", reportType);


            request.getRequestDispatcher("/ccReportDetails.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            // logger.error("Invalid report type requested: {}", reportType, e); // Uncomment if using SLF4j
            request.setAttribute("errorMessage", "Invalid report type: " + reportType);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (SQLException e) {
            // logger.error("SQL Error fetching report data for type: {}, Start Date: {}, End Date: {}", reportType, startDate, endDate, e); // Uncomment if using SLF4j
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            // logger.error("Unexpected error during report generation for type: {}", reportType, e); // Uncomment if using SLF4j
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}