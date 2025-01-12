<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctor Database Records</title>
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
            .a-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .a1, .a3 {
                width: 100px;
                margin: 50px;
                padding: 10px;
                text-align: center;
                background-color: #f4b41a;
                color: white;
                border-radius: 5px;
                font-size: 20px;
                text-decoration: none;
            }

            .a1:hover, .a2:hover, .a3:hover {
                background-color: #e69500;
            }

        </style>
    </head>
    <body>
        <h1>Doctor's Database Records</h1>
        <table>
            <tr>
                <th>Doctor ID</th>
                <th>Doctor Name</th>
                <th>Gender</th>
                <th>Specialization</th>
                <th>Experience</th>
                <th>Mobile Number</th>
                <th>Email</th>
                <th>Username</th>
                <th>Password</th>
                <th>Age</th>
                <th>Father's Name</th>
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

                    // SQL Query to fetch all data from the users table
                    String query = "select * from doctor order by doctorid";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    // Display fetched data in table rows
                    while (rs.next()) {
                        String did = rs.getString("doctorid");
                        String dname = rs.getString("doctorname");
                        String gen = rs.getString("gender");
                        String spec = rs.getString("specialization");
                        String exp = rs.getString("experience");
                        String conct = rs.getString("mobileno");
                        String email = rs.getString("email");
                        String un = rs.getString("username");
                        String pd = rs.getString("password");
                        String age = rs.getString("age");
                        String security = rs.getString("security_q");

            %>
            <tr>
                <td><%= did%></td>
                <td><%= dname%></td>
                <td><%= gen%></td>
                <td><%= spec%></td>
                <td><%= exp%></td>
                <td>+91 <%= conct%></td>
                <td><%= email%></td>
                <td><%= un%></td>
                <td><%= pd%></td>
                <td><%= age%></td>
                <td><%= security%></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close database connections
                    if (rs != null) {
                        try {
                            rs.close();
                        } catch (SQLException ignore) {
                        }
                    }
                    if (stmt != null) {
                        try {
                            stmt.close();
                        } catch (SQLException ignore) {
                        }
                    }
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException ignore) {
                        }
                    }
                }
            %>
        </table>

        <!-- Back button -->
        <a href="javascript:history.back()" class="back-btn">Go Back</a>

        <a href="admindoctorinsert.html" class="a1">Insert</a>
        <a href="admindoctordelete1.jsp" class="a3">Delete</a>

    </body>
</html>
