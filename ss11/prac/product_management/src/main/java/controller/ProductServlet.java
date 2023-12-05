package controller;

import model.Product;
import service.ProductService;
import service.implement.ProductServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
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
                goToCreateProductForm(request, response);
                break;
            case "edit":
                goToEditProductForm(request, response);
                break;
            case "remove":
                checkBeforeRemove(request, response);
                break;
        }
    }

    private void checkBeforeRemove(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/remove_product.jsp");
        String id = request.getParameter("id");
        if (productService.findById(id) != null) {
            request.setAttribute("id",id);
        } else {
            request.setAttribute("id","N/A");
        }
        try {
            requestDispatcher.forward(request,response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    private void goToEditProductForm(HttpServletRequest request, HttpServletResponse response) {
        Product productToEdit = productService.findById(request.getParameter("id"));
        request.setAttribute("product", productToEdit);
        try {
            request.getRequestDispatcher("/edit_product.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    private void displayProducts(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("display.jsp");
        List<Product> products = productService.getProducts();
        request.setAttribute("products", products);
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "edit":
                editProduct(request, response);
                break;
            case "remove":
                removeProduct(request,response);
                break;
        }
    }

    private void removeProduct(HttpServletRequest request, HttpServletResponse response) {
        productService.removeProduct(request.getParameter("id"));

        returnToView(request,response);
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        LocalDate productionDate = LocalDate.parse(request.getParameter("production_date"));
        String description = request.getParameter("description");

        Product productEdited = new Product(id, name, price, productionDate, description);
        productService.editProduct(productEdited);

        returnToView(request, response);
    }

    private static void returnToView(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect(request.getContextPath() + "/product-servlet?action=view");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void goToCreateProductForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect("/create_product.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        System.out.println(request.getParameter("production_date"));
        LocalDate productionDate = LocalDate.parse(request.getParameter("production_date"));
        String description = request.getParameter("description");
        productService.addProduct(new Product(id, name, price, productionDate, description));

        returnToView(request,response);
    }
}