<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Database Records</title>
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
        <h1>User Database Records</h1>
        <table>
            <tr>
                <th>Name</th>
                <th>Mobile Number</th>
                <th>Email</th>
                <th>Gender</th>
                <th>Age</th>
                <th>City</th>
                <th>Username</th>
                <th>Password</th>
                <th>Unique ID</th>
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
                    String query = "SELECT * FROM user1 order by u_id asc";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    // Display fetched data in table rows
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String mobile = rs.getString("mobile_no");
                        String email = rs.getString("email");
                        String gender = rs.getString("gender");
                        String age = rs.getString("age");
                        String city = rs.getString("city");
                        String username = rs.getString("username");
                        String pass = rs.getString("password");
                        String uid = rs.getString("u_id");
                        String security = rs.getString("security_q");

            %>
            <tr>
                <td><%= name%></td>
                <td> <%= mobile%></td>
                <td><%= email%></td>
                <td><%= gender%></td>
                <td><%= age%></td>
                <td><%= city%></td>
                <td><%= username%></td>
                <td><%= pass%></td>
                <td><%= uid%></td>
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

        <a href="adminuserindert.html" class="a1">Insert</a>
        <a href="adminuserdelete.jsp" class="a3">Delete</a>
    </body>
</html>
