<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %> 

<div id="diarydetail" data-role="page" data-theme="c">	
<%
	DiaryBean diarydata=(DiaryBean)request.getAttribute("diarydata");
	String friend_name = diarydata.getDiary_sharename();
	String my_name = session.getAttribute("name").toString();
	
	int friend_name_length = friend_name.length();
	int my_name_length = my_name.length();
	
	if(friend_name.substring(0, my_name_length).equals(my_name)){
		friend_name = friend_name.substring(my_name_length, friend_name_length);	
	}else if(friend_name.substring(friend_name_length-my_name_length, friend_name_length).equals(my_name)){
		friend_name = friend_name.substring(0, friend_name_length-my_name_length);
	}
	
	String write_id = diarydata.getDiary_id();
%>
		
		<script type="text/javascript">
					function selectChange(e) {
						if(e.selectedIndex == 1){
							$.mobile.changePage("DiaryListAction.di");
						} 
						else if(e.selectedIndex == 2){
							var num= <%=diarydata.getDiary_num()%>;
							var param= "num="+num;
							$.mobile.changePage("DiaryShareModify.di?"+param);
							
						}else if(e.selectedIndex == 3){
							var num= <%=diarydata.getDiary_num()%>;
							var param= "num="+num;
							$.mobile.changePage("DiaryDeleteAction.di?"+param);
		
						}
					}
					
		</script>
		
		<div data-role="header">
			<table width="100%">
				<tr>
				<td width="30%">
					<a href="javascript:history.back();" data-role="button" data-icon="arrow-l" data-inline="true">이전</a>
				</td>
				<td width="40%" align="center">
				<%=friend_name %>와 다이어리
				</td>
				<td width="30%" align="right">
				<select id="listbox" onchange="selectChange(this)" 
							data-role="button" data-icon="plus" data-iconpos="notext" 
							data-native-menu="false">
							<option value=""></option>
							<option value="">홈</option>
							<option value="">글수정</option>
							<option value="">글삭제</option>
				</select>
				</td>
				</tr>
			</table>			
		</div>
		<div data-role="content">
			<form>
				<input type="hidden" id="write_id" value="write_id"/>
				<input type="hidden" id="my_id" value="id"/>
			</form>
			<ul data-role="listview">
				<li data-theme="d">
					<%=diarydata.getDiary_subject() %>
					<br><br>
					&nbsp;&nbsp;&nbsp;<%=diarydata.getDiary_name() %>
					<br>
					&nbsp;&nbsp;&nbsp;<pre><font size="4"><%=diarydata.getDiary_content() %></font></pre>	<!-- DB에 enter로 입력된 것을 그대로 인식하여 가져옴 -->
					<br>
					&nbsp;&nbsp;&nbsp;<%=diarydata.getWritedate() %>
				</li>
			</ul>
		</div>
	</div>			
					
