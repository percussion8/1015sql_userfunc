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
	st.executeUpdate("alter table woori add name char(10)");
	st.executeUpdate("alter table woori modify name char(10) not null");
	st.executeUpdate("alter table woori add email char(30)");
	st.executeUpdate("alter table woori add password integer");
} catch(SQLException e) {
	out.println("alter problem");
	out.println(e.getMessage());
}

try {
	rs = st.executeQuery("select * from woori");
	/* out.println(rs); */
	ResultSetMetaData rsmd = rs.getMetaData();
	out.println("woori 테이블이 수정되었습니다. <br>");
	out.println(rsmd.getColumnCount() + "개의 컬럼을 가지고 있습니다.");
	for(int i = 1; i<=rsmd.getColumnCount(); i++){
		out.println(i+" 번째 컬럼은 " + rsmd.getColumnName(i));
		out.println(" 이고 유형은 " + rsmd.getColumnTypeName(i));
		out.println(" 이며 크기는 " + rsmd.getPrecision(i));
	}
	rs.close();
	st.close();
	conn.close();
} catch(SQLException e) {
	out.println(e.getMessage());
}


%>

<a href=main.html>메인으로</a>

