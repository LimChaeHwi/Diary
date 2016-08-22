<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %> 

<div id="diarydetail" data-role="page" data-theme="c">	
<%
	DiaryBean diarydata=(DiaryBean)request.getAttribute("diarydata");
%>
		
		<script type="text/javascript">
					function selectChange(e) {
						if(e.selectedIndex == 1){
							$.mobile.changePage("DiaryListAction.di");
						}
						else if(e.selectedIndex == 2){
							var num= <%=diarydata.getDiary_num()%>;
							var param= "num="+num;
							$.mobile.changePage("DiaryModify.di?"+param);
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
							<option value="">글수정</option>
							<option value="">글삭제</option>
				</select>
				</td>
				</tr>
			</table>			
		</div>
		<div data-role="content">
					<h4>&nbsp;&nbsp;<%=diarydata.getDiary_subject() %></h4>
					
					&nbsp;&nbsp;작성자: <%=diarydata.getDiary_name() %>
					<br><br>
					<%=diarydata.getDiary_content() %>	<!-- DB에 enter로 입력된 것을 그대로 인식하여 가져옴<pre></pre> -->
					<br><br>
					&nbsp;&nbsp;<%if(diarydata.getDiary_location()!=null){%><%=diarydata.getDiary_location() %><%} %>
					<br><br>
					&nbsp;&nbsp;<%=diarydata.getWritedate() %>
					
					<br>
		</div>		
		<div data-role="content">
			<%
			if(diarydata.getDiary_file()!=null){
				StringTokenizer stok = new StringTokenizer(diarydata.getDiary_file(),"/");
				while(stok.hasMoreTokens()){
					String token = stok.nextToken();
			%>
			<img src="./upload/<%=token%>" width="330" height="300"/>
			<%} %>
			
		<%} %>	
		</div>
		
	</div>			
					
