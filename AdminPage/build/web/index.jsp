
<%@page import="src.Model.User"%>
<%@page import="src.Constants"%>
<%@page import="src.Dal.UserDal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    boolean isError = false;
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    if(login!=null && password!=null) {
        UserDal userDal = new UserDal(Constants.url, Constants.login, Constants.password);
        User checkUser = new User(100,"","",login,"",password);
        if(userDal.isUserExist(checkUser)) {
            Constants.isAuthorize = true;
        } else {
            isError = true;
        }
    }
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Authorization</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="pr-wrap">
                        <div class="pass-reset">
                            <label>Введите логин</label>
                            <input type="email" placeholder="Email" />
                            <input type="submit" value="Submit" class="pass-reset-submit btn btn-success btn-sm" />
                         </div>
                    </div>
                    <div class="wrap">
                    <p class="form-title">Авторизация</p>
                        <form class="login" action="index.jsp" method="POST">
                        <input type="text" placeholder="Почта" name="login"/>
                        <input type="password" placeholder="Пароль" name="password"/>
                        <input type="submit" value="Войти" class="btn btn-success btn-sm" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <% if(isError) {%>
        <script>
            alert ('User not found! Please try again')
        </script>
        <%}%>
        <% if(Constants.isAuthorize) {%>
        <script>
            location.href = "main.jsp";
        </script>
        <%}%>
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
