<%@page import="classes.LibraryManager"%>
<%@page import="classes.Student"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="classes.SimpleUser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="/Project2022_E-Libraries/admin/admin.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("type") == null)
            {
                session.setAttribute("type", "");
            }
            if(session.getAttribute("savedusername") == null)
            {
                session.setAttribute("savedusername", "");
            }
            
            if(!session.getAttribute("type").equals("admin"))
                response.sendRedirect("/Project2022_E-Libraries/index.jsp");
            
            PrintWriter Out = response.getWriter();
        %>
        <form method="post" action="logout">
            <input type ="submit" value="Log Out">
        </form>
        <table id="users">
        <% 
            ArrayList<SimpleUser> users = Database.getUsers(Out);
            for(int i = 0; i < users.size(); i++)
            {
        %>
            <tr>
        <%
                if(users.get(i).getType().equals("student"))
                {
        %>
                <td>
                    <form method="post" action="studentDelete">
                        <input type="hidden" name="username" value = <%= users.get(i).getUsername() %>>
                        <input type="submit" value="Delete">
                    </form>
                </td>
        <%
                }
                else if(users.get(i).getType().equals("librarian"))
                {
        %>
                <td>
                    <form method="post" action="librarianDelete">
                        <input type="hidden" name="username" value = <%= users.get(i).getUsername() %>>
                        <input type="submit" value="Delete">
                    </form>
                </td>
        <%
                }
        %>  
                <td>
                     <%= users.get(i).getType() %>
                </td>
                <td>
                     <%= users.get(i).getUsername() %>
                </td>
                <td>
                     <%= users.get(i).getEmail() %>
                </td>
                <td>
                     <%= users.get(i).getFirstname() %>
                </td>
                <td>
                     <%= users.get(i).getLastname() %>
                </td>
            </tr>
        <%
            }
        %>
        </table>
        
        <h5>Number of books per library: <%= Database.getNumberOfBooksByLibrary(Out) %> </h5>
        <h5>Number of students per type: <%= Database.getNumberOfStudentsByType(Out) %> </h5>
        <h5>Number of books by genre: <%= Database.getNumberBooksByAllGenre(Out) %> </h5>
        
        <script src="/Project2022_E-Libraries/admin/admin.js"></script>
    </body>
</html>
