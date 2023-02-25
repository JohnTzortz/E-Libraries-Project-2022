package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "logout", urlPatterns = {"/logout", "/admin/logout", "/student/logout", "/librarian/logout"})
public class logout extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();

        if (session.getAttribute("savedusername") == null) {
            response.sendRedirect("/index.jsp");
            return;
        }

        session.removeAttribute("savedusername");
        session.removeAttribute("type");
        session.invalidate();
        request.getRequestDispatcher("/index.jsp").include(request, response);
    }
}
