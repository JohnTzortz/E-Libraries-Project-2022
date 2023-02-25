<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="/Project2022_E-Libraries/student/studentLogin.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
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
        %>


        <!-- απο εδω και κατω κωδικας html. -->

        <div class="login-form">
            <form action="/examples/actions/confirmation.php" method="post">
                <h2 class="text-center">Hello, Student</h2>       
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Username or Email" required="required">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" required="required">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">Log in</button>
                </div>
                <div class="clearfix">
                    <a href="#" class="float-right">Forgot Password?</a>
                </div>        
            </form>
            <p class="text-center"><a href="studentRegister.jsp">Create an Account</a></p>
        </div>
        
        <script src="/Project2022_E-Libraries/student/studentLogin.js"></script>
    </body>
</html>
