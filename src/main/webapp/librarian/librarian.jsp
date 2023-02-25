<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="/Project2022_E-Libraries/librarian/librarian.css">
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
            
            if(!session.getAttribute("type").equals("librarian"))
                response.sendRedirect("/Project2022_E-Libraries/index.jsp");
        %>
        
        <!-- απο εδω και κατω κωδικας html. -->
        
        <form method="post" action="logout">
            <input type ="submit" value="Log Out">
        </form>
        
        <script src="/Project2022_E-Libraries/librarian/librarian.js"></script>
    </body>
</html>
