package servlets.librarians;

import classes.Book;
import classes.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "bookInsert", urlPatterns = {"/bookInsert"})
public class bookInsert extends HttpServlet {

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

        Book book = new Book(
                request.getParameter("isbn"),
                request.getParameter("title"),
                request.getParameter("authors"),
                request.getParameter("genre"),
                request.getParameter("pages").equals("") ? null : Integer.parseInt(request.getParameter("pages")),
                request.getParameter("publicationyear").equals("") ? null : Integer.parseInt(request.getParameter("publicationyear")),
                request.getParameter("url").equals("") ? null : request.getParameter("url"),
                request.getParameter("photo").equals("") ? null : request.getParameter("photo")
        );

        Integer library_id = null;
        Database database = new Database(out);
        ResultSet result = database.executeStatement("select * from librarians where username=" + session.getAttribute("username"));
        try {
            result.next();
            library_id = result.getInt("library_id");

        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        Book.DBInsert(book, out, library_id);
    }
}
