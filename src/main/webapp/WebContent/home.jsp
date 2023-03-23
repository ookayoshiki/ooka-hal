<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
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

        //HashMap(一件文のデータを格納する連想配列)
        HashMap<String,String> map = null;



       //ArrayList(すべての件数を格納する連想配列)
        ArrayList<HashMap>list = null;
        list = new ArrayList<HashMap>();

      //更新件数
        int upd_count =0;

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



       //SQL文の発行(選択クエリ)
        SQL.append("select * from user_tbl where user_id='");
        SQL.append(user_idStr);
        SQL.append("'and user_pas='");
        SQL.append(user_pasStr);
        SQL.append("'");
        System.out.println(SQL.toString());

       //SQL文の発行(選択クエリ)
        rs = stmt.executeQuery(SQL.toString());

       //入力したデータがデータベースに存在するか調べる
       if(rs.next()){ //存在する
                         //ヒットフラグON
                         hit_flag =1;

          //検索のデータをHashMapへ格納する
          map = new HashMap<String,String>();
                         map.put("user_no",rs.getString("user_no"));
                         map.put("user_check",rs.getString("user_check"));
                         map.put("background" ,rs.getString("background"));
                        //一件分のデータ(HashMap)をArrayListへ追加
                         list.add(map);
       }else{ //存在しない
                         //ヒットフラグOFF
                         hit_flag =0;
       }
       if(hit_flag == 1  && list.get(0).get("user_check") == null){
    	   for(int i = 1;i < 37;i++){
    		    //SQLステートメントの作成(選択クエリ)
    		    SQL = new StringBuffer();
    		    SQL.append("insert into time_tbl(user_no,time_id)");
    		    SQL.append("values('");
    		    SQL.append(list.get(0).get("user_no"));
    		    SQL.append("','");
    		    SQL.append(i);
    		    SQL.append("')");
    		    System.out.println(SQL.toString());
    		    //SQL文の実行(DB追加)
    		    ins_count = stmt.executeUpdate(SQL.toString());
    			}
    	 //SQLステートメントの作成(選択クエリ)
    	   SQL = new StringBuffer();
    	   //SQL文の構築(DB更新)
    	   SQL.append("update user_tbl set user_check='");
    	   SQL.append(1);
    	   SQL.append("'where user_no ='");
    	   SQL.append(list.get(0).get("user_no"));
    	   SQL.append("'");
    	   System.out.println(SQL.toString());

    	   upd_count = stmt.executeUpdate(SQL.toString());
       }
       } //tryブロック終了

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
<%
        if(hit_flag ==1){ //認証OK
%>
<head>
<meta http-equiv="Content=Type" content="text/html; charset=UTF-8">
<title>Home</title>
<link rel="stylesheet" type="text/css" href="../css/reset.css">
<link rel="stylesheet" type="text/css" href="../css/home.css">
</head>
<%if("1".equals(list.get(0).get("background"))){ %><body id="background1"><%} %>
  <%if("2".equals(list.get(0).get("background"))){ %><body id="background2"><%} %>
  <%if("3".equals(list.get(0).get("background"))){ %><body id="background3"><%} %>
  <%if("4".equals(list.get(0).get("background"))){ %><body id="background4"><%} %>
  <%if("5".equals(list.get(0).get("background"))){ %><body id="background5"><%} %>
  <%if("6".equals(list.get(0).get("background"))){ %><body id="background6"><%} %>
  <%if("7".equals(list.get(0).get("background"))){ %><body id="background7"><%} %>
  <%if("8".equals(list.get(0).get("background"))){ %><body id="background8"><%} %>
    <div class="mask">
  <img src="../image/hello.jpg">
</div>
<table>
<td><a href="timetable.jsp?user_no=<%=list.get(0).get("user_no")%>" class="btn-circle-stitch1">Time Table</a></td>
<td><a href="todo.jsp?user_no=<%=list.get(0).get("user_no")%>" class="btn-circle-stitch2">To Do</a></td>
</table>

<%
                }else{ //認証NG
%>
<head>
<meta http-equiv="Content=Type" content="text/html; charset=UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="../css/reset.css">
<link rel="stylesheet" type="text/css" href="../css/common.css">
</head>
<body>
    <form name="login_form" method="Post" action="home.jsp">
      <div class="login_form_top">
        <h1>Login</h1>
        <p><font color="red">UserIDまたはPasswordが違います</font></p>
      </div>
      <div class="login_form_btm">
        <input type="id" name="user_id" placeholder="UserID" maxlength="20" required>
        <input type="password" name="user_pas" placeholder="Password" maxlength="20" required>
        <input type="submit" name="botton" value="Login">
        <a href="signup.jsp">Sign Up</a>
      </div>
    </form>
<%
                }
%>

<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%}%>
</body>
</html>
