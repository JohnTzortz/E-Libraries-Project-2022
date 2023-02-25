package servlets;

import classes.Student;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "studentDelete", urlPatterns = {"/studentDelete", "/admin/studentDelete"})
public class studentDelete extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        if (!(session.getAttribute("type").equals("admin") || session.getAttribute("type").equals("student"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        String redirect = Student.DBDelete(request.getParameter("username"), out);
        if (redirect != null) {
            request.getRequestDispatcher(redirect).include(request, response);
        }
    }
}
