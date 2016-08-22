<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %> 
<%@ page import ="net.member.db.*" %>
<%
	MemberBean memberdata = (MemberBean)request.getAttribute("memberdata");
%>
 
<div data-role="page" id="home" data-fullscreen="true" data-theme="c">
	<script type="text/javascript">
		
		function selectChange(e) {
			 if(e.selectedIndex == 1){
				 $.mobile.changePage("DiaryCalendarAction.di");
			 }else if(e.selectedIndex == 2){
				 $.mobile.changePage("DiaryWrite.di");
			 }
			}
		
	</script>
	<div id="menusPanel" data-role="panel" data-display="overlay">
		<table width="100%">
		<tr>
			<td>
				<div data-role="controlgroup" data-type="horizontal">
					<a href="modify.me" data-role="button" data-icon="gear" data-iconpos="notext" data-inline="true">사용자설정</a>
		
					<a href="loginform.me" data-role="button" data-icon="power" data-iconpos="notext" data-inline="true">로그아웃</a>	
				</div>
			</td>	
		</tr>
		<tr>
			<td height="400" align="center">
				<%if(memberdata.getImage()!=null){ %>
					<img src="./upload/<%=memberdata.getImage() %>" width="220" height="220"/>
				<%} %>	
			</td>
		</tr>
				<tr>
					<td>
						아이디 <%=memberdata.getId() %>
					</td>
				</tr>		
				<%if(memberdata.getName()!=null){%>
				<tr><td>이름 <%=memberdata.getName() %></td></tr><%} %>
				<%if(memberdata.getGender()!=null){%>
				<tr><td>성별 <%=memberdata.getGender() %></td></tr><%} %>
				<%if(memberdata.getBirthday()!=null){%>
				<tr><td>생일 <%=memberdata.getBirthday() %></td></tr><%} %>
				<%if(memberdata.getBlood()!=null){%>
				<tr><td>혈액형 <%=memberdata.getBlood() %></td></tr><%} %>
				<%if(memberdata.getPhone()!=null){%>
				<tr><td>전화번호 <%=memberdata.getPhone() %></td></tr><%} %>
				<%if(memberdata.getAddress()!=null){%>
				<tr><td>주소 <%=memberdata.getAddress() %></td></tr><%} %>
				<%if(memberdata.getEmail()!=null){%>
				<tr><td>이메일 <%=memberdata.getEmail() %></td></tr><%} %>
		</table>
	</div>
<%
	List diaryList=(List)request.getAttribute("diarylist");
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	DiaryDAO diarydao = new DiaryDAO();

%>
		<div data-role="header" data-position="fixed">
			<table width="100%">
				<tr>
				<td width="30%">
				<a href="#menusPanel" data-role="button" data-icon="bars" data-iconpos="notext">오버레이패널</a>
				</td>
				<td width="40%" align="center">
				다 이 어 리
				</td>
				<td width="30%" align="right">
				<select id="listbox" onchange="selectChange(this)" 
							data-role="button" data-icon="plus" data-iconpos="notext" 
							data-native-menu="false">
							<option value=""></option>
							<option value="">달력보기</option>
							<option value="">글쓰기</option>
				</select>
				</td>
				</tr>
			</table>
			
				<div data-role="navbar">
					<ul>
						<li><a href="#">공유</a></li>
						<li><a href="./DiaryListAction.di">전체</a></li>
						<li><a href="#" class="ui-btn-active">목록</a></li>
					</ul>
				</div>	
		</div>
		
		<div data-role="content" id="menulistdetail">
			<div id="main">
				<a href="./DiaryListAction.di">목록</a> > <%=request.getParameter("diary_type") %> <!--현재 선택한 타입 -->	
				<br><br>
<%
	if(listcount>0){
%>				
				<div class="tab-content">
					<div id="list">
<%
	for(int i=0;i<diaryList.size();i++)
	{
		DiaryBean diarydata=(DiaryBean)diaryList.get(i);
%>		
				<a href="./DiaryDetailAction.di?num=<%=diarydata.getDiary_num() %>">
					<%=diarydata.getDiary_subject() %>
					<br>
					&nbsp;&nbsp;&nbsp;<%=diarydata.getDiary_content() %>
					<br>
					&nbsp;&nbsp;&nbsp;<%=diarydata.getWritedate() %>	
				</a>
				<br><hr><br>
	<%} %>
					</div>
					
				</div>		
<%}else{ %>	
				<div class="tab-content">
						<div id="list">
							<h4>등록된 글이 없습니다.</h4>
						</div>
				</div>			
<%} %>				
			</div>
		</div>
</div>
