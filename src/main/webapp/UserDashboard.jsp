<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrettyPick - User Dashboard</title>
    <!-- Font Awesome CDN for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Global Styles */
        :root {
            --primary-color: #A7C7E7; /* Pastel Blue */
            --secondary-color: #F8FAFC; /* Snow White */
            --accent-color: #8FB1D9; /* Darker Pastel Blue for hover/accent */
            --dark-color: #2c3e50; /* Dark color for text */
            --light-color: #F8FAFC; /* Snow White for backgrounds */
            --gray-color: #6c757d; /* Gray for secondary text */
            --box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            background-color: var(--light-color);
            scroll-behavior: smooth;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        a {
            text-decoration: none;
            color: var(--dark-color);
        }

        ul {
            list-style: none;
        }

        img {
            max-width: 100%;
        }

        .section-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-header h2 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .section-header p {
            color: var(--gray-color);
            font-size: 1.1rem;
        }

        /* Button Styles */
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: var(--dark-color);
        }

        .btn-primary:hover {
            background-color: var(--accent-color);
            transform: translateY(-3px);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            color: var(--dark-color);
            border: 1px solid var(--primary-color);
        }

        .btn-secondary:hover {
            background-color: #E6ECEF; /* Slightly darker snow white */
            transform: translateY(-3px);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background-color: var(--primary-color);
            color: var(--dark-color);
            transform: translateY(-3px);
        }

        .btn-large {
            padding: 12px 30px;
            font-size: 1.1rem;
        }

        /* Header Styles */
        header {
            background-color: var(--secondary-color);
            box-shadow: var(--box-shadow);
            position: fixed;
            width: 100%;
            z-index: 1000;
        }

        header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }

        .logo h1 {
            font-size: 1.8rem;
            color: var(--primary-color);
            font-weight: 700;
        }

        nav {
            display: flex;
            align-items: center;
        }

        .nav-toggle {
            display: none;
        }

        .nav-toggle-label {
            display: none;
            cursor: pointer;
        }

        .nav-toggle-label span {
            display: block;
            width: 25px;
            height: 3px;
            margin: 5px 0;
            background-color: var(--dark-color);
            transition: var(--transition);
        }

        .nav-wrapper {
            display: flex;
            align-items: center;
        }

        .nav-links {
            display: flex;
            margin-right: 30px;
        }

        .nav-links li {
            margin: 0 15px;
        }

        .nav-links a {
            font-weight: 600;
            transition: var(--transition);
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .auth-buttons {
            display: flex;
            gap: 10px;
        }

        /* Welcome Section */
        .welcome-section {
            padding: 150px 0 100px;
            background-color: var(--light-color);
            text-align: center;
        }

        .welcome-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .welcome-content h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            color: var(--dark-color);
            line-height: 1.2;
        }

        .welcome-content p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: var(--gray-color);
        }

        .welcome-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        /* How It Works Section */
        .how-it-works {
            padding: 100px 0;
            background-color: var(--light-color);
        }

        .steps {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
        }

        .step {
            flex: 1;
            min-width: 250px;
            text-align: center;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }

        .step-number {
            width: 50px;
            height: 50px;
            background-color: var(--primary-color);
            color: var(--dark-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .step h3 {
            margin-bottom: 15px;
            color: var(--dark-color);
        }

        .step p {
            color: var(--gray-color);
        }

        /* Testimonials Section */
        .testimonials {
            padding: 100px 0;
            background-color: white;
        }

        .testimonial-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        .testimonial {
            background-color: var(--light-color);
            border-radius: 10px;
            padding: 30px;
            box-shadow: var(--box-shadow);
        }

        .testimonial-content {
            margin-bottom: 20px;
        }

        .testimonial-content p {
            font-style: italic;
            color: var(--dark-color);
        }

        .testimonial-author {
            display: flex;
            align-items: center;
        }

        .author-image {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-right: 15px;
            object-fit: cover;
        }

        .author-info h4 {
            margin-bottom: 5px;
            color: var(--dark-color);
        }

        .author-info p {
            color: var(--gray-color);
            font-size: 0.9rem;
        }

        /* CTA Section */
        .cta {
            padding: 80px 0;
            background-color: var(--secondary-color);
            text-align: center;
            color: var(--dark-color);
        }

        .cta h2 {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .cta p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .cta .btn-primary {
            background-color: var(--primary-color);
            color: var(--dark-color);
        }

        .cta .btn-primary:hover {
            background-color: var(--accent-color);
            transform: translateY(-3px);
        }

        /* Profile Section Styles */
        .profile-section {
            padding: 80px 0;
            background-color: var(--light-color);
        }

        .profile-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .profile-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .profile-header {
            display: flex;
            align-items: center;
            padding: 30px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .profile-avatar i {
            font-size: 40px;
            color: var(--primary-color);
        }

        .profile-info h3 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .profile-info p {
            margin-bottom: 5px;
            opacity: 0.9;
        }

        .badge {
            display: inline-block;
            padding: 5px 10px;
            background-color: white;
            color: var(--primary-color);
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .profile-tabs {
            display: flex;
            border-bottom: 1px solid #eee;
        }

        .tab-btn {
            padding: 15px 20px;
            background: none;
            border: none;
            cursor: pointer;
            font-weight: bold;
            color: var(--gray-color);
            transition: var(--transition);
            position: relative;
        }

        .tab-btn.active {
            color: var(--primary-color);
        }

        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: var(--primary-color);
        }

        .tab-content {
            display: none;
            padding: 30px;
        }

        .tab-content.active {
            display: block;
        }

        .profile-form .form-group {
            margin-bottom: 20px;
        }

        .profile-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark-color);
        }

        .profile-form input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: var(--transition);
        }

        .profile-form input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(167, 199, 231, 0.2);
            outline: none;
        }

        .success-message, .error-message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
        }

        .success-message i, .error-message i {
            margin-right: 10px;
            font-size: 18px;
        }

        /* Footer */
        footer {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            padding: 80px 0 20px;
        }

        .footer-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 40px;
            margin-bottom: 50px;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
        }

        .footer-section h3 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--secondary-color);
        }

        .footer-section p {
            margin-bottom: 15px;
            color: var(--secondary-color);
        }

        .contact p {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-section.links ul li {
            margin-bottom: 10px;
        }

        .footer-section.links ul li a {
            color: var(--secondary-color);
            transition: var(--transition);
        }

        .footer-section.links ul li a:hover {
            color: var(--accent-color);
            padding-left: 5px;
        }

        .social-icons {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .social-icons a {
            width: 40px;
            height: 40px;
            background-color: var(--secondary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--dark-color);
            transition: var(--transition);
        }

        .social-icons a:hover {
            background-color: var(--accent-color);
            transform: translateY(-3px);
        }

        .newsletter {
            display: flex;
            margin-top: 20px;
        }

        .newsletter input {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 5px 0 0 5px;
        }

        .newsletter button {
            border-radius: 0 5px 5px 0;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid var(--secondary-color);
            color: var(--secondary-color);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .welcome-section .container {
                flex-direction: column;
                text-align: center;
            }

            .welcome-content {
                padding-right: 0;
                margin-bottom: 50px;
            }

            .welcome-buttons {
                justify-content: center;
            }

            .steps {
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            .nav-toggle-label {
                display: block;
                z-index: 1001;
            }

            .nav-wrapper {
                position: fixed;
                top: 0;
                right: -100%;
                width: 80%;
                height: 100vh;
                background-color: var(--secondary-color);
                flex-direction: column;
                align-items: flex-start;
                padding: 80px 20px 20px;
                transition: right 0.3s ease;
                box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
            }

            .nav-toggle:checked ~ .nav-wrapper {
                right: 0;
            }

            .nav-links {
                flex-direction: column;
                width: 100%;
                margin-right: 0;
                margin-bottom: 30px;
            }

            .nav-links li {
                margin: 10px 0;
            }

            .auth-buttons {
                flex-direction: column;
                width: 100%;
                gap: 15px;
            }

            .auth-buttons a {
                width: 100%;
                text-align: center;
            }

            .testimonial-grid {
                grid-template-columns: 1fr;
            }

            .footer-content {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container">
        <div class="logo">
            <h1>PrettyPick</h1>
        </div>
        <nav>
            <input type="checkbox" id="nav-toggle" class="nav-toggle">
            <label for="nav-toggle" class="nav-toggle-label">
                <span></span>
                <span></span>
                <span></span>
            </label>
            <div class="nav-wrapper">
                <ul class="nav-links">
                    <li><a href="#home">Home</a></li>
                    <li><a href="services">Service</a></li>
                    <li><a href="aboutus.jsp">About us</a></li>
                    <li><a href="contactus.jsp">Contact Us</a></li>
                </ul>
                <div class="auth-buttons">
                    <%
                        String email = null;
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
                    <a href="#" class="btn btn-outline"><%= email != null ? email : "Guest" %></a>
                    <a href="logout" class="btn btn-primary">Logout</a>
                </div>
            </div>
        </nav>
    </div>
</header>

<!-- Welcome Section -->
<section id="home" class="welcome-section">
    <div class="container">
        <div class="welcome-content">
            <h1>Welcome, ${user.name}!</h1>
            <p>Your beauty journey starts here. Book your salon services with ease.</p>
            <div class="welcome-buttons">
                <a href="service.jsp" class="btn btn-primary btn-large">Book Appointment</a>
                <a href="#profile" class="btn btn-outline btn-large">My Profile</a>
            </div>
        </div>
    </div>
</section>

<!-- Profile Section -->
<section id="profile" class="profile-section">
    <div class="container">
        <div class="section-header">
            <h2>My Profile</h2>
            <p>Manage your personal information</p>
        </div>

        <!-- Success Messages -->
        <c:if test="${param.profileUpdated == 'true'}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> Your profile has been updated successfully.
            </div>
        </c:if>
        <c:if test="${param.passwordUpdated == 'true'}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> Your password has been updated successfully.
            </div>
        </c:if>

        <!-- Error Messages -->
        <c:if test="${not empty profileError}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${profileError}
            </div>
        </c:if>
        <c:if test="${not empty passwordError}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${passwordError}
            </div>
        </c:if>

        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="profile-info">
                        <h3>${user.name}</h3>
                        <p>${user.email}</p>
                        <p><span class="badge">${user.role}</span></p>
                    </div>
                </div>

                <div class="profile-tabs">
                    <button class="tab-btn active" onclick="openTab(event, 'personal-info')">Personal Information</button>
                    <button class="tab-btn" onclick="openTab(event, 'change-password')">Change Password</button>
                </div>

                <div id="personal-info" class="tab-content active">
                    <form action="user-dashboard" method="post" class="profile-form">
                        <input type="hidden" name="action" value="updateProfile">

                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="${user.name}" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" value="${user.email}" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" value="${user.phone}">
                        </div>

                        <button type="submit" class="btn btn-primary">Update Profile</button>
                    </form>
                </div>

                <div id="change-password" class="tab-content">
                    <form action="user-dashboard" method="post" class="profile-form">
                        <input type="hidden" name="action" value="updatePassword">

                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" required>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" required>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Change Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- How It Works -->
<section id="how-it-works" class="how-it-works">
    <div class="container">
        <div class="section-header">
            <h2>Our Services</h2>
            <p>Always their to make you feel pretty</p>
        </div>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Manicure</h3>
                <p>Get Awesome manicure</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Facial</h3>
                <p>Glow as Moon</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Hair SPA</h3>
                <p>Get a silky and shiny hair.</p>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials -->
<section id="testimonials" class="testimonials">
    <div class="container">
        <div class="section-header">
            <h2>What Our Clients Say</h2>
            <p>Hear from our satisfied customers</p>
        </div>
        <div class="testimonial-grid">
            <div class="testimonial">
                <div class="testimonial-content">
                    <p>"The online booking system is so convenient! I love being able to schedule my appointments anytime without having to call."</p>
                </div>
                <div class="testimonial-author">
                    <img src="" alt="" class="">
                    <div class="author-info">
                        <h4>Rahul Shah</h4>
                        <p>Regular Client</p>
                    </div>
                </div>
            </div>
            <div class="testimonial">
                <div class="testimonial-content">
                    <p>"PrettyPick has made it so easy to book my monthly hair appointments. The reminders are helpful and rescheduling is hassle-free!"</p>
                </div>
                <div class="testimonial-author">
                    <img src="" alt="" class="">
                    <div class="author-info">
                        <h4>Munna Raj Yadav</h4>
                        <p>Loyal Customer</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta">
    <div class="container">
        <h2>Ready for Your Next Appointment?</h2>
        <p>Book now and experience premium salon services tailored just for you</p>
        <a href="user-bookings" class="btn btn-primary btn-large">Book Now</a>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-section about">
                <h3>PrettyPick</h3>
                <p>Your smart salon appointment booking system. Making beauty services accessible and convenient.</p>
                <div class="contact">
                    <p><i class="fas fa-map-marker-alt"></i> 123 Beauty Lane, Salon City</p>
                    <p><i class="fas fa-phone"></i> (123) 456-7890</p>
                    <p><i class="fas fa-envelope"></i> info@prettypick.com</p>
                </div>
            </div>
            <div class="footer-section links">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="#home">Home</a></li>
                    <li><a href="#how-it-works">How It Works</a></li>
                    <li><a href="#testimonials">Testimonials</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="signup.jsp">Register</a></li>
                </ul>
            </div>
            <div class="footer-section social">
                <h3>Connect With Us</h3>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-pinterest"></i></a>
                </div>
                <form class="newsletter" action="newsletter-signup" method="post">
                    <input type="email" name="email" placeholder="Enter your email" required>
                    <button type="submit" class="btn btn-primary">Subscribe</button>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 PrettyPick. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    // Tab functionality for profile section
    function openTab(evt, tabName) {
        // Hide all tab content
        var tabContents = document.getElementsByClassName("tab-content");
        for (var i = 0; i < tabContents.length; i++) {
            tabContents[i].classList.remove("active");
        }

        // Remove active class from all tab buttons
        var tabButtons = document.getElementsByClassName("tab-btn");
        for (var i = 0; i < tabButtons.length; i++) {
            tabButtons[i].classList.remove("active");
        }

        // Show the current tab and add active class to the button
        document.getElementById(tabName).classList.add("active");
        evt.currentTarget.classList.add("active");
    }

    // Password validation
    document.addEventListener('DOMContentLoaded', function() {
        var passwordForm = document.querySelector('form[action="user-dashboard"][method="post"]:nth-of-type(2)');
        if (passwordForm) {
            passwordForm.addEventListener('submit', function(e) {
                var newPassword = document.getElementById('newPassword').value;
                var confirmPassword = document.getElementById('confirmPassword').value;

                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('New passwords do not match!');
                }
            });
        }
    });
</script>

</body>
</html>