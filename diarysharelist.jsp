<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %> 
<%@ page import ="net.member.db.*" %>

<div data-role="page" id="home" data-fullscreen="true" data-theme="c">
<%	
	MemberBean memberdata = (MemberBean)request.getAttribute("memberdata");
	DiaryDAO diarydao = new DiaryDAO();
	List diaryShareList=(List)request.getAttribute("diarysharelist");
	int sharelistcount=((Integer)request.getAttribute("sharelistcount")).intValue();
	
	String diary_share = request.getAttribute("diary_share").toString();
	String id = session.getAttribute("id").toString();
	String friend_id =null;
	int id_length = id.toString().length();
	int diary_share_length = diary_share.length();
	
	if(diary_share.substring(0, id_length).equals(id)){
		friend_id = diary_share.substring(id_length, diary_share_length);
	}else if(diary_share.substring(diary_share_length-id_length, diary_share_length).equals(id)){
		friend_id = diary_share.substring(0, diary_share_length-id_length);
	}
	String diary_sharename = request.getAttribute("diary_sharename").toString();
	String my_name= session.getAttribute("name").toString();
	int diary_sharename_length = diary_sharename.length();
	int my_name_length = my_name.length();
	String friend_name = null;
	
	if(diary_sharename.substring(0, my_name_length).equals(my_name)){
		friend_name = diary_sharename.substring(my_name_length, diary_sharename_length);
	}else if(diary_sharename.substring(diary_sharename_length-my_name_length, diary_sharename_length).equals(my_name)){
		friend_name = diary_sharename.substring(0, diary_sharename_length-my_name_length);
	}
%>		
	<script type="text/javascript">
		
		function selectChange(e) {
			if(e.selectedIndex == 1){
				$.mobile.changePage("DiaryListAction.di");
			}else if(e.selectedIndex == 2){
				var friend_id = $("#friend_id").attr("value");
				var friend_name = $("#friend_name").attr("value");
				
				var param= "friend_id=" + encodeURI(friend_id);
				param+= "&friend_name=" + encodeURI(friend_name);
				$.mobile.changePage("./diarysharewrite.jsp?"+param);
			}
		}
	</script>
	<div id="menusPanel" data-role="panel" data-display="overlay" >
		<table width="100%" >
		<tr>
			<td>
				<div data-role="controlgroup" data-type="horizontal">
					<a href="modify.me" data-role="button" data-icon="gear" data-iconpos="notext" data-inline="true">사용자설정</a>
		
					<a href="loginform.me" data-role="button" data-icon="power" data-iconpos="notext" data-inline="true">로그아웃</a>	
				</div>
			</td>	
		</tr>
		<tr bgcolor="white">
			<td height="270" align="center">
				<%if(memberdata.getImage()!=null){ %>
					<img src="./thumbnail/<%=memberdata.getImage() %>" width="220" height="252"/>
				<%} %>	
			</td>
		</tr>
				<tr>
					<td>
					<br>
						아이디 &nbsp;<%=memberdata.getId() %>
					</td>
				</tr>		
				<%if(memberdata.getName()!=null){%>
				<tr><td>이름 &nbsp;&nbsp;&nbsp;<%=memberdata.getName() %></td></tr><%} %>
				<%if(memberdata.getGender()!=null){%>
				<tr><td>성별 &nbsp;&nbsp;&nbsp;<%=memberdata.getGender() %></td></tr><%} %>
				<%if(memberdata.getBirthday()!=null){%>
				<tr><td>생일 &nbsp;&nbsp;&nbsp;<%=memberdata.getBirthday() %></td></tr><%} %>
				<%if(memberdata.getBlood()!=null){%>
				<tr><td>혈액형 &nbsp;<%=memberdata.getBlood() %></td></tr><%} %>
				<%if(memberdata.getPhone()!=null){%>
				<tr><td>휴대폰 <%=memberdata.getPhone() %></td></tr><%} %>
				<%if(memberdata.getAddress()!=null){%>
				<tr><td>주소 &nbsp;&nbsp;<%=memberdata.getAddress() %></td></tr><%} %>
				<%if(memberdata.getEmail()!=null){%>
				<tr><td>이메일 <%=memberdata.getEmail() %></td></tr><%} %>
		</table>

	</div>
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
									<option value="">홈</option>
									<option value="">글쓰기</option>
						</select>
					</td>
				</tr>
			</table>	
			<form>
				<input type="hidden" id="friend_id" value="<%=friend_id%>"/>
				<input type="hidden" id="friend_name" value="<%=friend_name%>"/>
			</form>
				
		</div>
		
	<div data-role="content" id="homelist">
	&nbsp;&nbsp;&nbsp;전체
		 		<%=diarydao.getShareListCount(id, diary_share)%>개 		<!--해당 id의 글의 갯수 -->	
	<ul data-role="listview" data-inset="true" data-filter="true" data-split-icon="gear" data-filter-placeholder="제목, 내용, 날짜 검색">		
				 
				
<%
	if(sharelistcount>0){

	for(int i=0;i<diaryShareList.size();i++)
	{
		DiaryBean diarydata=(DiaryBean)diaryShareList.get(i);
%>		
				<li>
				<a href="./DiaryShareDetailAction.di?num=<%=diarydata.getDiary_num() %>">
					<%=diarydata.getDiary_name() %>
					<br>
					<%=diarydata.getDiary_subject() %>
					<br>
					&nbsp;&nbsp;&nbsp;<%=diarydata.getDiary_content()%><%if(diarydata.getDiary_content().length()>14){%>. . .<%} %>
					<br>
					&nbsp;&nbsp;&nbsp;<%=diarydata.getWritedate() %>	
				</a>
				</li> 
				
	<%} 			
}else{ %>	
				<h4>등록된 글이 없습니다.</h4>				
<%} %>					
		</ul>
 	</div> 
	
	
</div>