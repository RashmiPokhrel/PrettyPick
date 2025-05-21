<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Header styles -->
<style>
    /* Header styles */
    header {
        background-color: white;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        padding: 1rem 0;
    }

    .container {
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo {
        font-size: 1.8rem;
        font-weight: bold;
        color: var(--logo-blue);
        text-decoration: none;
        transition: color 0.3s;
    }

    .logo:hover {
        color: var(--dark-blue);
    }

    .nav-links {
        display: flex;
        gap: 2rem;
    }

    .nav-links a {
        color: var(--nav-text);
        text-decoration: none;
        font-weight: 500;
        padding: 0.5rem 1rem;
        border-radius: 5px;
        transition: background-color 0.3s, color 0.3s;
    }

    .nav-links a:hover, .nav-links a.active {
        background-color: rgba(158, 210, 230, 0.1);
        color: var(--dark-blue);
    }

    .auth-buttons {
        display: flex;
        gap: 1rem;
        align-items: center;
    }

    .btn {
        padding: 0.5rem 1.5rem;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-outline {
        border: 1px solid var(--logo-blue);
        color: var(--logo-blue);
        background: transparent;
    }

    .btn-outline:hover {
        background: rgba(158, 210, 230, 0.1);
    }

    .btn-primary {
        background: var(--logo-blue);
        color: white;
        border: 1px solid var(--logo-blue);
    }

    .btn-primary:hover {
        background: var(--dark-blue);
        border-color: var(--dark-blue);
    }

    /* Responsive styles */
    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
        }

        .nav-links {
            margin-top: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .auth-buttons {
            margin-top: 1rem;
        }
    }
</style>

<!-- Header -->
<header>
    <div class="container">
        <nav class="navbar">
            <a href="/" class="logo">PrettyPick</a>
            <div class="nav-links">
                <%
                    String userRole = null;
                    Cookie[] roleCookies = request.getCookies();
                    if (roleCookies != null) {
                        for (Cookie cookie : roleCookies) {
                            if ("userRole".equals(cookie.getName())) {
                                userRole = cookie.getValue();
                                break;
                            }
                        }
                    }

                    // Show different navigation links based on user role
                    if ("admin".equals(userRole)) {
                        // Admin navigation links
                %>
                        <a href="admin-dashboard" class="${empty param.section ? 'active' : ''}">Dashboard</a>
                        <a href="admin-dashboard?section=appointments" class="${param.section == 'appointments' ? 'active' : ''}">Appointments</a>
                        <a href="admin-dashboard?section=bookings" class="${param.section == 'bookings' ? 'active' : ''}">Bookings</a>
                        <a href="admin-dashboard?section=services" class="${param.section == 'services' ? 'active' : ''}">Services</a>
                        <a href="admin-dashboard?section=users" class="${param.section == 'users' ? 'active' : ''}">Users</a>
                <%
                    } else {
                        // Regular user navigation links
                %>
                        <a href="user-dashboard" class="${pageContext.request.servletPath == '/UserDashboard.jsp' ? 'active' : ''}">Home</a>
                        <a href="services" class="${pageContext.request.servletPath == '/service.jsp' || pageContext.request.servletPath == '/service-updated.jsp' ? 'active' : ''}">Services</a>
                        <a href="user-bookings" class="${pageContext.request.servletPath == '/my-bookings.jsp' ? 'active' : ''}">My Bookings</a>
                        <a href="aboutus.jsp" class="${pageContext.request.servletPath == '/aboutus.jsp' ? 'active' : ''}">About Us</a>
                        <a href="contactus.jsp" class="${pageContext.request.servletPath == '/contactus.jsp' ? 'active' : ''}">Contact Us</a>
                <%
                    }
                %>
            </div>
            <div class="auth-buttons">
                <%
                    String userEmail = null;
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if ("userEmail".equals(cookie.getName())) {
                                userEmail = cookie.getValue();
                                break;
                            }
                        }
                    }

                    // Determine which dashboard to link to based on user role
                    String dashboardLink = "admin".equals(userRole) ? "admin-dashboard" : "user-dashboard";
                %>
                <a href="<%= dashboardLink %>" class="btn btn-outline"><%= userEmail != null ? userEmail : "Guest" %></a>
                <a href="logout" class="btn btn-primary">Logout</a>
            </div>
        </nav>
    </div>
</header>
<!-- Add spacing to account for fixed header -->
<div style="padding-top: 80px;"></div>
