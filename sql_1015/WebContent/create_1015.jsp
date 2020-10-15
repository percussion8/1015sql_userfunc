<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>

<%
Connection conn = null;
Statement st = null;
ResultSet rs = null;

//jdbc-odbc driver 등록
try{
	Class.forName("com.mysql.cj.jdbc.Driver");
} catch(ClassNotFoundException e){
	out.println(e.getMessage());
}

String dbURL = "jdbc:mysql://localhost:3306/member?useSSL=false";
String dbId = "root";
String dbPassword = "1234";
System.out.println("1)확인");

//DB와 연결
try{
	System.out.println("2)확인");
	conn = DriverManager.getConnection(dbURL, dbId, dbPassword);
	System.out.println("3) db연결 성공");
} catch(SQLException e){
	out.println("<script>alert('가입처리 되지 않았습니다. 다시 시도해주세요.')</script>");
}

try{
	st = conn.createStatement();
	st.executeUpdate("create table woori(id char(10) primary key)");
} catch(SQLException e) {
	out.println(e.getMessage());
}

try {
	rs = st.executeQuery("select * from woori");
	out.println(rs);
	ResultSetMetaData rsmd = rs.getMetaData();
	out.println("새로운 테이블이 생성되었습니다. <br>");
	out.println(rsmd.getColumnCount() + "개의 컬럼을 가지고 있습니다.");
	out.println("첫번째 컬럼은 " + rsmd.getColumnName(1) + "<br>");
	out.println("두번째 컬럼은 " + rsmd.getColumnName(2) + "<br>");
	out.println("세번째 컬럼은 " + rsmd.getColumnName(3) + "<br>");
	out.println("네번째 컬럼은 " + rsmd.getColumnName(4) + "<br>");
	rs.close();
	st.close();
	conn.close();
} catch(SQLException e) {
	out.println(e.getMessage());
}


%>

<a href=main.html>메인으로</a>

