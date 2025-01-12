<%-- 
    Document   : adminlogin
    Created on : 7 Aug, 2024, 7:08:41 PM
    Author     : ASUS
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
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
                PreparedStatement ps = con.prepareStatement("select * from admin where username=? and password=?");
                ps.setString(1, s1);
                ps.setString(2, s2);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    
                    String adname = rs.getString("name");
                    String adid = rs.getString("admin_id");

                    request.setAttribute("name", adname);
                    request.setAttribute("id", adid);
                    RequestDispatcher rd = request.getRequestDispatcher("weladmin.jsp");
                    rd.forward(request, response);
//                    out.println("LOGIN SUCESSFUL");
                    //response.sendRedirect("DoctorSpecialization.html");
                } else {
//                    out.println("SORRY YOU GIVE WRONG PASSWORD");
                    
                    %><script>
                        alert("Invalid Username or Password");
                        window.location.href = "adminlogin.html";
                    </script>
                    <%}
            } catch (Exception e) {
                e.printStackTrace();
            }


        %>
    </body>
</html>
