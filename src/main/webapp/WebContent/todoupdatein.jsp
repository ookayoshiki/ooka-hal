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
	SQL.append("' and todo_id ='");
	SQL.append(todo_idStr);
	SQL.append("' order by todo_id");

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
    <link rel="stylesheet" type="text/css" href="../css/todoin.css">

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
<form method="Post" class="a" action="todoupdateout.jsp">
<h1>変更</h1>
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<input type="hidden"name="todo_id"value="<%= todo_idStr %>">
<input type="hidden"name="0"value="<%= pStr %>">
<div class="cp_iptxt">
	<input class="ef" type="text" maxlength="20" name="todo_name" value="<%= list.get(0).get("todo_name") %>">
	<label>To Do</label>
	<span class="focus_line"></span>
	</div>
<div class="cp_ipselect">
<select class="cp_sl06" name="todo_year">
<option value="2022"<%if("2022".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2022年</option>
<option value="2023"<%if("2023".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2023年</option>
<option value="2024"<%if("2024".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2024年</option>
<option value="2025"<%if("2025".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2025年</option>
<option value="2026"<%if("2026".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2026年</option>
<option value="2027"<%if("2027".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2027年</option>
<option value="2028"<%if("2028".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2028年</option>
<option value="2029"<%if("2029".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2029年</option>
<option value="2030"<%if("2030".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2030年</option>
<option value="2031"<%if("2031".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2031年</option>
<option value="2032"<%if("2032".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2032年</option>
<option value="2033"<%if("2033".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2033年</option>
<option value="2034"<%if("2034".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2034年</option>
<option value="2035"<%if("2035".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2035年</option>
<option value="2036"<%if("2036".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2036年</option>
<option value="2037"<%if("2037".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2037年</option>
<option value="2038"<%if("2038".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2038年</option>
<option value="2039"<%if("2039".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2039年</option>
<option value="2040"<%if("2040".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2040年</option>
<option value="2041"<%if("2041".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2041年</option>
<option value="2042"<%if("2042".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2042年</option>
<option value="2043"<%if("2043".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2043年</option>
<option value="2044"<%if("2044".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2044年</option>
<option value="2045"<%if("2045".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2045年</option>
<option value="2046"<%if("2046".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2046年</option>
<option value="2047"<%if("2047".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2047年</option>
<option value="2048"<%if("2048".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2048年</option>
<option value="2049"<%if("2049".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2049年</option>
<option value="2050"<%if("2050".equals(list.get(0).get("todo_year"))){%>selected<%}%>>2050年</option>
</select>
<span class="cp_sl06_highlight"></span>
<span class="cp_sl06_selectbar"></span>
<label class="cp_sl06_selectlabel" >年</label>
</div>
<div class="cp_ipselect">
<select class="cp_sl06" name="todo_month">
<option value="1"<%if("1".equals(list.get(0).get("todo_month"))){%>selected<%}%>>1月</option>
<option value="2"<%if("2".equals(list.get(0).get("todo_month"))){%>selected<%}%>>2月</option>
<option value="3"<%if("3".equals(list.get(0).get("todo_month"))){%>selected<%}%>>3月</option>
<option value="4"<%if("4".equals(list.get(0).get("todo_month"))){%>selected<%}%>>4月</option>
<option value="5"<%if("5".equals(list.get(0).get("todo_month"))){%>selected<%}%>>5月</option>
<option value="6"<%if("6".equals(list.get(0).get("todo_month"))){%>selected<%}%>>6月</option>
<option value="7"<%if("7".equals(list.get(0).get("todo_month"))){%>selected<%}%>>7月</option>
<option value="8"<%if("8".equals(list.get(0).get("todo_month"))){%>selected<%}%>>8月</option>
<option value="9"<%if("9".equals(list.get(0).get("todo_month"))){%>selected<%}%>>9月</option>
<option value="10"<%if("10".equals(list.get(0).get("todo_month"))){%>selected<%}%>>10月</option>
<option value="11"<%if("11".equals(list.get(0).get("todo_month"))){%>selected<%}%>>11月</option>
<option value="12"<%if("12".equals(list.get(0).get("todo_month"))){%>selected<%}%>>12月</option>
</select>

<span class="cp_sl06_highlight"></span>
<span class="cp_sl06_selectbar"></span>
<label class="cp_sl06_selectlabel" >月</label>
</div>
<div class="cp_ipselect">
<select class="cp_sl06" name="todo_day">
<option value="1"<%if("1".equals(list.get(0).get("todo_day"))){%>selected<%}%>>1日</option>
<option value="2"<%if("2".equals(list.get(0).get("todo_day"))){%>selected<%}%>>2日</option>
<option value="3"<%if("3".equals(list.get(0).get("todo_day"))){%>selected<%}%>>3日</option>
<option value="4"<%if("4".equals(list.get(0).get("todo_day"))){%>selected<%}%>>4日</option>
<option value="5"<%if("5".equals(list.get(0).get("todo_day"))){%>selected<%}%>>5日</option>
<option value="6"<%if("6".equals(list.get(0).get("todo_day"))){%>selected<%}%>>6日</option>
<option value="7"<%if("7".equals(list.get(0).get("todo_day"))){%>selected<%}%>>7日</option>
<option value="8"<%if("8".equals(list.get(0).get("todo_day"))){%>selected<%}%>>8日</option>
<option value="9"<%if("9".equals(list.get(0).get("todo_day"))){%>selected<%}%>>9日</option>
<option value="10"<%if("10".equals(list.get(0).get("todo_day"))){%>selected<%}%>>10日</option>
<option value="11"<%if("11".equals(list.get(0).get("todo_day"))){%>selected<%}%>>11日</option>
<option value="12"<%if("12".equals(list.get(0).get("todo_day"))){%>selected<%}%>>12日</option>
<option value="13"<%if("13".equals(list.get(0).get("todo_day"))){%>selected<%}%>>13日</option>
<option value="14"<%if("14".equals(list.get(0).get("todo_day"))){%>selected<%}%>>14日</option>
<option value="15"<%if("15".equals(list.get(0).get("todo_day"))){%>selected<%}%>>15日</option>
<option value="16"<%if("16".equals(list.get(0).get("todo_day"))){%>selected<%}%>>16日</option>
<option value="17"<%if("17".equals(list.get(0).get("todo_day"))){%>selected<%}%>>17日</option>
<option value="18"<%if("18".equals(list.get(0).get("todo_day"))){%>selected<%}%>>18日</option>
<option value="19"<%if("19".equals(list.get(0).get("todo_day"))){%>selected<%}%>>19日</option>
<option value="20"<%if("20".equals(list.get(0).get("todo_day"))){%>selected<%}%>>20日</option>
<option value="21"<%if("21".equals(list.get(0).get("todo_day"))){%>selected<%}%>>21日</option>
<option value="22"<%if("22".equals(list.get(0).get("todo_day"))){%>selected<%}%>>22日</option>
<option value="23"<%if("23".equals(list.get(0).get("todo_day"))){%>selected<%}%>>23日</option>
<option value="24"<%if("24".equals(list.get(0).get("todo_day"))){%>selected<%}%>>24日</option>
<option value="25"<%if("25".equals(list.get(0).get("todo_day"))){%>selected<%}%>>25日</option>
<option value="26"<%if("26".equals(list.get(0).get("todo_day"))){%>selected<%}%>>26日</option>
<option value="27"<%if("27".equals(list.get(0).get("todo_day"))){%>selected<%}%>>27日</option>
<option value="28"<%if("28".equals(list.get(0).get("todo_day"))){%>selected<%}%>>28日</option>
<option value="29"<%if("29".equals(list.get(0).get("todo_day"))){%>selected<%}%>>29日</option>
<option value="30"<%if("30".equals(list.get(0).get("todo_day"))){%>selected<%}%>>30日</option>
<option value="31"<%if("31".equals(list.get(0).get("todo_day"))){%>selected<%}%>>31日</option>
</select>

<span class="cp_sl06_highlight"></span>
<span class="cp_sl06_selectbar"></span>
<label class="cp_sl06_selectlabel" >日</label>
</div>
<div class="cp_ipselect">
<select class="cp_sl06" name="todo_important">
<option value="1"<%if("1".equals(list.get(0).get("todo_important"))){%>selected<%}%>>低</option>
<option value="2"<%if("2".equals(list.get(0).get("todo_important"))){%>selected<%}%>>中</option>
<option value="3"<%if("3".equals(list.get(0).get("todo_important"))){%>selected<%}%>>高</option>
</select>

<span class="cp_sl06_highlight"></span>
<span class="cp_sl06_selectbar"></span>
<label class="cp_sl06_selectlabel" >優先度</label>
</div>

<div class="cp_iptxt">
	<input class="ef" type="text" maxlength="30" name="todo_msg" value="<%= list.get(0).get("todo_msg") %>">
	<label>メモ</label>
	<span class="focus_line"></span>
</div>
<table>
<div class="hoge">
<td><button class="buttonA" type="submit" form="ho">戻る</button></td>
<td><button class="buttonA" type="submit">変更</button></td>
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