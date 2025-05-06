package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Clear cookies by setting their max age to 0
        Cookie emailCookie = new Cookie("userEmail", "");
        emailCookie.setMaxAge(0);
        emailCookie.setPath("/");
        response.addCookie(emailCookie);

        Cookie roleCookie = new Cookie("userRole", "");
        roleCookie.setMaxAge(0);
        roleCookie.setPath("/");
        response.addCookie(roleCookie);

        // Redirect to home page
        response.sendRedirect("home.jsp");
    }
}