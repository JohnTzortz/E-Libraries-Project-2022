package servlets;

import classes.BookInLibrary;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "bookInLibraryUpdate", urlPatterns = {"/bookInLibraryUpdate"})
public class bookInLibraryUpdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        if (!session.getAttribute("type").equals("librarian")) {
            response.sendRedirect("index.jsp");
            return;
        }

        BookInLibrary.DBUpdate(
                request.getParameter("isbn"),
                out,
                request.getParameter("available")
        );
    }
}
