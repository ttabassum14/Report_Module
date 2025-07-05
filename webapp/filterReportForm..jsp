<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Filter Reports - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #eef2f3; /* Light grey/blue background */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }
        
        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .report-filter-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px; /* Adjusted max-width for the form */
            text-align: center;
            border: 1px solid #e0e0e0;
        }

        h2 {
            font-size: 38px;
            font-variant: small-caps;
            color: #004d40; /* Dark Teal */
            text-align: center;
            margin-bottom: 30px;
            letter-spacing: 1px;
        }

        h4 {
            font-size: 20px;
            color: #555;
            margin-bottom: 25px;
            font-weight: 500;
        }

        .filter-form label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 15px;
        }

        .filter-form input[type="date"] {
            width: calc(100% - 20px); /* Account for padding */
            padding: 12px 10px;
            margin-bottom: 20px;
            border: 1px solid #dcdcdc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .filter-form input[type="date"]:focus {
            border-color: #00796b;
            box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2);
            outline: none;
        }

        .filter-form button[type="submit"] {
            background-color: #00796b;
            color: white;
            padding: 14px 25px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 700;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
        }

        .filter-form button[type="submit"]:hover {
            background-color: #00695c;
            transform: translateY(-2px);
        }

        .filter-form button[type="submit"]:active {
            transform: translateY(0);
        }

        .back-link-container {
            margin-top: 30px;
            font-size: 16px;
        }

        .back-link-container a {
            color: #00796b; /* Matching bank theme color for links */
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .back-link-container a:hover {
            color: #004d40;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <img alt="Prime Bank" src="img/pbl.png">
        <div>
            <a href="creditCardReportList.jsp" class="back-button">Back to Reports</a>
            <form action="logout" method="post" style="display:inline-block; margin-left: 10px;">
                <button type="submit" class="logout-button">Log Out</button>
            </form>
        </div>
    </div>
    
    <div class="main-content">
        <div class="report-filter-container">
            <h2>Credit Card Report Details</h2>
            
            <h4>Filter Reports by Date Range:</h4>
            <form action="filterReports" method="get" class="filter-form">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" required aria-label="Select start date">

                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" required aria-label="Select end date">

                <button type="submit">Generate Report</button>
            </form>

            <div class="back-link-container">
                <a href="creditCardReportList.jsp">Go Back to Report List</a>
            </div>
        </div>
    </div>
</body>
</html>