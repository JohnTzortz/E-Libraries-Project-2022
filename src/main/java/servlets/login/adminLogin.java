package servlets.librarians;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "adminLogin", urlPatterns = {"/admin/adminLogin"})
public class adminLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (request.getParameter("username").equals("admin") && request.getParameter("password").equals("admin12*")) {
            HttpSession session = request.getSession();
            session.setAttribute("savedusername", request.getParameter("username"));
            session.setAttribute("type", "admin");
            request.getRequestDispatcher("admin.jsp").include(request, response);
        } else {
            out.println("Status code 403 - Forbidden - Message: Incorrect login credentials");
            request.getRequestDispatcher("adminLogin.jsp").include(request, response);
        }
    }
}
