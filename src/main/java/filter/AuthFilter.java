package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Authentication and authorization filter for protecting routes
 * based on user roles.
 */
@WebFilter(urlPatterns = {
    "/admin-dashboard", 
    "/admin-dashboard/*", 
    "/user-dashboard", 
    "/user-dashboard/*",
    "/user-bookings",
    "/feedbacks"
})
public class AuthFilter implements Filter {
    private static final Logger LOGGER = Logger.getLogger(AuthFilter.class.getName());

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        LOGGER.info("AuthFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        LOGGER.info("AuthFilter processing request: " + requestURI);
        
        // Get user information from cookies
        String userEmail = null;
        String userRole = null;
        Cookie[] cookies = httpRequest.getCookies();
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    userEmail = cookie.getValue();
                } else if ("userRole".equals(cookie.getName())) {
                    userRole = cookie.getValue();
                }
            }
        }
        
        // Check if user is logged in
        if (userEmail == null) {
            LOGGER.warning("Unauthorized access attempt to " + requestURI + ": User not logged in");
            httpRequest.setAttribute("errorMessage", "Please log in to access this page");
            httpRequest.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Check role-based access for admin routes
        if (requestURI.contains("/admin-dashboard") && !"admin".equals(userRole)) {
            LOGGER.warning("Unauthorized access attempt to admin area by user: " + userEmail);
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        LOGGER.info("AuthFilter destroyed");
    }
}
