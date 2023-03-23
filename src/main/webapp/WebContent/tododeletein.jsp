<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
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
String todo_idStr =request.getParameter("todo_id");
String pStr =request.getParameter("0");

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

//HashMap(一件分のデータを格納する連想配列)
HashMap<String,String> map = null;

//ArrayList(全ての件数を格納する配列)
ArrayList<HashMap> list = null;
list = new ArrayList<HashMap>();

try{//ロードに失敗したときのための例外処理

//JDBCドライバのロード
Class.forName(DRIVER).newInstance();

//Connectionオブジェクトの作成
con = DriverManager.getConnection(URL,USER,PASSWORD);

//Statementオブジェクトの作成
stmt = con.createStatement();

//SQLステートメントの作成(選択クエリ)
SQL = new StringBuffer();

//SQL文の発行(選択クエリ)
SQL.append("select * from todo_tbl as t inner join user_tbl as u on t.user_no where u.user_no = '");
SQL.append(user_noStr);
SQL.append("' and todo_id = '");
SQL.append(todo_idStr);
SQL.append(" '");
System.out.println(SQL.toString());

//SQL文の発行(選択クエリ)
rs = stmt.executeQuery(SQL.toString());

//抽出したデータを繰り返し処理で表示する
while(rs.next()){
//DBのデータをHashMapへ格納する                            
map = new HashMap<String,String>();
map.put("todo_name" ,rs.getString("todo_name"));
map.put("todo_year" ,rs.getString("todo_year"));
map.put("todo_month" ,rs.getString("todo_month"));
map.put("todo_day" ,rs.getString("todo_day"));
map.put("todo_important" ,rs.getString("todo_important"));
map.put("todo_msg" ,rs.getString("todo_msg"));
map.put("background" ,rs.getString("background"));

//一件分のデータ(HashMap)をArrayListへ追加
list.add(map);
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
	if(rs != null){
		rs.close();
		}
	if(stmt != null){
		stmt.close();
}if(con != null){
	con.close();
}
}
catch(SQLException e){
	ERMSG = new StringBuffer();
	ERMSG.append(e.getMessage());
	}
}
%>
<!DOCTYPE html>

<html lang="ja">

  <head>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width">

    <title>To Do</title>

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
<form method="Post" class="a" action="tododeleteout.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%= todo_idStr %>">
<input type="hidden"name="0"value="<%= pStr %>">
<p>この内容を削除しますか？</p>
<p>To Do:<%=list.get(0).get("todo_name")%></p>
<p>期日:<%=list.get(0).get("todo_year")%>年<%=list.get(0).get("todo_month")%>月<%=list.get(0).get("todo_month")%>日　優先度:
<%if("1".equals(list.get(0).get("todo_important"))){ %>
低<%} %>
<%if("2".equals(list.get(0).get("todo_important"))){ %>
中<%} %>
<%if("3".equals(list.get(0).get("todo_important"))){ %>
高<%} %>
</p>
<p>メモ:<%=list.get(0).get("todo_msg")%></p>
<table>
<div class="hoge">
<td><button class="buttonA" type="submit" form="ho">戻る</button></td>
<td><button class="buttonA" type="submit">削除</button></td>
</div>
</table>
</form>
<%if("0".equals(pStr)){%>
<form method="Post" id="ho" class="b" action="todo.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
</form>
<%}else{ %>
<form method="Post" id="ho" class="b" action="todocompletion.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<%} %>
</form>
<%} %>
</body>
</html>