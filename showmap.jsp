<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 

<div data-role="page" data-theme="c">
<%
	
	String diary_type = request.getParameter("diary_type");
	String diary_subject = request.getParameter("diary_subject");
	String diary_content = request.getParameter("diary_content");
	String diary_file = request.getParameter("diary_file");
	String diary_weather = request.getParameter("diary_weather");
	
%>	
	
	<script type="text/javascript">
		
		var lat ;
		var lng ;
		var map;
		
		var infowindow = new google.maps.InfoWindow(); //추가
		var marker =[];			//추가
		var geocoder;			//추가
		var geocodemarker = [];	//추가
		
		var GreenIcon = new google.maps.MarkerImage(
				   "http://labs.google.com/ridefinder/images/mm_20_green.png",
				   new google.maps.Size(12, 20),
				   new google.maps.Point(0, 0),
				   new google.maps.Point(6, 20)
		);
	// 녹색 마커 아이콘을 정의하는 부분
		
		navigator.geolocation.getCurrentPosition (function (pos)
		{
			lat = pos.coords.latitude;
		    lng = pos.coords.longitude;
		  
			var latlng = new google.maps.LatLng(lat,lng);
			 
			var option={
				zoom:17,
				center:latlng,
				mapTypeControl: true,
				navigationControlOptions:
					{style:google.maps.NavigationControlStyle.SMALL},
				mapTypeId: google.maps.MapTypeId.ROADMAP
				};
			 
			map = document.getElementById("mapView");
			
			mapView.style.width=$(window).width()-0+"px";
			mapView.style.height=$(window).height()-60+"px";
			mapView.style.margin = "-16px";
			 map = new google.maps.Map(map, option);
			 geocoder =  new google.maps.Geocoder();		//추가
			 google.maps.event.addListener(map, 'click', codeCoordinate);	//추가
			 /*아랫글에서 설명한 event를 이용 지도를 'click'하면 codeCoordinate함수를 실행합니다.
	           codeCoordinate함수는 클릭한 지점의 좌표를 가지고 주소를 찾는 함수입니다. */
//	           map = new google.maps.Marker({
//					 position:latlng,
//					 map:map
//			 	 });						//초기화한 값으로 위치 지도위에 마커를 뿌림
		});	 
			 
	//추가 Setmarker
			 function Setmarker(latLng) {
			     
				  if (marker.length > 0)
				       {
				  		  marker[0].setMap(null); 
				  	   }
				// marker.length는 marker라는 배열의 원소의 개수입니다.
				// 만약 이 개수가 0이 아니라면 marker를 map에 표시되지 않게 합니다.
				// 이는 다른 지점을 클릭할 때 기존의 마커를 제거하기 위함입니다.

				  marker = [];
				  marker.length = 0;
				// marker를 빈 배열로 만들고, marker 배열의 개수를 0개로 만들어 marker 배열을 초기화합니
				// 다.

				   marker.push(new google.maps.Marker({
				   position: latLng,
				   map: map
				  } ));
				// marker 배열에 새 marker object를 push 함수로 추가합니다.

				}
			 /*클릭한 지점에 마커를 표시하는 함수입니다.
			   그런데 이 함수를 잘 봐야 하는 것이 바로 marker를 생성하지 않고 marker라는 배열 안에 Marker 
			   obejct  원소를 계속 추가하고 있습니다. 이는 매번 클릭할 때마다 새로운 마커를 생성하기 위함입니
			   다. */

	//입력 받은 주소를 지오코딩 요청하고 결과를 마커로 지도에 표시합니다.
			function codeAddress(event) {
	
				 if (geocodemarker.length > 0)
				 {
					  for (var i=0;i<geocodemarker.length ;i++ )
					  {
					   geocodemarker[i].setMap(null);
					  }
				  geocodemarker =[];
				  geocodemarker.length = 0;
				 }
			        //이 부분도 위와 같이 주소를 입력할 때 표시되는 marker가 매번 새로 나타나게 하기 위함입니
			        //다.
			 
			 var address = document.getElementById("addr1").value;
			        //아래의 주소 입력창에서 받은 정보를 address 변수에 저장합니다.
			
			        //지오코딩하는 부분입니다.
			 geocoder.geocode( {'address': address}, 
			function(results, status) {
			  if (status == google.maps.GeocoderStatus.OK)  //Geocoding이 성공적이라면,
			  {
		//	   alert(results.length + "개의 결과를 찾았습니다.");
			   //결과의 개수를 표시하는 창을 띄웁니다. alert 함수는 알림창 함수입니다.
			   for(var i=0;i<results.length;i++)
			   {
			    map.setCenter(results[i].geometry.location);
			    geocodemarker.push(new google.maps.Marker({
			     center: results[i].geometry.location,
			     position: results[i].geometry.location,
			     icon: GreenIcon,
			     map: map
			    }));
			   } 
			                        //결과가 여러 개일 수 있기 때문에 모든 결과를 지도에 marker에 표시합니다.
			  }
			  else
			  { 
				  alert("해당위치정보가 없습니다."); 
			  }
			 });
		}


		//클릭 이벤트 발생 시 그 좌표를 주소로 변환하는 함수입니다.
			function codeCoordinate(event) {
			        
			 Setmarker(event.latLng);
			        //이벤트 발생 시 그 좌표에 마커를 생성합니다.
				
			        // 좌표를 받아 reverse geocoding(좌표를 주소로 바꾸기)를 실행합니다.
			 geocoder.geocode({'latLng' : event.latLng}, 
			function(results, status) {
			  if (status == google.maps.GeocoderStatus.OK)  {
			   if (results[1])
			   {
				   
			    infowindow.setContent(results[1].formatted_address);	//클릭한 곳의 주소
			    infowindow.open(map, marker[0]);
			                                //infowindow로 주소를 표시합니다.
			    $(".gm-style-iw").click(function(){
					var ans;
					ans=confirm("위치를 저장하시겠습니까?");
			    	if(ans == true){
			    		
			    		var diary_type = $("#diary_type").attr("value");
			    		var diary_subject = $("#diary_subject").attr("value");
			    		var diary_content = $("#diary_content").attr("value");
			    		var diary_file = $("#diary_file").attr("value");
			    		var diary_weather = $("#diary_weather").attr("value");
			    		var location = results[1].formatted_address;
			    		
			    		
			    		
			    		var param = "diary_type=" + encodeURI(diary_type);
			    		param += "&diary_subject=" + encodeURI(diary_subject);
			    		param += "&diary_content=" + encodeURI(diary_content);
			    		param += "&diary_file=" + encodeURI(diary_file);
			    		param += "&diary_weather=" + encodeURI(diary_weather);
			    		param += "&location=" + encodeURI(location);
			    		
			    		$.mobile.changePage("DiaryWrite.di?"+param);
			    	}else{
			    		
			    	}
			    	
				});
			   }
			  }
			  
			});
		}
			
		
				
	</script>

<div data-role="header">
	<table>
		<tr>
			<td><input type="text" size="100" id="addr1" name="address" style="color:black;"/></td>  
			<td><input name="submit" type="submit" value="검색" onclick='codeAddress(); return false;' /></td>
		</tr>
	</table>	
</div>	
		
<div data-role="content">
			<input type="hidden" id="diary_type" value="<%=diary_type%>"/>
			<input type="hidden" id="diary_subject" value="<%=diary_subject%>"/>
			<input type="hidden" id="diary_content" value="<%=diary_content%>"/>
			<input type="hidden" id="diary_file" value="<%=diary_file%>"/>
			<input type="hidden" id="diary_weather" value="<%=diary_weather%>"/>
			<div id="mapView">
				
			</div>
</div>

</div>




