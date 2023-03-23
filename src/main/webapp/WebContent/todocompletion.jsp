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
        String todo_idStr =request.getParameter("todo_id");
        String c = null;

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

       if(todo_idStr != null){
     //SQLステートメントの作成(選択クエリ)
       SQL = new StringBuffer();
       //SQL文の構築(DB更新)
       SQL.append("update todo_tbl set todo_completion='");
       SQL.append(0);
       SQL.append("' where user_no ='");
       SQL.append(user_noStr);
       SQL.append("' and todo_id ='");
       SQL.append(todo_idStr);
       SQL.append("'");
       System.out.println(SQL.toString());

       upd_count = stmt.executeUpdate(SQL.toString());
       }

       //SQLステートメントの作成(選択クエリ)
       SQL = new StringBuffer();
       //SQL文の構築(DB検索)
       SQL.append("select u.user_no,case when t.user_no is null then '");
       SQL.append(user_noStr);
       SQL.append("' else t.user_no end as user_no,case when t.todo_id is null then '");
       SQL.append(0);
       SQL.append("' else t.todo_id end as todo_id,todo_name,todo_year,todo_month,todo_day,todo_msg,todo_important,todo_completion,background from todo_tbl as t right outer join user_tbl as u on t.user_no = u.user_no where u.user_no = '");
       SQL.append(user_noStr);
       SQL.append("' order by todo_no desc");
       System.out.println(SQL.toString());

       //SQL文の発行(選択クエリ)
       rs = stmt.executeQuery(SQL.toString());

           //抽出したデータを繰り返し処理で表示する
           while(rs.next()){
           //DBのデータをHashMapへ格納する                            
           map = new HashMap<String,String>();
           map.put("todo_id" ,rs.getString("todo_id"));
           map.put("todo_name" ,rs.getString("todo_name"));
           map.put("todo_year" ,rs.getString("todo_year"));
           map.put("todo_month" ,rs.getString("todo_month"));
           map.put("todo_day" ,rs.getString("todo_day"));
           map.put("todo_msg" ,rs.getString("todo_msg"));
           map.put("todo_important" ,rs.getString("todo_important"));
           map.put("todo_completion" ,rs.getString("todo_completion"));
           map.put("background" ,rs.getString("background"));

           //一件分のデータ(HashMap)をArrayListへ追加
           list.add(map);
           }//存在する(追加NG)
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
    <link rel="stylesheet" type="text/css" href="../css/todo.css">
  </head>

  <%if("1".equals(list.get(0).get("background"))){ %><body id="background1"><%} %>
  <%if("2".equals(list.get(0).get("background"))){ %><body id="background2"><%} %>
  <%if("3".equals(list.get(0).get("background"))){ %><body id="background3"><%} %>
  <%if("4".equals(list.get(0).get("background"))){ %><body id="background4"><%} %>
  <%if("5".equals(list.get(0).get("background"))){ %><body id="background5"><%} %>
  <%if("6".equals(list.get(0).get("background"))){ %><body id="background6"><%} %>
  <%if("7".equals(list.get(0).get("background"))){ %><body id="background7"><%} %>
  <%if("8".equals(list.get(0).get("background"))){ %><body id="background8"><%} %>
<h1>完了済み</h1>
<p>優先度：低<font color="#C4FF89">■</font>　優先度：中<font color="#F4F4A8">■　</font>優先度：高<font color="#FFB2D8">■</font></p>
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
<!--ここまでメニュー-->
<div class="tab-area">

<input id="tab-btn1" class="tab-btn" name="tab" type="radio" checked>
<input id="tab-btn2" class="tab-btn" name="tab" type="radio">
<input id="tab-btn3" class="tab-btn" name="tab" type="radio">
<input id="tab-btn4" class="tab-btn" name="tab" type="radio">

<ul class="tab-list-wrap">
<li><label id="tab-list1" class="tab-list" for="tab-btn1">すべて</label></li>
<li><label id="tab-list2" class="tab-list" for="tab-btn2">優先度：低</label></li>
<li><label id="tab-list3" class="tab-list" for="tab-btn3">優先度：中</label></li>
<li><label id="tab-list4" class="tab-list" for="tab-btn4">優先度：高</label></li>
</ul>
<form method="Post" id="insert" action="todoinsertin.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
</form>
<form method="Post" id="com" action="todo.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
</form>

<div class="tab-content-wrap">
<div id="tab-content1" class="tab-content">
<%
int w = 0;
if(!("0".equals(list.get(0).get("todo_id")))){
for(int i=0;i < list.size();i++){
if("1".equals(list.get(i).get("todo_completion"))){
if("1".equals(list.get(i).get("todo_important"))){
	c = "#C4FF89";
}
if("2".equals(list.get(i).get("todo_important"))){
	c = "#FFFFB2";
}
if("3".equals(list.get(i).get("todo_important"))){
	c = "#FFB2D8";
}
w = 1;
%>
<div id="aiueo" style="border:2px dashed #ffffff;background-color:<%=c%>;box-shadow:0 0 0 6px <%=c%>;padding:10px;margin:20px;">
<table>
<tr>
<td class="to">To Do:<%=list.get(i).get("todo_name")%></td>
<td>期日:<%=list.get(i).get("todo_year")%>年<%=list.get(i).get("todo_month")%>月<%=list.get(i).get("todo_day")%>日</td>
</tr>
<%if(!("".equals(list.get(i).get("todo_msg")))){%>
<tr>
<td colspan="2">メモ:<%=list.get(i).get("todo_msg")%></td>
</tr>
<%} %>
</table>
<table>
<tr><td>
<form method="Post" action="todoupdatein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"type="submit">変更</button>
</form></td>
<td>
<form method="Post" action="todocompletion.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<button class="buttonB"type="submit">未完了</button>
</form></td>
<td>
<form method="Post" action="tododeletein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"  type="submit">削除</button>
</form>
</td></tr>
</table>
</div>
<%}}}
if(w == 0){%><p>現在ありません</p> <%} %>
<table>
<div class="hoge">
<td><button class="buttonA" form="insert" type="submit">登録</button></td>
<td><button class="buttonA" form="com" type="submit">未完了一覧</button></td>
</div>
</table>
</div>
<div id="tab-content2" class="tab-content">
<%
int x = 0;
if(!("0".equals(list.get(0).get("todo_id")))){
for(int i=0;i < list.size();i++){
if("1".equals(list.get(i).get("todo_completion"))){
if("1".equals(list.get(i).get("todo_important"))){
x = 1;
%>
<div id="aiueo" style="border:2px dashed #ffffff;background-color:#C4FF89;box-shadow:0 0 0 6px #C4FF89;padding:10px;margin:20px;">
<table>
<tr>
<td class="to">To Do:<%=list.get(i).get("todo_name")%></td>
<td>期日:<%=list.get(i).get("todo_year")%>年<%=list.get(i).get("todo_month")%>月<%=list.get(i).get("todo_day")%>日</td>
</tr>
<%if(!("".equals(list.get(i).get("todo_msg")))){%>
<tr>
<td colspan="2">メモ:<%=list.get(i).get("todo_msg")%></td>
</tr>
<%} %>
</table>
<table>
<tr><td>
<form method="Post" action="todoupdatein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"type="submit">変更</button>
</form></td>
<td>
<form method="Post" action="todocompletion.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<button class="buttonB"type="submit">未完了</button>
</form></td>
<td>
<form method="Post" action="tododeletein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"  type="submit">削除</button>
</form>
</td></tr>
</table>
</div>
<%}}}}
if(x == 0){%><p>現在ありません</p> <%} %>
<table>
<div class="hoge">
<td><button class="buttonA" form="insert" type="submit">登録</button></td>
<td><button class="buttonA" form="com" type="submit">未完了一覧</button></td>
</div>
</table>
</div>
<div id="tab-content3" class="tab-content">
<%
int y = 0;
if(!("0".equals(list.get(0).get("todo_id")))){
for(int i=0;i < list.size();i++){
if("1".equals(list.get(i).get("todo_completion"))){
if("2".equals(list.get(i).get("todo_important"))){
y = 1;
%>
<div id="aiueo" style="border:2px dashed #ffffff;background-color:#FFFFB2;box-shadow:0 0 0 6px #FFFFB2;padding:10px;margin:20px;">
<table>
<tr>
<td class="to">To Do:<%=list.get(i).get("todo_name")%></td>
<td>期日:<%=list.get(i).get("todo_year")%>年<%=list.get(i).get("todo_month")%>月<%=list.get(i).get("todo_day")%>日</td>
</tr>
<%if(!("".equals(list.get(i).get("todo_msg")))){%>
<tr>
<td colspan="2">メモ:<%=list.get(i).get("todo_msg")%></td>
</tr>
<%} %>
</table>
<table>
<tr><td>
<form method="Post" action="todoupdatein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"type="submit">変更</button>
</form></td>
<td>
<form method="Post" action="todocompletion.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<button class="buttonB"type="submit">未完了</button>
</form></td>
<td>
<form method="Post" action="tododeletein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"  type="submit">削除</button>
</form>
</td></tr>
</table>
</div>
<%}}}}
if(y == 0){%><p>現在ありません</p> <%} %>
<table>
<div class="hoge">
<td><button class="buttonA" form="insert" type="submit">登録</button></td>
<td><button class="buttonA" form="com" type="submit">未完了一覧</button></td>
</div>
</table>
</div>
<div id="tab-content4" class="tab-content">
<%
int z = 0;
if(!("0".equals(list.get(0).get("todo_id")))){
for(int i=0;i < list.size();i++){
if("1".equals(list.get(i).get("todo_completion"))){
if("3".equals(list.get(i).get("todo_important"))){
z = 1;
%>
<div id="aiueo" style="border:2px dashed #ffffff;background-color:#FFB2D8;box-shadow:0 0 0 6px #FFB2D8;padding:10px;margin:20px;">
<table>
<tr>
<td class="to">To Do:<%=list.get(i).get("todo_name")%></td>
<td>期日:<%=list.get(i).get("todo_year")%>年<%=list.get(i).get("todo_month")%>月<%=list.get(i).get("todo_day")%>日</td>
</tr>
<%if(!("".equals(list.get(i).get("todo_msg")))){%>
<tr>
<td colspan="2">メモ:<%=list.get(i).get("todo_msg")%></td>
</tr>
<%} %>
</table>
<table>
<tr><td>
<form method="Post" action="todoupdatein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"type="submit">変更</button>
</form></td>
<td>
<form method="Post" action="todocompletion.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<button class="buttonB"type="submit">未完了</button>
</form></td>
<td>
<form method="Post" action="tododeletein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%=list.get(i).get("todo_id")%>">
<input type="hidden"name="0"value="1">
<button class="buttonB"  type="submit">削除</button>
</form>
</td></tr>
</table>
</div>
<%}}}}
if(z == 0){%><p>現在ありません</p> <%} %>
<table>
<div class="hoge">
<td><button class="buttonA" form="insert" type="submit">登録</button></td>
<td><button class="buttonA" form="com" type="submit">未完了一覧</button></td>
</div>
</table>
</div>
</div>
</div>
<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%}}%>
</body>
</html>