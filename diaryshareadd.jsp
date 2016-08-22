<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.member.db.*" %>


<div data-role="page" data-theme="c">
	<script type="text/javascript">
		
		function findfriend(){
			var friend_id = $("#friend_id").val();
			var param= "friend_id=" + encodeURI(friend_id);
			$.mobile.changePage("MemberFindFriendAction.me?"+param);
		}
		function idcheck(){
			 var sid = $("#friend_id").val();               //인풋에 있는 값을 변수에 받아서.		     
			 $.ajax({
		      type:"POST",
		      url:'./id_check.jsp',  //url에 주소 넣기
		      datatype: 'json',      //dataType에 데이터 타입 넣기
		      data: {sid : sid},
		      success : function(data){     //success에 성공했을 때 동작 넣기.
		       //찾는 아이디가 없는 경우
		       if(data==0){ 
		    	   $("#idCheckSpan").text("존재하지 않는 아이디입니다.");
		    	   $("#join_id").val("");
		       }
		       //아이디를 찾은 경우
		       else{
		    	   findfriend(); 
		       }
		      }
		     });
		 }
		function focusidbox(){
			$("#idCheckSpan").text("");
		}
	
	</script>	
	<div id="menusPanel" data-role="panel" data-display="overlay">
		<h2>사진</h2>
		<h2>사용자정보</h2>
		<div data-role="controlgroup" data-type="horizontal">
		<a href="#" data-role="button" data-icon="gear" data-iconpos="notext">사용자설정</a>

		<a href="loginform.me" data-role="button" data-icon="power" data-iconpos="notext">로그아웃</a>
		
		</div>
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
			
			</td>
			</tr>
		</table>	
				
		</div>
	<form id="friendidform" method="post" action="#">
		<div data-role="content">
			<div data-role="fieldcontain">
				<label for="friend_id">친구 아이디</label>
				<input type="text" id="friend_id" name="id" placeholder="영문,숫자" autocomplete="off" maxlength="15" onclick="focusidbox();"/>
				<span id="idCheckSpan"></span>
			</div>
	
			<a href="javascript:idcheck();" data-role="button" data-inline="true" >검색</a>
			
			<a href="javascript:history.back()" data-role="button" data-inline="true">취소</a>	<!-- 뒤로가기 -->
		</div>
	</form>
</div>