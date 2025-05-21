<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
            background-color: var(--snow-white);
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            padding: 0.5rem 0;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 5%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .logo {
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--logo-blue);
            text-decoration: none;
            letter-spacing: -0.5px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 3rem;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--nav-text);
            font-weight: 500;
            font-size: 0.95rem;
            transition: color 0.3s;
        }

        .nav-links a:not(.login-btn, .register-btn):hover {
            color: var(--logo-blue);
        }

        .login-btn {
            padding: 0.6rem 2rem;
            border: 1px solid var(--register-blue);
            border-radius: 6px;
            color: var(--register-blue) !important;
            background: transparent;
            transition: all 0.3s ease;
            margin-left: 1rem;
        }

        .login-btn:hover {
            background: rgba(184, 216, 232, 0.1);
        }

        .register-btn {
            padding: 0.6rem 2rem;
            background-color: var(--register-blue);
            border-radius: 6px;
            color: var(--snow-white) !important;
            border: 1px solid var(--register-blue);
            transition: all 0.3s ease;
            margin-left: 0.5rem;
        }

        .register-btn:hover {
            background-color: #a8c8d8;
            border-color: #a8c8d8;
        }

        /* Hero section (simplified offers) */
        .hero {
            padding: 8rem 5% 5rem;
            max-width: 1400px;
            margin: 0 auto;
            background-color: var(--snow-white);
        }

        .hero-content {
            text-align: center;
        }

        .hero h1 {
            font-size: 3.5rem;
            line-height: 1.1;
            color: var(--dark-blue);
            margin-bottom: 3rem;
            font-weight: 800;
            text-align: center;
            position: relative;
        }

        .hero h1::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--register-blue);
            margin: 1rem auto;
            border-radius: 2px;
        }

        /* Offers Container */
        .offers-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 1rem;
        }

        .offer-card {
            background: var(--snow-white);
            border-radius: 12px;
            border: 1px solid var(--light-blue);
            padding: 1.5rem;
            text-align: center;
            position: relative;
        }

        .offer-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--register-blue);
            color: var(--snow-white);
            padding: 0.4rem 0.8rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .offer-card.seasonal .offer-badge {
            background: #FF6B6B;
        }

        .offer-card.featured {
            border: 2px solid var(--register-blue);
        }

        .offer-title {
            font-size: 1.4rem;
            color: var(--dark-blue);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .offer-price {
            margin: 1rem 0;
        }

        .offer-price .discount {
            font-size: 1.5rem;
            color: var(--register-blue);
            font-weight: 700;
        }

        .offer-price .original {
            font-size: 1rem;
            color: var(--nav-text);
            text-decoration: line-through;
            margin-right: 0.5rem;
        }

        .offer-details ul {
            list-style: none;
            padding: 0;
            margin: 1rem 0;
        }

        .offer-details li {
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
            font-size: 0.95rem;
        }

        /* Booking Form Styles */
        .booking-form-container {
            display: none;
            background-color: var(--snow-white);
            padding: 2rem;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            margin: 2rem auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .booking-form-container.active {
            display: block;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .form-header h2 {
            color: var(--dark-blue);
            margin-bottom: 0.5rem;
        }

        .selected-service {
            color: var(--dark-blue);
            font-weight: bold;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .service-details {
            color: var(--pastel-blue);
            font-weight: 500;
            margin: 0.25rem 0;
        }

        .booking-summary {
            margin-top: 2rem;
            padding: 1rem;
            background-color: #f9f9f9;
            border-radius: 5px;
            border-left: 4px solid var(--pastel-blue);
        }

        .booking-summary h3 {
            color: var(--dark-blue);
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .booking-summary p {
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .booking-summary a {
            color: var(--pastel-blue);
            text-decoration: none;
        }

        .booking-summary a:hover {
            text-decoration: underline;
        }

        .form-header h2 {
            color: var(--dark-blue);
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .selected-service {
            color: var(--pastel-blue);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .booking-form .form-group {
            margin-bottom: 1rem;
        }

        .booking-form label {
            display: block;
            margin-bottom: 0.3rem;
            color: var(--dark-blue);
            font-weight: 500;
            font-size: 0.9rem;
        }

        .booking-form input,
        .booking-form textarea {
            width: 100%;
            padding: 0.6rem;
            border: 1px solid var(--light-blue);
            border-radius: 5px;
            font-size: 0.9rem;
            transition: border-color 0.3s;
        }

        .booking-form input:focus,
        .booking-form textarea:focus {
            outline: none;
            border-color: var(--pastel-blue);
        }

        .submit-btn {
            width: 100%;
            padding: 0.8rem;
            background-color: var(--pastel-blue);
            color: var(--dark-blue);
            border: none;
            border-radius: 5px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: var(--dark-blue);
            color: var(--snow-white);
        }

        /* Success message */
        .success-message {
            text-align: center;
            color: var(--pastel-blue);
            font-size: 1.2rem;
            margin: 1rem 0;
        }

        /* Bookings Display */
        .bookings-container {
            margin: 2rem auto;
            max-width: 1200px;
            padding: 1rem;
        }

        .bookings-container h3 {
            color: var(--dark-blue);
            margin-bottom: 1rem;
        }

        .booking-item {
            background: var(--snow-white);
            padding: 1rem;
            border-radius: 5px;
            border: 1px solid var(--light-blue);
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
        }

        /* Services section */
        .services {
            padding: 5rem 5%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .services h2 {
            text-align: center;
            margin-bottom: 3rem;
            font-size: 2.5rem;
            color: var(--dark-blue);
        }

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
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .service-card {
            background: var(--snow-white);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
            text-align: left;
            transition: transform 0.3s;
            border: 1px solid var(--light-blue);
        }

        .service-card:hover {
            transform: translateY(-5px);
        }

        .service-card h4 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--dark-blue);
        }

        .service-card p {
            color: var(--dark-blue);
            margin-bottom: 1rem;
        }

        .price {
            font-weight: bold;
            color: var(--pastel-blue);
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        .service-features {
            list-style: none;
            margin: 1rem 0;
        }

        .service-features li {
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
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
        }

        .service-book-btn:hover {
            background-color: var(--light-blue);
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
            color: var(--light-blue);
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 0.8rem;
        }

        .footer-section ul a {
            color: var(--light-blue);
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
            gap: 0.5rem;
        }

        .newsletter input {
            padding: 0.8rem;
            border: none;
            border-radius: 5px;
            flex: 1;
            background-color: var(--snow-white);
        }

        .subscribe-btn {
            padding: 0.8rem 1.5rem;
            background-color: var(--pastel-blue);
            color: var(--dark-blue);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: 500;
        }

        .subscribe-btn:hover {
            background-color: var(--light-blue);
        }

        .footer-bottom {
            text-align: center;
            margin-top: 3rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.1);
            color: var(--light-blue);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .offers-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .offers-container {
                grid-template-columns: 1fr;
                padding: 0.5rem;
            }

            .offer-card {
                max-width: 400px;
                margin: 0 auto;
            }

            .nav-links {
                display: none;
            }

            .services h2 {
                font-size: 2rem;
            }

            .service-category h3 {
                font-size: 1.8rem;
            }

            .footer-container {
                grid-template-columns: 1fr;
            }

            .booking-form-container {
                width: 95%;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Include the common header -->
<%@ include file="includes/header.jsp" %>

<main>
    <!-- Offer Section (simplified) -->
    <section class="hero">
        <div class="hero-content">
            <h1>Special Offers</h1>
            <div class="offers-container">
                <div class="offer-card featured">
                    <div class="offer-badge">FEATURED</div>
                    <div class="offer-title">New Customer Special</div>
                    <div class="offer-price">
                        <span class="original">NPR 2,000</span>
                        <span class="discount">50% OFF</span>
                    </div>
                    <div class="offer-details">
                        <ul>
                            <li>Any Service</li>
                            <li>Free Consultation</li>
                            <li>Product Sample Kit</li>
                        </ul>
                    </div>
                </div>

                <div class="offer-card">
                    <div class="offer-title">Package Deal</div>
                    <div class="offer-price">
                        <span class="original">NPR 3,000</span>
                        <span class="discount">NPR 1,999</span>
                    </div>
                    <div class="offer-details">
                        <ul>
                            <li>Haircut & Style</li>
                            <li>Free Hair Spa</li>
                            <li>Free Hair Mask</li>
                        </ul>
                    </div>
                </div>

                <div class="offer-card seasonal">
                    <div class="offer-badge">LIMITED TIME</div>
                    <div class="offer-title">Winter Special</div>
                    <div class="offer-price">
                        <span class="discount">30% OFF</span>
                    </div>
                    <div class="offer-details">
                        <ul>
                            <li>All Hair Treatments</li>
                            <li>Free Deep Conditioning</li>
                            <li>Valid this Month</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="services">
        <h2>Our Services</h2>

        <!-- Booking Success Message -->
        <c:if test="${param.booking == 'success'}">
            <div class="success-message">
                Booking confirmed successfully!
            </div>
        </c:if>

        <!-- Display Bookings from Session -->
        <div class="bookings-container">
            <h3>Your Bookings</h3>
            <c:if test="${not empty sessionScope.bookings}">
                <c:forEach var="booking" items="${sessionScope.bookings}">
                    <div class="booking-item">${booking}</div>
                </c:forEach>
            </c:if>
            <c:if test="${empty sessionScope.bookings}">
                <p>No bookings yet.</p>
            </c:if>
        </div>

        <!-- Booking Form (Shared for all services) -->
        <div class="booking-form-container" id="booking-form">
            <div class="form-header">
                <h2>Book Appointment</h2>
                <p class="selected-service" id="selected-service-text">Service: [Select a service]</p>
                <p class="service-details" id="service-price">Price: $0.00</p>
                <p class="service-details" id="service-duration">Duration: 0 min</p>
            </div>
            <form class="booking-form" action="book" method="post">
                <div class="form-group">
                    <label for="date">Date</label>
                    <input type="date" id="date" name="date" required min="<%= java.time.LocalDate.now() %>">
                </div>
                <div class="form-group">
                    <label for="time">Time</label>
                    <select id="time" name="time" required>
                        <option value="">Select a time</option>
                        <option value="09:00">9:00 AM</option>
                        <option value="10:00">10:00 AM</option>
                        <option value="11:00">11:00 AM</option>
                        <option value="12:00">12:00 PM</option>
                        <option value="13:00">1:00 PM</option>
                        <option value="14:00">2:00 PM</option>
                        <option value="15:00">3:00 PM</option>
                        <option value="16:00">4:00 PM</option>
                        <option value="17:00">5:00 PM</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="notes">Special Requests (Optional)</label>
                    <textarea id="notes" name="notes" rows="2" placeholder="Any special requests or preferences?"></textarea>
                </div>
                <input type="hidden" id="service" name="service" value="">
                <div class="booking-summary">
                    <h3>Booking Summary</h3>
                    <p>Please review your booking details before confirming.</p>
                    <p>By booking this service, you agree to our <a href="#">Terms and Conditions</a>.</p>
                </div>
                <button type="submit" class="submit-btn">Confirm Booking</button>
            </form>
        </div>

        <!-- Dynamic Services List -->
        <c:forEach var="category" items="${serviceCategories}">
            <div class="service-category">
                <h3>
                    <c:choose>
                        <c:when test="${category eq 'Hair'}"><i class="fas fa-cut"></i> Hair Services</c:when>
                        <c:when test="${category eq 'Facial'}"><i class="fas fa-spa"></i> Facial Services</c:when>
                        <c:when test="${category eq 'Nail'}"><i class="fas fa-hand-sparkles"></i> Nail Services</c:when>
                        <c:when test="${category eq 'Massage & Spa'}"><i class="fas fa-hot-tub"></i> Massage & Spa Services</c:when>
                        <c:when test="${category eq 'Makeup'}"><i class="fas fa-magic"></i> Makeup Services</c:when>
                        <c:otherwise><i class="fas fa-concierge-bell"></i> ${category} Services</c:otherwise>
                    </c:choose>
                </h3>
                <div class="service-grid">
                    <c:forEach var="service" items="${services}">
                        <c:if test="${service.category eq category}">
                            <div class="service-card" data-duration="${service.duration}">
                                <h4>${service.service_Name}</h4>
                                <p>${service.description}</p>
                                <p class="price">$${service.price}</p>
                                <ul class="service-features">
                                    <c:forEach var="feature" items="${service.features}">
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
                <li><a href="UserDashboard.jsp">Home</a></li>
                <li><a href="services">Services</a></li>
                <li><a href="user-bookings">My Bookings</a></li>
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
        // Get service details from the card
        const serviceCard = event.target.closest('.service-card');
        const priceText = serviceCard.querySelector('.price').textContent;
        const durationText = serviceCard.dataset.duration || '60 min'; // Default to 60 min if not specified

        // Show the form
        const formContainer = document.getElementById('booking-form');
        formContainer.classList.add('active');

        // Update the selected service text
        const selectedServiceText = document.getElementById('selected-service-text');
        selectedServiceText.textContent = `Service: ${serviceName}`;

        // Update price and duration
        document.getElementById('service-price').textContent = `Price: ${priceText}`;
        document.getElementById('service-duration').textContent = `Duration: ${durationText}`;

        // Set the hidden service input value
        const serviceInput = document.getElementById('service');
        serviceInput.value = serviceId;

        // Scroll to the form
        formContainer.scrollIntoView({ behavior: 'smooth' });

        // Set minimum date to today
        const dateInput = document.getElementById('date');
        const today = new Date().toISOString().split('T')[0];
        dateInput.min = today;
        dateInput.value = today;
    }
</script>
</body>
</html>