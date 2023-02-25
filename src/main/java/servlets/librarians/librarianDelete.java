package servlets;

import classes.LibraryManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "librarianDelete", urlPatterns = {"/librarianDelete", "/admin/librarianDelete"})
public class librarianDelete extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        if (!(session.getAttribute("type").equals("librarian") || session.getAttribute("type").equals("admin"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        String redirect = LibraryManager.DBDelete(request.getParameter("username"), out);
        if (redirect != null) {
            request.getRequestDispatcher(redirect).include(request, response);
        }
    }
}
