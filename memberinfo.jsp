<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.member.db.*" %>
<%
	MemberBean memberdata = (MemberBean)request.getAttribute("memberdata");
%> 
<div data-role="page" data-theme="c">
	<script type="text/javascript">
		function membermodify(){
			var id = $("#modify_id").attr("value"); 
			var password = $("#modify_pass").val();
			var name = $("#modify_name").val();
			var gender = $("#modify_gender").val();
			var birthday = $("#modify_birthday").val();
			var blood = $("#modify_blood").val();
			var phone = $("#modify_phone").val();
			var address = $("#modify_address").val();
			var email = $("#modify_email").val();
			var image = $("#modify_image").val();
			
			var param = "id=" +encodeURI(id);
			param += "&password=" +encodeURI(password);
			param += "&name=" +encodeURI(name);
			param += "&gender=" +encodeURI(gender);
			param += "&birthday=" +encodeURI(birthday);
			param += "&blood=" +encodeURI(blood);
			param += "&phone=" +encodeURI(phone);
			param += "&address=" +encodeURI(address);
			param += "&email=" +encodeURI(email);
			param += "&image=" +encodeURI(image);
			
			$.mobile.changePage("MemberModifyAction.me?"+param);
		}
		function memberdelete(){
			var ans;
			ans=confirm("회원탈퇴 하시겠습니까?");
			if(ans == true){
				var id = $("#modify_id").attr("value");
				var param = "id=" +encodeURI(id);
				$.mobile.changePage("MemberDeleteAction.me?"+param);
			}else{
				
			}
		}
	 	$(document).ready(function(){
			 $('#multiform input[name=photo]').MultiFile({
					max: 5, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
					accept: 'jpg', //허용할 확장자(지정하지 않으면 모든 확장자 허용) 'jpg|png|gif'
					maxfile: 1024*1024*10, //각 파일 최대 업로드 크기
					maxsize: 1024*1024*20,  //전체 파일 최대 업로드 크기
					STRING: { //Multi-lingual support : 메시지 수정 가능
					    remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
					    duplicate : "$file 은 이미 선택된 파일입니다.", 
					    denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
					     selected:'$file 을 선택했습니다.', 
					    toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)",
					    toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
					    toobig: "$file 은 크기가 매우 큽니다. (max $size)"
					},
					list:"#afile3-list" //파일목록을 출력할 요소 지정가능
			});
	 	});	 
		//jQuery form 플러그인을 사용하여 폼데이터를 ajax로 전송

		$(function(){
			//폼전송 : 해당폼의 submit 이벤트가 발생했을경우 실행  
		   	 $('#multiform').ajaxForm({
		       cache: false,
		       dataType:"json",
		       //보내기전 validation check가 필요할경우
		       beforeSubmit: function (data, frm, opt) {
			       //console.log(data);  
		           return true;
		       },
		       //submit이후의 처리
		       success: function(data, statusText){
		           //console.log(data); //응답받은 데이터 콘솔로 출력          
		           output(data); //받은 정보를 화면 출력하는 함수 호출
		       },
		       //ajax error
		       error: function(e){
		           alert("사진저장실패");
		           console.log(e);
		       }                               
			});
		});


		//전달받은 정보를 가지고 화면에 보기 좋게 출력
		function output(data) {
			//업로드한 파일을 다운로드할수있도록 화면 구성
			
		    if(data.photo){
		        
		        $.each(data.photo, function(index, item){
		     	   var link = "FileDownload?f="+item.uploadedFileName+"&of="+item.fileName;
		  			$("#pre_image").remove();
		            $("#result").append("<img src='./upload/"+item.uploadedFileName+"'"+ 
		            		"style='-webkit-transform: rotate(0deg);transform: rotate(0deg)' width='80' height='80'/>");
		             
		             $("#modify_image").val(item.uploadedFileName);
		        });
		        
		    }           
		    
		    $('#multiform')[0].reset(); //폼 초기화(리셋); 
		    $('#multiform input:file').MultiFile('reset'); //멀티파일 초기화        
		}	

	</script>
	<div data-role="header">
		<h2>회원정보</h2>
	</div>
		<form name="multiform" id="multiform" action="FileUploadServlet" method="POST" enctype="multipart/form-data">
			<table style="margin:auto">
				<tr><td>
				<h4>프로필사진</h4>
					<div id="result">
					<%
						if(memberdata.getImage()!=null){
					%>	
						<img src="./thumbnail/<%=memberdata.getImage() %>" width="80" height="80" id="pre_image"/>
					<%
						}
					%>	
					</div>			<!--업로드된 사진 미리보기 -->
				</td></tr>
				<tr><td>
						<input type="file" class="afile3" name="photo"/>
				</td></tr>
				<tr><td>		
						<input type="submit" id="btnSubmit" data-inline="true" value="사진등록"/><br/>
				</td></tr>
			</table>
		</form>
		<form id="modifyform" method="post" action="#">
			<input type="hidden" id="modify_image" value="${requestScope.memberdata.getImage()!=null?requestScope.memberdata.getImage(): '' }"/>
		<div data-role="content">	
			<div data-role="fieldcontain">
				<label for="modify_id">아이디</label>
				<input type="text" id="modify_id" name="modify_id" value="<%=memberdata.getId() %>" autocomplete="off" maxlength="15" readonly/>
			</div>
			<div data-role="fieldcontain">
				<label for="modify_pass">비밀번호</label>
				<input type="password" id="modify_pass" name="modify_password" value="" maxlength="20"/>
			</div>
			<div data-role="fieldcontain">
				<label for="modify_name">이름</label>
				<input type="text" id="modify_name" name="modify_name" value="<%if(memberdata.getName()!=null){%><%=memberdata.getName() %><%} %>" autocomplete="off" maxlength="10"/>
			</div>   
			<div data-role="fieldcontain">
					<label for="modify_birthday">생년월일</label>
					<input type="tel" id="modify_birthday" name="modify_birthday" value="<%if(memberdata.getBirthday()!=null){%><%=memberdata.getBirthday() %><%} %>" autocomplete="off"
						maxlength="6"/>
			</div>	
			<div data-role="fieldcontain">
				<label for="modify_gender">성별</label>
				<select name="modify_gender" id="modify_gender" data-role="slider">
					<option value="남자">남자</option>
					<option value="여자">여자</option>
				</select> 	
			</div>

			<div data-role="fieldcontain">
				<label for="modify_blood">혈액형</label>
				<select id="modify_blood" name="modify_blood" data-native-menu="false"  data-theme="a">
					<option value="설정안함">-선택해주세요-</option>
					<option value="A형">A형</option>
					<option value="B형">B형</option>
					<option value="O형">O형</option>
					<option value="AB형">AB형</option>
				</select>
			</div>
			<div data-role="fieldcontain">
				<label for="modify_phone">휴대전화</label>
				<input type="tel" id="modify_phone" name="modify_phone" value="<%if(memberdata.getPhone()!=null){%><%=memberdata.getPhone() %><%} %>" autocomplete="off"
					maxlength="13"/>
			</div>
			<div data-role="fieldcontain">
				<label for="modify_address">주소</label>
				<input type="text" id="modify_address" name="modify_address" value="<%if(memberdata.getAddress()!=null){%><%=memberdata.getAddress() %><%} %>" autocomplete="off" maxlength="40"/>
			</div>
				<div data-role="fieldcontain">
					<label for="modify_email">이메일</label>
					<input type="text" id="modify_email" name="modify_email" value="<%if(memberdata.getEmail()!=null){%><%=memberdata.getEmail() %><%} %>" autocomplete="off" maxlength="30"/>
			</div>
		</div>
			<table style="margin:auto">
				<tr>
					<td>
						<a href="javascript:memberdelete()" data-role="button" data-inline="true">탈퇴</a>
						<a href="javascript:membermodify()" data-role="button" data-inline="true">수정</a>
						<a href="DiaryListAction.di" data-role="button" data-inline="true">취소</a>
					</td>
				</tr>
			</table>	
		
	</form>
</div>