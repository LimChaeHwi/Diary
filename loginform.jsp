<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.member.db.*" %>

	<div data-role="page" data-theme="c">
			<script type="text/javascript">
				function login(){
					var id = $("#login_id").val();
					var password = $("#login_password").val();
					var autologin = $("#autologin").val();
				//	alert("id=" + id);
					param = "id=" +encodeURI(id);
					param += "&password=" +encodeURI(password);
					$.mobile.changePage("login.me?"+param);
				}
				
				
			</script>
			<style type="text/css">
				#loginbtn{
					height:60px
				}
			</style>
		<div data-role="header">
				<h1>다 이 어 리</h1>
		</div>
		<br><br>
		<div data-role="content">
			<form name="loginform" action="#" method="post">
				<br><br>
				<table style="margin:auto">
					<tr>
						<td>
							<div data-role="fieldcontain">
								
								<input id = "login_id" type="text" name="id" value="" width="20" placeholder="아이디" autocomplete="off">
								
								<input id = "login_password" type="password" name="password" value="" width="20" placeholder="비밀번호">
							</div>
						</td>
						<td>
							&nbsp;&nbsp;
							<a id="loginbtn"
							href="javascript:login()"
							data-role="button"
							data-inline="true">
								<p valign="middle">로그인</p>
							</a>
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							<div data-role="fieldcontain">
<!-- 							<fieldset data-role="controlgroup">
									<input id="autologin" type="checkbox" name="autologin" value="false"/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label for="autologin">자동로그인</label>
								</fieldset> -->
								<a href="findmember.jsp"> &nbsp;&nbsp;아이디/비밀번호찾기</a>
								<br><br>
								<a href="joinform.me"> &nbsp;&nbsp;회원가입</a>
							</div>
						</td>
					</tr>
				</table>
				
			</form>

		</div>
	</div>		
