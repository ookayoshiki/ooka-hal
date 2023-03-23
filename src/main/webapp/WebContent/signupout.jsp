<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
        //文字コードの指定
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        //入力データ受信
        String user_idStr =request.getParameter("user_id");
        String user_pasStr =request.getParameter("user_pas");

        //データベースに接続するために使用する変数宣言
        Connection con = null;
        Statement stmt = null;
        StringBuffer SQL = null;
        ResultSet rs = null;

        //MySQLに接続する設定
        String USER = "b514730714a426";
        String PASSWORD = "908eb037";
        String URL = "jdbc:mysql://us-cdbr-east-06.cleardb.net/heroku_420468ff511f4c4?useUnicode=true&characterEncoding=utf8";
        String DRIVER = "com.mysql.jdbc.Driver";

        //確認メッセージ
        StringBuffer ERMSG = null;

        //ヒットフラグ
        int hit_flag =0;

        //追加件数
        int ins_count =0;

        try{
        //ロード失敗したときのための例外処理
        //JDBCドライバのロード
        Class.forName(DRIVER).newInstance();



       //Connectionオブジェクトの作成
       con = DriverManager.getConnection(URL,USER,PASSWORD);



       //Statementオブジェクトの作成
       stmt = con.createStatement();



       //SQLステートメントの作成(選択クエリ)
       SQL = new StringBuffer();

       //SQL文の構築(DB検索)
       SQL.append("select * from user_tbl where user_id='");
       SQL.append(user_idStr);
       SQL.append("'");
       System.out.println(SQL.toString());

       //SQL文の発行(選択クエリ)
       rs = stmt.executeQuery(SQL.toString());

       //入力したデータがデータベースに存在するか調べる
       if(rs.next()){ //存在する(追加NG)
                         //ヒットフラグON
                         hit_flag =1;

       }
       else if((user_idStr.equals("")) || (user_pasStr.equals(""))){
    hit_flag = 1;
       }
       else{ //存在しない(追加OK)
       //ヒットフラグOFF
       hit_flag =0;
       //SQLステートメントの作成(選択クエリ)
       SQL = new StringBuffer();

       SQL.append("insert into user_tbl(user_id,user_pas,background)");
       SQL.append("values('");
       SQL.append(user_idStr);
       SQL.append("','");
       SQL.append(user_pasStr);
       SQL.append("','");
       SQL.append(1);
       SQL.append("')");
       System.out.println(SQL.toString());

       //SQL文の実行(DB追加)
       ins_count = stmt.executeUpdate(SQL.toString());
       }
       }//tryブロック終了

        catch(ClassNotFoundException e){
            ERMSG = new StringBuffer();
            ERMSG.append(e.getMessage());
        }
        catch(SQLException e){
            ERMSG = new StringBuffer();
            ERMSG.append(e.getMessage());
        }
        catch(Exception e){
            ERMSG = new StringBuffer();
            ERMSG.append(e.getMessage());
        }

        finally{//例外があってもなくても必ず実行する
            //各種オブジェクトクローズ(後片付け)
            try{
                if(rs !=null){
                                rs.close();
                }
                if(stmt !=null){
                    stmt.close();
                }
                if(con !=null){
                        con.close();
                }
            }
        catch(SQLException e){
            ERMSG = new StringBuffer();
            ERMSG.append(e.getMessage());
                            }
        }
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content=Type" content="text/html; charset=UTF-8">
<title>Sign Up</title>
    <link rel="stylesheet" type="text/css" href="../css/reset.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
</head>
<body>
<%
    if(hit_flag == 1  || ins_count == 0){//認証NG
%>
    <form name="login_form" method="Post" action="signupout.jsp">
      <div class="login_form_top">
        <h1>Sign up</h1>
      </div>
      <p><font color="red">会員登録できません</font></p>
      <div class="login_form_btm">
        <input type="id" name="user_id" placeholder="UserID" maxlength="20" required>
        <input type="password" name="user_pas" placeholder="Password" maxlength="20" required>
        <input type="submit" name="botton" value="Sign Up">
      </div>
    </form>
 <%
     }else{//認証OK
 %>
    <form name="login_form">
    <p>登録完了です！</p>
    <a href="login.jsp">Login</a>
    </form>
 <%
     }
%>
<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%} %>
</body>
</html>
