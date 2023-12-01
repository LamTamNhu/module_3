package calculator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CalculatorServlet", value = "/calc")
public class CalculatorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productDescription = request.getParameter("description");
        Double price = Double.valueOf(request.getParameter("price"));
        Double discountPercent = Double.valueOf(request.getParameter("discount percent"));

        Double discountAmount = price * discountPercent * 0.01;
        Double discountPrice = price - discountAmount;

        PrintWriter writer = response.getWriter();
        writer.println("<html>");
        writer.println("<p>");
        writer.println("Product Description: " + productDescription + "<br>");
        writer.println("List Price: " + price + "<br>");
        writer.println("Discount percent: " + discountPercent + "<br>");
        writer.println("Result<br>");
        writer.println("Discount amount: " + discountAmount + "<br>");
        writer.println("Discount price: " + discountPrice);
        writer.println("</p>");
        writer.println("</html>");
    }
}