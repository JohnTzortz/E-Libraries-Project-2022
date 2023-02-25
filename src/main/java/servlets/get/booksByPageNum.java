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

@WebServlet(name = "booksByPageNum", urlPatterns = {"/booksByPageNum"})
public class booksByPageNum extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Book> books = Database.getBooksByPageNum(request.getParameter("toNPages").equals("") ? 0 : Integer.parseInt(request.getParameter("fromNPages")),
                response.getWriter(),
                request.getParameter("toNPages").equals("") ? Integer.MAX_VALUE : Integer.parseInt(request.getParameter("toNPages")));
        for (int i = 0; i < books.size(); i++) {
            response.getWriter().println(books.get(i).getTitle());
        }
    }
}
