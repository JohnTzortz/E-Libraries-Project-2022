package servlets.get;

import classes.Database;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "test", urlPatterns = {"/test"})
public class test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Integer> inte = Database.getNumberOfBooksByLibrary(response.getWriter());
        for (int i = 0; i < inte.size(); i++) {
            response.getWriter().println(inte.get(i));
        }
    }
}
