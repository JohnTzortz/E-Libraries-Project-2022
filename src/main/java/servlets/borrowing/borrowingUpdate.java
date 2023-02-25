package servlets;

import classes.Borrowing;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "borrowingUpdate", urlPatterns = {"/borrowingUpdate"})
public class borrowingUpdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        if (!(session.getAttribute("type").equals("librarian") || session.getAttribute("type").equals("student"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        Borrowing.DBUpdate(
                Integer.parseInt(request.getParameter("bookcopy_id")),
                out,
                Integer.parseInt(request.getParameter("user_id")),
                request.getParameter("status")
        );
    }
}
