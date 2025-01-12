<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
    </head>
    <body>
        <%
            try {
                // Retrieve the data from the request parameters
                String name = request.getParameter("name");
                String contactStr = request.getParameter("mobile");
                String email = request.getParameter("email");
                String gender = request.getParameter("gender");
                String age = request.getParameter("age");
                String city = request.getParameter("city");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String question = request.getParameter("security");

                // Validate that contactStr is not null and is numeric
                if (contactStr != null && contactStr.matches("\\d+")) {
                    // Parse contactStr to long to handle large numbers
                    long contact = Long.parseLong(contactStr);

                    // Load the Oracle JDBC driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                    // Retrieve the maximum value of u_id from the database
                    String maxUidQuery = "SELECT COALESCE(MAX(u_id), 0) FROM user1";
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(maxUidQuery);

                    int nextUid = 1; // Default to 1 in case the table is empty
                    if (rs.next()) {
                        nextUid = rs.getInt(1) + 1; // Increment the maximum u_id by 1
                    }

                    rs.close();
                    stmt.close();

                    // Insert the new user data
                    String sql = "INSERT INTO user1 (name, mobile_no, email, gender, age, city, username, password, u_id, security_q) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(sql);

                    ps.setString(1, name);
                    ps.setLong(2, contact); // Set contact as long
                    ps.setString(3, email);
                    ps.setString(4, gender);
                    ps.setString(5, age);
                    ps.setString(6, city);
                    ps.setString(7, username);
                    ps.setString(8, password);
                    ps.setInt(9, nextUid); // Set the new incremented u_id
                    ps.setString(10, question);

                    int result = ps.executeUpdate();

                    // Check if the insertion was successful
                    if (result > 0) {
                        //out.println("<h3>Data Insertion Done. User ID: " + nextUid + "</h3>");   
                        out.println("<script>alert('Registration is Successfully Done!');</script>");
                        response.setHeader("Refresh", "0; URL=adminuserindert.html");
                    } else {
                        out.println("<h3>Data Insertion Failed</h3>");
                    }

                    // Close the PreparedStatement and Connection
                    ps.close();
                    con.close();
                } else {
                    // Handle invalid contact input
                    out.println("<h3>Invalid contact number format. Please enter digits only.</h3>");
                }

            } catch (NumberFormatException nfe) {
                // Handle the case where the contact number is not a valid long
                out.println("<h3>Invalid contact number format. Please enter digits only.</h3>");
            } catch (SQLException sqle) {
                // Handle SQL exceptions
                out.println("<h3>Database error: " + sqle.getMessage() + "</h3>");
            } catch (Exception e) {
                // Handle other exceptions
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        %>
    </body>
</html>
