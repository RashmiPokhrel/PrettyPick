<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Admin User - PrettyPick</title>
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
        
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        h1 {
            color: var(--dark-blue);
            margin-bottom: 20px;
        }
        
        p {
            margin-bottom: 20px;
            color: var(--nav-text);
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: var(--logo-blue);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: var(--dark-blue);
        }
        
        .info {
            margin-top: 30px;
            padding: 15px;
            background-color: var(--light-blue);
            border-radius: 5px;
            text-align: left;
        }
        
        .info p {
            margin-bottom: 10px;
        }
        
        .back-link {
            display: block;
            margin-top: 20px;
            color: var(--logo-blue);
            text-decoration: none;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add Admin User</h1>
        <p>This page will create a specific admin user with the following credentials:</p>
        
        <div class="info">
            <p><strong>Email:</strong> admin@gmail.com</p>
            <p><strong>Password:</strong> admin@123</p>
            <p><strong>Role:</strong> admin</p>
        </div>
        
        <p>Click the button below to create this admin user:</p>
        
        <a href="add-admin-user" class="btn">Create Admin User</a>
        
        <a href="login" class="back-link">Back to Login</a>
    </div>
</body>
</html>
