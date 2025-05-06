package servlet;

import dao.ServiceDAO;
import model.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(urlPatterns = {"/services"})
public class ServiceServlet extends HttpServlet {

    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        try {
            serviceDAO = new ServiceDAO();
            System.out.println("ServiceServlet initialized successfully");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ServiceServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all services
            List<service> services = serviceDAO.getAllServices();

            // Filter out inactive services
            services.removeIf(service -> "Inactive".equals(service.getStatus()));

            // Extract service categories
            Set<String> categories = new HashSet<>();
            for (service s : services) {
                // For simplicity, we'll categorize services based on their name
                // In a real application, you would have a category field in the service table
                String category = categorizeService(s.getService_Name());
                s.setCategory(category);
                categories.add(category);

                // Add features to each service
                s.setFeatures(generateFeatures(s.getService_Name(), s.getDescription()));
            }

            // Set services and categories as request attributes
            request.setAttribute("services", services);
            request.setAttribute("serviceCategories", categories);

            // Forward to the service page
            request.getRequestDispatcher("service.jsp").forward(request, response);
        } catch (SQLException ex) {
            throw new ServletException("Database error", ex);
        }
    }

    // Helper method to categorize services
    private String categorizeService(String serviceName) {
        // First check if the service already has a category assigned
        if (serviceName != null && !serviceName.trim().isEmpty()) {
            serviceName = serviceName.toLowerCase();
            if (serviceName.contains("hair") || serviceName.contains("cut") || serviceName.contains("style") ||
                serviceName.contains("color") || serviceName.contains("treatment")) {
                return "Hair";
            } else if (serviceName.contains("facial") || serviceName.contains("face") ||
                       serviceName.contains("skin") || serviceName.contains("aging")) {
                return "Facial";
            } else if (serviceName.contains("nail") || serviceName.contains("manicure") ||
                       serviceName.contains("pedicure")) {
                return "Nail";
            } else if (serviceName.contains("massage") || serviceName.contains("spa") ||
                       serviceName.contains("therapy")) {
                return "Massage & Spa";
            } else if (serviceName.contains("makeup") || serviceName.contains("makeover") ||
                       serviceName.contains("bridal")) {
                return "Makeup";
            } else {
                return "Other";
            }
        } else {
            return "Other";
        }
    }

    // Helper method to generate features for services
    private List<String> generateFeatures(String serviceName, String description) {
        List<String> features = new ArrayList<>();

        if (serviceName == null) {
            return features;
        }

        String lowerName = serviceName.toLowerCase();

        // Add some default features based on service name
        if (lowerName.contains("hair")) {
            features.add("Consultation Included");
            features.add("Professional Products");
            features.add("Styling Tips");

            if (lowerName.contains("color") || lowerName.contains("balayage")) {
                features.add("Color Protection Kit");
                features.add("Ammonia-Free Options");
            }

            if (lowerName.contains("extension")) {
                features.add("Premium Quality Hair");
                features.add("Multiple Techniques Available");
            }

            if (lowerName.contains("keratin") || lowerName.contains("treatment")) {
                features.add("Long-Lasting Results");
                features.add("Frizz Reduction");
            }
        } else if (lowerName.contains("facial")) {
            features.add("Skin Analysis");
            features.add("Deep Cleansing");
            features.add("Face Massage");

            if (lowerName.contains("hydrat")) {
                features.add("Intense Moisturization");
                features.add("Hyaluronic Acid Treatment");
            }

            if (lowerName.contains("acne")) {
                features.add("Antibacterial Treatment");
                features.add("Pore Cleansing");
            }

            if (lowerName.contains("gold")) {
                features.add("24K Gold Infusion");
                features.add("Anti-Aging Benefits");
            }
        } else if (lowerName.contains("nail")) {
            features.add("Nail Shaping");
            features.add("Cuticle Care");
            features.add("Polish Application");

            if (lowerName.contains("gel")) {
                features.add("Long-Lasting Formula");
                features.add("Chip-Resistant Finish");
            }

            if (lowerName.contains("art")) {
                features.add("Custom Designs");
                features.add("Rhinestone Options");
            }

            if (lowerName.contains("pedicure")) {
                features.add("Foot Scrub");
                features.add("Callus Removal");
            }
        } else if (lowerName.contains("massage") || lowerName.contains("spa") || lowerName.contains("therapy")) {
            features.add("Professional Therapists");
            features.add("Relaxing Environment");
            features.add("Stress Relief");

            if (lowerName.contains("swedish")) {
                features.add("Full Body Relaxation");
                features.add("Improved Circulation");
            }

            if (lowerName.contains("deep tissue")) {
                features.add("Muscle Pain Relief");
                features.add("Tension Release");
            }

            if (lowerName.contains("stone")) {
                features.add("Heated Basalt Stones");
                features.add("Enhanced Relaxation");
            }
        } else if (lowerName.contains("makeup") || lowerName.contains("bridal")) {
            features.add("Premium Cosmetics");
            features.add("Professional Application");
            features.add("Skin-Friendly Products");

            if (lowerName.contains("bridal")) {
                features.add("Trial Session Included");
                features.add("Long-Lasting Formula");
            }

            if (lowerName.contains("lesson")) {
                features.add("Personalized Techniques");
                features.add("Product Recommendations");
            }
        } else {
            features.add("Professional Service");
            features.add("Expert Technicians");
            features.add("Premium Products");
        }

        return features;
    }
}