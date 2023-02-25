package servlets.librarians;

import classes.Borrowing;
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

@WebServlet(name = "borrowingInsert", urlPatterns = {"/borrowingInsert"})
public class borrowingInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        HttpSession session = request.getSession();
        if (!session.getAttribute("type").equals("librarian")) {
            response.sendRedirect("index.jsp");
            return;
        }

        Borrowing borrowing = null;
        try {
            borrowing = new Borrowing(
                    Integer.parseInt(request.getParameter("bookcopy_id")),
                    Integer.parseInt(request.getParameter("user_id")),
                    new java.sql.Date(sdf.parse(request.getParameter("fromdate")).getTime()),
                    new java.sql.Date(sdf.parse(request.getParameter("todate")).getTime()),
                    request.getParameter("status")
            );
        } catch (ParseException ex) {
            out.println("Status code 406 - Not Acceptable - ParseException - Message: Date format problem");
            ex.printStackTrace();
        }
        Borrowing.DBInsert(borrowing, out);
    }
}
