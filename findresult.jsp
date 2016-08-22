<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>	
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %>	 

<div data-role="page" data-theme="c">

	<script type="text/javascript">
		
	</script>
		
		<div data-role="header">
			<h1>개인정보찾기</h1>
		</div>
		<div data-role="content">
		<br>
			<table style="margin:auto; width:80%">
				<tr>
					<td align="center">
					<%
						if(request.getParameter("set").equals("1")){
					%>
						<div>
							<b>아이디 검색결과</b>
							<br>
							<% 
								if(request.getAttribute("findid")!=null){
							%>
								<%=request.getAttribute("findid") %>
							<%
								}else{
							%>
								잘못된 입력 내용입니다.
							<%
								}
							%>		
						</div>
					<%
						}else{
					%>
						
						<div>
							<b>비밀번호 검색결과</b>
							<br>
							<% 
								if(request.getAttribute("findpassword")!=null){
							%>
								<%=request.getAttribute("findpassword") %>
							<%
								}else{
							%>
								잘못된 입력 내용입니다.
							<%
								}
							%>		
						</div>
					<%
						}
					%>	
					</td>
				</tr>
				<tr>
					<td align="center">
						<a href="./loginform.me" data-role="button" data-inline="true">로그인 페이지</a>
					</td>	
				</tr>	
			</table>		
		</div>	
		
	</div>
