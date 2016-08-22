<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>	
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="net.diary.db.*" %>
<%@ page import ="com.exam.*" %>

<div data-role="page" data-theme="c"> 
	<%
	
	SimpleDateFormat sdf = new SimpleDateFormat("M월 dd일"); 				//글제목
	String strDate = sdf.format(new Date());
	SimpleDateFormat sdf2 = new SimpleDateFormat("YYYY년 M월 d일 aa h:mm"); //글쓴 시각
	String strDate2 = sdf2.format(new Date());
	String id=null;
	String name=null;
	if(session.getAttribute("id")!=null){
		id=(String)session.getAttribute("id");
		name=(String)session.getAttribute("name");
	}
		String diary_type = request.getParameter("diary_type");
		String diary_subject = request.getParameter("diary_subject");
		String diary_content = request.getParameter("diary_content");
		String diary_file = request.getParameter("diary_file");
		String diary_weather = request.getParameter("diary_weather");
		String diary_location = request.getParameter("location");
	%>
		
	<script type="text/javascript">
		$("#location_status").hide();
		$("#file_status").hide();
		
		$("#camera_btn").click(function(){
			$("#location_status").hide();
			$("#file_status").show();
		});
		$("#location_btn").click(function(){
			$("#location_status").show();
			$("#file_status").hide();
		});
		function diaryadd(){
		
					var diary_id = $("#diary_id").attr("value");
					var diary_name = $("#diary_name").attr("value");
					var diary_type = $("#diary_type").val();
						if(diary_type==""){diary_type="설정안함";}
					var diary_subject = $("#diary_subject").val();
					var diary_content = $("#diary_content").val();
					var diary_file = $("#diary_file").val();
					var diary_weather = $("#diary_weather").val();
					var diary_location = $("#diary_location").val();
					var writedate = $("#diary_writedate").attr("value");
					
					var param= "diary_id=" + encodeURI(diary_id);
					param += "&diary_name="+encodeURI(diary_name);
					param += "&diary_type="+encodeURI(diary_type);
					param += "&diary_subject="+encodeURI(diary_subject);
					param += "&diary_content="+encodeURI(diary_content);
					param += "&diary_file="+encodeURI(diary_file);
					param += "&diary_weather="+encodeURI(diary_weather);
					param += "&diary_location="+encodeURI(diary_location);
					param += "&writedate="+encodeURI(writedate);
					
					$.mobile.changePage("DiaryWriteAction.di?"+param);
			
		}

 	$(document).ready(function(){
		 $('#multiform input[name=photo]').MultiFile({
				max: 5, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
				accept: 'jpg|png|gif|jpeg', //허용할 확장자(지정하지 않으면 모든 확장자 허용) 'jpg|png|gif'
				maxfile: 1024*1024*10, //각 파일 최대 업로드 크기
				maxsize: 1024*1024*20,  //전체 파일 최대 업로드 크기
				STRING: { //Multi-lingual support : 메시지 수정 가능
				    remove : "취소", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
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
	        var filevalue ="";
	        var cnt = 1;
	        $.each(data.photo, function(index, item){
	     	   var link = "FileDownload?f="+item.uploadedFileName+"&of="+item.fileName;
	//     	   $("#result").append("<a href='"+ link +"' download>"+item.fileName+"</a>");
	  //          $("#result").append("<br/>");
	            $("#result").append("<img src='./thumbnail/"+ item.uploadedFileName+"'"+ 
	            		"style='-webkit-transform: rotate(0deg);transform: rotate(0deg)' width='80' height='80'"+ 
	            		"id='"+cnt+"'/>");
	            $("#"+cnt+"").click(function(){      	
	            	var ans;
	            	ans = confirm("삭제하시겠습니까?");
	            	if(ans==true){
	            		deleteimage();
	            	}
	            });
	            filevalue += item.uploadedFileName+"/";
	            cnt++;
	        });
	        $("#diary_file").val(filevalue);
	    }           
	    
	    $('#multiform')[0].reset(); //폼 초기화(리셋); 
	    $('#multiform input:file').MultiFile('reset'); //멀티파일 초기화        
	}
	
	//업로드한 이미지 삭제하기
	function deleteimage(){
		  
	   	 $.ajax({
	   		 type:"POST",
	   		 url:"./src/com/exam/FileDeleteServlet.java",
	       cache: false,
	       dataType:"json",
	       //보내기전 validation check가 필요할경우
	       beforeSubmit: function (data, frm, opt) {
		       //console.log(data);
		       alert(1);
	           return true;
	       },
	       //submit이후의 처리
	       success: function(data, statusText){
	           //console.log(data); //응답받은 데이터 콘솔로 출력          
	           output(data); //받은 정보를 화면 출력하는 함수 호출
	       },
	       //ajax error
	       error: function(e){
	           alert("사진삭제실패");
	           console.log(e);
	       }                               
		});
	}
	function showmap(){
		
		var diary_type = $("#diary_type").val();
		var diary_subject = $("#diary_subject").val();
		var diary_content = $("#diary_content").val();
		var diary_file = $("#diary_file").val();
		var diary_weather = $("#diary_weather").val();
		var diary_location = $("#diary_location").val();
		
		
		var param = "diary_type="+encodeURI(diary_type);
		param += "&diary_subject="+encodeURI(diary_subject);
		param += "&diary_content="+encodeURI(diary_content);
		param += "&diary_file="+encodeURI(diary_file);
		param += "&diary_weather="+encodeURI(diary_weather);
		param += "&diary_location="+encodeURI(diary_location);
		
		$.mobile.changePage("ShowMapAction.di?"+param);
	}

	</script>
	
  		
		<div data-role="header">
			<a href="./DiaryListAction.di" data-inline="true">취소</a>
			<h1>글쓰기</h1>
			<a href="javascript:diaryadd()" data-inline="true">완료</a>
		</div>
		<div data-role="content">
		<form id="writeform" method="post" action="#" >
		<input type="hidden" id="diary_id" name="diary_id" value="<%=id%>"/>
		<input type="hidden" id="diary_name" name="diary_name" value="<%=name%>"/>
		<input type="hidden" id="diary_writedate" name="diary_writedate" value="<%=strDate2%>"/>
		<input type="hidden" id="diary_file" name="diary_file" value=""/>
		<input type="hidden" id="lat" value=""/>
		<input type="hidden" id="lng" value=""/>
			<table width="100%">
				<tr>
					<td >
						<input id = "diary_subject" type="text" name="diary_subject" value="${param.diary_subject!=null?param.diary_subject:'' }" 
							placeholder="오늘은 <%=strDate%>" required  >
					</td>	
				</tr>
				<tr>
					<td>
						<input id="diary_type" type="text" name="diary_type" value="${param.diary_type!=null?param.diary_type:'' }" 
							placeholder="글종류" required />
					</td>
					
				</tr>
				<tr>
					<td >
						<textarea id = "diary_content" name="diary_content" wrap="hard"
							style="resize:none; height:200px" placeholder="내용">${param.diary_content!=null?param.diary_content:''}</textarea>	<!-- wrap="hard"는 입력한 내용을 그대로 인식하게 -->
  					</td>	
				</tr>	
			</table>
		</form>
		
		</div>
		<form id="imageform" method="post" action="FileDeleteServlet">			
		
			<div id="result">	
				
			</div>						<!--업로드된 사진 미리보기 -->
		</form>
		<form name="multiform" id="multiform" action="FileUploadServlet" method="POST" enctype="multipart/form-data">
			
			<!-- 다중 파일업로드  -->
			
			<table style="margin:15px" >
				<tr>
					<td>
						<input type="button" id="camera_btn" data-icon="camera" data-inline="true" data-iconpos="notext" onclick=""/>
						<input type="button" id="location_btn" data-icon="location" data-inline="true" data-iconpos="notext" />	
			<!--  		<input type="button" data-icon="cloud" data-inline="true" data-iconpos="notext" onclick=""/> -->
					</td>
				</tr>
			</table>
			<div id="file_status">
				<table>	
					<tr>
						<td width="2%"></td>
						<td align="center" width="96%" colspan="2">
							<input type="file" class="afile3" name="photo"/>
						</td>
						<td width="2%"></td>
					</tr>		
					<tr>
						<td></td>
						<td>
				 			<div id="afile3-list" style="border:2px solid #c9c9c9;min-height:50px;width:200px">
				 			</div>
				 		</td>
				 		<td>	 
							<input type="submit" id="btnSubmit" data-inline="true" value="사진등록"/><br/>
						</td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="location_status">
				<table width="100%">
					<tr>
						<td><input type="text" id="diary_location" value="${param.location!=null?param.location:'' }" /></td>
						<td><a href="javascript:showmap();" data-role="button" id="location_map">지도</a>
					</tr>	
				</table>
			</div>
						
		</form>	
		
  		
</div>
