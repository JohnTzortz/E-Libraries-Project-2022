<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="/Project2022_E-Libraries/student/student.css">
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
            
            if(!session.getAttribute("type").equals("student"))
                response.sendRedirect("/Project2022_E-Libraries/index.jsp");
        %>

        <form method="post" action="logout">
            <input type="submit" value="Log Out">
        </form>
        <br>
        Search books by genre
        <form method="get" action="booksByGenre">
            <input type="text" name="genre" placeholder="genre" required>
            <input type="submit" value="Submit">
        </form>
        <br>
        Search books by publication year
        <form method="get" action="booksByYear">
            <input type="number" name="fromYear" placeholder="from year" min="1500" max="2022">
            <input type="number" name="toYear" placeholder="to year" min="1500" max="2022">
            <input type="submit" value="Submit">
        </form>
        <br>
        Search books by title
        <form method="get" action="booksByTitle">
            <input type="text" name="title" placeholder="title" required>
            <input type="submit" value="Submit">
        </form>
        <br>
        Search books by author
        <form method="get" action="booksByAuthor">
            <input type="text" name="author" placeholder="author" required>
            <input type="submit" value="Submit">
        </form>
        <br>
        Search books by number of pages
        <form method="get" action="booksByPageNum">
            <input type="number" name="fromNPages" placeholder="from number of pages" min="0">
            <input type="number" name="toNPages" placeholder="to number of pages" min="0">
            <input type="submit" value="Submit">
        </form>
        <script src="/Project2022_E-Libraries/student/student.js"></script>
    </body>
</html>
