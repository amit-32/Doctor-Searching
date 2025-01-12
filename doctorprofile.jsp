<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Doctor</title>
        <style>
            /* Basic Styling */
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f0f4f8;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                min-height: 100vh;
                color: #333;
            }

            h1 {
                text-align: center;
                font-size: 2.5rem;
                color: #1845ad;
                margin-top: 20px;
            }

            p {
                text-align: center;
                font-size: 1.2rem;
                margin-bottom: 20px;
            }

            /* Table Styling */
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
                animation: fadeIn 1s ease-in-out;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #1845ad;
                color: #fff;
                font-size: 1rem;
                text-transform: uppercase;
            }

            td {
                background-color: #fff;
                color: #555;
            }

            /* Hover Effect for Rows */
            tr:hover {
                background-color: #f1f1f1;
                transform: scale(1.02);
                transition: transform 0.2s ease-in-out, background-color 0.2s ease-in-out;
            }

            /* Smooth Fade-in Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive Design */
            @media screen and (max-width: 768px) {
                table {
                    width: 100%;
                }

                h1 {
                    font-size: 2rem;
                }

                p {
                    font-size: 1rem;
                }
            }

            /* Sign-out button placement */
            .sign-out {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #f44336;
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                font-size: 16px;
                cursor: pointer;
                border: none;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
                transition: background 0.3s ease;
            }

            .sign-out:hover {
                background-color: #d32f2f;
            }

            /* Footer Section */
            footer {
                position: fixed;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100%;
                text-align: center;
                padding: 15px 0;
                background-color: #f8f8f8;
                font-size: 0.9rem;
                color: #888;
                box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
            }

            footer a {
                color: #1845ad;
                text-decoration: none;
            }

        </style>
        <script>
            function signOut() {
                window.location.href = 'doctor.html'; // Redirect to logout page
            }
        </script>
    </head>
    <body>
        <!-- Sign-out button -->
        <button class="sign-out" onclick="signOut()">Sign Out</button>

        <%
            String name = (String) request.getAttribute("name");
            String id = (String) request.getAttribute("id");
        %>
        <h1>Welcome, <%out.println(name);%> Your ID is <%out.println(id);%>.</h1>
        <p>Your Today's Patients are:</p>

        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Load Oracle JDBC Driver
                Class.forName("oracle.jdbc.driver.OracleDriver");
                
                // Connect to the Oracle Database
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");
                
                // SQL query to fetch patients assigned to the logged-in doctor
                String sql = "SELECT * FROM patient WHERE t_id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, id);
                rs = ps.executeQuery();

                // Check if there are any results
                if (!rs.isBeforeFirst()) {
                    out.println("<p>No patients found for today.</p>");
                } else {
        %>
        <table>
            <tr>
                <th>Patient Name</th>
                <th>Date Of Appointment</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Specialization</th>
                <th>Gender</th>
            </tr>
        <%
                    // Loop through the ResultSet and display patient details
                    while (rs.next()) {
                        String pname = rs.getString("p_name");
                        String doa = rs.getString("doa");
                        String address = rs.getString("address");
                        String contact = rs.getString("contact");
                        String email = rs.getString("email");
                        String spec = rs.getString("specialization");
                        String gender = rs.getString("gender");
        %>
            <tr>
                <td><%= pname %></td>
                <td><%= doa %></td>
                <td><%= address %></td>
                <td><%= contact %></td>
                <td><%= email %></td>
                <td><%= spec %></td>
                <td><%= gender %></td>
            </tr>
        <%
                    }
        %>
        </table>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Clean up database resources
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
        <p>To Update Your Password <span><a href="doctorforget.html">Click Here</a></span></p>

        <footer>
            <p>&copy; 2024 Healthcare System. All rights reserved. | <a href="#">Privacy Policy</a></p>
        </footer>
    </body>
</html>
