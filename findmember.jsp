<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>	
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %>
	 
<div data-role="page" data-theme="c">

	<script type="text/javascript">
		
		function findid(){				
					var id_name = $("#id_name").val();
					var id_birthday = $("#id_birthday").val();

					var param= "name=" + encodeURI(id_name);
					param += "&birthday="+encodeURI(id_birthday);
					
					$.mobile.changePage("MemberFindIdAction.me?"+param);	
		}
		function findpassword(){
			var pass_id = $("#pass_id").val();
			var pass_name = $("#pass_name").val();
			var pass_birthday = $("#pass_birthday").val();
			
			var param= "findid=" + encodeURI(pass_id);
			param += "&name=" + encodeURI(pass_name);
			param += "&birthday=" +encodeURI(pass_birthday);
			
			$.mobile.changePage("MemberFindIdAction.me?"+param);	
		}
	
	</script>
		<form id="findform" method="post" action="#" >
		<div data-role="header">
			<a href="./loginform.me" data-role="button" data-inline="true">취소</a>
			<h1>개인정보찾기</h1>
			
		</div>
		<div data-role="content">
			<table style="margin:auto; width:80%">
				<tr>
					<td align="center">
						<h3>아이디찾기</h3>
						<input id = "id_name" type="text" name="id_name" value="" placeholder="이름" required>
						<input id = "id_birthday" type="text" name="id_birthday" value="" placeholder="생년월일" required/>
					</td>
					
				</tr>
				<tr>
					<td>
						<a href="javascript:findid()" data-role="button">아이디찾기</a>
					</td>	
				</tr>	
			</table>
			<br><hr>
			<table style="margin:auto; width:80%">
				<tr>
					<td align="center">
						<h3>비밀번호찾기</h3>
						<input id = "pass_id" type="text" name="pass_id" value="" placeholder="아이디" required>
						<input id = "pass_name" type="text" name="pass_name" value="" placeholder="이름" required>
						<input id= "pass_birthday" type="text" name="pass_birthday" value="" placeholder="생년월일" required/>
					</td>
					
				</tr>
				<tr>
					<td>
						<a href="javascript:findpassword()" data-role="button">비밀번호찾기</a>
					</td>	
				</tr>	
			</table>		
		</div>	
		</form>
	</div>
