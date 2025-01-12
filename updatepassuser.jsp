<%@ page import="java.sql.*" %>
<%
    try {
        // Get mobile number and passwords from the request
        String mobile = request.getParameter("mobile");
        String newPassword = request.getParameter("n_password");
        String confirmPassword = request.getParameter("c_password");

        // Check if the new password and confirm password match
        if (newPassword.equals(confirmPassword)) {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Connect to the database
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

            // SQL query to update the password
            String sql = "UPDATE user1 SET password=? WHERE mobile_no=?";

            // Prepare the SQL statement
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, mobile);

            // Execute the update query
            int rowsAffected = ps.executeUpdate();

            // Check if the update was successful
            if (rowsAffected > 0) {
                out.println("<script>alert('Password updated successfully! Redirecting you to the login page.');</script>");
                response.setHeader("Refresh", "2; URL=userlogin.html"); // Redirect after 2 seconds
            } else {
                out.println("<p>No user found with the provided mobile number.</p>");
            }

            // Close the connection
            ps.close();
            con.close();
        } else {
            out.println("<p>Passwords do not match.</p>");
        }
    } catch (ClassNotFoundException e) {
        out.println("<p>Error loading database driver: " + e.getMessage() + "</p>");
    } catch (SQLException e) {
        out.println("<p>Database error: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p>Unexpected error: " + e.getMessage() + "</p>");
    }
%>
