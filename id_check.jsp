<%@page import="net.member.db.MemberDAO"%>
<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.util.List" %>
<%
	String sid = request.getParameter("sid");
	MemberDAO dao = new MemberDAO();
	int re = dao.getDoubleCheck(sid);
%>
	<%=re%>