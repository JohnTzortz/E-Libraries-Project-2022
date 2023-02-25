
<%@page import="com.sun.tools.javac.util.Pair"%>
<%@page import="classes.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="classes.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="styles.css">
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
            
            if(session.getAttribute("type").equals("student"))
                response.sendRedirect("/Project2022_E-Libraries/student/student.jsp");
            else if(session.getAttribute("type").equals("librarian"))
                response.sendRedirect("/Project2022_E-Libraries/librarian/librarian.jsp");
            
            PrintWriter Out = response.getWriter();
        %>
        Student Login: 
        <form method="post" action="studentLogin">
            <input type="text" name="login" required>
            <input type="password" name="password" required>
            <input type="submit" value="submit">
        </form>
        Librarian Login: 
        <form method="post" action="librarianLogin">
            <input type="text" name="login" required>
            <input type="password" name="password" required>
            <input type="submit" value="submit">
        </form>
        <br>
        <table id="books">
        <% 
            ArrayList<Pair<String, ArrayList<Book>>> pairs = Database.getBooksByAllGenre(Out);
            for(int i = 0; i < pairs.size(); i++)
            {
        %>
                <th><%= pairs.get(i).fst %></th>
        <%
        %>
            <tr>
                <th>ISBN</th>
                <th>Title</th>
                <th>Authors</th>
                <th>Genre</th>
                <th>Photo</th>
                <th>URL</th>
            </tr>
                
        <%
                for(int j = 0; j < pairs.get(i).snd.size(); j++)
                {
        %>
                    <tr>
                        <td>
                            <%= pairs.get(i).snd.get(j).getIsbn() %>
                        </td>
                        <td>
                            <%= pairs.get(i).snd.get(j).getTitle() %>
                        </td>
                        <td>
                            <%= pairs.get(i).snd.get(j).getAuthors() %>
                        </td>
                        <td>
                            <%= pairs.get(i).snd.get(j).getGenre() %>
                        </td>
                        <td>
                            <a target="_blank" href= <%= pairs.get(i).snd.get(j).getPhoto() %> >Click here</a>
                        </td>
                        <td>
                            <a target="_blank" href= <%= pairs.get(i).snd.get(j).getUrl() %> >Click here</a>
                        </td>
                    </tr>
        <%
                }
            }
        %>
        </table>
        
        <script src="script.js"></script>
    </body>
</html>
