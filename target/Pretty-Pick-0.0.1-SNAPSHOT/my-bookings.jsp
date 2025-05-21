<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - PrettyPick</title>
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
            padding-bottom: 3rem;
        }

        /* Bookings page styles */
        .bookings-header {
            background: linear-gradient(135deg, var(--pastel-blue), var(--light-blue));
            padding: 3rem 5%;
            text-align: center;
            color: var(--dark-blue);
        }

        .bookings-header h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .bookings-header p {
            font-size: 1.1rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .bookings-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 5%;
        }

        /* Success and error messages */
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 500;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 500;
        }

        /* Booking cards */
        .booking-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .booking-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            padding: 1.5rem;
            transition: transform 0.3s;
            position: relative;
            overflow: hidden;
        }

        .booking-card:hover {
            transform: translateY(-5px);
        }

        .booking-card h3 {
            font-size: 1.5rem;
            color: var(--dark-blue);
            margin-bottom: 0.5rem;
        }

        .booking-details {
            margin-bottom: 1.5rem;
        }

        .booking-details p {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .booking-details i {
            color: var(--logo-blue);
            width: 20px;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .confirmed {
            background-color: #d4edda;
            color: #155724;
        }

        .cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .completed {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .booking-actions {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            padding: 0.4rem 0.8rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 0.8rem;
            transition: background-color 0.3s, color 0.3s;
        }

        .reschedule-btn {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .reschedule-btn:hover {
            background-color: #0c5460;
            color: white;
        }

        .cancel-btn {
            background-color: #f8d7da;
            color: #721c24;
        }

        .cancel-btn:hover {
            background-color: #721c24;
            color: white;
        }

        .no-bookings {
            text-align: center;
            padding: 3rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .no-bookings h2 {
            color: var(--dark-blue);
            margin-bottom: 1rem;
        }

        .no-bookings p {
            color: var(--nav-text);
            margin-bottom: 1.5rem;
        }

        /* Status ribbon */
        .status-ribbon {
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            overflow: hidden;
        }

        .status-ribbon-inner {
            position: absolute;
            top: 30px;
            right: -40px;
            transform: rotate(45deg);
            width: 200px;
            text-align: center;
            padding: 0.5rem 0;
            font-weight: bold;
            font-size: 0.8rem;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .ribbon-pending {
            background-color: #ffc107;
        }

        .ribbon-confirmed {
            background-color: #28a745;
        }

        .ribbon-cancelled {
            background-color: #dc3545;
        }

        .ribbon-completed {
            background-color: #17a2b8;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: var(--snow-white);
            margin: 10% auto;
            padding: 2rem;
            border-radius: 10px;
            width: 80%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            position: relative;
        }

        .close {
            position: absolute;
            right: 1.5rem;
            top: 1rem;
            color: var(--nav-text);
            font-size: 2rem;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: var(--dark-blue);
        }

        .modal-form {
            margin-top: 1rem;
        }

        .modal-form .form-group {
            margin-bottom: 1rem;
        }

        .modal-form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        .modal-form input, .modal-form select, .modal-form textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .modal-form button {
            padding: 0.75rem 1.5rem;
            background-color: var(--logo-blue);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .modal-form button:hover {
            background-color: var(--dark-blue);
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

            .bookings-header h1 {
                font-size: 2rem;
            }

            .booking-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Include the common header -->
    <%@ include file="includes/header.jsp" %>

    <!-- Main Content -->
    <main>
        <!-- Bookings Header -->
        <section class="bookings-header">
            <h1>My Bookings</h1>
            <p>View and manage all your appointments</p>
        </section>

        <!-- Bookings Content -->
        <section class="bookings-container">
            <!-- Success Messages -->
            <c:if test="${param.cancelled == 'true'}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> Your booking has been successfully cancelled.
                </div>
            </c:if>
            <c:if test="${param.updated == 'true'}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> Your booking has been successfully updated.
                </div>
            </c:if>

            <!-- Error Messages -->
            <c:if test="${not empty param.error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${param.error}
                </div>
            </c:if>

            <!-- Bookings List -->
            <c:choose>
                <c:when test="${not empty bookings}">
                    <div class="booking-cards">
                        <c:forEach var="booking" items="${bookings}">
                            <div class="booking-card">
                                <!-- Status Ribbon -->
                                <div class="status-ribbon">
                                    <div class="status-ribbon-inner ribbon-${booking[3].toLowerCase()}">
                                        ${booking[3]}
                                    </div>
                                </div>

                                <h3>${booking[4]}</h3>
                                <div class="booking-details">
                                    <p><i class="far fa-calendar"></i> Date: ${booking[1]}</p>
                                    <p><i class="far fa-clock"></i> Time: ${booking[2]}</p>
                                    <p><i class="fas fa-dollar-sign"></i> Price: $${booking[5]}</p>
                                    <p><i class="fas fa-hourglass-half"></i> Duration: ${booking[6]}</p>
                                    <c:if test="${not empty booking[7]}">
                                        <p><i class="far fa-sticky-note"></i> Notes: ${booking[7]}</p>
                                    </c:if>
                                </div>
                                <div class="booking-actions">
                                    <c:if test="${booking[3] == 'Pending' || booking[3] == 'Confirmed'}">
                                        <button class="action-btn reschedule-btn" onclick="openRescheduleModal(${booking[0]}, '${booking[1]}', '${booking[2]}')">
                                            <i class="fas fa-calendar-alt"></i> Reschedule
                                        </button>
                                        <form action="user-bookings" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="bookingId" value="${booking[0]}">
                                            <button type="submit" class="action-btn cancel-btn">
                                                <i class="fas fa-times-circle"></i> Cancel
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-bookings">
                        <h2>You don't have any bookings yet</h2>
                        <p>Book your first appointment to get started!</p>
                        <a href="services" class="btn btn-primary">Browse Services</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <!-- Reschedule Modal -->
        <div id="rescheduleModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeRescheduleModal()">&times;</span>
                <h2>Reschedule Appointment</h2>
                <form class="modal-form" action="user-bookings" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="bookingId" name="bookingId">

                    <div class="form-group">
                        <label for="date">New Date:</label>
                        <input type="date" id="date" name="date" required min="<%= java.time.LocalDate.now() %>">
                    </div>

                    <div class="form-group">
                        <label for="time">New Time:</label>
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

                    <button type="submit">Confirm Reschedule</button>
                </form>
            </div>
        </div>
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
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2023 PrettyPick. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Reschedule Modal Functions
        function openRescheduleModal(bookingId, date, time) {
            document.getElementById('bookingId').value = bookingId;
            document.getElementById('date').value = date;

            // Set the time in the select dropdown
            const timeSelect = document.getElementById('time');
            for (let i = 0; i < timeSelect.options.length; i++) {
                if (timeSelect.options[i].value === time) {
                    timeSelect.selectedIndex = i;
                    break;
                }
            }

            document.getElementById('rescheduleModal').style.display = 'block';
        }

        function closeRescheduleModal() {
            document.getElementById('rescheduleModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target == document.getElementById('rescheduleModal')) {
                closeRescheduleModal();
            }
        }
    </script>
</body>
</html>
