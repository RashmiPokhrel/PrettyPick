<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - PrettyPick</title>
    <link rel="stylesheet" href="Css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 404 Page Specific Styles */
        .error-container {
            max-width: 800px;
            margin: 5rem auto;
            padding: 2rem;
            text-align: center;
            background-color: var(--light-color);
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }
        
        .error-icon {
            font-size: 5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .error-container h1 {
            font-size: 2.5rem;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }
        
        .error-container p {
            font-size: 1.1rem;
            color: var(--gray-color);
            margin-bottom: 2rem;
        }
        
        .error-code {
            font-size: 8rem;
            font-weight: bold;
            color: var(--primary-color);
            margin-bottom: 1rem;
            line-height: 1;
        }
        
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 1rem;
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
                    <a href="service.jsp">Services</a>
                    <a href="aboutus.jsp">About Us</a>
                    <a href="contactus.jsp">Contact Us</a>
                </div>
                <div class="auth-buttons">
                    <a href="login.jsp" class="btn btn-outline">Login</a>
                    <a href="signup.jsp" class="btn btn-primary">Register</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <div class="error-container">
            <div class="error-code">404</div>
            <div class="error-icon">
                <i class="fas fa-search"></i>
            </div>
            <h1>Page Not Found</h1>
            <p>The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
            
            <div class="btn-container">
                <a href="javascript:history.back()" class="btn btn-outline">Go Back</a>
                <a href="home.jsp" class="btn btn-primary">Go to Homepage</a>
            </div>
        </div>
    </main>
    
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
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="service.jsp">Services</a></li>
                        <li><a href="bookings.jsp">My Bookings</a></li>
                        <li><a href="aboutus.jsp">About Us</a></li>
                        <li><a href="contactus.jsp">Contact Us</a></li>
                    </ul>
                </div>
                <div class="footer-section social">
                    <h3>Follow Us</h3>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 PrettyPick. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
