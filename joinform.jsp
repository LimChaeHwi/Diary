<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.member.db.*" %>


<div data-role="page" data-theme="c">
	<script type="text/javascript">
			$("#plusform").hide();
			$("#plusbtn").click(function(){
			$("#plusform").toggle();
			});
		function memberjoin(){
			
			var id = $("#join_id").val(); 
			var password = $("#join_pass").val();
			var name = $("#join_name").val();
			var gender = $("#join_gender").val();
			var birthday = $("#join_birthday").val();
			var blood = $("#join_blood").val();
			var phone = $("#join_phone").val();
			var address = $("#join_address").val();
			var email = $("#join_email").val();
			if(id==''){
				alert("아이디를 입력해주세요");	
			}else if(password==''){
				alert("비밀번호를 입력해주세요");
			}else if(name==''){
				alert("이름을 입력해주세요");
			}else if(birthday==''){
				alert("생년월일을 입력해주세요");
			}else{
				var param = "id=" +encodeURI(id);
				param += "&password=" +encodeURI(password);
				param += "&name=" +encodeURI(name);
				param += "&gender=" +encodeURI(gender);
				param += "&birthday=" +encodeURI(birthday);
				param += "&blood=" +encodeURI(blood);
				param += "&phone=" +encodeURI(phone);
				param += "&address=" +encodeURI(address);
				param += "&email=" +encodeURI(email);
			
				$.mobile.changePage("join.me?"+param);
			}
		}
		function doublecheck(){
			 var sid = $("#join_id").val();               //인풋에 있는 값을 변수에 받아서.
		     
			 $.ajax({
		      type:"POST",
		      url:'./id_check.jsp',  //url에 주소 넣기
		      datatype: 'json',      //dataType에 데이터 타입 넣기
		      data: {sid : sid},
		      success : function(data){     //success에 성공했을 때 동작 넣기.
		       //중복되지 않은 경우
		       if(data==1){ 
		    	   $("#idCheckSpan").text("사용중인 아이디입니다.");
		    	   $("#join_id").val("");
		       }
		       //중복된 경우
		       else{
		    	   $("#idCheckSpan").text("사용가능한 아이디입니다.");
		    	  
		       }
		      
		      }
		     });
		 }
		function focusidbox(){
			$("#idCheckSpan").text("");
		}
		
		 
		function loginform(){
			$.mobile.changePage("loginform.me");
		}
		
	</script>
	<div data-role="header">
		<h2>다 이 어 리</h2>
	</div>
	<form id="joinform" method="post" action="./MemberDoubleCheckAction.me">
		
		<div data-role="content">
			<div data-role="fieldcontain">
				<label for="join_id">아이디</label> <span id="idCheckSpan"></span>
				<input type="text" id="join_id" name="join_id" placeholder="영문,숫자" autocomplete="off" maxlength="15" onblur="doublecheck();" onclick="focusidbox();"/>
			</div>
			<div data-role="fieldcontain">
				<label for="join_pass">비밀번호</label>
				<input type="password" id="join_pass" name="join_pass" placeholder="영문,숫자 20자이내" maxlength="20"/>
			</div>
			<div data-role="fieldcontain">
				<label for="join_name">이름</label>
				<input type="text" id="join_name" name="join_name" autocomplete="off" maxlength="10"/>
			</div>
			<div data-role="fieldcontain">
					<label for="join_birthday">생년월일</label>
					<input type="tel" id="join_birthday" name="join_birthday" placeholder="예)900507" autocomplete="off"
						maxlength="6" required/>
			</div>	
			<div data-role="fieldcontain">
				<label for="join_gender">성별</label>
				<select name="join_gender" id="join_gender" data-role="slider" data-theme="a">
					<option value="남자">남자</option>
					<option value="여자">여자</option>
				</select> 	
			</div>
			
			<a href="#" id= "plusbtn" data-role="button" data-icon="plus">추가정보입력</a>	
			
			<div id="plusform">
				
				<div data-role="fieldcontain">
					<label for="join_blood">혈액형</label>
					<select id="join_blood" name="join_blood" data-native-menu="false" data-theme="a">
						<option value="설정안함">-선택해주세요-</option>
						<option value="A형">A형</option>
						<option value="B형">B형</option>
						<option value="O형">O형</option>
						<option value="AB형">AB형</option>
					</select>
				</div>
				<div data-role="fieldcontain">
					<label for="join_phone">휴대전화</label>
					<input type="tel" id="join_phone" name="join_phone" placeholder="예)000-0000-0000" autocomplete="off"
						maxlength="13"/>
				</div>
				<div data-role="fieldcontain">
					<label for="join_address">주소</label>
					<input type="text" id="join_address" name="join_address" autocomplete="off" maxlength="40"/>
				</div>
				<div data-role="fieldcontain">
					<label for="join_email">이메일</label>
					<input type="text" id="join_email" name="join_email" autocomplete="off" maxlength="30"/>
				</div>
			</div>
			<table style="margin:auto">
				<tr>
					<td>
						<a href="javascript:memberjoin();" data-role="button" data-inline="true">가입</a>
						<a href="javascript:loginform()" data-role="button" data-inline="true">취소</a>
					</td>
				</tr>
			</table>	
		</div>
	</form>
</div>