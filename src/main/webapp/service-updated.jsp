<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrettyPick - Beauty Services</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --pastel-blue: #9ED2E6;
            --snow-white: #F8F9FF;
            --dark-blue: #2B4F60;
            --light-blue: #BFE6F5;
            --logo-blue: #9ED2E6;
            --nav-text: #4A4A4A;
            --register-blue: #9ED2E6;
        }

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: var(--dark-blue);
            background-color: var(--snow-white);
        }

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

        /* Main content styles */
        main {
            padding-top: 5rem;
        }

        /* Hero section */
        .hero {
            background: linear-gradient(135deg, var(--pastel-blue), var(--light-blue));
            padding: 5rem 5%;
            text-align: center;
            color: var(--dark-blue);
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto 2rem;
        }

        .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        .hero-btn {
            padding: 0.8rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .hero-btn-primary {
            background: white;
            color: var(--dark-blue);
            border: 1px solid white;
        }

        .hero-btn-primary:hover {
            background: var(--dark-blue);
            color: white;
            border-color: var(--dark-blue);
        }

        .hero-btn-secondary {
            background: transparent;
            color: white;
            border: 1px solid white;
        }

        .hero-btn-secondary:hover {
            background: white;
            color: var(--dark-blue);
        }

        /* Service styles */
        .service-category {
            margin-bottom: 4rem;
        }

        .service-category h3 {
            color: var(--dark-blue);
            font-size: 2rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .service-category h3 i {
            color: var(--pastel-blue);
        }

        .service-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .service-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            padding: 2rem;
            transition: transform 0.3s;
        }

        .service-card:hover {
            transform: translateY(-5px);
        }

        .service-card h4 {
            font-size: 1.5rem;
            color: var(--dark-blue);
            margin-bottom: 0.5rem;
        }

        .service-card p {
            color: var(--nav-text);
            margin-bottom: 1rem;
        }

        .price {
            font-weight: bold;
            color: var(--dark-blue);
            font-size: 1.2rem;
        }

        .service-features {
            list-style: none;
            margin: 1rem 0;
        }

        .service-features li {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .service-features li:before {
            content: "•";
            color: var(--pastel-blue);
            font-weight: bold;
        }

        .service-book-btn {
            display: inline-block;
            padding: 0.8rem 2rem;
            background-color: var(--pastel-blue);
            color: var(--dark-blue);
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-weight: 500;
            margin-top: 1rem;
            cursor: pointer;
            border: none;
        }

        .service-book-btn:hover {
            background-color: var(--light-blue);
        }

        /* Booking form styles */
        .booking-form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            display: none;
        }

        .booking-form-container.active {
            display: block;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h2 {
            color: var(--dark-blue);
            margin-bottom: 0.5rem;
        }

        .selected-service {
            color: var(--pastel-blue);
            font-weight: bold;
        }

        .booking-form {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group label {
            font-weight: 500;
            color: var(--dark-blue);
        }

        .form-group input, .form-group textarea {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: inherit;
        }

        .submit-btn {
            padding: 1rem;
            background-color: var(--pastel-blue);
            color: var(--dark-blue);
            border: none;
            border-radius: 5px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: var(--light-blue);
        }

        /* Success message */
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 500;
        }

        /* Error message */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 500;
        }

        /* Footer styles */
        footer {
            background-color: var(--dark-blue);
            color: var(--snow-white);
            padding: 4rem 5% 1rem;
        }

        .footer-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 3rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-section h3 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: var(--snow-white);
        }

        .footer-section p {
            margin-bottom: 0.8rem;
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 0.8rem;
        }

        .footer-section ul a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-section ul a:hover {
            color: var(--pastel-blue);
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .social-links a {
            color: var(--snow-white);
            font-size: 1.2rem;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: var(--pastel-blue);
        }

        .newsletter {
            display: flex;
            margin-top: 1rem;
        }

        .newsletter input {
            padding: 0.8rem;
            border: none;
            border-radius: 5px 0 0 5px;
            width: 100%;
        }

        .subscribe-btn {
            padding: 0.8rem 1.5rem;
            background-color: var(--pastel-blue);
            color: var(--dark-blue);
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .subscribe-btn:hover {
            background-color: var(--light-blue);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.6);
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

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }
        }

        /* No services message */
        .no-services {
            text-align: center;
            padding: 3rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin: 2rem auto;
            max-width: 800px;
        }

        .no-services h3 {
            color: var(--dark-blue);
            margin-bottom: 1rem;
        }

        .no-services p {
            color: var(--nav-text);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="home.jsp" class="logo">PrettyPick</a>
                <div class="nav-links">
                    <a href="home.jsp">Home</a>
                    <a href="services" class="active">Services</a>
                    <%
                        String userEmail = null;
                        String userRole = null;
                        Cookie[] cookies = request.getCookies();
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                if ("userEmail".equals(cookie.getName())) {
                                    userEmail = cookie.getValue();
                                } else if ("userRole".equals(cookie.getName())) {
                                    userRole = cookie.getValue();
                                }
                            }
                        }
                        
                        if (userEmail != null) {
                            if ("admin".equals(userRole)) {
                    %>
                    <a href="admin-dashboard">Dashboard</a>
                    <%
                            } else {
                    %>
                    <a href="user-dashboard">Dashboard</a>
                    <a href="bookings">My Bookings</a>
                    <%
                            }
                        }
                    %>
                    <a href="aboutus.jsp">About Us</a>
                    <a href="contactus.jsp">Contact Us</a>
                </div>
                <div class="auth-buttons">
                    <%
                        if (userEmail != null) {
                    %>
                    <a href="#" class="btn btn-outline"><%= userEmail %></a>
                    <a href="logout" class="btn btn-primary">Logout</a>
                    <%
                        } else {
                    %>
                    <a href="login.jsp" class="btn btn-outline">Login</a>
                    <a href="signup.jsp" class="btn btn-primary">Register</a>
                    <%
                        }
                    %>
                </div>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <!-- Hero Section -->
        <section class="hero">
            <h1>Our Beauty Services</h1>
            <p>Discover our range of premium beauty services designed to make you look and feel your best. Book your appointment today!</p>
            <div class="hero-buttons">
                <a href="#services" class="hero-btn hero-btn-primary">View Services</a>
                <a href="contactus.jsp" class="hero-btn hero-btn-secondary">Contact Us</a>
            </div>
        </section>

        <!-- Services Section -->
        <section id="services" class="services">
            <div class="container">
                <h2>Our Services</h2>

                <!-- Booking Success Message -->
                <c:if test="${param.booking == 'success'}">
                    <div class="success-message">
                        Booking confirmed successfully!
                    </div>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- Booking Form (Shared for all services) -->
                <div class="booking-form-container" id="booking-form">
                    <div class="form-header">
                        <h2>Book Appointment</h2>
                        <p class="selected-service" id="selected-service-text">Service: [Select a service]</p>
                    </div>
                    <form class="booking-form" action="book" method="post">
                        <div class="form-group">
                            <label for="date">Date</label>
                            <input type="date" id="date" name="date" required min="<%= java.time.LocalDate.now() %>">
                        </div>
                        <div class="form-group">
                            <label for="time">Time</label>
                            <input type="time" id="time" name="time" required>
                        </div>
                        <div class="form-group">
                            <label for="notes">Notes (Optional)</label>
                            <textarea id="notes" name="notes" rows="2"></textarea>
                        </div>
                        <input type="hidden" id="service" name="service" value="">
                        <button type="submit" class="submit-btn">Confirm Booking</button>
                    </form>
                </div>

                <!-- Dynamic Services List -->
                <c:forEach items="${serviceCategories}" var="category">
                    <div class="service-category">
                        <h3>
                            <c:choose>
                                <c:when test="${category eq 'Hair'}"><i class="fas fa-cut"></i> Hair Services</c:when>
                                <c:when test="${category eq 'Facial'}"><i class="fas fa-spa"></i> Facial Services</c:when>
                                <c:when test="${category eq 'Nail'}"><i class="fas fa-hand-sparkles"></i> Nail Services</c:when>
                                <c:otherwise><i class="fas fa-concierge-bell"></i> ${category} Services</c:otherwise>
                            </c:choose>
                        </h3>
                        <div class="service-grid">
                            <c:forEach items="${services}" var="service">
                                <c:if test="${service.category eq category}">
                                    <div class="service-card">
                                        <h4>${service.service_Name}</h4>
                                        <p>${service.description}</p>
                                        <p class="price">$${service.price}</p>
                                        <ul class="service-features">
                                            <c:forEach items="${service.features}" var="feature">
                                                <li>${feature}</li>
                                            </c:forEach>
                                        </ul>
                                        <button class="service-book-btn" onclick="showBookingForm(${service.service_Id}, '${service.service_Name}')">Book Now</button>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>

                <!-- If no services are available -->
                <c:if test="${empty services}">
                    <div class="no-services">
                        <h3>No services available at the moment.</h3>
                        <p>Please check back later or contact us for more information.</p>
                    </div>
                </c:if>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-section">
                <h3>PrettyPick</h3>
                <p>Your smart salon appointment booking system.</p>
                <p>Making beauty services accessible and convenient.</p>
                <p class="address">123 Beauty Lane, Salon City</p>
                <p class="phone">(123) 456-7890</p>
                <p class="email">info@prettypick.com</p>
            </div>

            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="services">Services</a></li>
                    <li><a href="bookings">My Bookings</a></li>
                    <li><a href="aboutus.jsp">About Us</a></li>
                    <li><a href="contactus.jsp">Contact Us</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Connect With Us</h3>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <div class="newsletter">
                    <input type="email" placeholder="Enter your email">
                    <button class="subscribe-btn">Subscribe</button>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2023 PrettyPick. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function showBookingForm(serviceId, serviceName) {
            // Show the form
            const formContainer = document.getElementById('booking-form');
            formContainer.classList.add('active');

            // Update the selected service text
            const selectedServiceText = document.getElementById('selected-service-text');
            selectedServiceText.textContent = `Service: ${serviceName}`;

            // Set the hidden service input value
            const serviceInput = document.getElementById('service');
            serviceInput.value = serviceId;

            // Scroll to the form
            formContainer.scrollIntoView({ behavior: 'smooth' });
        }
    </script>
</body>
</html>
