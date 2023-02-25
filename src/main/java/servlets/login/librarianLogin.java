package servlets.librarians;

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

@WebServlet(name = "librarianLogin", urlPatterns = {"/librarianLogin"})
public class librarianLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from librarians");
            boolean userExists = false;
            boolean isPasswordCorrect = false;
            while (result.next()) {
                if (request.getParameter("login").equals(result.getString("username")) || request.getParameter("login").equals(result.getString("email"))) {
                    userExists = true;
                    if (request.getParameter("password").equals(result.getString("password"))) {
                        isPasswordCorrect = true;
                    }
                    break;
                }
            }
            database.close();

            if (!userExists) {
                out.println("Status code 404 - Not found - Message: User does not exist");
                request.getRequestDispatcher("index.jsp").include(request, response);
            } else if (!isPasswordCorrect) {
                out.println("Status code 403 - Forbidden - Message: Incorrect password");
                request.getRequestDispatcher("index.jsp").include(request, response);
            } else {
                String username = request.getParameter("login");
                if (request.getParameter("login").contains("@")) {
                    database = new Database(out);
                    result = database.executeStatement("select username from librarians where email='" + request.getParameter("login") + "'");
                    result.next();
                    username = result.getString("username");
                    database.close();
                }
                HttpSession session = request.getSession();
                session.setAttribute("savedusername", username);
                session.setAttribute("type", "librarian");
                request.getRequestDispatcher("/librarian/librarian.jsp").include(request, response);
            }
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal Server error - SQLException");
            ex.printStackTrace();
        }
    }
}
