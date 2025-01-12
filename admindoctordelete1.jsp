<%-- 
    Document   : admindoctordelete
    Created on : 5 Oct, 2024, 10:36:14 PM
    Author     : ASUS
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Doctor</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            form {
                background-color: #fff;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
                text-align: center;
            }

            h1 {
                color: #e74c3c;
                margin-bottom: 20px;
            }

            label {
                font-size: 16px;
                color: #333;
                display: block;
                margin-bottom: 10px;
            }

            input[type="number"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            button {
                width: 100%;
                padding: 12px;
                background-color: #e74c3c;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                cursor: pointer;
            }

            button:hover {
                background-color: #c0392b;
            }

            .message {
                color: #2ecc71;
                margin-top: 20px;
                font-size: 18px;
            }

            .error {
                color: red;
                margin-top: 20px;
                font-size: 18px;
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
        </style>
    </head>
    <body>
        <form method="post" action="">
            <h1>Delete Doctor Record</h1>
            <label for="del">Enter the Doctor ID:<span>*</span></label>
            <input type="number" id="del" name="del" placeholder="Doctor ID" required min="0">
            <br>
            <button type="submit">Delete</button>
            
            <a href="doctordatabase.jsp" class="back-btn">Go Back</a>
        </form>

        <%
            Connection con = null;
            PreparedStatement ps = null;
            try {
                String id = request.getParameter("del");

                if (id != null && !id.isEmpty()) {
                    // Load Oracle JDBC Driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");

                    // Establish the connection
                    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                    // Prepare the SQL Delete statement
                    String sql = "DELETE FROM doctor WHERE doctorid = ?";
                    ps = con.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(id));

                    // Execute the query
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        %>
                        <script>alert("Doctor Data Deleted")</script>
                      <%  response.setHeader("Refresh", "0; URL=admindoctordelete1.jsp");
                        
                    } else {
                        out.println("<div class='error'>Doctor ID not found!</div>");
                    }
                }

            } catch (Exception e) {
                out.println("<div class='error'>" + e.getMessage() + "</div>");
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException ex) {
                    out.println("<div class='error'>" + ex.getMessage() + "</div>");
                }
            }
        %>
    </body>
</html>
