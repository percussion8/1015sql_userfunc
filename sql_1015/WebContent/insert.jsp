<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String id = request.getParameter("id");
int password = Integer.parseInt(request.getParameter("password"));
String name = request.getParameter("name");
String email = request.getParameter("email");
String sql = null;
Connection conn = null;
Statement st = null;
ResultSet rs = null;
int cnt = 0;

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
	st = conn.createStatement();
	rs = st.executeQuery("select * from woori where id='" + id + "'");
	if(!(rs.next())){
		//statement객체생성
		sql = "insert into woori(id, password, name, email)";
		sql += " values('" + id + "'," + password + ",'";
		sql += name+"',' " + email + "')";
		//insert문을 이용하여 데이터 입력
		cnt = st.executeUpdate(sql);
		if(cnt>0) out.println("데이터가 성공적으로 입력되었습니다.");
		 else out.println("데이터가 이미 등록되어 있습니다.");
		
	}else {
		out.println("id가 이미 등록되어 있습니다.");
	}
	st.close();
	conn.close();
} catch(SQLException e){
	out.println("<script>alert('가입처리 되지 않았습니다. 다시 시도해주세요.')</script>");
}

%>

<a href=main.html>메인으로</a>

