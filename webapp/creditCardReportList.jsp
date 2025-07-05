<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Credit Card Reports - Prime Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #eef2f3; 
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }
        
        .main-content {
            flex-grow: 1;
            padding: 40px; /* Increased padding */
            max-width: 1200px; /* Max width for content */
            margin: 0 auto; /* Center content */
            width: 100%;
        }

        h2 {
            font-size: 38px;
            font-variant: small-caps;
            color: #004d40; /* Dark Teal */
            text-align: center;
            margin-bottom: 40px; /* More space below heading */
            letter-spacing: 1px;
        }

        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); /* Responsive grid */
            gap: 25px; /* Increased gap */
            padding: 0;
        }

        .report-item {
            display: flex; /* Use flex for internal alignment */
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 25px;
            background: #fff; /* White background for items */
            text-align: center;
            border: 1px solid #e0e0e0; /* Subtle border */
            border-radius: 8px; /* Rounded corners */
            text-decoration: none;
            color: #333;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* Soft shadow */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .report-item:hover {
            transform: translateY(-5px); /* Lift effect on hover */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12); /* Enhanced shadow on hover */
        }

        .report-item .icon {
            font-size: 40px; /* Icon size */
            color: #00796b; /* Teal icon color */
            margin-bottom: 15px;
        }

        .report-item .title {
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .report-item .description {
            font-size: 14px;
            color: #777;
            line-height: 1.5;
        }
    </style>
</head>
<body>

    <div class="header">
        <img alt="Prime Bank" src="img/pbl.png">
        <div>
            <a href="dashboard.jsp" class="back-button">Back to Dashboard</a>
            <form action="logout" method="post" style="display:inline-block; margin-left: 10px;">
                <button type="submit" class="logout-button">Log Out</button>
            </form>
        </div>
    </div>
    
    <div class="main-content">
        <h2>Credit Card Reports</h2>
        <div class="reports-grid">
            <a href="filterReportForm.jsp?reportId=report1" class="report-item">
                <span class="icon"><i class="fas fa-chart-pie"></i></span>
                <span class="title">Report 1</span>
                <span class="description"></span>
            </a>
            <a href="filterReportForm.jsp?reportId=report2" class="report-item">
                <span class="icon"><i class="fas fa-file-invoice-dollar"></i></span>
                <span class="title">Report 2</span>
                <span class="description"></span>
            </a>
            <a href="filterReportForm.jsp?reportId=report3" class="report-item">
                <span class="icon"><i class="fas fa-calendar-alt"></i></span>
                <span class="title">Report 3</span>
                <span class="description"></span>
            </a>
            <a href="filterReportForm.jsp?reportId=report4" class="report-item">
                <span class="icon"><i class="fas fa-users"></i></span>
                <span class="title">Report 4</span>
                <span class="description"></span>
            </a>
            </div>
    </div>
</body>
</html>