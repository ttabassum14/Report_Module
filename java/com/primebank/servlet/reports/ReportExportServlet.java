package com.primebank.servlet.report;

// iText imports for PDF
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.Font; // Optional: for custom fonts

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.Set; // To get column headers

// import org.slf4j.Logger; // Uncomment if using SLF4j
// import org.slf4j.LoggerFactory; // Uncomment if using SLF4j

@WebServlet("/exportReport") // Annotation for servlet mapping
public class ReportExportServlet extends HttpServlet {

    // private static final Logger logger = LoggerFactory.getLogger(ReportExportServlet.class); // Uncomment if using SLF4j

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String format = request.getParameter("format");

        // Retrieve the report data from session (or other cache)
        List<Map<String, Object>> reportData = (List<Map<String, Object>>) request.getSession().getAttribute("currentReportData");
        String reportType = (String) request.getSession().getAttribute("currentReportType");

        if (reportData == null || reportData.isEmpty()) {
            // logger.warn("Attempted to export empty or non-existent report data."); // Uncomment if using SLF4j
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No report data available for export. Please generate a report first.");
            return;
        }

        if (format == null || format.isEmpty()) {
            format = "csv"; // Default to CSV if format is not specified
        }

        String fileName = (reportType != null ? reportType.toLowerCase().replace(" ", "_") : "report") + "_export"; // Sanitize for filename

        try {
            switch (format.toLowerCase()) {
                case "csv":
                    exportCsv(reportData, fileName, response);
                    break;
                case "pdf":
                    exportPdf(reportData, fileName, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unsupported export format: " + format);
                    break;
            }
        } catch (IOException e) {
            // logger.error("IO Error during report export for format: {}", format, e); // Uncomment if using SLF4j
            throw new ServletException("Error exporting report: " + e.getMessage(), e);
        } catch (DocumentException e) { // Catch iText-specific exception
            // logger.error("PDF generation error for format: {}", format, e); // Uncomment if using SLF4j
            throw new ServletException("Error generating PDF report: " + e.getMessage(), e);
        } catch (Exception e) {
            // logger.error("An unexpected error occurred during report export for format: {}", format, e); // Uncomment if using SLF4j
            throw new ServletException("An unexpected error occurred during export: " + e.getMessage(), e);
        }
    }

    private void exportCsv(List<Map<String, Object>> reportData, String fileName, HttpServletResponse response) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + ".csv\"");

        try (PrintWriter writer = response.getWriter()) {
            // Write headers
            if (!reportData.isEmpty()) {
                boolean firstColumn = true;
                for (String key : reportData.get(0).keySet()) {
                    if (!firstColumn) {
                        writer.append(",");
                    }
                    writer.append("\"").append(escapeCsv(key)).append("\"");
                    firstColumn = false;
                }
                writer.append("\n");
            }

            // Write data rows
            for (Map<String, Object> row : reportData) {
                boolean firstColumn = true;
                for (Object value : row.values()) {
                    if (!firstColumn) {
                        writer.append(",");
                    }
                    writer.append("\"").append(escapeCsv(value != null ? value.toString() : "")).append("\"");
                    firstColumn = false;
                }
                writer.append("\n");
            }
        }
    }

    private String escapeCsv(String value) {
        // Basic CSV escaping: replace double quotes with two double quotes, and enclose in double quotes
        if (value == null) {
            return "";
        }
        String escaped = value.replace("\"", "\"\"");
        return escaped;
    }

    

    // New method for PDF export
    private void exportPdf(List<Map<String, Object>> reportData, String fileName, HttpServletResponse response) throws IOException, DocumentException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + ".pdf\"");

        Document document = new Document();
        try {
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            writer.setPageEvent(new HeaderFooter()); // Attach header/footer
            document.open();

            if (reportData.isEmpty()) {
                document.add(new Phrase("No data available for this report."));
                return;
            }

            Set<String> columnHeaders = reportData.get(0).keySet();
            PdfPTable table = new PdfPTable(columnHeaders.size());
            table.setWidthPercentage(100);

            Font headerFont = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);
            Font cellFont = new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL);

            for (String header : columnHeaders) {
                PdfPCell headerCell = new PdfPCell(new Phrase(header, headerFont));
                headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                headerCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell(headerCell);
            }

            for (Map<String, Object> row : reportData) {
                for (String header : columnHeaders) {
                    Object value = row.get(header);
                    PdfPCell dataCell = new PdfPCell(new Phrase(value != null ? value.toString() : "", cellFont));
                    dataCell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    dataCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    table.addCell(dataCell);
                }
            }

            document.add(table);

        } finally {
            if (document.isOpen()) {
                document.close();
            }
        }
    }
}