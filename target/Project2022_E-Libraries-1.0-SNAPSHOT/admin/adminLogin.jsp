<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="/Project2022_E-Libraries/admin/adminLogin.css">
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
                response.sendRedirect("/Project2022_E-Libraries/students/student.jsp");
            else if(session.getAttribute("type").equals("librarian"))
                response.sendRedirect("/Project2022_E-Libraries/librarian/librarian.jsp");
        %>
        
        <form method="post" action="adminLogin">
            <input type="text" name="username" required>
            <input type="password" name="password" required>
            <input type="submit" value="submit">
        </form>
        
        <script src="/Project2022_E-Libraries/admin/adminLogin.js"></script>
    </body>
</html>
