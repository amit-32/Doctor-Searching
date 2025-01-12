<%-- 
    Document   : patientlg
    Created on : 9 Aug, 2024, 11:09:09 AM
    Author     : ASUS
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
    </head>
    <body>
        <%@page import="java.sql.DriverManager" %>
        <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
        <%@page import="java.sql.Connection" %>
        <%@page import="java.sql.*,java.util.*" %>

        <%
            try {
                String s1 = request.getParameter("username");
                String s2 = request.getParameter("password");
                out.println(s1);
                out.println(s2);
                Class.forName("oracle.jdbc.driver.OracleDriver");

                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");
                PreparedStatement ps = con.prepareStatement("select * from user1 where username=? and password=?");
                ps.setString(1, s1);
                ps.setString(2, s2);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Retrieve the username and password from the database result set
//                    String retrievedUsername1 = rs.getString("username");
//                    String retrievedPassword2 = rs.getString("password");
//
//                    // Print the retrieved username and password
//                    System.out.println("Retrieved Username: " + retrievedUsername1);
//                    System.out.println("Retrieved Password: " + retrievedPassword2);
//
                  // Show success message
                    response.sendRedirect("doctordetails.html");

                } else {
                    // Show failure message
                    
                    %>
                    <script>
                        alert("Invalid Username or Password");
                        window.location.href = "userlogin.html";
                    </script>
                    <%}

            } catch (Exception e) {
                e.printStackTrace();
            }


        %>

    </body>
</html>
