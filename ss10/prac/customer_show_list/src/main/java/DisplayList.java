import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DisplayList", value = "/display_list")
public class DisplayList extends HttpServlet {
    private static final List<Customer> customers = new ArrayList<>();

    static {
        customers.add(new Customer("Christopher V Black","5/10/1984","969 Jerry Toth Drive","https://www.fakepersongenerator.com/Face/male/male1084599248017.jpg"));
        customers.add(new Customer("John C Wicker","6/30/1987","2768 Deer Ridge Drive","https://www.fakepersongenerator.com/Face/male/male1085676664306.jpg"));
        customers.add(new Customer("Julia M Lowe","8/20/1971","885 Whitetail Lane","https://www.fakepersongenerator.com/Face/female/female20161024788896453.jpg"));
        customers.add(new Customer("Debbie D Allen","9/11/1983","2395 Sweetwood Drive","https://www.fakepersongenerator.com/Face/female/female1022845937744.jpg"));
        customers.add(new Customer("George M Bryant","11/23/1971","121 Jerry Tooth Drive","https://www.fakepersongenerator.com/Face/male/male1085761922271.jpg"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("show_list.jsp");
        request.setAttribute("customers",customers);
        requestDispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}