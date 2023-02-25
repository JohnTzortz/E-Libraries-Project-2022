package servlets.librarians;

import classes.Review;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "reviewInsert", urlPatterns = {"/reviewInsert"})
public class reviewInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        if (!session.getAttribute("type").equals("student")) {
            response.sendRedirect("index.jsp");
            return;
        }

        Review review = new Review(
                request.getParameter("user_id").equals("") ? null : Integer.parseInt(request.getParameter("user_id")),
                request.getParameter("isbn"),
                request.getParameter("reviewText"),
                request.getParameter("reviewScore").equals("") ? null : Integer.parseInt(request.getParameter("reviewScore"))
        );
        Review.DBInsert(review, out);
    }
}
