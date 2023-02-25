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

@WebServlet(name = "booksByAuthor", urlPatterns = {"/booksByAuthor"})
public class booksByAuthor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Book> books = Database.getBooksByAuthor(request.getParameter("author"), response.getWriter());
        for (int i = 0; i < books.size(); i++) {
            response.getWriter().println(books.get(i).getTitle());
        }
    }
}
