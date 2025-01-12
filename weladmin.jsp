<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome Admin</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            overflow: hidden;
            background-size: cover;
            background-position: center;
        }

        h1 {
            font-size: 48px;
            margin-bottom: 20px;
            color: black;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 40px;
            color: black;
        }

        button {
            background: #fff;
            color: #333;
            padding: 12px 25px;
            margin: 10px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            transition: background 0.3s ease, transform 0.3s ease;
        }

        button:hover {
            background: #4facfe;
            color: #fff;
            transform: translateY(-5px);
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
        }

        .container {
            text-align: center;
            padding: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(6px);
        }

        /* Sign-out button placement */
        .sign-out {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #f44336; /* Red background */
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
            background-color: #d32f2f; /* Darker red on hover */
        }

    </style>
    <script>
        // JavaScript for handling button clicks and navigation
        function navigateTo(page) {
            window.location.href = page;
        }

        function signOut() {
            // Redirect to a logout page or handle session invalidation
            window.location.href = 'welcomepage.html'; // Redirect to a sign-out page
        }
    </script>
</head>
<body>

<div class="container">
    <!-- Sign-Out button positioned at the top right -->
    <button class="sign-out" onclick="signOut()">Sign Out</button>

    <%
        String name = (String) request.getAttribute("name");
        String id = (String) request.getAttribute("id");
    %>
    <h1>Welcome Mr. <% out.println(name); %></h1>
    <h2>Which Database You Want to See:</h2>

    <div>
        <!-- Use JavaScript to handle button clicks -->
        <button onclick="navigateTo('userdatabase.jsp')">USER Database</button>
        <button onclick="navigateTo('patientdatabase.jsp')">Patient Database</button>
        <button onclick="navigateTo('doctordatabase.jsp')">Doctor Database</button>
        <button onclick="navigateTo('admindatabase.jsp')">ADMIN Database</button>
    </div>
</div>
    
</body>
</html>
