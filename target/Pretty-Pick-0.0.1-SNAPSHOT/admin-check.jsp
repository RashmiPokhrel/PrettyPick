<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin User Check - PrettyPick</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f8f9ff;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2B4F60;
            margin-bottom: 20px;
        }
        .info-box {
            background-color: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .success-box {
            background-color: #e8f5e9;
            border-left: 4px solid #4caf50;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .error-box {
            background-color: #ffebee;
            border-left: 4px solid #f44336;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .btn {
            display: inline-block;
            background-color: #9ED2E6;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #2B4F60;
        }
        pre {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 4px;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin User Check</h1>
        
        <div class="info-box">
            <p>This page checks if the admin user exists and creates it if needed.</p>
            <p><strong>Admin Email:</strong> admin@gmail.com</p>
            <p><strong>Admin Password:</strong> admin@123</p>
        </div>
        
        <form action="add-admin-user" method="get">
            <button type="submit" class="btn">Create Admin User</button>
            <a href="login" class="btn" style="background-color: #2B4F60;">Go to Login</a>
        </form>
        
        <div style="margin-top: 20px;">
            <p>After creating the admin user, you can log in with the credentials above.</p>
            <p>The admin dashboard will allow you to:</p>
            <ul>
                <li>View and manage user appointments (accept/reject)</li>
                <li>View registered users</li>
                <li>Manage services</li>
                <li>Filter and search through data</li>
            </ul>
        </div>
    </div>
</body>
</html>
