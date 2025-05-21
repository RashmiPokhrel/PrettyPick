<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback - PrettyPick</title>
    <link rel="stylesheet" href="Css/style.css">
    <style>
        /* Feedback Page Specific Styles */
        .feedbacks-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--light-color);
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }

        .feedbacks-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .feedbacks-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .feedback-card {
            background-color: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .feedback-card:hover {
            transform: translateY(-5px);
        }

        .feedback-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.5rem;
        }

        .feedback-service {
            font-weight: bold;
            color: var(--primary-color);
        }

        .feedback-date {
            font-size: 0.8rem;
            color: var(--gray-color);
        }

        .feedback-rating {
            display: flex;
            margin-bottom: 0.5rem;
        }

        .star {
            color: gold;
            margin-right: 2px;
        }

        .feedback-comments {
            margin-top: 1rem;
            line-height: 1.5;
        }

        .feedback-user {
            margin-top: 1rem;
            font-style: italic;
            color: var(--gray-color);
            text-align: right;
        }

        .no-feedbacks {
            text-align: center;
            padding: 2rem;
            color: var(--gray-color);
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
    </style>
</head>
<body>
    <!-- Include the common header -->
    <%@ include file="includes/header.jsp" %>

    <!-- Main Content -->
    <main>
        <div class="feedbacks-container">
            <div class="feedbacks-header">
                <h1>Customer Feedback</h1>
                <c:if test="${not isAdmin}">
                    <a href="bookings.jsp" class="btn btn-primary">Back to Bookings</a>
                </c:if>
            </div>

            <!-- Alert Messages -->
            <c:if test="${param.submitted == 'true'}">
                <div class="alert alert-success">
                    Your feedback has been submitted successfully. Thank you!
                </div>
            </c:if>

            <!-- Feedbacks Grid -->
            <c:choose>
                <c:when test="${not empty feedbacks}">
                    <div class="feedbacks-grid">
                        <c:forEach var="feedback" items="${feedbacks}">
                            <div class="feedback-card">
                                <div class="feedback-header">
                                    <c:choose>
                                        <c:when test="${isAdmin}">
                                            <span class="feedback-service">${feedback[6]}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="feedback-service">Service ID: ${feedback.service_Id}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="feedback-date">
                                        <c:choose>
                                            <c:when test="${isAdmin}">
                                                ${feedback[3]}
                                            </c:when>
                                            <c:otherwise>
                                                ${feedback.submitted_at}
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="feedback-rating">
                                    <c:choose>
                                        <c:when test="${isAdmin}">
                                            <c:forEach begin="1" end="${feedback[1]}">
                                                <span class="star">★</span>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach begin="1" end="${feedback.rating}">
                                                <span class="star">★</span>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="feedback-comments">
                                    <c:choose>
                                        <c:when test="${isAdmin}">
                                            ${feedback[2]}
                                        </c:when>
                                        <c:otherwise>
                                            ${feedback.comments}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <c:if test="${isAdmin}">
                                    <div class="feedback-user">
                                        - ${feedback[4]}
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-feedbacks">
                        <h3>No feedback available yet.</h3>
                        <p>Feedback will appear here after customers submit their reviews.</p>
                    </div>
                </c:otherwise>
            </c:choose>
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
