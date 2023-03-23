<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.ArrayList" %>
<%
//文字コードの指定
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

//入力データ受信
String user_noStr =request.getParameter("user_no");
if(user_noStr == null){%>
<!DOCTYPE html>

<html lang="ja">

  <head>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width">

    <title>To Do</title>

    <link rel="stylesheet" type="text/css" href="../css/reset.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
  </head>
  <form method="Post" action="index.jsp">
  <p>Loginページからご利用ください</p>
  <button class="buttonA"type="submit">Login</button>
  </form><%
}
else{
String todo_nameStr =request.getParameter("todo_name");
String todo_yearStr =request.getParameter("todo_year");
String todo_monthStr =request.getParameter("todo_month");
String todo_dayStr =request.getParameter("todo_day");
String todo_importantStr =request.getParameter("todo_important");
String todo_msgStr =request.getParameter("todo_msg");
int todo_yearInt = Integer.parseInt(todo_yearStr);
int todo_monthInt = Integer.parseInt(todo_monthStr);
int todo_dayInt = Integer.parseInt(todo_dayStr);
int todo_noInt = (todo_yearInt * 10000) + (todo_monthInt * 100) + todo_dayInt;
int hit_flag = 0;

switch(todo_monthInt){
case 2:
  if(todo_yearInt % 400 == 0 || (todo_yearInt % 4 == 0 && todo_yearInt % 100 != 0)){
	  if(todo_dayInt >= 29){
		  hit_flag = 1;
	  }
  }else{
	  if(todo_dayInt >= 28){
		  hit_flag = 1;
	  }
  }
  break;
case 4:
case 6:
case 9:
case 11:
  if(todo_dayInt >= 31){
	  hit_flag = 1;
  }
  break;
}
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

//追加件数
int ins_count =0;

//HashMap(一件分のデータを格納する連想配列)
HashMap<String,String> map = null;

//ArrayList(全ての件数を格納する配列)
ArrayList<HashMap> list = null;
list = new ArrayList<HashMap>();
try{
//ロード失敗したときのための例外処理
//JDBCドライバのロード
Class.forName(DRIVER).newInstance();



//Connectionオブジェクトの作成
con = DriverManager.getConnection(URL,USER,PASSWORD);



//Statementオブジェクトの作成
stmt = con.createStatement();

if(hit_flag ==0){
//SQLステートメントの作成(選択クエリ)
SQL = new StringBuffer();

SQL.append("insert into todo_tbl(user_no,todo_name,todo_year,todo_month,todo_day,todo_no,todo_msg,todo_important,todo_completion)");
SQL.append("values('");
SQL.append(user_noStr);
SQL.append("','");
SQL.append(todo_nameStr);
SQL.append("','");
SQL.append(todo_yearStr);
SQL.append("','");
SQL.append(todo_monthStr);
SQL.append("','");
SQL.append(todo_dayStr);
SQL.append("','");
SQL.append(todo_noInt);
SQL.append("','");
SQL.append(todo_msgStr);
SQL.append("','");
SQL.append(todo_importantStr);
SQL.append("','");
SQL.append(0);
SQL.append("')");
System.out.println(SQL.toString());

//SQL文の実行(DB追加)
ins_count = stmt.executeUpdate(SQL.toString());
}
//SQLステートメントの作成(選択クエリ)
SQL = new StringBuffer();
//SQL文の構築(DB検索)
SQL.append("select background from user_tbl where user_no='");
SQL.append(user_noStr);
SQL.append("'");
System.out.println(SQL.toString());

//SQL文の発行(選択クエリ)
rs = stmt.executeQuery(SQL.toString());

    //抽出したデータを繰り返し処理で表示する
    while(rs.next()){
    //DBのデータをHashMapへ格納する                            
    map = new HashMap<String,String>();
    map.put("background" ,rs.getString("background"));

    //一件分のデータ(HashMap)をArrayListへ追加
    list.add(map);
    }//存在する(追加NG)
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


<html lang="ja">

  <head>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width">

    <title>Time Table</title>

    <link rel="stylesheet" type="text/css" href="../css/reset.css">
    <link rel="stylesheet" type="text/css" href="../css/nav.css">
    <link rel="stylesheet" type="text/css" href="../css/timetablein.css">

  </head>

  <%if("1".equals(list.get(0).get("background"))){ %><body id="background1"><%} %>
  <%if("2".equals(list.get(0).get("background"))){ %><body id="background2"><%} %>
  <%if("3".equals(list.get(0).get("background"))){ %><body id="background3"><%} %>
  <%if("4".equals(list.get(0).get("background"))){ %><body id="background4"><%} %>
  <%if("5".equals(list.get(0).get("background"))){ %><body id="background5"><%} %>
  <%if("6".equals(list.get(0).get("background"))){ %><body id="background6"><%} %>
  <%if("7".equals(list.get(0).get("background"))){ %><body id="background7"><%} %>
  <%if("8".equals(list.get(0).get("background"))){ %><body id="background8"><%} %>
<input type="checkbox" id="menu-btn-check">
<label for="menu-btn-check" class="menu-btn"><span></span></label>
<!--ここからメニュー-->
<div class="menu-content">
<ul>
<li>
<a href="timetable.jsp?user_no=<%=user_noStr%>">Time Table</a>
</li>
<li>
<a href="todo.jsp?user_no=<%=user_noStr%>">To Do</a>
</li>
  <li>
  <a href="background.jsp?user_no=<%=user_noStr%>">Background</a>
  </li>
<li>
<a href="index.jsp">Logout</a>
</li>
</ul>
</div>
<%if(hit_flag == 1){%>
<form method="Post" class="a" action="todoinsertin.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_name"value="<%= todo_nameStr %>">
<input type="hidden"name="todo_msg"value="<%= todo_msgStr %>">
<p>暦上存在しない年月日が入力されています</p>
<div class="hoge">
<button class="buttonA" type="submit">入力に戻る</button>
</div>
</form>
<%}else{ %>
<form method="Post" class="a" action="todo.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<p>登録完了です！</p>
<div class="hoge">
<button class="buttonA" type="submit">To Do</button>
</div>
</form>
<%} %>
<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%}}%>
</body>
</html>