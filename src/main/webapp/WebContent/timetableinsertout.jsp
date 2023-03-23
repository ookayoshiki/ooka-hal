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
String time_idStr =request.getParameter("time_id");
String time_nameStr =request.getParameter("time_name");
String time_teacherStr =request.getParameter("time_teacher");
String time_roomStr =request.getParameter("time_room");
String time_msgStr =request.getParameter("time_msg");

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

//更新件数
int upd_count =0;

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

//SQLステートメントの作成(選択クエリ)
SQL = new StringBuffer();
//SQL文の構築(DB更新)
SQL.append("update time_tbl set time_name='");
SQL.append(time_nameStr);
SQL.append("',time_teacher='");
SQL.append(time_teacherStr);
SQL.append("',time_room='");
SQL.append(time_roomStr);
SQL.append("',time_msg='");
SQL.append(time_msgStr);
SQL.append("'where user_no ='");
SQL.append(user_noStr);
SQL.append("' and time_id ='");
SQL.append(time_idStr);
SQL.append("'");
System.out.println(SQL.toString());

upd_count = stmt.executeUpdate(SQL.toString());

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
<form method="Post" class="a" action="timetable.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<p>登録完了です！</p>
<div class="hoge">
<td><button class="buttonA" type="submit">Time Table</button></td>
</div>
</form>
<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%}}%>
</body>
</html>