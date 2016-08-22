<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>	
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %>	 

<div data-role="page" data-theme="c">
	<%
	request.setCharacterEncoding("utf-8");
	SimpleDateFormat sdf = new SimpleDateFormat("M월 dd일"); 				//글제목
	String strDate = sdf.format(new Date());
	SimpleDateFormat sdf2 = new SimpleDateFormat("YYYY년 M월 d일 aa h:mm"); //글쓴 시각
	String strDate2 = sdf2.format(new Date());
	String id=null;
	String name=null;
	String friend_name = null;
	String friend_id = null;
	if(session.getAttribute("id")!=null){
		id=(String)session.getAttribute("id");
		name=(String)session.getAttribute("name");
	}
	
	if(request.getAttribute("friend_id")!=null){
		friend_id= (String)request.getAttribute("friend_id");
		friend_name = (String)request.getAttribute("friend_name");	
	}else if(request.getParameter("friend_id")!=null){
		friend_id= request.getParameter("friend_id");
		friend_name = request.getParameter("friend_name");
	}
	%> 
  	
	<script type="text/javascript">
		
		function diaryshareadd(){
					
					
					var diary_id = $("#diary_id").attr("value");
					var diary_name = $("#diary_name").attr("value");
					var diary_type = $("#diary_type").val();
					var diary_subject = $("#diary_subject").val();
					var diary_content = $("#diary_content").val();
					var diary_file = $("#diary_file").val();
					var diary_weather = $("#diary_weather").val();
					var diary_location = $("#diary_location").val();
					var writedate = $("#diary_writedate").attr("value");
					var diary_share = $("#friend_id").attr("value")+$("#diary_id").attr("value");
					var diary_sharename = $("#friend_name").attr("value")+$("#diary_name").attr("value");
					
					
					var param= "diary_id=" + encodeURI(diary_id);
					param += "&diary_name="+encodeURI(diary_name);
					param += "&diary_type="+encodeURI(diary_type);
					param += "&diary_subject="+encodeURI(diary_subject);
					param += "&diary_content="+encodeURI(diary_content);
					param += "&diary_file="+encodeURI(diary_file);
					param += "&diary_weather="+encodeURI(diary_weather);
					param += "&diary_location="+encodeURI(diary_location);
					param += "&writedate="+encodeURI(writedate);
					param += "&diary_share="+encodeURI(diary_share);
					param += "&diary_sharename="+encodeURI(diary_sharename);
					
					$.mobile.changePage("DiaryShareAddAction.di?"+param);
			
		}
	
	</script>
	

		<form id="writeform" method="post" action="#" >
		<input type="hidden" id="diary_id" name="diary_id" value="<%=id%>"/>
		<input type="hidden" id="diary_name" name="diary_name" value="<%=name%>"/>
		<input type="hidden" id="diary_writedate" name="diary_writedate" value="<%=strDate2%>"/>
		<input type="hidden" id="friend_name" name="friend_name" value="<%=friend_name%>"/>
		<input type="hidden" id="friend_id" name="friend_id" value="<%=friend_id%>"/>
		
		<div data-role="header">
			<a href="javascript:history.back();" data-inline="true">취소</a>
			<h1><%=friend_name%>에게 글쓰기</h1>
			<a href="javascript:diaryshareadd()" data-inline="true">완료</a>
		</div>
		<div data-role="content">
			<table width="100%">
				<tr>
					<td colspan="2">
						<input id = "diary_subject" type="text" name="diary_subject" value="" placeholder="오늘은 <%=strDate%>">
					</td>	
				</tr>
				<tr>
					
				</tr>
				<tr>
					<td colspan="2">
						<textarea id = "diary_content" name="diary_content" wrap="hard"
							style="resize:none;height:200px" placeholder="내용"></textarea>	<!-- wrap="hard"는 입력한 내용을 그대로 인식하게 -->
					</td>	
				</tr>	
			</table>		
		</div>	
		</form>
	</div>
