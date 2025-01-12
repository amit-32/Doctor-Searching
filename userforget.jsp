<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Forget Password</title>
    </head>
    <body>
        <%
            try {
                // Get name, mobile number, and security question (father's name) from the request
                String name = request.getParameter("username");
                String mob = request.getParameter("mobile");
                String fname = request.getParameter("fatherName");

                // Check if inputs are valid
                if (name != null && mob != null && fname != null && !name.isEmpty() && !mob.isEmpty() && !fname.isEmpty()) {
                    // Establish a connection to the database
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                    // Query to select user based on name, mobile number, and security question
                    String sql = "SELECT * FROM user1 WHERE username = ? AND mobile_no = ? AND security_q = ?";
                    PreparedStatement ps = con.prepareStatement(sql);

                    // Set parameters for the query
                    ps.setString(1, name);
                    ps.setString(2, mob);
                    ps.setString(3, fname);

                    // Execute query
                    ResultSet resultSet = ps.executeQuery();

                    if (resultSet.next()) {
                        // If user is found, redirect to updatepassuser.html with the mobile number as a query parameter
                        response.sendRedirect("updatepassuser.html?mobile=" + mob);
                    } else {
                        out.println("<p>No user data found for the provided name, mobile number, and security question.</p>");
                    }

                    // Close resources
                    resultSet.close();
                    ps.close();
                    con.close();
                } else {
                    out.println("<p>Invalid input. Please provide name, mobile number, and security question.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Database connection error: " + e.getMessage() + "</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Unexpected error: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
