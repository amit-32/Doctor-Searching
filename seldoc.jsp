<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <%@page import="java.sql.*"%>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Available Doctors</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <style>
            /* Global Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                margin: 0;
                font-family: 'Roboto', sans-serif;
                background-color: #f3f4f6;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 1000px;
                height: auto;
                display: flex;
                flex-direction: column;
                margin: 20px 0;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                font-size: 16px;
                text-align: left;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #007bff;
                color: white;
                font-size: 18px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            input[type="radio"] {
                transform: scale(1.2);
                margin-right: 10px;
            }

            /* Button Styling */
            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 18px;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
                text-align: center;
            }

            button:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }

            button:focus {
                outline: none;
            }

            /* Table Styling for responsiveness */
            @media screen and (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }

                th {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }

                tr {
                    margin-bottom: 20px;
                }

                td {
                    border: none;
                    position: relative;
                    padding-left: 50%;
                }

                td:before {
                    position: absolute;
                    top: 15px;
                    left: 15px;
                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                    font-weight: bold;
                }

                td:nth-of-type(1):before { content: "Doctor Name"; }
                td:nth-of-type(2):before { content: "Gender"; }
                td:nth-of-type(3):before { content: "Specialization"; }
                td:nth-of-type(4):before { content: "Experience"; }
                td:nth-of-type(5):before { content: "Mobile No."; }
                td:nth-of-type(6):before { content: "Select"; }
            }
        </style>
    </head>

    <body>
        <%
            String spec = (String) request.getAttribute("spe");
            String conct = (String) request.getAttribute("cont");

            if (conct == null || conct.isEmpty()) {
                conct = "No contact provided";
            }
        %>

        <form action="appobooked.jsp" method="post">
            <h2>Available Doctors for Specialization: <%= spec %></h2>
            <table>
                <thead>
                    <tr>
                        <th>Doctor Name</th>
                        <th>Gender</th>
                        <th>Specialization</th>
                        <th>Experience</th>
                        <th>Mobile No.</th>
                        <th>Select</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            if (spec != null && !spec.trim().isEmpty()) {
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                                String sql = "SELECT * FROM doctor WHERE LOWER(specialization) = ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, spec.trim().toLowerCase());

                                ResultSet resultSet = ps.executeQuery();

                                if (!resultSet.isBeforeFirst()) {
                                    out.println("<tr><td colspan='6'>No doctors found for specialization: " + spec + "</td></tr>");
                                } else {
                                    int id = 1000;

                                    while (resultSet.next()) {
                                        id++;
                    %>
                    <tr>
                        <td><%= resultSet.getString("doctorname") %></td>
                        <td><%= resultSet.getString("gender") %></td>
                        <td><%= resultSet.getString("specialization") %></td>
                        <td><%= resultSet.getString("experience") %> Years</td>
                        <td>+91 <%= resultSet.getString("mobileno") %></td>
                        <td>
                            <input type="radio" name="doctorid" value="<%= resultSet.getString("doctorid") %>" required>
                        </td>
                    </tr>
                    <%
                                    }
                                }

                                resultSet.close();
                                ps.close();
                                con.close();
                            } else {
                                out.println("<tr><td colspan='6'>No specialization selected.</td></tr>");
                            }
                        } catch (SQLException sqle) {
                            out.println("<h3>Database error: " + sqle.getMessage() + "</h3>");
                        } catch (Exception e) {
                            out.println("<h3>Error: " + e.getMessage() + "</h3>");
                        }
                    %>
                </tbody>
            </table>
            <input type="hidden" name="contact" value="<%= conct %>">
            <button type="submit">Book Appointment</button>
        </form>
    </body>

</html>
