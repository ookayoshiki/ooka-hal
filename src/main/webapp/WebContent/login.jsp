<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">

  <head>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width">

    <title>Login</title>

    <link rel="stylesheet" type="text/css" href="../css/reset.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">

  </head>

  <body>

    <form name="login_form" method="Post" action="home.jsp">
      <div class="login_form_top">
        <h1>Login</h1>
      </div>
      <div class="login_form_btm">
        <input type="id" name="user_id" placeholder="UserID" maxlength="20" required>
        <input type="password" name="user_pas" placeholder="Password" maxlength="20" required>
        <input type="submit" name="botton" value="Login">
        <a href="signup.jsp">Sign Up</a>
      </div>
    </form>

  </body>
</html>