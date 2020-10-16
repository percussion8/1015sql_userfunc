<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String id = request.getParameter("id");
String password = request.getParameter("password");
String sql = "select * from woori where id=?";
Connection conn = null;
PreparedStatement pst = null;
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
} catch(SQLException e){
	out.println(e.getMessage());
}

try{
	pst = conn.prepareStatement(sql);
	pst.setString(1, id); // ?의 갯수에 맞춰서 값을 세팅함, 첫번째 ?에 id를 sql 질의어를 수행하고 resultset을 구함
	rs = pst.executeQuery();
	
	if(!(rs.next())) { %>
		해당되는 회원이 없습니다.
	<% } else {
		System.out.println(rs.getString("name"));
		System.out.println(rs.getString("email"));
		if(password.equals(rs.getString("password"))) { %>
		사용자 아이디가 <%= id %> 인 회원의 정보는 다음과 같습니다.
		정보를 변경하려면 내용을 입력한 다음 <수정하기> 버튼을 누르세요.
		<form action="update.jsp" name="form1" method="post">
			<br>아이디:
			<input type="text" name="id" value="<%= id.trim() %>">
			<br>이름:
			<input type="text" name="name" value="<%= rs.getString("name").trim() %>">
			<br>email:
			<input type="text" name="email" value="<%= rs.getString("email").trim() %>">
			<input type="submit" name="change" value="수정하기">
			<a href="delete.jsp?id= <%= id %>">삭제하기</a>
		</form>
	<% } else { %>
		비밀번호가 틀립니다.
	<% }
	}
	rs.close();
	pst.close();
	conn.close();
} catch(SQLException e){
	out.println(e.getMessage());
}
	%>


<a href=main.html>메인으로</a>
&nbsp; <a href="select.html">조회페이지로</a>

