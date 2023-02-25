package servlets.librarians;

import classes.AdminMessage;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "adminMessageInsert", urlPatterns = {"/adminMessageInsert"})
public class adminMessageInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        HttpSession session = request.getSession();
        if (session.getAttribute("type").equals("admin")) {
            response.sendRedirect("index.jsp");
            return;
        }

        AdminMessage message = null;
        try {
            message = new AdminMessage(
                    request.getParameter("message"),
                    new java.sql.Date(sdf.parse(request.getParameter("date")).getTime()));
        } catch (ParseException ex) {
            out.println("Status code 406 - Not Acceptable - ParseException - Message: Date format problem");
            ex.printStackTrace();
        }
        AdminMessage.DBInsert(message, out);
    }
}
