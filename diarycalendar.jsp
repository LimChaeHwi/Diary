<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %>
<%@ page import ="net.member.db.*" %>
 

<div data-role="page" id="diarycalendar" data-fullscreen="true" data-theme="c">
<%
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	int day = cal.get(Calendar.DATE);
	if(request.getAttribute("year")!=null){
		year = Integer.parseInt(request.getAttribute("year").toString());
		month = Integer.parseInt(request.getAttribute("month").toString());
	}
	List diarydata=(List)request.getAttribute("diarydata");
	MemberBean memberdata = (MemberBean)request.getAttribute("memberdata");
%>
		<script type="text/javascript">
						$("#calendartable").bind("swipeleft",function(event){
							nextmonth();
						});
						$("#calendartable").bind("swiperight",function(event){
							premonth(); 
						});
					function selectChange(e) {
						if(e.selectedIndex == 1){
							$.mobile.changePage("DiaryListAction.di");
						}
						else if(e.selectedIndex == 2){
							$.mobile.changePage("DiaryWrite.di");
						}
					}
					function premonth(){
						var type = -1;
						var year = <%=year%>;
						var month = <%=month%>;
						param ="type="+ type;
						param +="&year="+ encodeURI(year);
						param +="&month="+ encodeURI(month);
						$.mobile.changePage("DiaryCalendarAction.di?"+param);
					}
					function nextmonth(){
						var type = 1;
						var year = <%=year%>;
						var month = <%=month%>;
						param ="type="+ type;
						param +="&year="+ encodeURI(year);
						param +="&month="+ encodeURI(month);
						$.mobile.changePage("DiaryCalendarAction.di?"+param);
					}
					function selectmonth(){
						var type = 2;
						var year = $("#select_year").val();
						var month = $("#select_month").val();
						
						param = "type=" + type;
						param +="&year="+ encodeURI(year);
						param +="&month="+ encodeURI(month);
						$.mobile.changePage("DiaryCalendarAction.di?"+param);
					}
					$("#<%=day%>").css("font-weight","bold");				
					
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
			달 력 보 기
			</td>
			<td width="30%" align="right">
			<select id="listbox" onchange="selectChange(this)" 
						data-role="button" data-icon="plus" data-iconpos="notext"
						data-native-menu="false">
						<option value=""></option>
						<option value="">리스트</option>
						<option value="">글쓰기</option>
			</select>
			</td>
			</tr>
		</table>	
		</div>
	<div data-role="content" id="calendar">
<%
	
	cal.set(year,month-1,1);									//시간대 설정
	int minDay = cal.getActualMinimum(Calendar.DAY_OF_MONTH);	//현재 월에 첫날
	int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	//현재 월의 마지막 일
	int startnum = 0;
	
	int cnt = 0;												//요일에 대한 카운트시 몇번째 요일인가 찾을 때
	
	Calendar calfirstset = Calendar.getInstance();
	calfirstset.set(year,month-1,1);							//현재 날짜 설정하기 day를 1로 설정
	int dayNum = calfirstset.get(Calendar.DAY_OF_WEEK);			//현재 월의 첫째 요일 구하기

	String firstday = null;
	switch(dayNum){
		case 1:firstday = "일";break ;
		case 2:firstday = "월";break ;
		case 3:firstday = "화";break ;
		case 4:firstday = "수";break ;
		case 5:firstday = "목";break ;
		case 6:firstday = "금";break ;
		case 7:firstday = "토";break ;
	} 
	Calendar callastset = Calendar.getInstance();						//지난달 마지막 날짜 구하기
	callastset.set(year,month-2,day);
	int lastNum = callastset.getActualMaximum(Calendar.DAY_OF_MONTH);		//지난달 마지막 날짜
%>			
	<div id="calendartable">
			<table width="100%">	
				<tr>									
					<td align="right">
						<a href="javascript:premonth()" data-role="button" data-icon="arrow-l" data-iconpos="notext">이전달</a></td>
					<td colspan="5" align="center">
					<a href="#calendarPopup" data-rel="popup" data-transition="flip" style="border:0">
						<b><font size=6><%=year %> . <%=month %></font></b>			
					</a>																	<!-- 년 . 월 -->
						<div data-role="popup" id="calendarPopup" class="ui-content" >
							<table>
								<tr>
									<td><input type="number" id="select_year" min="1900" max="2100" value="<%=year %>" maxlength="4"/></td>
									<td><input type="number" id="select_month" min="1" max="12" value="<%=month %>" maxlength="2"/></td>
								</tr>
								<tr>
									<td></td>
									<td align="right"><a href="javascript:selectmonth()" data-role="button" data-inline="true">이동</a></td>
								</tr>	
							</table>	
						</div>
					</td>
					<td>
						<a href="javascript:nextmonth()" data-role="button" data-icon="arrow-r" data-iconpos="notext" >다음달</a>
					</td>
				</tr>
			</table>	
			<table border="1" cellpadding ="0" cellspacing="0" bordercolor="orange" width="100%" >
				<tr bgcolor="white">
					<td width="40" align="center"><div id="sun"><font color="red"><b>일</b></font></div></td>
					<td width="40" align="center"><div id="mon"><b>월</b></div></td>
					<td width="40" align="center"><div id="tue"><b>화</b></div></td>
					<td width="40" align="center"><div id="wed"><b>수</b></div></td>
					<td width="40" align="center"><div id="thu"><b>목</b></div></td>
					<td width="40" align="center"><div id="fri"><b>금</b></div></td>
					<td width="40" align="center"><div id="sat"><font color="blue">토</font></div></td>
				</tr>
				<%
					%>
					<tr>
					<%
					int k =1;
					for(k =1; k<=7; k++){						//이전달 날짜 표시 lastNum
						if(dayNum==k){					 
							startnum = k;
							break;
						}
					}	
					for(int j=k-2; j>=0;j--){
					%>
					<td valign="top" height="70"><font color="gray"><%=lastNum-j %></font></td>
					<%
					}
					for(int i = startnum; i<maxDay+startnum;i++){	//현재달 날짜 표시 minDay
						
						if(i%7 == 1){								//일요일이 될때마다 리 카운트
							cnt = 0;
						}
						%>
						<td valign="top" height="70">
							<div id="<%=minDay%>"><%=minDay %><hr>					<!-- 날짜 표시 -->
								
								<% for(int g=diarydata.size()-1 ; g>-1; g--){
									DiaryBean diarycalendar=(DiaryBean)diarydata.get(g);		//리스트를 하나씩 읽기
									int writemonth= 0;
									int writeday= 0;
									if(diarycalendar.getWritedate().substring(7,8).equals("월")&&
										diarycalendar.getWritedate().substring(10,11).equals("일")){
										writemonth=Integer.parseInt(diarycalendar.getWritedate().substring(6,7).trim());
										writeday=Integer.parseInt(diarycalendar.getWritedate().substring(9,10));
									}else if(diarycalendar.getWritedate().substring(7,8).equals("월")&&
											diarycalendar.getWritedate().substring(11,12).equals("일")){
										writemonth=Integer.parseInt(diarycalendar.getWritedate().substring(6,7).trim());
										writeday=Integer.parseInt(diarycalendar.getWritedate().substring(9,11));
									}else if(diarycalendar.getWritedate().substring(8,9).equals("월")&&
											diarycalendar.getWritedate().substring(11,12).equals("일")){
										writemonth=Integer.parseInt(diarycalendar.getWritedate().substring(6,8).trim());
										writeday=Integer.parseInt(diarycalendar.getWritedate().substring(10,11));
									}else if(diarycalendar.getWritedate().substring(8,9).equals("월")&&
											diarycalendar.getWritedate().substring(12,13).equals("일")){
										writemonth=Integer.parseInt(diarycalendar.getWritedate().substring(6,8).trim());
										writeday=Integer.parseInt(diarycalendar.getWritedate().substring(10,12));
									}
									
									if(month==writemonth&&minDay==writeday){
								
										%>
											
											<a href="./DiaryDetailAction.di?num=<%=diarycalendar.getDiary_num() %>">
											
											&nbsp;<font size="1"><%=diarycalendar.getDiary_subject()%></font><br>
											<%
				
									}
											%>
											</a>
											
										<%
					
									}
								
								%>
								
							</div>		<!-- 해당 날짜로 아이디 설정 -->
						</td>
						<%
							cnt++;
						if(minDay<maxDay){							//다음달의 날짜 표시 minDay
							minDay++;
						}else{
							minDay=1;
							for(int f=0; f<7-cnt; f++){
								%>
								<td valign="top" height="70"><font color="gray"><%=minDay %></font></td>
								<%
								minDay++;
							}
						}
						if(i%7 == 0){
							%>
							</tr>
							<%
						}
						
					}
					
				%>

			</table>
		</div>			
		</div>
</div>

