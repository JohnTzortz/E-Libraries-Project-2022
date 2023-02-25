package servlets;

import classes.Database;
import classes.LibraryManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "librarianUpdate", urlPatterns = {"/librarianUpdate"})
public class librarianUpdate extends HttpServlet {

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

        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select password from librarians where username='" + request.getParameter("username") + "'");
            result.next();
            LibraryManager.DBUpdate(
                    request.getParameter("username"),
                    out,
                    request.getParameter("newPassword").equals("") ? result.getString("password") : request.getParameter("newPassword"),
                    request.getParameter("firstname"),
                    request.getParameter("lastname"),
                    new java.sql.Date(sdf.parse(request.getParameter("birthdate")).getTime()),
                    request.getParameter("gender"),
                    request.getParameter("personalpage"),
                    request.getParameter("country"),
                    request.getParameter("city"),
                    request.getParameter("address"),
                    request.getParameter("libraryinfo"),
                    request.getParameter("telephone"));
            database.close();
        } catch (ParseException ex) {
            out.println("Status code 406 - Not Acceptable - ParseException - Message: Date format problem");
            ex.printStackTrace();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal Server error - SQLException");
            ex.printStackTrace();
        }
    }
}
