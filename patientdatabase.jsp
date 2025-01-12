<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Database Records</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f7f7;
                padding: 20px;
            }

            h1 {
                text-align: center;
                font-size: 28px;
                color: #333;
                margin-bottom: 20px;
            }

            table {
                width: 90%;
                margin: 0 auto;
                border-collapse: collapse;
                background: #fff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                font-size: 16px;
            }

            th, td {
                padding: 15px;
                border: 1px solid #ddd;
                text-align: left;
            }

            th {
                background-color: #f4b41a;
                color: #fff;
                font-size: 18px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            td {
                color: #333;
            }

            .back-btn {
                display: block;
                width: 150px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
            }

            .back-btn:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <h1>Patient Database Records</h1>
        <table>
            <tr>
                <th>Patient Name</th>
                <th>Date Of Appointment</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Specialization</th>
                <th>Gender</th>
                <th>Temporary ID</th>
            </tr>
            <%
                // Database connection setup
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load Oracle JDBC driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    // Establish the connection to the database
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                    // SQL Query to fetch all data from the patient table
                    String query = "SELECT * FROM patient";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    // Display fetched data in table rows
                    while (rs.next()) {
                        String name = rs.getString("p_name");
                        String doa = rs.getString("doa");
                        String add = rs.getString("address");
                        String cont = rs.getString("contact");
                        String email = rs.getString("email");
                        String spec = rs.getString("specialization");
                        String gender = rs.getString("gender");
                        String tid = rs.getString("t_id");

                        %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= doa %></td>
                            <td><%= add %></td>
                            <td>+91 <%= cont %></td>
                            <td><%= email %></td>
                            <td><%= spec %></td>
                            <td><%= gender %></td>
                            <td><%= tid %></td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close database connections
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </table>

        <!-- Back button -->
        <a href="javascript:history.back()" class="back-btn">Go Back</a>
    </body>
</html>
