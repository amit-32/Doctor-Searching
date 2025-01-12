<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #74ebd5, #acb6e5);
            color: #333;
        }

        .container {
            background-color: #fff;
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            font-size: 32px;
            color: #2e8b57;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 10px;
            color: #555;
        }

        .details p {
            font-weight: 500;
            color: #333;
        }

        .details {
            margin: 30px 0;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            padding: 20px 0;
        }

        /* Home Button Styles */
        .home-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: #2e8b57;
            color: white;
            font-size: 18px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-decoration: none;
            border-radius: 30px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .home-button:hover {
            background-color: #45a049;
            transform: translateY(-3px);
        }

        .home-button:focus {
            outline: none;
        }

        /* Keyframe for fadeIn animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .container {
                padding: 30px;
            }

            h1 {
                font-size: 28px;
            }

            p {
                font-size: 16px;
            }

            .home-button {
                font-size: 16px;
                padding: 10px 20px;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Booking Confirmed!</h1>
        <p>Your appointment has been successfully booked.</p>

        <%
            try {
                // Get doctor ID and contact from the request
                String doctorid = request.getParameter("doctorid");
                String contact = request.getParameter("contact");

                // Establish a connection to the database
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "amit1234");

                // Select patient data based on contact
                String sql = "SELECT * FROM patient WHERE contact = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, contact);
                ResultSet resultSet = ps.executeQuery();

                if (resultSet.next()) {
                    // Display patient details
                    String patientName = resultSet.getString("p_name");
                    String appointmentDate = resultSet.getString("doa");

                    // Update the patient's record with the doctor's ID
                    String updateSql = "UPDATE patient SET t_id = ? WHERE contact = ?";
                    PreparedStatement updatePs = con.prepareStatement(updateSql);
                    updatePs.setString(1, doctorid);  // Set doctor ID
                    updatePs.setString(2, contact);   // Set contact to match the correct patient

                    // Execute the update query
                    int rowsAffected = updatePs.executeUpdate();

                    // If the update was successful, display the details
                    if (rowsAffected > 0) {
        %>
                        <div class="details">
                            <p><strong>Patient Name:</strong> <%= patientName %></p>
                            <p><strong>Appointment Date:</strong> <%= appointmentDate %></p>
                            <p><strong>Appointment Time:</strong> 10:00 AM to 2:00 PM</p>
                        </div>
        <%
                    } else {
                        out.println("<p>Failed to update patient data.</p>");
                    }

                    // Close the update PreparedStatement
                    updatePs.close();
                } else {
                    out.println("<p>No patient data found for the provided contact number.</p>");
                }

                // Close ResultSet, PreparedStatement, and Connection
                resultSet.close();
                ps.close();
                con.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <a href="welcomepage.html" class="home-button">Go Home</a>
    </div>
</body>

</html>
