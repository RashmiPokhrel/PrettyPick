<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>PrettyPick - Sign Up</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Global variables */
        :root {
            --pastel-blue: #9ED2E6;
            --snow-white: #F8F9FF;
            --dark-blue: #2B4F60;
            --light-blue: #BFE6F5;
            --logo-blue: #9ED2E6;
            --nav-text: #4A4A4A;
            --register-blue: #9ED2E6;
        }

        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: var(--dark-blue);
            background-color: var(--snow-white);
        }

        /* Signup specific styles */
        .signup-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .logo-container {
            text-align: center;
            font-size: 2rem;
            color: var(--logo-blue);
            margin-bottom: 20px;
            font-weight: bold;
        }

        h2 {
            text-align: center;
            color: var(--dark-blue);
            margin-bottom: 20px;
        }

        .error-message {
            color: #721c24;
            background-color: #f8d7da;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
        }

        .success-message {
            color: #155724;
            background-color: #d4edda;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: var(--nav-text);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            cursor: pointer;
        }

        .checkbox-label input[type="checkbox"] {
            margin-right: 10px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: var(--logo-blue);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: var(--dark-blue);
        }

        p {
            text-align: center;
            margin-top: 20px;
            color: var(--nav-text);
        }

        a {
            color: var(--logo-blue);
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: var(--nav-text);
            margin-top: -10px;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<div class="signup-container">
    <div class="logo-container">PrettyPick</div>
    <h2>Sign Up</h2>

    <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>

    <form action="signup" method="post" onsubmit="return validateForm()">
        <label for="name">Full Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" placeholder="Optional">

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <div class="password-requirements">Password must be at least 6 characters long</div>

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>

        <input type="hidden" name="role" value="user">

        <label class="checkbox-label">
            <input type="checkbox" name="terms" required>
            I agree to the terms and conditions
        </label>

        <button type="submit">Sign Up</button>
    </form>

    <p>Already have an account? <a href="login">Login</a></p>
</div>
</body>
</html>