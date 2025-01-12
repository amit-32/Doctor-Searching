<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Form</title>
    </head>
    <body>
        <%
            try {
                // Retrieve the data from the request parameters
                String name = ("Dr. " + request.getParameter("name"));
                String gender = request.getParameter("gender");
                String spec = request.getParameter("spec");
                String exp = request.getParameter("Experience");
                String contactStr = request.getParameter("mobile");
                String email = request.getParameter("email");
                String un = request.getParameter("username");
                String pd = request.getParameter("password");
                String age = request.getParameter("age");
                String sq = request.getParameter("security");

                // Validate that contactStr is not null and is numeric
                if (contactStr != null && contactStr.matches("\\d+")) {
                    // Parse contactStr to long to handle large numbers
                    long contact = Long.parseLong(contactStr);

                    // Load the Oracle JDBC driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                    // Query to get the max doctorid from the doctor table
                    String maxIdQuery = "SELECT NVL(MAX(doctorid), 0) FROM doctor";
                    PreparedStatement psMaxId = con.prepareStatement(maxIdQuery);
                    ResultSet rsMaxId = psMaxId.executeQuery();
                    int newDoctorId = 1;  // Default to 1 if no doctor exists

                    // If the result set has a value, increment it
                    if (rsMaxId.next()) {
                        newDoctorId = rsMaxId.getInt(1) + 1;
                    }

                    // Close the ResultSet and PreparedStatement for maxIdQuery
                    rsMaxId.close();
                    psMaxId.close();

                    // Now use the newDoctorId for insertion
                    String sql = "INSERT INTO doctor (doctorid, doctorname, gender, specialization, experience, mobileno, email, username, password, age, security_q) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(sql);

                    ps.setInt(1, newDoctorId);  // Set the new doctor ID
                    ps.setString(2, name);
                    ps.setString(3, gender);
                    ps.setString(4, spec);
                    ps.setString(5, exp);
                    ps.setLong(6, contact);
                    ps.setString(7, email);
                    ps.setString(8, un);
                    ps.setString(9, pd);
                    ps.setString(10, age);
                    ps.setString(11, sq);

                    int result = ps.executeUpdate();

                    // Check if the insertion was successful
                    if (result > 0) {
                        // Show success message
                        
                        %><script>alert("Data Inserted Successfully !!!")</script>
                        
                        <% response.setHeader("Refresh", "0; URL=admindoctorinsert.html");} else{
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
