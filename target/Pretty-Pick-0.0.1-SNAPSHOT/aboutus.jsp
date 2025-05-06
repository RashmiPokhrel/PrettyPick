<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PrettyPick - About Us</title>
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
      padding: 1rem 0;
      min-height: 70px;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 5%;
      max-width: 1400px;
      margin: 0 auto;
    }

    .logo {
      font-size: 2rem;
      font-weight: 600;
      color: var(--logo-blue);
      text-decoration: none;
      letter-spacing: -0.5px;
      padding: 0.5rem 0;
    }

    .nav-links {
      display: flex;
      align-items: center;
      gap: 2rem;
    }

    .nav-links a {
      text-decoration: none;
      color: var(--nav-text);
      font-weight: 500;
      font-size: 1rem;
      transition: color 0.3s;
    }

    .nav-links a:not(.login-btn, .register-btn):hover {
      color: var(--logo-blue);
    }

    .login-btn {
      padding: 0.7rem 2.2rem;
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
      padding: 0.7rem 2.2rem;
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

    /* About Us Section */
    .about-section {
      padding: 8rem 5% 5rem;
      max-width: 1200px;
      margin: 0 auto;
      background-color: var(--snow-white);
    }

    .about-section h1 {
      font-size: 3rem;
      color: var(--dark-blue);
      text-align: center;
      margin-bottom: 2rem;
      position: relative;
    }

    .about-section h1::after {
      content: '';
      display: block;
      width: 60px;
      height: 4px;
      background: var(--register-blue);
      margin: 1rem auto;
      border-radius: 2px;
    }

    .about-content {
      display: flex;
      flex-direction: column;
      gap: 2rem;
    }

    .about-text {
      text-align: center;
      font-size: 1.1rem;
      color: var(--dark-blue);
      margin-bottom: 1.5rem;
    }

    .mission-vision {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin-bottom: 3rem;
    }

    .mission-card, .vision-card {
      background: var(--snow-white);
      border: 1px solid var(--light-blue);
      border-radius: 10px;
      padding: 1.5rem;
      text-align: center;
    }

    .mission-card h3, .vision-card h3 {
      font-size: 1.5rem;
      color: var(--dark-blue);
      margin-bottom: 1rem;
    }

    .mission-card p, .vision-card p {
      color: var(--dark-blue);
      font-size: 1rem;
    }

    .team-section {
      text-align: center;
    }

    .team-section h2 {
      font-size: 2rem;
      color: var(--dark-blue);
      margin-bottom: 2rem;
    }

    .team-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 2rem;
    }

    .team-member {
      background: var(--snow-white);
      border: 1px solid var(--light-blue);
      border-radius: 10px;
      padding: 1.5rem;
    }

    .team-member h4 {
      font-size: 1.3rem;
      color: var(--dark-blue);
      margin-bottom: 0.5rem;
    }

    .team-member p {
      color: var(--dark-blue);
      font-size: 0.95rem;
      opacity: 0.8;
    }

    /* Footer styles */
    footer {
      background-color: var(--dark-blue);
      color: var(--snow-white);
      padding: 5rem 5% 2rem;
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

    .newsletter {
      display: flex;
      gap: 0.8rem;
    }

    .newsletter input {
      padding: 1rem;
      border: none;
      border-radius: 5px;
      flex: 1;
      background-color: var(--snow-white);
      font-size: 1rem;
    }

    .subscribe-btn {
      padding: 1rem 2rem;
      background-color: var(--pastel-blue);
      color: var(--dark-blue);
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
      font-weight: 500;
      font-size: 1rem;
    }

    .subscribe-btn:hover {
      background-color: var(--light-blue);
    }

    .footer-bottom {
      text-align: center;
      margin-top: 4rem;
      padding-top: 2rem;
      border-top: 1px solid rgba(255,255,255,0.1);
      color: var(--light-blue);
      font-size: 1rem;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      .about-section h1 {
        font-size: 2.5rem;
      }

      .about-text {
        font-size: 1rem;
      }

      .mission-card h3, .vision-card h3 {
        font-size: 1.3rem;
      }

      .team-section h2 {
        font-size: 1.8rem;
      }

      .nav-links {
        display: none;
      }

      .footer-container {
        grid-template-columns: 1fr;
        min-height: 400px;
      }

      .navbar {
        padding: 0 3%;
      }

      .logo {
        font-size: 1.8rem;
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
      <a href="/">Home</a>
      <a href="/services">Services</a>
      <a href="/about">About Us</a>
      <a href="/contact">Contact Us</a>
      <a href="/login" class="login-btn">Login</a>
      <a href="/register" class="register-btn">Register</a>
    </div>
  </nav>
</header>

<main>
  <!-- About Us Section -->
  <section class="about-section">
    <h1>About PrettyPick</h1>
    <div class="about-content">
      <p class="about-text">
        PrettyPick is your trusted partner in beauty, offering a seamless salon booking experience. Founded in 2025, we set out to revolutionize the way you access premium beauty services, making it easier than ever to look and feel your best.
      </p>
      <div class="mission-vision">
        <div class="mission-card">
          <h3>Our Mission</h3>
          <p>To empower everyone with accessible, high-quality beauty services through innovative technology and exceptional customer care.</p>
        </div>
        <div class="vision-card">
          <h3>Our Vision</h3>
          <p>To be the leading salon booking platform, connecting beauty enthusiasts with top professionals worldwide.</p>
        </div>
      </div>
      <div class="team-section">
        <h2>Meet Our Team</h2>
        <div class="team-grid">
          <div class="team-member">
            <h4>Nabin Regmi</h4>
            <p>Founder</p>
          </div>
          <div class="team-member">
            <h4>Rashmi Pokhrel</h4>
            <p>CEO</p>
          </div>
          <div class="team-member">
            <h4>Krisha Timalsina</h4>
            <p>Customer Experience Manager</p>
          </div>
          <div class="team-member">
            <h4>Sagar Chapagain</h4>
            <p>Hair Stylist</p>
          </div>
          <div class="team-member">
            <h4>Alice Khadgi</h4>
            <p>Manager</p>
          </div>
        </div>
      </div>
    </div>
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
      <p class="address">Itahari, Biratnagar Line</p>
      <p class="phone">+9779804373219</p>
      <p class="email">info@prettypick.com</p>
    </div>
    <div class="footer-section">
      <h3>Quick Links</h3>
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/services">Services</a></li>
        <li><a href="/how-it-works">How It Works</a></li>
        <li><a href="/login">Login</a></li>
        <li><a href="/register">Register</a></li>
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
</body>
</html>
