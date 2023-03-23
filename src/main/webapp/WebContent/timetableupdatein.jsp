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
String userid_noStr =request.getParameter("userid_no");
if(userid_noStr == null){%>
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
int userid_noInt = Integer.parseInt(userid_noStr);
int user_noInt = userid_noInt/100;
int time_idInt = userid_noInt - (user_noInt * 100);
String user_noStr = String.valueOf(user_noInt);
int nullflag = 0;

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
    SQL.append("select * from time_tbl as t inner join user_tbl as u on t.user_no = u.user_no where u.user_no='");
    SQL.append(user_noInt);
	SQL.append("' and t.time_id ='");
	SQL.append(time_idInt);
	SQL.append("' order by t.time_id");

	//SQL文の発行(選択クエリ)
	rs = stmt.executeQuery(SQL.toString());

	//抽出したデータを繰り返し処理で表示する
	while(rs.next()){
	//DBのデータをHashMapへ格納する                            
	map = new HashMap<String,String>();
	map.put("user_no" ,rs.getString("user_no"));
	map.put("time_id" ,rs.getString("time_id"));
	map.put("time_name" ,rs.getString("time_name"));
	map.put("time_teacher" ,rs.getString("time_teacher"));
	map.put("time_room" ,rs.getString("time_room"));
	map.put("time_msg" ,rs.getString("time_msg"));
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
<form method="Post" class="a" action="timetableupdateout.jsp">
<%if(list.get(0).get("time_name") == null || (list.get(0).get("time_name").equals("")) && list.get(0).get("time_teacher") == null || (list.get(0).get("time_teacher").equals("")) && list.get(0).get("time_room") == null || (list.get(0).get("time_room").equals("")) && list.get(0).get("time_msg") == null || (list.get(0).get("time_msg").equals(""))){
nullflag = 1;
%>
<h1>登録</h1>
<%}else{ %>
<h1>変更</h1>
<%} %>
<input type="hidden"name="nullflag"value="<%=nullflag %>">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="time_idid"value="<%=time_idInt %>">
<input type="hidden"name="i"value="null">
<div class="cp_ipselect">
<select class="cp_sl06" name="time_id">
<option value="1"<%if(time_idInt == 1){%>selected<%}%>>Mon 1限</option>
<option value="2"<%if(time_idInt == 2){%>selected<%}%>>Mon 2限</option>
<option value="3"<%if(time_idInt == 3){%>selected<%}%>>Mon 3限</option>
<option value="4"<%if(time_idInt == 4){%>selected<%}%>>Mon 4限</option>
<option value="5"<%if(time_idInt == 5){%>selected<%}%>>Mon 5限</option>
<option value="6"<%if(time_idInt == 6){%>selected<%}%>>Mon 6限</option>
<option value="7"<%if(time_idInt == 7){%>selected<%}%>>Tue 1限</option>
<option value="8"<%if(time_idInt == 8){%>selected<%}%>>Tue 2限</option>
<option value="9"<%if(time_idInt == 9){%>selected<%}%>>Tue 3限</option>
<option value="10"<%if(time_idInt == 10){%>selected<%}%>>Tue 4限</option>
<option value="11"<%if(time_idInt == 11){%>selected<%}%>>Tue 5限</option>
<option value="12"<%if(time_idInt == 12){%>selected<%}%>>Tue 6限</option>
<option value="13"<%if(time_idInt == 13){%>selected<%}%>>Wed 1限</option>
<option value="14"<%if(time_idInt == 14){%>selected<%}%>>Wed 2限</option>
<option value="15"<%if(time_idInt == 15){%>selected<%}%>>Wed 3限</option>
<option value="16"<%if(time_idInt == 16){%>selected<%}%>>Wed 4限</option>
<option value="17"<%if(time_idInt == 17){%>selected<%}%>>Wed 5限</option>
<option value="18"<%if(time_idInt == 18){%>selected<%}%>>Wed 6限</option>
<option value="19"<%if(time_idInt == 19){%>selected<%}%>>Thu 1限</option>
<option value="20"<%if(time_idInt == 20){%>selected<%}%>>Thu 2限</option>
<option value="21"<%if(time_idInt == 21){%>selected<%}%>>Thu 3限</option>
<option value="22"<%if(time_idInt == 22){%>selected<%}%>>Thu 4限</option>
<option value="23"<%if(time_idInt == 23){%>selected<%}%>>Thu 5限</option>
<option value="24"<%if(time_idInt == 24){%>selected<%}%>>Thu 6限</option>
<option value="25"<%if(time_idInt == 25){%>selected<%}%>>Fri 1限</option>
<option value="26"<%if(time_idInt == 26){%>selected<%}%>>Fri 2限</option>
<option value="27"<%if(time_idInt == 27){%>selected<%}%>>Fri 3限</option>
<option value="28"<%if(time_idInt == 28){%>selected<%}%>>Fri 4限</option>
<option value="29"<%if(time_idInt == 29){%>selected<%}%>>Fri 5限</option>
<option value="30"<%if(time_idInt == 30){%>selected<%}%>>Fri 6限</option>
<option value="31"<%if(time_idInt == 31){%>selected<%}%>>Sat 1限</option>
<option value="32"<%if(time_idInt == 32){%>selected<%}%>>Sat 2限</option>
<option value="33"<%if(time_idInt == 33){%>selected<%}%>>Sat 3限</option>
<option value="34"<%if(time_idInt == 34){%>selected<%}%>>Sat 4限</option>
<option value="35"<%if(time_idInt == 35){%>selected<%}%>>Sat 5限</option>
<option value="36"<%if(time_idInt == 36){%>selected<%}%>>Sat 6限</option>
</select>
<span class="cp_sl06_highlight"></span>
<span class="cp_sl06_selectbar"></span>
<label class="cp_sl06_selectlabel" >時間割</label>
</div>

<div class="cp_iptxt">
	<input class="ef" type="text" maxlength="20" name="time_name" value=<%if(list.get(0).get("time_name") != null){ %>"<%= list.get(0).get("time_name") %>"<%}else{ %>""<%} %>>
	<label>科目</label>
	<span class="focus_line"></span>
	</div>
<div class="cp_iptxt">
	<input class="ef" type="text" maxlength="20" name="time_teacher" value=<%if(list.get(0).get("time_teacher") != null){ %>"<%= list.get(0).get("time_teacher") %>"<%}else{ %>""<%} %>>
	<label>担当</label>
	<span class="focus_line"></span>
</div>
<div class="cp_iptxt">
	<input class="ef" type="text" maxlength="20" name="time_room" value=<%if(list.get(0).get("time_room") != null){ %>"<%= list.get(0).get("time_room") %>"<%}else{ %>""<%} %>>
	<label>教室</label>
	<span class="focus_line"></span>
</div>
<div class="cp_iptxt">
	<input class="ef" type="text" maxlength="20" name="time_msg" value=<%if(list.get(0).get("time_msg") != null){ %>"<%= list.get(0).get("time_msg") %>"<%}else{ %>""<%} %>>
	<label>持ち物</label>
	<span class="focus_line"></span>
</div>
<table>
<div class="hoge">
<td><button class="buttonA" type="submit" form="ho">戻る</button></td>
<td><button class="buttonA" type="submit"><%if(nullflag == 1) {%>登録<%}else{ %>変更<%} %></button></td>
</div>
</table>
</form>
<form method="Post" id="ho" class="b" action="timetable.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
</form>
<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%}}%>
</body>
</html>