package controller;

import model.Product;
import service.ProductService;
import service.implement.ProductServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/product-servlet")
public class ProductServlet extends HttpServlet {
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "view":
                displayProducts(request, response);
                break;
            case "add":
                System.out.println("added worked!");
                break;
            case "edit":
                System.out.println("edit worked!");
                break;
            case "remove":
                System.out.println("remove worked!");
                break;
            case "detail":
                System.out.println("detail worked!");
        }
    }

    private void displayProducts(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("display.jsp");
        List<Product> products = productService.getProducts();
        request.setAttribute("products", products);
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}