<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>PrettyPick - Sign Up</title>
    <link rel="stylesheet" href="Css/style.css">
</head>
<body>
<div class="signup-container">
    <div class="logo">PrettyPick</div>
    <h2>Sign Up</h2>
    <%
        // Display error message if present
        if (request.getAttribute("errorMessage") != null) { %>
    <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <%
        // Check for email cookie
        String email = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    email = cookie.getValue();
                    break;
                }
            }
        }
    %>

    <form action="signup" method="post">
        <label for="name">Full Name:</label>
        <input type="text" id="name" name="name" required>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required>
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
        <input type="hidden" name="role" value="user">
        <label class="checkbox-label">
            <input type="checkbox" name="terms" required> I agree to the terms and conditions
        </label>
        <button type="submit">Sign Up</button>
    </form>
    <p>Already have an account? <a href="login.jsp">Login</a></p>
</div>
</body>
</html>