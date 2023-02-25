package servlets.get;

import classes.Book;
import classes.Database;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "booksByYear", urlPatterns = {"/booksByYear"})
public class booksByYear extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Book> books = Database.getBooksByYear(request.getParameter("fromYear").equals("") ? 1500 : Integer.parseInt(request.getParameter("fromYear")),
                response.getWriter(),
                request.getParameter("toYear").equals("") ? Integer.MAX_VALUE : Integer.parseInt(request.getParameter("toYear")));
        for (int i = 0; i < books.size(); i++) {
            response.getWriter().println(books.get(i).getTitle());
        }
    }
}
