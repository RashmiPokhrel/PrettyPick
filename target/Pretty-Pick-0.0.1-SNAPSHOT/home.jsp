<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrettyPick - Smart Salon Appointment Booking</title>
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

        /* Hero Section */
        .hero {
            padding: 150px 0 100px;
            background-color: var(--light-color);
        }

        .hero .container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .hero-content {
            flex: 1;
            padding-right: 50px;
        }

        .hero-content h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            color: var(--dark-color);
            line-height: 1.2;
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: var(--gray-color);
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
        }

        .hero-image {
            flex: 1;
            text-align: center;
        }

        /* Services Section */
        .services {
            padding: 100px 0;
            background-color: white;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .service-card {
            background-color: var(--secondary-color);
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .service-card:hover {
            transform: translateY(-10px);
        }

        .service-icon {
            width: 70px;
            height: 70px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .service-icon i {
            font-size: 30px;
            color: var(--primary-color);
        }

        .service-card h3 {
            margin-bottom: 15px;
            color: var(--dark-color);
        }

        .service-card p {
            margin-bottom: 20px;
            color: var(--gray-color);
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
            .hero .container {
                flex-direction: column;
                text-align: center;
            }

            .hero-content {
                padding-right: 0;
                margin-bottom: 50px;
            }

            .hero-buttons {
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

            .services-grid {
                grid-template-columns: 1fr;
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
                    <li><a href="/services">Services</a></li>
                    <li><a href="aboutus.jsp">About Us</a></li>
                    <li><a href="contactus.jsp">Contact Us</a></li>
                </ul>
                <div class="auth-buttons">
                    <a href="login.jsp" class="btn btn-outline">Login</a>
                    <a href="signup.jsp" class="btn btn-primary">Register</a>
                </div>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section id="home" class="hero">
    <div class="container">
        <div class="hero-content">
            <h1>Beauty Appointments Made Simple</h1>
            <p>Book your salon services online with just a few clicks. No waiting, no calls.</p>
            <div class="hero-buttons">
                <a href="views/auth/register.html" class="btn btn-primary btn-large">Book Now</a>
                <a href="#services" class="btn btn-outline btn-large">Explore Services</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="/placeholder.svg?height=400&width=600" alt="">
        </div>
    </div>
</section>

<!-- How It Works -->
<section id="how-it-works" class="how-it-works">
    <div class="container">
        <div class="section-header">
            <h2>How It Works</h2>
            <p>Book your appointment in 3 simple steps</p>
        </div>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Create an Account</h3>
                <p>Register with your email and set up your profile</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Choose a Service</h3>
                <p>Browse our services and select what you need</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Book Your Slot</h3>
                <p>Select a convenient date and time for your appointment</p>
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
        <h2>Ready to Look Your Best?</h2>
        <p>Book your appointment today and experience premium salon services</p>
        <a href="views/auth/register.html" class="btn btn-primary btn-large">Get Started</a>
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
                    <li><a href="#services">Services</a></li>
                    <li><a href="#how-it-works">How It Works</a></li>
                    <li><a href="views/auth/login.html">Login</a></li>
                    <li><a href="views/auth/register.html">Register</a></li>
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
</body>
</html>