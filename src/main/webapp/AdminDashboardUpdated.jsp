<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrettyPick - Admin Dashboard</title>
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
            --gradient-bg: linear-gradient(135deg, var(--pastel-blue), var(--light-blue));
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
            padding: 1rem 0;
            min-height: 70px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 5%;
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
            cursor: pointer;
        }

        .nav-links a:hover, .nav-links a.active {
            background-color: rgba(158, 210, 230, 0.1);
            color: var(--dark-blue);
        }

        .logout-btn {
            color: var(--nav-text);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            margin-left: 2rem;
        }

        .logout-btn:hover {
            background: rgba(184, 216, 232, 0.1);
        }

        /* Dashboard styles */
        .main-content {
            padding: 8rem 5% 5rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .dashboard h1 {
            font-size: 3rem;
            color: var(--dark-blue);
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .dashboard h1::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--register-blue);
            margin: 1rem auto;
            border-radius: 2px;
        }

        .stats-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .stat-card {
            flex: 1;
            background: var(--gradient-bg);
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            color: var(--dark-blue);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .stat-card p {
            font-size: 2rem;
            font-weight: bold;
        }

        .content-area {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .content-section {
            padding: 2rem;
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .content-section h2 {
            font-size: 1.8rem;
            color: var(--dark-blue);
            margin-bottom: 1.5rem;
            position: relative;
        }

        .content-section h2::after {
            content: '';
            display: block;
            width: 40px;
            height: 3px;
            background: var(--register-blue);
            margin-top: 0.5rem;
            border-radius: 2px;
        }

        /* Dashboard info styles */
        .dashboard-info {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .info-card {
            flex: 1;
            min-width: 300px;
            background: var(--snow-white);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .info-card h3 {
            font-size: 1.4rem;
            color: var(--dark-blue);
            margin-bottom: 1rem;
        }

        .info-card p {
            margin-bottom: 0.5rem;
            color: var(--nav-text);
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: var(--snow-white);
            color: var(--dark-blue);
            font-weight: bold;
        }

        tr:hover {
            background-color: rgba(158, 210, 230, 0.05);
        }

        /* Status badge styles */
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .confirmed {
            background-color: #d4edda;
            color: #155724;
        }

        .canceled, .cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .completed {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        /* Action button styles */
        .action-btn {
            padding: 0.4rem 0.8rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-right: 0.5rem;
            transition: background-color 0.3s, color 0.3s;
        }

        .confirm-btn {
            background-color: #d4edda;
            color: #155724;
        }

        .confirm-btn:hover {
            background-color: #155724;
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

        .reopen-btn {
            background-color: #fff3cd;
            color: #856404;
        }

        .reopen-btn:hover {
            background-color: #856404;
            color: white;
        }

        .edit-btn {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .edit-btn:hover {
            background-color: #0c5460;
            color: white;
        }

        .delete-btn {
            background-color: #f8d7da;
            color: #721c24;
        }

        .delete-btn:hover {
            background-color: #721c24;
            color: white;
        }

        .complete-btn {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .complete-btn:hover {
            background-color: #0c5460;
            color: white;
        }

        /* Form styles */
        form {
            background: var(--snow-white);
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
            font-weight: 500;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: inherit;
            font-size: 1rem;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .submit-btn {
            background: var(--register-blue);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background: var(--dark-blue);
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
            max-width: 600px;
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

        /* Footer styles */
        footer {
            background: var(--dark-blue);
            color: var(--snow-white);
            padding: 4rem 5% 2rem;
            margin-top: 4rem;
        }

        .footer-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 4rem;
            max-width: 1200px;
            margin: 0 auto;
            min-height: 300px;
        }

        .footer-section h3 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: var(--snow-white);
        }

        .footer-section p {
            margin-bottom: 0.8rem;
            color: var(--light-blue);
            font-size: 1rem;
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
            font-size: 1rem;
        }

        .footer-section ul a:hover {
            color: var(--pastel-blue);
        }

        .social-links {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .social-links a {
            color: var(--snow-white);
            font-size: 1.5rem;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: var(--pastel-blue);
        }

        .copyright {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid rgba(158, 210, 230, 0.2);
            margin-top: 2rem;
            color: var(--light-blue);
            font-size: 0.9rem;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 1rem;
            }

            .nav-links {
                margin-top: 1rem;
                flex-wrap: wrap;
                justify-content: center;
                gap: 0.5rem;
            }

            .logout-btn {
                margin-left: 0;
                margin-top: 1rem;
            }

            .main-content {
                padding: 6rem 1rem 2rem;
            }

            .dashboard h1 {
                font-size: 2rem;
            }

            .stat-card {
                min-width: 120px;
            }

            table {
                display: block;
                overflow-x: auto;
            }

            th, td {
                padding: 0.75rem;
            }

            .action-btn {
                padding: 0.3rem 0.6rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <nav class="navbar">
        <a href="/" class="logo">PrettyPick</a>
        <div class="nav-links">
            <a onclick="showSection('dashboard')" class="active">Dashboard</a>
            <a onclick="showSection('bookings')">Bookings</a>
            <a onclick="showSection('services')">Services</a>
            <a onclick="showSection('users')">Users</a>
            <a href="logout" class="logout-btn">Logout</a>
        </div>
    </nav>
</header>

<!-- Main Content -->
<main class="main-content">
    <section class="dashboard">
        <h1>Admin Dashboard</h1>

        <!-- Stats Bar -->
        <div class="stats-bar">
            <div class="stat-card">
                <h3>Pending</h3>
                <p>${pendingCount}</p>
            </div>
            <div class="stat-card">
                <h3>Confirmed</h3>
                <p>${confirmedCount}</p>
            </div>
            <div class="stat-card">
                <h3>Cancelled</h3>
                <p>${cancelledCount}</p>
            </div>
            <div class="stat-card">
                <h3>Completed</h3>
                <p>${completedCount}</p>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Dashboard Info -->
            <div id="dashboard" class="content-section active">
                <h2>Dashboard Overview</h2>
                <div class="dashboard-info">
                    <div class="info-card">
                        <h3>System Information</h3>
                        <p><strong>Server Time:</strong> <%= new java.util.Date() %></p>
                        <p><strong>Total Services:</strong> ${services.size()}</p>
                        <p><strong>Total Users:</strong> ${users.size()}</p>
                        <p><strong>Last Login:</strong> <%= new java.util.Date() %></p>
                    </div>
                </div>
            </div>

            <!-- Manage Bookings -->
            <div id="bookings" class="content-section">
                <h2>Manage Bookings</h2>
                <table>
                    <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer</th>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>${booking[0]}</td>
                            <td>${booking[5]}</td>
                            <td>${booking[8]}</td>
                            <td>${booking[1]}</td>
                            <td>${booking[2]}</td>
                            <td><span class="status-badge ${booking[3].toLowerCase()}">${booking[3]}</span></td>
                            <td>
                                <c:if test="${booking[3] == 'Pending'}">
                                    <form action="admin-dashboard" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="updateBookingStatus">
                                        <input type="hidden" name="bookingId" value="${booking[0]}">
                                        <input type="hidden" name="status" value="Confirmed">
                                        <button type="submit" class="action-btn confirm-btn">Confirm</button>
                                    </form>
                                    <form action="admin-dashboard" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="updateBookingStatus">
                                        <input type="hidden" name="bookingId" value="${booking[0]}">
                                        <input type="hidden" name="status" value="Cancelled">
                                        <button type="submit" class="action-btn cancel-btn">Cancel</button>
                                    </form>
                                </c:if>
                                <c:if test="${booking[3] == 'Confirmed'}">
                                    <form action="admin-dashboard" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="updateBookingStatus">
                                        <input type="hidden" name="bookingId" value="${booking[0]}">
                                        <input type="hidden" name="status" value="Completed">
                                        <button type="submit" class="action-btn complete-btn">Complete</button>
                                    </form>
                                    <form action="admin-dashboard" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="updateBookingStatus">
                                        <input type="hidden" name="bookingId" value="${booking[0]}">
                                        <input type="hidden" name="status" value="Cancelled">
                                        <button type="submit" class="action-btn cancel-btn">Cancel</button>
                                    </form>
                                </c:if>
                                <c:if test="${booking[3] == 'Cancelled'}">
                                    <form action="admin-dashboard" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="updateBookingStatus">
                                        <input type="hidden" name="bookingId" value="${booking[0]}">
                                        <input type="hidden" name="status" value="Pending">
                                        <button type="submit" class="action-btn reopen-btn">Reopen</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="7" style="text-align: center;">No bookings found</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Manage Services -->
            <div id="services" class="content-section">
                <h2>Manage Services</h2>
                <form action="admin-dashboard" method="post">
                    <input type="hidden" name="action" value="addService">
                    <div class="form-group">
                        <label for="serviceName">Service Name</label>
                        <input type="text" id="serviceName" name="serviceName" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="price">Price ($)</label>
                        <input type="number" id="price" name="price" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label for="duration">Duration (minutes)</label>
                        <input type="text" id="duration" name="duration" required>
                    </div>
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" required>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                    <button type="submit" class="submit-btn">Add Service</button>
                </form>

                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Service Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Duration</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="service" items="${services}">
                        <tr>
                            <td>${service.service_Id}</td>
                            <td>${service.service_Name}</td>
                            <td>${service.description}</td>
                            <td>$${service.price}</td>
                            <td>${service.duration}</td>
                            <td>${service.status}</td>
                            <td>
                                <button class="action-btn edit-btn" onclick="editService(${service.service_Id}, '${service.service_Name}', '${service.description}', ${service.price}, '${service.duration}', '${service.status}')">Edit</button>
                                <form action="admin-dashboard" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this service?');">
                                    <input type="hidden" name="action" value="deleteService">
                                    <input type="hidden" name="serviceId" value="${service.service_Id}">
                                    <button type="submit" class="action-btn delete-btn">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty services}">
                        <tr>
                            <td colspan="7" style="text-align: center;">No services found</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                
                <!-- Edit Service Modal -->
                <div id="editServiceModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeEditServiceModal()">&times;</span>
                        <h2>Edit Service</h2>
                        <form action="admin-dashboard" method="post">
                            <input type="hidden" name="action" value="updateService">
                            <input type="hidden" id="editServiceId" name="serviceId">
                            <div class="form-group">
                                <label for="editServiceName">Service Name</label>
                                <input type="text" id="editServiceName" name="serviceName" required>
                            </div>
                            <div class="form-group">
                                <label for="editDescription">Description</label>
                                <textarea id="editDescription" name="description" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="editPrice">Price ($)</label>
                                <input type="number" id="editPrice" name="price" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label for="editDuration">Duration (minutes)</label>
                                <input type="text" id="editDuration" name="duration" required>
                            </div>
                            <div class="form-group">
                                <label for="editStatus">Status</label>
                                <select id="editStatus" name="status" required>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                            <button type="submit" class="submit-btn">Update Service</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Manage Users -->
            <div id="users" class="content-section">
                <h2>Manage Users</h2>
                <table>
                    <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.role}</td>
                            <td>
                                <button class="action-btn edit-btn" onclick="editUser(${user.userId})">Edit</button>
                                <c:if test="${user.role != 'admin'}">
                                    <form action="admin-dashboard" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                        <input type="hidden" name="action" value="deleteUser">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <button type="submit" class="action-btn delete-btn">Delete</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="6" style="text-align: center;">No users found</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</main>

<script>
    // Show section function
    function showSection(sectionId) {
        // Hide all sections
        const sections = document.querySelectorAll('.content-section');
        sections.forEach(section => {
            section.classList.remove('active');
        });

        // Show selected section
        document.getElementById(sectionId).classList.add('active');

        // Update active nav link
        const navLinks = document.querySelectorAll('.nav-links a');
        navLinks.forEach(link => {
            link.classList.remove('active');
        });
        event.target.classList.add('active');
    }

    // Edit service function
    function editService(serviceId, serviceName, description, price, duration, status) {
        document.getElementById('editServiceId').value = serviceId;
        document.getElementById('editServiceName').value = serviceName;
        document.getElementById('editDescription').value = description;
        document.getElementById('editPrice').value = price;
        document.getElementById('editDuration').value = duration;
        document.getElementById('editStatus').value = status;
        
        document.getElementById('editServiceModal').style.display = 'block';
    }
    
    // Close edit service modal
    function closeEditServiceModal() {
        document.getElementById('editServiceModal').style.display = 'none';
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('editServiceModal');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
    
    // Edit user function (placeholder for now)
    function editUser(userId) {
        alert('Edit user functionality will be implemented soon. User ID: ' + userId);
    }
</script>
</body>
</html>
