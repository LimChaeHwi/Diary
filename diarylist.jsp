<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %> 
<%@ page import ="net.member.db.*" %>

<div data-role="page" id="home" data-fullscreen="true" data-theme="c" >
<%
	DiaryDAO diarydao = new DiaryDAO();
	List diaryList=(List)request.getAttribute("diarylist");
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	
	List diaryMenu=(List)request.getAttribute("diarymenu");
	int menucount=((Integer)request.getAttribute("menucount")).intValue();
	
	List diaryShare=(List)request.getAttribute("diaryshare");
	int sharecount=((Integer)request.getAttribute("sharecount")).intValue();
	
	MemberBean memberdata = (MemberBean)request.getAttribute("memberdata");
	String id = (String)session.getAttribute("id");
	
	
%>	
	<script type="text/javascript">
		
		function selectChange(e) {
			 if(e.selectedIndex == 1){
			 	$.mobile.changePage("DiaryCalendarAction.di");
			 }else if(e.selectedIndex == 2){
				$.mobile.changePage("DiaryWrite.di");
			 }
		}
			$("#menulist").hide();
			$("#sharelist").hide();								//처음에 두 내용을 숨긴다
			
			
			$("#homelist").bind("swipeleft",function(event){
				$("#homelist").hide();
				$("#menulist").show();
				$("#all").removeClass("ui-btn-active");
				$("#menu").addClass("ui-btn-active");
			});
			$("#menulist").bind("swiperight",function(event){
				$("#menulist").hide();	
				$("#homelist").show();
				$("#menu").removeClass("ui-btn-active");
				$("#all").addClass("ui-btn-active");
			});
			
			$("#homelist").bind("swiperight",function(event){
				$("#homelist").hide();	
				$("#sharelist").show();
				$("#all").removeClass("ui-btn-active");
				$("#share").addClass("ui-btn-active");
			});
			$("#sharelist").bind("swipeleft",function(event){
				$("#sharelist").hide();	
				$("#homelist").show();
				$("#share").removeClass("ui-btn-active");
				$("#all").addClass("ui-btn-active");
			});
			
			$("#all").click(function(){
				$("#menulist").hide();	
				$("#homelist").show();
				$("#sharelist").hide();
			});
			$("#menu").click(function(){
				$("#homelist").hide();
				$("#menulist").show();
				$("#sharelist").hide();
			});
			$("#share").click(function(){
				$("#homelist").hide();
				$("#menulist").hide();
				$("#sharelist").show();
			});
			
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
						<option value="">달력보기</option>
						<option value="">글쓰기</option>
			</select>
			</td>
			</tr>
		</table>	
			
				<div data-role="navbar">
				 	<ul>
						<li><a id="share" href="#">공유</a></li>
						<li><a id="all" href="#" class="ui-btn-active">전체</a></li>
						<li><a id="menu" href="#">목록</a></li>
					</ul>
				</div>	
		</div>
												<!-- 메인 페이지 -->
	<div data-role="content" id="homelist">
				&nbsp;&nbsp;&nbsp;전체
		  		<%=diarydao.getListCount(session.getAttribute("id").toString()) %>개 		<!--해당 id의 글의 갯수 -->	
	<ul data-role="listview" data-inset="true" data-filter="true" data-split-icon="gear" data-filter-placeholder="제목, 내용, 글종류, 날짜 검색">	<!-- 검색창 -->	
	
<%
	if(listcount>0){

	for(int i=0;i<diaryList.size();i++)
	{
		DiaryBean diarydata=(DiaryBean)diaryList.get(i);
%>		
				<li>
				<table><tr><td>
					<a href="./DiaryDetailAction.di?num=<%=diarydata.getDiary_num() %>">
						<%=diarydata.getDiary_subject() %>
						<br>
						&nbsp;&nbsp;&nbsp;<%=diarydata.getDiary_content()%><%if(diarydata.getDiary_content().length()>14){%>. . .<%} %>
						<br>
						<%
						if(diarydata.getDiary_file()!=null){
							StringTokenizer stok = new StringTokenizer(diarydata.getDiary_file(),"/");
							while(stok.hasMoreTokens()){
								String token = stok.nextToken();
						%>
							<img src="./thumbnail/<%=token %>" width="80" height="80"/>
						
						<%  }%>
						<br>
					<% } %>
						
						&nbsp;&nbsp;&nbsp;<%=diarydata.getWritedate() %>	
					</a>
				</td></tr>	
				</table>	
				</li> 
	<%} 			
}else{ %>	
				<h4>등록된 글이 없습니다.</h4>				
<%} %>					
		</ul>
 	</div> 
													<!-- 목록 탭 내용 -->		
 	<div data-role="content" id="menulist"> 
					<div id="main">
<%
	if(menucount>0){
%>				
				<div class="tab-content">
					<div id="list">
<%
	for(int i=0;i<diaryMenu.size();i++)
	{
		DiaryBean diarydata=(DiaryBean)diaryMenu.get(i);
%>				
				<a href="./DiaryMenuDetailAction.di?diary_type=<%=diarydata.getDiary_type() %>">
					&nbsp;&nbsp;<%=diarydao.getMenuDetailCount((String)session.getAttribute("id"), diarydata.getDiary_type()) %>
					&nbsp;&nbsp;&nbsp;<b><%=diarydata.getDiary_type() %></b>
				</a>	
				<hr><br>
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
														<!-- 공유 탭 내용 -->		
 	<div data-role="content" id="sharelist">
	
				<div id="main">
					<ul data-role="listview" data-inset="true" data-filter="true" data-split-icon="gear" data-filter-placeholder="이름 검색">

<%
	
	if(sharecount>0){
		
		for(int i=0;i<diaryShare.size();i++)
		{
			DiaryBean diarydata=(DiaryBean)diaryShare.get(i);
				if(diarydata.getDiary_sharename()!=null){
					
					String friend_name = diarydata.getDiary_sharename();			//친구이름+자신이름 or 자신이름+친구이름
					String my_name = session.getAttribute("name").toString();		//자신 이름
					String friend_id = diarydata.getDiary_share();					//친구 아이디
					
					int friend_name_length = friend_name.length();
					int my_name_length = my_name.length();
					//로그인중인 ID가 가져온 값에 앞이나 뒤에 붙어 있는지	ab 또는 ba
					if(id.equals(friend_id.substring(0,id.length()))||id.equals(friend_id.substring(friend_id.length()-id.length(), friend_id.length()))){
						
						if(friend_name.substring(0, my_name_length).equals(my_name)){
							int cnt = 0;
							
							friend_name = friend_name.substring(my_name_length, friend_name_length);	//친구가 나에게 쓴글; 글쓴이
							for(int j=0; j<i+1;j++){
								DiaryBean diarydata2=(DiaryBean)diaryShare.get(j);
								if(diarydata2.getDiary_sharename().equals(friend_name+my_name)){
									cnt++;
								}else{
									
								}
							}
							
							
							if(cnt<1){
										%>
										
										<li>
											
											<a href="./DiaryShareListAction.di?diary_share=<%=diarydata.getDiary_share()%>&diary_sharename=<%=diarydata.getDiary_sharename()%>">
												&nbsp;&nbsp;<%=friend_name %>
											</a>
												
										</li>
										
										<%			
							}			
						}else if(friend_name.substring(friend_name_length-my_name_length, friend_name_length).equals(my_name)){
							int cnt = 0;
							friend_name = friend_name.substring(0, friend_name_length-my_name_length);	//내가 친구에게 쓴글; 받는이
							for(int j=0; j<i+1;j++){
								DiaryBean diarydata2=(DiaryBean)diaryShare.get(j);
								if(diarydata2.getDiary_sharename().equals(my_name+friend_name)){
									cnt++;
								}else{
									
								}
							}
							
							if(cnt<1){
									%>
									
									<li>
										<a href="./DiaryShareListAction.di?diary_share=<%=diarydata.getDiary_share()%>
											&diary_sharename=<%=diarydata.getDiary_sharename()%>">
											&nbsp;&nbsp;
											<%=friend_name %>
										</a>	
									</li> 
									<% 
							}
							
						}	
					}
				}
			}
	
			%>
	
				</ul>				
<%}else{ %>	
				<div class="tab-content">
						<h4>공유된 글이 없습니다.</h4>
						
				</div>	
<%} %>					
					<a href="DiaryShareAdd.di" data-role="button" data-icon="plus">공유 다이어리 추가하기</a>			
			</div>
	
	</div>
	
	
</div>
