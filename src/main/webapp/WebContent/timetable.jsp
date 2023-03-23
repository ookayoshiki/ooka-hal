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
        int user_noInt = Integer.parseInt(user_noStr);
        int user_no1Int = (user_noInt * 100) + 1;
        int user_no2Int = (user_noInt * 100) + 2;
        int user_no3Int = (user_noInt * 100) + 3;
        int user_no4Int = (user_noInt * 100) + 4;
        int user_no5Int = (user_noInt * 100) + 5;
        int user_no6Int = (user_noInt * 100) + 6;
        int user_no7Int = (user_noInt * 100) + 7;
        int user_no8Int = (user_noInt * 100) + 8;
        int user_no9Int = (user_noInt * 100) + 9;
        int user_no10Int = (user_noInt * 100) + 10;
        int user_no11Int = (user_noInt * 100) + 11;
        int user_no12Int = (user_noInt * 100) + 12;
        int user_no13Int = (user_noInt * 100) + 13;
        int user_no14Int = (user_noInt * 100) + 14;
        int user_no15Int = (user_noInt * 100) + 15;
        int user_no16Int = (user_noInt * 100) + 16;
        int user_no17Int = (user_noInt * 100) + 17;
        int user_no18Int = (user_noInt * 100) + 18;
        int user_no19Int = (user_noInt * 100) + 19;
        int user_no20Int = (user_noInt * 100) + 20;
        int user_no21Int = (user_noInt * 100) + 21;
        int user_no22Int = (user_noInt * 100) + 22;
        int user_no23Int = (user_noInt * 100) + 23;
        int user_no24Int = (user_noInt * 100) + 24;
        int user_no25Int = (user_noInt * 100) + 25;
        int user_no26Int = (user_noInt * 100) + 26;
        int user_no27Int = (user_noInt * 100) + 27;
        int user_no28Int = (user_noInt * 100) + 28;
        int user_no29Int = (user_noInt * 100) + 29;
        int user_no30Int = (user_noInt * 100) + 30;
        int user_no31Int = (user_noInt * 100) + 31;
        int user_no32Int = (user_noInt * 100) + 32;
        int user_no33Int = (user_noInt * 100) + 33;
        int user_no34Int = (user_noInt * 100) + 34;
        int user_no35Int = (user_noInt * 100) + 35;
        int user_no36Int = (user_noInt * 100) + 36;

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

       //SQLステートメントの作成(選択クエリ)
       SQL = new StringBuffer();
       //SQL文の構築(DB検索)
       SQL.append("select * from time_tbl as t inner join user_tbl as u on t.user_no = u.user_no where u.user_no='");
       SQL.append(user_noStr);
       SQL.append("'");
       SQL.append("order by t.time_id");
       System.out.println(SQL.toString());

       //SQL文の発行(選択クエリ)
       rs = stmt.executeQuery(SQL.toString());

           //抽出したデータを繰り返し処理で表示する
           while(rs.next()){
           //DBのデータをHashMapへ格納する                            
           map = new HashMap<String,String>();
           map.put("time_name" ,rs.getString("time_name"));
           map.put("user_no" ,rs.getString("user_no"));
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

    <title>Time Table</title>

    <link rel="stylesheet" type="text/css" href="../css/reset.css">
    <link rel="stylesheet" type="text/css" href="../css/nav.css">
    <link rel="stylesheet" type="text/css" href="../css/timetable.css">

  </head>

  <%if("1".equals(list.get(0).get("background"))){ %><body id="background1"><%} %>
  <%if("2".equals(list.get(0).get("background"))){ %><body id="background2"><%} %>
  <%if("3".equals(list.get(0).get("background"))){ %><body id="background3"><%} %>
  <%if("4".equals(list.get(0).get("background"))){ %><body id="background4"><%} %>
  <%if("5".equals(list.get(0).get("background"))){ %><body id="background5"><%} %>
  <%if("6".equals(list.get(0).get("background"))){ %><body id="background6"><%} %>
  <%if("7".equals(list.get(0).get("background"))){ %><body id="background7"><%} %>
  <%if("8".equals(list.get(0).get("background"))){ %><body id="background8"><%} %>
<h1>Time Table</h1>
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
    <table class="osare-table col5t">
<thead>
<tr>
<th> </th>
<th>Mon</th>
<th>Tue</th>
<th>Wed</th>
<th>Thu</th>
<th>Fri</th>
<th>Sat</th>
</tr>
</thead>
<tbody>
<tr>
<th>1限</th>
<td><%if(list.get(0).get("time_name") != null && !(list.get(0).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no1Int%>"><%=list.get(0).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no1Int%>">　</a><%} %></td>
<td><%if(list.get(6).get("time_name") != null && !(list.get(6).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no7Int%>"><%=list.get(6).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no7Int%>">　</a><%} %></td>
<td><%if(list.get(12).get("time_name") != null && !(list.get(12).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no13Int%>"><%=list.get(12).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no13Int%>">　</a><%} %></td>
<td><%if(list.get(18).get("time_name") != null && !(list.get(18).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no19Int%>"><%=list.get(18).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no19Int%>">　</a><%} %></td>
<td><%if(list.get(24).get("time_name") != null && !(list.get(24).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no25Int%>"><%=list.get(24).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no25Int%>">　</a><%} %></td>
<td><%if(list.get(30).get("time_name") != null && !(list.get(30).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no31Int%>"><%=list.get(30).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no31Int%>">　</a><%} %></td>
</tr>
<tr>
<th>2限</th>
<td><%if(list.get(1).get("time_name") != null && !(list.get(1).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no2Int%>"><%=list.get(1).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no2Int%>">　</a><%} %></td>
<td><%if(list.get(7).get("time_name") != null && !(list.get(7).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no8Int%>"><%=list.get(7).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no8Int%>">　</a><%} %></td>
<td><%if(list.get(13).get("time_name") != null && !(list.get(13).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no14Int%>"><%=list.get(13).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no14Int%>">　</a><%} %></td>
<td><%if(list.get(19).get("time_name") != null && !(list.get(19).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no20Int%>"><%=list.get(19).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no20Int%>">　</a><%} %></td>
<td><%if(list.get(25).get("time_name") != null && !(list.get(25).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no26Int%>"><%=list.get(25).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no26Int%>">　</a><%} %></td>
<td><%if(list.get(31).get("time_name") != null && !(list.get(31).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no32Int%>"><%=list.get(31).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no32Int%>">　</a><%} %></td>
</tr>
<tr>
<th>3限</th>
<td><%if(list.get(2).get("time_name") != null && !(list.get(2).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no3Int%>"><%=list.get(2).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no3Int%>">　</a><%} %></td>
<td><%if(list.get(8).get("time_name") != null && !(list.get(8).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no9Int%>"><%=list.get(8).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no9Int%>">　</a><%} %></td>
<td><%if(list.get(14).get("time_name") != null && !(list.get(14).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no15Int%>"><%=list.get(14).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no15Int%>">　</a><%} %></td>
<td><%if(list.get(20).get("time_name") != null && !(list.get(20).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no21Int%>"><%=list.get(20).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no21Int%>">　</a><%} %></td>
<td><%if(list.get(26).get("time_name") != null && !(list.get(26).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no27Int%>"><%=list.get(26).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no27Int%>">　</a><%} %></td>
<td><%if(list.get(32).get("time_name") != null && !(list.get(32).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no33Int%>"><%=list.get(32).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no33Int%>">　</a><%} %></td>
</tr>
<tr>
<th>4限</th>
<td><%if(list.get(3).get("time_name") != null && !(list.get(3).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no4Int%>"><%=list.get(3).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no4Int%>">　</a><%} %></td>
<td><%if(list.get(9).get("time_name") != null && !(list.get(9).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no10Int%>"><%=list.get(9).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no10Int%>">　</a><%} %></td>
<td><%if(list.get(15).get("time_name") != null && !(list.get(15).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no16Int%>"><%=list.get(15).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no16Int%>">　</a><%} %></td>
<td><%if(list.get(21).get("time_name") != null && !(list.get(21).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no22Int%>"><%=list.get(21).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no22Int%>">　</a><%} %></td>
<td><%if(list.get(27).get("time_name") != null && !(list.get(27).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no28Int%>"><%=list.get(27).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no28Int%>">　</a><%} %></td>
<td><%if(list.get(33).get("time_name") != null && !(list.get(33).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no34Int%>"><%=list.get(33).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no34Int%>">　</a><%} %></td>
</tr>
<tr>
<th>5限</th>
<td><%if(list.get(4).get("time_name") != null && !(list.get(4).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no5Int%>"><%=list.get(4).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no5Int%>">　</a><%} %></td>
<td><%if(list.get(10).get("time_name") != null && !(list.get(10).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no11Int%>"><%=list.get(10).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no11Int%>">　</a><%} %></td>
<td><%if(list.get(16).get("time_name") != null && !(list.get(16).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no17Int%>"><%=list.get(16).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no17Int%>">　</a><%} %></td>
<td><%if(list.get(22).get("time_name") != null && !(list.get(22).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no23Int%>"><%=list.get(22).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no23Int%>">　</a><%} %></td>
<td><%if(list.get(28).get("time_name") != null && !(list.get(28).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no29Int%>"><%=list.get(28).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no29Int%>">　</a><%} %></td>
<td><%if(list.get(34).get("time_name") != null && !(list.get(34).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no35Int%>"><%=list.get(34).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no35Int%>">　</a><%} %></td>
</tr>
<tr>
<th>6限</th>
<td><%if(list.get(5).get("time_name") != null && !(list.get(5).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no6Int%>"><%=list.get(5).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no6Int%>">　</a><%} %></td>
<td><%if(list.get(11).get("time_name") != null && !(list.get(11).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no12Int%>"><%=list.get(11).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no12Int%>">　</a><%} %></td>
<td><%if(list.get(17).get("time_name") != null && !(list.get(17).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no18Int%>"><%=list.get(17).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no18Int%>">　</a><%} %></td>
<td><%if(list.get(23).get("time_name") != null && !(list.get(23).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no24Int%>"><%=list.get(23).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no24Int%>">　</a><%} %></td>
<td><%if(list.get(29).get("time_name") != null && !(list.get(29).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no30Int%>"><%=list.get(29).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no30Int%>">　</a><%} %></td>
<td><%if(list.get(35).get("time_name") != null && !(list.get(35).get("time_name").equals(""))){%><a href="timetableupdatein.jsp?userid_no=<%=user_no36Int%>"><%=list.get(35).get("time_name")%></a><%}else{%><a href="timetableupdatein.jsp?userid_no=<%=user_no36Int%>">　</a><%} %></td>
</tr>
</tbody>
</table>
<table>
<div class="hoge">
<form method="Post" action="timetableinsertin.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<td><button class="buttonA" type="submit">登録</button></td>
</form>
<form method="Post" action="timetabledeletein.jsp">
<input type="hidden"name="user_no"value="<%= user_noStr %>">
<td><button class="buttonA" type="submit">すべて削除</button></td>
</form>
</div>
</table>
<%if(ERMSG !=null){%>
予期せぬエラーが発生しました<br/>
<%=ERMSG %>
<%}}%>
</body>
</html>