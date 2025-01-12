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
        <title>Doctor's Login</title>
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

                Class.forName("oracle.jdbc.driver.OracleDriver");

                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");
                PreparedStatement ps = con.prepareStatement("select * from doctor where username=? and password=?");
                ps.setString(1, s1);
                ps.setString(2, s2);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Retrieve the username and password from the database result set
                    String docname = rs.getString("doctorname");
                    String docid = rs.getString("doctorid");

                    request.setAttribute("name", docname);
                    request.setAttribute("id", docid);
                    RequestDispatcher rd = request.getRequestDispatcher("doctorprofile.jsp");
                    rd.forward(request, response);

                } else {
                    
                    
        %>
                    <script>
                        alert("Invalid Username or Password");
                        window.location.href = "doctor.html"; // Redirect to doctor.html after alert
                    </script>
        <%   
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

    </body>
</html>
