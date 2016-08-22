<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>		
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %> 

<div data-role="page" data-theme="c">
<%
	DiaryBean diarydata=(DiaryBean)request.getAttribute("diarydata");
	
%>
		<script type="text/javascript">
		function diarymodify(){
			var num= $("#modify_num").val();
			var diary_subject= $("#modify_subject").val();
			var diary_type = $("#diary_type").val();
			var diary_content= $("#modify_content").val();
		
			var param = "num="+encodeURI(num);
			param += "&diary_subject="+encodeURI(diary_subject);
			param += "&diary_type="+encodeURI(diary_type);
			param += "&diary_content="+encodeURI(diary_content);
			
			$.mobile.changePage("DiaryModifyAction.di?"+param);
		}
	</script>

		<div data-role="header">
			<a href="#" data-rel="back" data-icon="arrow-l">이전</a>
			<h1>글수정하기</h1>
		</div>
		<form id="modifyform" method="post" action="#" >
			<input type="hidden" id="modify_num" name="modify_num" value=<%=diarydata.getDiary_num() %>>	
			
			<div data-role="fieldcontain">
				<label for = "modify_subject">제 목</label>
				<input id = "modify_subject" type="text" name="modify_subject" value=<%=diarydata.getDiary_subject() %>>
			</div>
			<div data-role="fieldcontain">
				<label for = "diary_type">글종류</label>	
				<input type="text" id="diary_type" name="diary_type" value=<%=diarydata.getDiary_type() %>>
			</div>
			<div data-role="fieldcontain">
				<label for = "modify_content">내 용</label>
				<textarea id = "modify_content" type="text" name="modify_content" wrap="hard" 
					style="height:250px"><%=diarydata.getDiary_content() %></textarea>
			</div>
				<center>
				<a href="javascript:diarymodify();" data-role="button" 
					data-inline="true">글 수정</a>
				<a href="javascript:modifyform.reset();" data-role="button" value="다시쓰기"
					data-inline="true">다시쓰기</a>
				</center>
		</form>
	</div>
