package servlets;

import classes.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "studentInsert", urlPatterns = {"/studentInsert"})
public class studentInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        final PrintWriter out = response.getWriter();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Student student = null;
        try {
            student = new Student(
                    request.getParameter("username"),
                    request.getParameter("email"),
                    request.getParameter("password"),
                    request.getParameter("firstname"),
                    request.getParameter("lastname"),
                    new java.sql.Date(sdf.parse(request.getParameter("birthdate")).getTime()),
                    request.getParameter("gender"),
                    request.getParameter("country"),
                    request.getParameter("city"),
                    request.getParameter("address"),
                    request.getParameter("student_type"),
                    request.getParameter("student_id"),
                    new java.sql.Date(sdf.parse(request.getParameter("student_id_from_date")).getTime()),
                    new java.sql.Date(sdf.parse(request.getParameter("student_id_to_date")).getTime()),
                    request.getParameter("university"),
                    request.getParameter("departmant"),
                    request.getParameter("lat").equals("") ? null : Double.parseDouble(request.getParameter("lat")),
                    request.getParameter("lon").equals("") ? null : Double.parseDouble(request.getParameter("lon")),
                    request.getParameter("telephone").equals("") ? null : request.getParameter("telephone"),
                    request.getParameter("personalpage").equals("") ? null : request.getParameter("personalpage")
            );
        } catch (ParseException ex) {
            out.println("Status code 406 - Not Acceptable - ParseException - Message: Date format problem");
            ex.printStackTrace();
        }
        Student.DBInsert(student, out);
    }
}
