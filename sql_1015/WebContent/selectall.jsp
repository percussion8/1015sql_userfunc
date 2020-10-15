<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

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

//DB와 연결
try{
	conn = DriverManager.getConnection(dbURL, dbId, dbPassword);
	
	/* rs = st.executeQuery("select * from woori where id='" + id + "'");
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
	conn.close(); */
} catch(SQLException e){
	out.println("<script>alert('가입처리 되지 않았습니다. 다시 시도해주세요.')</script>");
}

try{
	 st = conn.createStatement();
	 rs = st.executeQuery("select * from woori order by id");


%>

<html>
<body>
<center>
<h3>우리 회원 정보 보기</h3>
<table border=1>
<tr>
<th>사용자 id</th>
<th>이름</th>
<th>email</th>
</tr>
<%
if(!(rs.next())){ %>
	<tr>
		<td colspan="4">등록된 회원이 없습니다.</td>
	</tr>
<% } else {
		do{
			out.println("<tr>");
			out.println("<td>" + rs.getString("id") + "</td>");
			out.println("<td>" + rs.getString("name") + "</td>");
			out.println("<td>" + rs.getString("email") + "</td>");
			out.println("<tr>");
			
		} while(rs.next());
}
rs.close();
st.close();
conn.close();
} catch(SQLException e){
System.out.println(e.getMessage());
}
	%>

</table>
<a href="main.html">메인으로</a>&nbsp;
<a href="insert.html">회원등록으로</a>
</center>
</body>
</html>

