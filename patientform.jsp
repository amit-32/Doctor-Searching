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
                String name = request.getParameter("name");
                String dob = request.getParameter("dob");
                String address = request.getParameter("address");
                String contactStr = request.getParameter("contact");
                String email = request.getParameter("email");
                String spec = request.getParameter("spec");
                String gender = request.getParameter("gender");

                // Validate that contactStr is not null and is numeric
                if (contactStr != null && contactStr.matches("\\d+")) {
                    // Parse contactStr to long to handle large numbers
                    long contact = Long.parseLong(contactStr);

                    // Load the Oracle JDBC driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                    String sql = "INSERT INTO patient (p_name, doa, address, contact, email, specialization, gender) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(sql);

                    ps.setString(1, name);
                    ps.setString(2, dob);
                    ps.setString(3, address);
                    ps.setLong(4, contact);  // Set contact as long
                    ps.setString(5, email);
                    ps.setString(6, spec);
                    ps.setString(7, gender);

                    int result = ps.executeUpdate();

                    // Check if the insertion was successful
                    if (result > 0) {
                        // Use RequestDispatcher to forward the request and pass the spec parameter to seldoc.jsp
                        request.setAttribute("spe", spec);
                        request.setAttribute("cont", contactStr);
                        RequestDispatcher rd = request.getRequestDispatcher("seldoc.jsp");

                        rd.forward(request, response);

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
