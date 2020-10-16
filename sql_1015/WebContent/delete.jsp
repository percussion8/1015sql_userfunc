<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>

<%
Connection conn = null;
Statement st = null;
ResultSet rs = null;
String sql = null;
String id = request.getParameter("id");

//jdbc-odbc driver 등록
try{
	Class.forName("com.mysql.cj.jdbc.Driver");
} catch(ClassNotFoundException e){
	out.println(e.getMessage());
}

String dbURL = "jdbc:mysql://localhost:3306/member?useSSL=false";
String dbId = "root";
String dbPassword = "1234";

//DB와 연결
try{
	conn = DriverManager.getConnection(dbURL, dbId, dbPassword);
	
	//statement객체 생성
	st = conn.createStatement();
	sql = "delete from woori where id = '" + id + "'";
	st.executeUpdate(sql);
	st.close();
	conn.close();
} catch(SQLException e){
	out.println(e.getMessage());
}


%>
<jsp:forward page="selectall.jsp" />
<a href=main.html>메인으로</a>

