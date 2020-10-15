<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String email =request.getParameter("email");
String sql = null;
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

//DB와 연결
try{
	conn = DriverManager.getConnection(dbURL, dbId, dbPassword);
} catch(SQLException e){
	out.println("<script>alert('가입처리 되지 않았습니다. 다시 시도해주세요.')</script>");
}

try{
	 st = conn.createStatement();
	//statement객체생성
			sql = "update woori set ";
			sql += "name = '" + name + "', email= '" + email + "', ";
			sql += " where id= '" + id + "'";
	st.executeUpdate(sql);
	st.close();
	conn.close();
} catch (SQLException e){
	out.println(e.getMessage());
}
%>
<jsp:forward page="selectall.jsp" />


