<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - PrettyPick</title>
    <link rel="stylesheet" href="Css/style.css">
    <style>
        /* Bookings Page Specific Styles */
        .bookings-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--light-color);
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }

        .bookings-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .bookings-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .bookings-table th, .bookings-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .bookings-table th {
            background-color: var(--primary-color);
            color: #312828;
        }

        .bookings-table tr:hover {
            background-color: #f5f5f5;
        }

        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            text-align: center;
        }

        .pending {
            background-color: #ffeeba;
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
            background-color: #c3e6cb;
            color: #0c5460;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-right: 0.5rem;
            transition: var(--transition);
        }

        .cancel-btn {
            background-color: #f8d7da;
            color: #721c24;
        }

        .cancel-btn:hover {
            background-color: #e77681;
            color: white;
        }

        .reschedule-btn {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .reschedule-btn:hover {
            background-color: #86cfda;
            color: white;
        }

        .feedback-btn {
            background-color: #d4edda;
            color: #155724;
        }

        .feedback-btn:hover {
            background-color: #8fd19e;
            color: white;
        }

        .no-bookings {
            text-align: center;
            padding: 2rem;
            color: var(--gray-color);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 2rem;
            border-radius: 10px;
            max-width: 500px;
            box-shadow: var(--box-shadow);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: black;
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
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: var(--transition);
        }

        .modal-form button:hover {
            background-color: var(--accent-color);
        }

        /* Alert Messages */
        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 5px;
            text-align: center;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
                    <a href="user-bookings" class="active">My Bookings</a>
                    <a href="aboutus.jsp">About Us</a>
                </div>
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
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <div class="bookings-container">
            <div class="bookings-header">
                <h1>My Bookings</h1>
                <a href="service.jsp" class="btn btn-primary">Book New Appointment</a>
            </div>

            <!-- Alert Messages -->
            <c:if test="${param.updated == 'true'}">
                <div class="alert alert-success">
                    Your booking has been updated successfully.
                </div>
            </c:if>

            <c:if test="${param.cancelled == 'true'}">
                <div class="alert alert-success">
                    Your booking has been cancelled successfully.
                </div>
            </c:if>

            <!-- Bookings Table -->
            <c:choose>
                <c:when test="${not empty bookings}">
                    <table class="bookings-table">
                        <thead>
                            <tr>
                                <th>Service</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookings}">
                                <tr>
                                    <td>${booking[4]}</td>
                                    <td>${booking[1]}</td>
                                    <td>${booking[2]}</td>
                                    <td>
                                        <span class="status-badge ${booking[3].toLowerCase()}">${booking[3]}</span>
                                    </td>
                                    <td>$${booking[5]}</td>
                                    <td>
                                        <c:if test="${booking[3] == 'Pending' || booking[3] == 'Confirmed'}">
                                            <button class="action-btn reschedule-btn" onclick="openRescheduleModal(${booking[0]}, '${booking[1]}', '${booking[2]}')">Reschedule</button>
                                            <button class="action-btn cancel-btn" onclick="cancelBooking(${booking[0]})">Cancel</button>
                                        </c:if>
                                        <c:if test="${booking[3] == 'Completed'}">
                                            <button class="action-btn feedback-btn" onclick="openFeedbackModal(${booking[0]}, '${booking[4]}')">Leave Feedback</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-bookings">
                        <h3>You don't have any bookings yet.</h3>
                        <p>Book your first appointment to get started!</p>
                        <a href="service.jsp" class="btn btn-primary">Book Now</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Reschedule Modal -->
        <div id="rescheduleModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeRescheduleModal()">&times;</span>
                <h2>Reschedule Appointment</h2>
                <form class="modal-form" action="book" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="bookingId" name="bookingId">

                    <div class="form-group">
                        <label for="date">New Date:</label>
                        <input type="date" id="date" name="date" required>
                    </div>

                    <div class="form-group">
                        <label for="time">New Time:</label>
                        <input type="time" id="time" name="time" required>
                    </div>

                    <button type="submit">Confirm Reschedule</button>
                </form>
            </div>
        </div>

        <!-- Feedback Modal -->
        <div id="feedbackModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeFeedbackModal()">&times;</span>
                <h2>Leave Feedback</h2>
                <p id="serviceNameDisplay"></p>
                <form class="modal-form" action="feedback" method="post">
                    <input type="hidden" id="feedbackBookingId" name="bookingId">

                    <div class="form-group">
                        <label for="rating">Rating:</label>
                        <select id="rating" name="rating" required>
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Very Good</option>
                            <option value="3">3 - Good</option>
                            <option value="2">2 - Fair</option>
                            <option value="1">1 - Poor</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="comments">Comments:</label>
                        <textarea id="comments" name="comments" rows="4" required></textarea>
                    </div>

                    <button type="submit">Submit Feedback</button>
                </form>
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
                        <li><a href="user-bookings">My Bookings</a></li>
                        <li><a href="aboutus.jsp">About Us</a></li>
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

    <script>
        // Reschedule Modal Functions
        function openRescheduleModal(bookingId, date, time) {
            document.getElementById('bookingId').value = bookingId;
            document.getElementById('date').value = date;
            document.getElementById('time').value = time;
            document.getElementById('rescheduleModal').style.display = 'block';
        }

        function closeRescheduleModal() {
            document.getElementById('rescheduleModal').style.display = 'none';
        }

        // Feedback Modal Functions
        function openFeedbackModal(bookingId, serviceName) {
            document.getElementById('feedbackBookingId').value = bookingId;
            document.getElementById('serviceNameDisplay').textContent = 'Service: ' + serviceName;
            document.getElementById('feedbackModal').style.display = 'block';
        }

        function closeFeedbackModal() {
            document.getElementById('feedbackModal').style.display = 'none';
        }

        // Cancel Booking Function
        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'book';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'cancel';

                const bookingIdInput = document.createElement('input');
                bookingIdInput.type = 'hidden';
                bookingIdInput.name = 'bookingId';
                bookingIdInput.value = bookingId;

                form.appendChild(actionInput);
                form.appendChild(bookingIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Close modals when clicking outside
        window.onclick = function(event) {
            if (event.target == document.getElementById('rescheduleModal')) {
                closeRescheduleModal();
            }
            if (event.target == document.getElementById('feedbackModal')) {
                closeFeedbackModal();
            }
        }
    </script>
</body>
</html>
